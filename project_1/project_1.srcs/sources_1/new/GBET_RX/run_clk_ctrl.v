//********************************************************
//**********rx˫������ȥ֡ͷģ��**************************
//********************************************************
//rx���յ�����ȥ��֡ͷ7*55+1*d5,�浽ram�У��ڶ���������һģ��
module run_clk_ctrl(
	input	wire		rx_clk,//phy������125Mʱ��
	input	wire		sclk,//ϵͳ125mʱ��
	input	wire		rst_n,

	input	wire		rx_en,//˫�ص�rxʹ��
	input	wire[7:0]	rx_data,//˫�ص�rx����
	
	output	reg		dout_en_o,//ram������������ͬ����ʹ��
	output	wire[7:0]	dout_o,//ram������
	output	reg[5:0]	rd_cnt,//��������������Ϊ1��Ӧread_data_o�ĵ�һ����
	output	reg[5:0]	Latch_max   
);
reg[5:0]	w_cnt   ;//дram�ļ���
reg		Wr_clr_flag   ;//��w_cnt�����־λ
reg[2:0]	cnt_55  ;//֡ͷ55����
reg		Mac_en  =  1'b0;//����⵽7*55  һ��d5������
reg		Mac_en_dly ;//Mac_en��һ��
reg[7:0]	rx_data_dly;
reg		Latch_flag   ;//��Mac_en�½�������һ��ʱ��

reg		Mac_en_dly1,Mac_en_dly2,Mac_en_dly3,Mac_en_dly4;//��sclkʱ���¶�Mac_en��ʱ
reg		Mac_en_dly5,Mac_en_dly6,Mac_en_dly7;
reg		rd_start;
reg		rd_en;
//��֡ͷ55����
always@(posedge rx_clk )
	if(!rst_n)
		cnt_55 <= 0 ;
	else if(rx_data==  8'h55 && Mac_en==0)
		cnt_55 <= cnt_55+1'b1  ;
	else	
		cnt_55 <= 0 ;
//��⵽7*55��һ��d5������
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
	
//дram�ļ�����
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
//��Latch_flagλ1ʱ��w_cnt-1����
always @(posedge  rx_clk  )
	if(!rst_n)
		Latch_max  <=   'd0  ;
	else if(Wr_clr_flag==1)
		Latch_max  <=   'd0  ;
	else  if(Latch_flag  ==  1'b1)
		Latch_max  <=  w_cnt  -  1'd1  ; 
		
/******************************************/	
//ϵͳ125Mʱ�Ӵ���	
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

//��ram��ʼ��־λ			
always@( posedge sclk  )
	if(!rst_n)
		rd_start  <=  1'b0  ;
	else  if(Mac_en_dly6==1'b1  &&  Mac_en_dly7==1'b0)
		rd_start  <=  1'b1  ;
	else
		rd_start  <=  1'b0  ;
//��ramʹ��
always@(posedge sclk )
	if(!rst_n)
		rd_en  <=  1'b0  ;
	else  if(Mac_en_dly5  ==  1'b0  &&  rd_cnt  ==  Latch_max)
		rd_en  <=  1'b0  ;
	else  if(rd_start  ==  1'b1)
		rd_en  <=  1'b1	;
//������
always@(posedge sclk  )
	if(!rst_n)
		rd_cnt  <=  6'h0  ;
	else  if(rd_start==1'b1)
		rd_cnt  <=  6'h0  ;
	else  if(rd_en==1'b1)
		rd_cnt  <=  rd_cnt  +  1'b1  ;
//��read_en_oͬ�����ź�
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