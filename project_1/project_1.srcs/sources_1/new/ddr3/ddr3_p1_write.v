//**********************************************
//*****ddr3��дģ�飬������д�йص�����********
//*********************************************
module  ddr3_p1_write #
 (    
        parameter	WRITE_BL  =  6'd63,//ͻ������
         parameter	ADDR_BL = 9'd256//ÿͻ��һ��д��ַ��256
)
(
	input	wire	 	sclk		,
	input	wire		rst_n		,
	input	wire		rx_po_flag	,//����rxģ�������־λ
	input	wire[7:0]	rx_po_data	,//����rxģ����յ�����
	input	wire[25:0]	rslt		,
	input	wire		begin_flag	,
	input	wire		c3_p_wr_empty	,
	output	reg           c3_p_wr_en    ,//дʹ��  
	output	wire[15:0]  	c3_p_wr_mask 	, //����  
	output	wire[127:0]	c3_p_wr_data	,//��ddr3дfifoд�������  
	output	reg		c3_p_cmd_en   ,//����ʹ��        
       output	wire[2:0]	c3_p_cmd_instr,//д����
	output	wire[6:0]	c3_p_cmd_bl 	,//ͻ������
	output	wire[27:0]	c3_p_cmd_byte_addr,//�����ַ 	
       output	reg		frame_rx_end    
 ); 
reg[6:0]   	write_cnt_bl ;  //д���ݼ���
reg[1:0]	cnt_rx_po_flag;//��rx_po_flag����
reg		write_fifo_wr_en;//fifo1��дʹ��
reg		write_fifo_rd_en;//fifo1��ʹ��
reg[31:0]	fifo_write_data;//fifo1��д����
reg[13:0]	write_brust_cnt;
wire[7:0]	rd_data_count;
assign  c3_p_wr_mask ='d0 ;//
assign  c3_p_cmd_bl  =	WRITE_BL  ;
assign	c3_p_cmd_byte_addr ={write_brust_cnt,9'd0};//ddr3��д��ַ
assign	c3_p_cmd_instr = 3'd0 ;

//��д����Ϊ��дʹ�����ߣ���������Ϊͻ������ʱ����
always@(posedge sclk )
	if(!rst_n)
		c3_p_wr_en  <=  1'd0  ;
	else	c3_p_wr_en  <=  write_fifo_rd_en ; 
//��дʹ��Ϊ�߼�������fifo�ձ�־��������
always@(posedge sclk )
	if(!rst_n)
      		write_cnt_bl  <=  7'd0 ;	
     	 else  if(write_fifo_rd_en  ==  1'b1)
      		write_cnt_bl  <=  write_cnt_bl  + 1'd1 ;
      	else  write_cnt_bl  <=  7'd0  ;	
////��������Ϊͻ������ʱ������������ʹ��
always@(posedge sclk )
	if(!rst_n)
		c3_p_cmd_en  <=  1'b0  ;
	else  if(write_cnt_bl  ==WRITE_BL)
		c3_p_cmd_en  <=  1'b1  ;
	else 
		c3_p_cmd_en  <=  1'b0  ;
//��������Ϊͻ������ʱ��д��ַ��256
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
//*****    д����  *****  
//**********************  
//��rx_po_flag����
always@(posedge sclk )
	if(!rst_n) 
		cnt_rx_po_flag  <=  2'd0  ;
	else  if(cnt_rx_po_flag ==  2'd2 &&rx_po_flag  ==  1'b1 )
		cnt_rx_po_flag  <=  2'd0  ;
	else  if( rx_po_flag  ==  1'd1   )
		cnt_rx_po_flag  <=  cnt_rx_po_flag  +  1'd1  ;
//�����ڷ������ĸ���λ������ϳ�һ��32λ����
always @(posedge sclk)
	if(!rst_n)
		fifo_write_data  <=  32'h00000000 ;
	else  if(rx_po_flag ==  1'd1)
		fifo_write_data[23:0]  <=  {fifo_write_data[15:0],rx_po_data[7:0]};
//��ddr3��fifo�����ݵ�fifo��дʹ��
always @(posedge sclk )
	if(!rst_n)
		write_fifo_wr_en  <=  1'b0  ;
	else  if(  cnt_rx_po_flag  ==  2'd2 && rx_po_flag==  1'b1 )
		write_fifo_wr_en  <=  1'b1  ;
	else  
		write_fifo_wr_en  <=  1'b0  ;
//��ddr3��fifo�����ݵ�fifo�Ķ�ʹ��
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