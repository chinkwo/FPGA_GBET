//**********************************************
//*****ddr3的写模块，产生和写有关的数据********
//*********************************************
module  ddr3_p1_write #
 (    
        parameter	WRITE_BL  =  6'd63,//突发长度
         parameter	ADDR_BL = 9'd256//每突发一次写地址加256
)
(
	input	wire	 	sclk		,
	input	wire		rst_n		,
	input	wire		rx_po_flag	,//串口rx模块产生标志位
	input	wire[7:0]	rx_po_data	,//串口rx模块接收的数据
	input	wire[25:0]	rslt		,
	input	wire		begin_flag	,
	input	wire		c3_p_wr_empty	,
	output	reg           c3_p_wr_en    ,//写使能  
	output	wire[15:0]  	c3_p_wr_mask 	, //掩码  
	output	wire[127:0]	c3_p_wr_data	,//向ddr3写fifo写入的数据  
	output	reg		c3_p_cmd_en   ,//命令使能        
       output	wire[2:0]	c3_p_cmd_instr,//写命令
	output	wire[6:0]	c3_p_cmd_bl 	,//突发长度
	output	wire[27:0]	c3_p_cmd_byte_addr,//命令地址 	
       output	reg		frame_rx_end    
 ); 
reg[6:0]   	write_cnt_bl ;  //写数据计数
reg[1:0]	cnt_rx_po_flag;//对rx_po_flag计数
reg		write_fifo_wr_en;//fifo1的写使能
reg		write_fifo_rd_en;//fifo1读使能
reg[31:0]	fifo_write_data;//fifo1的写数据
reg[13:0]	write_brust_cnt;
wire[7:0]	rd_data_count;
assign  c3_p_wr_mask ='d0 ;//
assign  c3_p_cmd_bl  =	WRITE_BL  ;
assign	c3_p_cmd_byte_addr ={write_brust_cnt,9'd0};//ddr3的写地址
assign	c3_p_cmd_instr = 3'd0 ;

//当写请求为高写使能拉高，当计数器为突发长度时拉低
always@(posedge sclk )
	if(!rst_n)
		c3_p_wr_en  <=  1'd0  ;
	else	c3_p_wr_en  <=  write_fifo_rd_en ; 
//对写使能为高计数，当fifo空标志拉高清零
always@(posedge sclk )
	if(!rst_n)
      		write_cnt_bl  <=  7'd0 ;	
     	 else  if(write_fifo_rd_en  ==  1'b1)
      		write_cnt_bl  <=  write_cnt_bl  + 1'd1 ;
      	else  write_cnt_bl  <=  7'd0  ;	
////当计数器为突发长度时拉，产生命令使能
always@(posedge sclk )
	if(!rst_n)
		c3_p_cmd_en  <=  1'b0  ;
	else  if(write_cnt_bl  ==WRITE_BL)
		c3_p_cmd_en  <=  1'b1  ;
	else 
		c3_p_cmd_en  <=  1'b0  ;
//当计数器为突发长度时，写地址加256
always@(posedge sclk )
	if(!rst_n)
		write_brust_cnt  <=  14'd0  ;
	else  if((write_brust_cnt== rslt[13:0]&&  c3_p_cmd_en  ==  1'b1  )||begin_flag==  1'b1   )
		write_brust_cnt<=  1'b0  ;
	else  if(c3_p_cmd_en ==  1'b1)
		write_brust_cnt  <=  write_brust_cnt  + 1'b1;	
always@(posedge sclk)
	if(!rst_n)
		frame_rx_end<=  1'b0  ;
	
	else  if (write_brust_cnt==  rslt[13:0] &&  c3_p_cmd_en==  1'b1 )
		frame_rx_end<=  1'b1  ;
	else  if(write_brust_cnt  ==  rslt[13:0])
		frame_rx_end  <=  1'b0;
//**********************  
//*****    写控制  *****  
//**********************  
//对rx_po_flag计数
always@(posedge sclk )
	if(!rst_n) 
		cnt_rx_po_flag  <=  2'd0  ;
	else  if(cnt_rx_po_flag ==  2'd2 &&rx_po_flag  ==  1'b1 )
		cnt_rx_po_flag  <=  2'd0  ;
	else  if( rx_po_flag  ==  1'd1   )
		cnt_rx_po_flag  <=  cnt_rx_po_flag  +  1'd1  ;
//将串口发来的四个八位数据组合长一个32位数据
always @(posedge sclk)
	if(!rst_n)
		fifo_write_data  <=  32'h00000000 ;
	else  if(rx_po_flag ==  1'd1)
		fifo_write_data[23:0]  <=  {fifo_write_data[15:0],rx_po_data[7:0]};
//向ddr3的fifo传数据的fifo的写使能
always @(posedge sclk )
	if(!rst_n)
		write_fifo_wr_en  <=  1'b0  ;
	else  if(  cnt_rx_po_flag  ==  2'd2 && rx_po_flag==  1'b1 )
		write_fifo_wr_en  <=  1'b1  ;
	else  
		write_fifo_wr_en  <=  1'b0  ;
//向ddr3的fifo传数据的fifo的读使能
always @(posedge sclk )
	if(!rst_n)
		write_fifo_rd_en  <=  1'b0  ;
	else if(  rd_data_count>'d60&&c3_p_wr_empty==1'b1 &&rx_po_flag=='d0)
		write_fifo_rd_en  <=  1'b1  ;
	else  if(write_cnt_bl  ==  WRITE_BL )
		write_fifo_rd_en  <=  1'b0  ;
fifo_in32_o128 fifo_in32_o128_inst (
  .wr_clk(sclk),                // input wire wr_clk
  .rd_clk(sclk),                // input wire rd_clk
  .din(fifo_write_data),                      // input wire [31 : 0] din
  .wr_en(write_fifo_wr_en),                  // input wire wr_en
  .rd_en(write_fifo_rd_en),                  // input wire rd_en
  .dout(c3_p_wr_data),                    // output wire [127 : 0] dout
  .full(),                    // output wire full
  .empty(),                  // output wire empty
  .rd_data_count(rd_data_count)  // output wire [7 : 0] rd_data_count
);
endmodule              