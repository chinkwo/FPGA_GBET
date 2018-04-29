//********************************************
//**********图像信息采集模块******************
//********************************************
module image_ctrl(
	input	wire		sclk,
	input	wire		rst_n,
	
	input	wire		dout_en_o,
	input	wire[7:0]	dout_o,
	input	wire[5:0]	rd_cnt,
	input	wire[5:0]	Latch_max,//锁存的w_cnt-1的值
	
	output	reg		begin_flag, 
	output	wire[31:0]	rlst,//图像的w*h的值
	output	reg		rgb_en,//与po_rx_data同步的使能
	output	reg[7:0]	rgb_data//图像信息
);
reg[2:0]	cnt_aa;
reg		width_en;//宽度信息标志位
reg[15:0]	width_data;//宽度数据
reg		height_en;//高度信息标志位
reg[15:0]	height_data;//高度数据



reg		start_image_en;//检测到f5或f6时拉高
reg		image_en;//检测到f5或f6时拉高


always@(posedge sclk )
	if(!rst_n)
		cnt_aa<= 'b0 ;
	else if(rd_cnt>=43 && rd_cnt <=49 &&dout_o==8'haa )
		cnt_aa <= cnt_aa+1 ;
	else
		cnt_aa<= 'b0 ;
//宽标志位
always@(posedge sclk )
	if(!rst_n)
		width_en<= 1'b0 ;
	else if(cnt_aa==7&&dout_o==8'hfa&&rd_cnt ==50)
		width_en <= 1'b1 ;
	else if(rd_cnt==12'd52 && width_en==1'b1)
		width_en <= 1'b0 ;
//高标志
always@(posedge sclk )
	if(!rst_n)
		height_en <= 1'b0 ;
	else if(rd_cnt==12'd52 && width_en==1'b1)
		height_en <= 1'b1 ;		
	else if(rd_cnt == 12'd54&&height_en==1'b1)
		height_en <= 1'b0 ;		
		
//宽数据
always@(posedge sclk)
	if(!rst_n)
		width_data <= 16'h0 ;
	else if(width_en == 1'b1)
		width_data <= {width_data[7:0],dout_o};

//高数据
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
		
		
		
//乘法器例化	
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

	
//检测到图像的头数据是拉高
always @(posedge sclk )
	if(!rst_n)
		start_image_en <= 1'b0 ;
	else if(rd_cnt ==52&&start_image_en==1)
		start_image_en <= 1'b0 ;
	else if(rd_cnt == 50 && cnt_aa==7&&(dout_o == 8'hf6 || dout_o == 8'hf5) )
		start_image_en <= 1'b1 ;
//在图像信息时拉高，在校验码=前拉低
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