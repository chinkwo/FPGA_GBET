//*****************************************************
//***********读模块，向fifo发送读使能，和命令**********     
//*****************************************************  
module	ddr3_p6_read #
(
	parameter	READ_BL =  6'd63 	
)(
	input	wire		sclk		,  
	input	wire		rst_n		,
	input	wire		p6_rd_empty,
	input	wire		p6_rd_full,
	input	wire	[5:0]	c3_p6_rd_count  , //读fifo的数据量
	input	wire	[127:0]	c3_p6_rd_data,//ddr3输出的32位数据
	input	wire	[25:0]	rslt,
	input	wire		frame_rx_end,//当图片全部写入ddr3是拉高，在倒数第二个突发后拉低
	input	wire		read_fifo3_rd_en  ,  //成桢模块串来的使能
	
	output	reg		c3_p6_rd_en  	,//读fifo的读使能
	output	reg		c3_p6_cmd_en            ,      //命令使能        
        output	wire	[2:0]	c3_p6_cmd_instr 	,      //读写命令
	output	wire	[6:0]	c3_p6_cmd_bl            ,      //突发长度
	output	wire	[27:0]	c3_p6_cmd_byte_addr     ,  	//命令地址 
	
	output	wire	[127:0]	read_fifo3_read_data   ,
        output	wire	[9:0]	read_fifo3_rd_count//放读出ddr3数据fifo的读数据量
);    

reg	[13:0]	cnt_read_req;
reg	[5:0]	read_cnt_bl;
reg		c3_p6_rd_flag;

reg		c4_read_flag;

assign	c3_p6_cmd_instr  = 3'b001 ;
assign  c3_p6_cmd_bl  		=	READ_BL  ;
assign	c3_p6_cmd_byte_addr =  {cnt_read_req,9'h00} ; 



//对读请求计数
always@(posedge	sclk )
	if(!rst_n)
		cnt_read_req  <=  14'd0;
	else  if((cnt_read_req  == rslt[13:0] &&  c3_p6_cmd_en  ==  1'b1)||frame_rx_end=='d0 )
		cnt_read_req  <=  14'd0 ;
	else  if(c3_p6_cmd_en  ==  1'b1)
		cnt_read_req  <= cnt_read_req  +  1'b1 ;
//对读使能位高计数，当读fifo没数据归零
always@(posedge sclk )
	if(!rst_n)
		read_cnt_bl  <=  7'd0  ;
	else   if(c3_p6_rd_en  ==  1'd1)
		read_cnt_bl  <=  read_cnt_bl  +  1'd1  ;
	else   if(c3_p6_rd_en  =='d0)
		read_cnt_bl  <=  7'd0  ;
//当读fifo数据达到突发长度后读使能拉高，当计数器为突发长度时拉低
always@(posedge sclk )
	if(!rst_n)
		c3_p6_rd_en  <=  1'd0  ;
	else  if(c3_p6_rd_count >='d60)
		c3_p6_rd_en  <=  1'd1  ;
	else  if(read_cnt_bl  == READ_BL)
		c3_p6_rd_en  <=  1'd0  ;
//当fifo2的读数据大与1024且行同步信号位高时拉高	
//当都命令拉高是c3_p6_rd_flag拉高，当突发读完后拉低
always@(posedge  sclk  )
	if(!rst_n)
		c3_p6_rd_flag  <=  1'b0 ;
	else if(c3_p6_cmd_en ==  1'b1 )
		c3_p6_rd_flag  <=  1'b1 ;
	else  if(read_cnt_bl  == READ_BL)
		c3_p6_rd_flag  <=  1'b0 ;	
//当fifo2的读数据小于1024且c3_p6_rd_flag为低时命令使能拉高一次，当c4_read_flag位1时拉低
always@(posedge sclk  )
	if(!rst_n)
		c3_p6_cmd_en  <=  1'b0  ;  
	else	if(c3_p6_cmd_en  ==  1'b1  || c4_read_flag== 1'b1  )
		c3_p6_cmd_en  <=  1'b0  ;
	else   if(read_fifo3_rd_count <'d256 && c3_p6_rd_flag ==  1'b0&& frame_rx_end ==  1'b1 )
		c3_p6_cmd_en  <=  1'b1  ;
			
//当把数据都一遍后拉高，当ddr3写下一个图片是拉低	
always@(posedge sclk)
	if(!rst_n)
		c4_read_flag  <=  1'b0  ;
	else  if(frame_rx_end  ==  1'b0)
		c4_read_flag  <=  1'b0  ;
	else  if(cnt_read_req  ==  rslt[13:0] &&  c3_p6_cmd_en  ==  1'b1)
		c4_read_flag  <=  1'b1;
		
		
		
		

		
fifo_ddr3_rd_p6  fifo_ddr3_rd_p6_inst(
  .wr_clk(sclk),                // input wire wr_clk
  .rd_clk(sclk),                // input wire rd_clk
  .din(c3_p6_rd_data),                      // input wire [127 : 0] din
  .wr_en(c3_p6_rd_en),                  // input wire wr_en
  .rd_en(read_fifo3_rd_en),                  // input wire rd_en
  .dout(read_fifo3_read_data),                    // output wire [127 : 0] dout
  .full(),                    // output wire full
  .empty(),                  // output wire empty
  .rd_data_count(read_fifo3_rd_count)  // output wire [9 : 0] rd_data_count
);
endmodule
