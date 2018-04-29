//********************************************************
//**********rx双沿数据去帧头模块**************************
//********************************************************
//rx接收的数据去掉帧头7*55+1*d5,存到ram中，在读出传到下一模块
module run_clk_ctrl(
	input	wire		rx_clk,//phy传来的125M时钟
	input	wire		sclk,//系统125m时钟
	input	wire		rst_n,

	input	wire		rx_en,//双沿的rx使能
	input	wire[7:0]	rx_data,//双沿的rx数据
	
	output	reg		dout_en_o,//ram读出的与数据同步的使能
	output	wire[7:0]	dout_o,//ram的数据
	output	reg[5:0]	rd_cnt,//读计数到计数器为1对应read_data_o的第一个数
	output	reg[5:0]	Latch_max   
);
reg[5:0]	w_cnt   ;//写ram的计数
reg		Wr_clr_flag   ;//对w_cnt清零标志位
reg[2:0]	cnt_55  ;//帧头55计数
reg		Mac_en  =  1'b0;//当检测到7*55  一个d5是拉高
reg		Mac_en_dly ;//Mac_en延一拍
reg[7:0]	rx_data_dly;
reg		Latch_flag   ;//在Mac_en下降沿拉高一个时钟

reg		Mac_en_dly1,Mac_en_dly2,Mac_en_dly3,Mac_en_dly4;//在sclk时钟下对Mac_en延时
reg		Mac_en_dly5,Mac_en_dly6,Mac_en_dly7;
reg		rd_start;
reg		rd_en;
//对帧头55计数
always@(posedge rx_clk )
	if(!rst_n)
		cnt_55 <= 0 ;
	else if(rx_data==  8'h55 && Mac_en==0)
		cnt_55 <= cnt_55+1'b1  ;
	else	
		cnt_55 <= 0 ;
//检测到7*55和一个d5后拉高
always@(posedge rx_clk  or negedge rx_en )
	if(rx_en==  1'b0)
		Mac_en  <=  1'b0 ;
	else	if(cnt_55  ==  3'd7  &&  rx_data  ==  8'hd5)
		Mac_en  <=  1'b1 ;
always@(posedge rx_clk  )
	if(!rst_n)
		begin
			Mac_en_dly   <=  1'b0  ;
			rx_data_dly  <=  8'h0  ;
		end 	
	else	
		begin
			Mac_en_dly   <=  Mac_en ;
			rx_data_dly  <=  rx_data;
		end 	
	
//写ram的计数器
always@(posedge rx_clk  )
	if(!rst_n)
		w_cnt <= 6'd0  ;
	else  if(Wr_clr_flag==1'b1)
		w_cnt <=6'd0  ;
	else  if(Mac_en_dly==1'b1)
		w_cnt <= w_cnt+1'b1;		
always@(posedge rx_clk   )
	if(!rst_n)
		Wr_clr_flag  <=  1'b0  ;
	else  if(rx_data==8'hd5 && cnt_55==3'd7 &&  Mac_en==1'b0)
		Wr_clr_flag  <=  1'b1  ;
	else
		Wr_clr_flag  <=  1'b0  ;
always@(posedge rx_clk )
	if(!rst_n)
		Latch_flag  <=  1'b0  ;
	else  if(Mac_en  ==  1'b0  &&  Mac_en_dly  ==  1'b1)
		Latch_flag  <=  1'b1 ;
	else	
		Latch_flag  <=  1'b0  ;
//当Latch_flag位1时将w_cnt-1锁存
always @(posedge  rx_clk  )
	if(!rst_n)
		Latch_max  <=   'd0  ;
	else if(Wr_clr_flag==1)
		Latch_max  <=   'd0  ;
	else  if(Latch_flag  ==  1'b1)
		Latch_max  <=  w_cnt  -  1'd1  ; 
		
/******************************************/	
//系统125M时钟处理	
/******************************************/		
always@(posedge sclk  )
	if(!rst_n)
		begin
			Mac_en_dly1  <=  1'b0  ;
			Mac_en_dly2  <=  1'b0  ;
			Mac_en_dly3  <=  1'b0  ;
			Mac_en_dly4  <=  1'b0  ;
			Mac_en_dly5  <=  1'b0  ;
			Mac_en_dly6  <=  1'b0  ;
			Mac_en_dly7  <=  1'b0  ;
		end 
	else
		begin
			Mac_en_dly1  <=  Mac_en_dly  ;
			Mac_en_dly2  <=  Mac_en_dly1  ;
			Mac_en_dly3  <=  Mac_en_dly2  ;
			Mac_en_dly4  <=  Mac_en_dly3  ;
			Mac_en_dly5  <=  Mac_en_dly4  ;
			Mac_en_dly6  <=  Mac_en_dly5  ;
			Mac_en_dly7  <=  Mac_en_dly6  ;
		end 	

//读ram开始标志位			
always@( posedge sclk  )
	if(!rst_n)
		rd_start  <=  1'b0  ;
	else  if(Mac_en_dly6==1'b1  &&  Mac_en_dly7==1'b0)
		rd_start  <=  1'b1  ;
	else
		rd_start  <=  1'b0  ;
//读ram使能
always@(posedge sclk )
	if(!rst_n)
		rd_en  <=  1'b0  ;
	else  if(Mac_en_dly5  ==  1'b0  &&  rd_cnt  ==  Latch_max)
		rd_en  <=  1'b0  ;
	else  if(rd_start  ==  1'b1)
		rd_en  <=  1'b1	;
//读计数
always@(posedge sclk  )
	if(!rst_n)
		rd_cnt  <=  6'h0  ;
	else  if(rd_start==1'b1)
		rd_cnt  <=  6'h0  ;
	else  if(rd_en==1'b1)
		rd_cnt  <=  rd_cnt  +  1'b1  ;
//与read_en_o同步的信号
always@(posedge sclk  )
	if(!rst_n)
		dout_en_o  <=  1'b0  ;
	else  
		dout_en_o  <= rd_en;
ram_64x8 ram_64x8_inst (
  .clka(rx_clk),    // input wire clka
  .wea(Mac_en_dly),      // input wire [0 : 0] wea
  .addra(w_cnt),  // input wire [5 : 0] addra
  .dina(rx_data_dly),    // input wire [7 : 0] dina
  .clkb(sclk),    // input wire clkb
  .addrb(rd_cnt),  // input wire [5 : 0] addrb
  .doutb(dout_o)  // output wire [7 : 0] doutb
);
		
endmodule