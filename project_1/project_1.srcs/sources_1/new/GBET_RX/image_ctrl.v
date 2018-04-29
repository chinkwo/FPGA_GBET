//********************************************
//**********ͼ����Ϣ�ɼ�ģ��******************
//********************************************
module image_ctrl(
	input	wire		sclk,
	input	wire		rst_n,
	
	input	wire		dout_en_o,
	input	wire[7:0]	dout_o,
	input	wire[5:0]	rd_cnt,
	input	wire[5:0]	Latch_max,//�����w_cnt-1��ֵ
	
	output	reg		begin_flag, 
	output	wire[31:0]	rlst,//ͼ���w*h��ֵ
	output	reg		rgb_en,//��po_rx_dataͬ����ʹ��
	output	reg[7:0]	rgb_data//ͼ����Ϣ
);
reg[2:0]	cnt_aa;
reg		width_en;//�����Ϣ��־λ
reg[15:0]	width_data;//�������
reg		height_en;//�߶���Ϣ��־λ
reg[15:0]	height_data;//�߶�����



reg		start_image_en;//��⵽f5��f6ʱ����
reg		image_en;//��⵽f5��f6ʱ����


always@(posedge sclk )
	if(!rst_n)
		cnt_aa<= 'b0 ;
	else if(rd_cnt>=43 && rd_cnt <=49 &&dout_o==8'haa )
		cnt_aa <= cnt_aa+1 ;
	else
		cnt_aa<= 'b0 ;
//���־λ
always@(posedge sclk )
	if(!rst_n)
		width_en<= 1'b0 ;
	else if(cnt_aa==7&&dout_o==8'hfa&&rd_cnt ==50)
		width_en <= 1'b1 ;
	else if(rd_cnt==12'd52 && width_en==1'b1)
		width_en <= 1'b0 ;
//�߱�־
always@(posedge sclk )
	if(!rst_n)
		height_en <= 1'b0 ;
	else if(rd_cnt==12'd52 && width_en==1'b1)
		height_en <= 1'b1 ;		
	else if(rd_cnt == 12'd54&&height_en==1'b1)
		height_en <= 1'b0 ;		
		
//������
always@(posedge sclk)
	if(!rst_n)
		width_data <= 16'h0 ;
	else if(width_en == 1'b1)
		width_data <= {width_data[7:0],dout_o};

//������
always@(posedge sclk )
	if(!rst_n)
		height_data <= 16'b0 ;
	else if(height_en == 1'b1)
		height_data <= {height_data[7:0],dout_o} ;
always@(posedge sclk )
	if(!rst_n)
		begin_flag <= 0 ;
	else 
		begin_flag <=	height_en;	
		
		
		
//�˷�������	
wire	[15:0]	mult_w;	
wire	[15:0]	mult_h;	
assign mult_w =width_data+1;
assign	mult_h=height_data+1;
mult_gen_0 multiplier_inst (
 .CLK(sclk), // input wire CLK
 .A(mult_w),   // input wire [15 : 0] A
 .B(mult_h),   // input wire [15 : 0] B
 .P(rlst)   // output wire [31 : 0] P
);	

	
//��⵽ͼ���ͷ����������
always @(posedge sclk )
	if(!rst_n)
		start_image_en <= 1'b0 ;
	else if(rd_cnt ==52&&start_image_en==1)
		start_image_en <= 1'b0 ;
	else if(rd_cnt == 50 && cnt_aa==7&&(dout_o == 8'hf6 || dout_o == 8'hf5) )
		start_image_en <= 1'b1 ;
//��ͼ����Ϣʱ���ߣ���У����=ǰ����
always @(posedge sclk )
	if(!rst_n)
		image_en <= 1'b0 ;
	else if(rd_cnt == 12'd52 && start_image_en == 1'b1 )
		image_en <= 1'b1 ;	
	else if(rd_cnt ==Latch_max-3)	
		image_en <= 1'b0 ;
always@(posedge sclk)
	if(!rst_n)
		rgb_data <= 8'd0;
	else if(image_en==1'b1)
		rgb_data <= dout_o;
	else  
		rgb_data <= 8'h00;
always@(posedge sclk)
	if(!rst_n)
		rgb_en <= 1'b0 ;
	else  
		rgb_en <= image_en;

endmodule