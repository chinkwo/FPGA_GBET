//*****************************************************
//***********��ģ�飬��fifo���Ͷ�ʹ�ܣ�������**********     
//*****************************************************  
module	ddr3_p5_read #
(
	parameter	READ_BL =  6'd63 	
)
(
input	wire		sclk		,  
input	wire		hdmi_clk	, 
input	wire		rst_n		,
input	wire[5:0]	c3_p5_rd_count, //��fifo��������
input	wire[127:0]	c3_p5_rd_data	,//ddr3�����32λ����
input	wire		video_h_de	,
input	wire[25:0]	rslt		,
input	wire		begin_flag	,
output	reg		c3_p5_rd_en  	,//��fifo�Ķ�ʹ��
output	reg		c3_p5_cmd_en  ,      //����ʹ��        
output	wire[2:0]	c3_p5_cmd_instr,      //��д����
output	wire[6:0]	c3_p5_cmd_bl   ,      //ͻ������
output	wire[27:0]	c3_p5_cmd_byte_addr,  	//�����ַ 
output	wire[23:0]	rgb     
);   
reg	[13:0]	cnt_read_req;
reg	[6:0]	read_cnt_bl;
reg		h_oe;
reg		c3_p5_rd_flag;
wire		read_fifo_wr_en  ;//����Ŷ���ddr3����fifo��дʹ��
reg		read_fifo_rd_en;//��Ŷ���ddr3����fifo�Ķ�ʹ��
wire	[10:0]	read_fifo_rd_count;//�Ŷ���ddr3����fifo�Ķ�������
wire	[31:0]	read_fifo_read_data; 
assign	read_fifo_wr_en =c3_p5_rd_en ;
assign	c3_p5_cmd_instr  = 3'b001 ;
assign  c3_p5_cmd_bl  	    =	READ_BL  ;
assign	c3_p5_cmd_byte_addr =  {cnt_read_req,9'h00} ; 
assign	rgb= {read_fifo_read_data[7:0],read_fifo_read_data[15:8],read_fifo_read_data[23:16]}; 
//�Զ��������
always@(posedge	sclk )
	if(!rst_n)
		cnt_read_req  <=  14'd0;
	else  if(cnt_read_req  == rslt[13:0]  &&  c3_p5_cmd_en  ==  1'b1 )
		cnt_read_req  <=  14'd0 ;
	else  if(c3_p5_cmd_en  ==  1'b1)
		cnt_read_req  <= cnt_read_req  +  1'b1 ;
//�Զ�ʹ��λ�߼���������fifoû���ݹ���
always@(posedge sclk )
	if(!rst_n)
		read_cnt_bl  <=  7'd0  ;
	else   if(c3_p5_rd_en  ==  1'd1)
		read_cnt_bl  <=  read_cnt_bl  +  1'd1  ;
	else   if(c3_p5_rd_en  ==  'd0)
		read_cnt_bl  <=  7'd0  ;
//����fifo���ݴﵽͻ�����Ⱥ��ʹ�����ߣ���������Ϊͻ������ʱ����
always@(posedge sclk )
	if(!rst_n)
		c3_p5_rd_en  <=  1'd0  ;
	else  if(c3_p5_rd_count>='d60)
		c3_p5_rd_en  <=  1'd1  ;
	else  if(read_cnt_bl  == READ_BL)
		c3_p5_rd_en  <=  1'd0  ;
//��fifo2�Ķ����ݴ���1024����ͬ���ź�λ��ʱ����	
always@(posedge hdmi_clk )
	if(!rst_n)
		h_oe  <=  1'b0 ;
	else if(read_fifo_rd_count[10]==  1'b1  && begin_flag  ==  1'b1  )
		h_oe  <= 1'b1 ;
//��h_oeλ����video_h_deλ1ʱ��ʹ������
always@(posedge hdmi_clk )
	if(!rst_n)
	 	read_fifo_rd_en  <=  1'b0  ;
	else  if(h_oe  ==  1'b1  &&  video_h_de==  1'b1 )
		read_fifo_rd_en  <=  1'b1  ;
	else	read_fifo_rd_en  <=  1'b0  ;
//��������������c3_p5_rd_flag���ߣ���ͻ�����������
always@(posedge  sclk  )
	if(!rst_n)
		c3_p5_rd_flag  <=  1'b0 ;
	else if(c3_p5_cmd_en ==  1'b1 )
		c3_p5_rd_flag  <=  1'b1 ;
	else  if(read_cnt_bl  == READ_BL)
		c3_p5_rd_flag  <=  1'b0 ;	
//��fifo2�Ķ�����С��1024��c3_p5_rd_flagΪ��ʱ����ʹ������һ��
always@(posedge sclk  )
	if(!rst_n)
		c3_p5_cmd_en  <=  1'b0  ;
	else	if(c3_p5_cmd_en  ==  1'b1)
		c3_p5_cmd_en  <=  1'b0  ;
	else	if(read_fifo_rd_count[10]==  1'b0 && c3_p5_rd_flag ==  1'b0 )
		c3_p5_cmd_en  <=  1'b1  ;	
	else	
		c3_p5_cmd_en  <=  1'b0  ;	
//fifo2������	
fifo_in128_o32_2048 fifo_in128_o32_2048_inst (
  .wr_clk(sclk),  // input wire wr_clk
  .rd_clk(hdmi_clk),  // input wire rd_clk
  .din(c3_p5_rd_data),        // input wire [127 : 0] din
  .wr_en(read_fifo_wr_en),    // input wire wr_en
  .rd_en(read_fifo_rd_en),    // input wire rd_en
  .dout(read_fifo_read_data),      // output wire [31 : 0] dout
  .full(),      // output wire full
  .empty() ,   // output wire empty
   .rd_data_count(read_fifo_rd_count)  // output wire [10 : 0] rd_data_count
);
endmodule
