//*****************************************************
//***********��ģ�飬��fifo���Ͷ�ʹ�ܣ�������**********     
//*****************************************************  
module	ddr3_p6_read #
(
	parameter	READ_BL =  6'd63 	
)(
	input	wire		sclk		,  
	input	wire		rst_n		,
	input	wire		p6_rd_empty,
	input	wire		p6_rd_full,
	input	wire	[5:0]	c3_p6_rd_count  , //��fifo��������
	input	wire	[127:0]	c3_p6_rd_data,//ddr3�����32λ����
	input	wire	[25:0]	rslt,
	input	wire		frame_rx_end,//��ͼƬȫ��д��ddr3�����ߣ��ڵ����ڶ���ͻ��������
	input	wire		read_fifo3_rd_en  ,  //����ģ�鴮����ʹ��
	
	output	reg		c3_p6_rd_en  	,//��fifo�Ķ�ʹ��
	output	reg		c3_p6_cmd_en            ,      //����ʹ��        
        output	wire	[2:0]	c3_p6_cmd_instr 	,      //��д����
	output	wire	[6:0]	c3_p6_cmd_bl            ,      //ͻ������
	output	wire	[27:0]	c3_p6_cmd_byte_addr     ,  	//�����ַ 
	
	output	wire	[127:0]	read_fifo3_read_data   ,
        output	wire	[9:0]	read_fifo3_rd_count//�Ŷ���ddr3����fifo�Ķ�������
);    

reg	[13:0]	cnt_read_req;
reg	[5:0]	read_cnt_bl;
reg		c3_p6_rd_flag;

reg		c4_read_flag;

assign	c3_p6_cmd_instr  = 3'b001 ;
assign  c3_p6_cmd_bl  		=	READ_BL  ;
assign	c3_p6_cmd_byte_addr =  {cnt_read_req,9'h00} ; 



//�Զ��������
always@(posedge	sclk )
	if(!rst_n)
		cnt_read_req  <=  14'd0;
	else  if((cnt_read_req  == rslt[13:0] &&  c3_p6_cmd_en  ==  1'b1)||frame_rx_end=='d0 )
		cnt_read_req  <=  14'd0 ;
	else  if(c3_p6_cmd_en  ==  1'b1)
		cnt_read_req  <= cnt_read_req  +  1'b1 ;
//�Զ�ʹ��λ�߼���������fifoû���ݹ���
always@(posedge sclk )
	if(!rst_n)
		read_cnt_bl  <=  7'd0  ;
	else   if(c3_p6_rd_en  ==  1'd1)
		read_cnt_bl  <=  read_cnt_bl  +  1'd1  ;
	else   if(c3_p6_rd_en  =='d0)
		read_cnt_bl  <=  7'd0  ;
//����fifo���ݴﵽͻ�����Ⱥ��ʹ�����ߣ���������Ϊͻ������ʱ����
always@(posedge sclk )
	if(!rst_n)
		c3_p6_rd_en  <=  1'd0  ;
	else  if(c3_p6_rd_count >='d60)
		c3_p6_rd_en  <=  1'd1  ;
	else  if(read_cnt_bl  == READ_BL)
		c3_p6_rd_en  <=  1'd0  ;
//��fifo2�Ķ����ݴ���1024����ͬ���ź�λ��ʱ����	
//��������������c3_p6_rd_flag���ߣ���ͻ�����������
always@(posedge  sclk  )
	if(!rst_n)
		c3_p6_rd_flag  <=  1'b0 ;
	else if(c3_p6_cmd_en ==  1'b1 )
		c3_p6_rd_flag  <=  1'b1 ;
	else  if(read_cnt_bl  == READ_BL)
		c3_p6_rd_flag  <=  1'b0 ;	
//��fifo2�Ķ�����С��1024��c3_p6_rd_flagΪ��ʱ����ʹ������һ�Σ���c4_read_flagλ1ʱ����
always@(posedge sclk  )
	if(!rst_n)
		c3_p6_cmd_en  <=  1'b0  ;  
	else	if(c3_p6_cmd_en  ==  1'b1  || c4_read_flag== 1'b1  )
		c3_p6_cmd_en  <=  1'b0  ;
	else   if(read_fifo3_rd_count <'d256 && c3_p6_rd_flag ==  1'b0&& frame_rx_end ==  1'b1 )
		c3_p6_cmd_en  <=  1'b1  ;
			
//�������ݶ�һ������ߣ���ddr3д��һ��ͼƬ������	
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
