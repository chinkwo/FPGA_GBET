/******************************************/
//本模块针对于千兆rx仿真模拟一针1024*768数据
/******************************************/
module	tx_data_up(
	input	wire	sclk,rst_n,
	input	wire	start_flag,
	
	output	reg[7:0]	data_o,
	output	reg		data_en

);


reg		start_flag1,start_flag2;
reg		cnt_head_en;
reg[8:0]	cnt_head;
reg		cnt_rgb_en;
reg[10:0]	cnt_rgb;
reg		dly_en;
reg[6:0]	dly_cnt;
reg[1:0]	bao_cnt;
reg[9:0]	row_cnt;
always @(posedge sclk or negedge rst_n)
	if(!rst_n)begin
		start_flag1 <= 0;
		start_flag2 <= 0;
	end 
	else begin
		start_flag1 <= start_flag;
		start_flag2 <= start_flag1;
	end 

always @(posedge sclk or negedge rst_n)
	if(!rst_n)
		cnt_head_en <= 0;
	else if(start_flag1==1&&start_flag2==0)
		cnt_head_en <= 1;
	else if(cnt_head==309)
		cnt_head_en <= 0;
always @(posedge sclk or negedge rst_n)
	if(!rst_n)
		cnt_head <= 0;
	else if(cnt_head_en==1)
		cnt_head <= cnt_head+1;
	else 
		cnt_head <= 0;

always @(posedge sclk or negedge rst_n)
	if(!rst_n)
		dly_en <= 0;
	else if(cnt_head==309 ||(cnt_rgb==1263)||(cnt_rgb==735&&bao_cnt==2&&row_cnt!=767))
		dly_en <= 1;
	else if(dly_cnt==100)
		dly_en <= 0;
always @(posedge sclk or negedge rst_n)
	if(!rst_n)
		dly_cnt <= 0;
	else if(dly_en==1)
		dly_cnt <= dly_cnt+1;
	else 
		dly_cnt <= 0;

always @(posedge sclk or negedge rst_n)
	if(!rst_n)
		cnt_rgb_en <= 0;
	else if(dly_cnt==100)
		cnt_rgb_en <= 1;
	else if(cnt_rgb==1263||(bao_cnt==2&&cnt_rgb==735))
		cnt_rgb_en <= 0;

always @(posedge sclk or negedge rst_n)
	if(!rst_n)
		cnt_rgb <= 0;
	else if(cnt_rgb_en==1)
		cnt_rgb <= cnt_rgb+1;
	else 
		cnt_rgb <= 0;
				
always @(posedge sclk or negedge rst_n)
	if(!rst_n)
		bao_cnt <= 0;
	else if(cnt_rgb==1263)
		bao_cnt <= bao_cnt+1;
	else if(bao_cnt==2&&cnt_rgb==735)
		bao_cnt <= 0;		
		

always @(posedge sclk or negedge rst_n)
	if(!rst_n)
		row_cnt <= 0;
	else if(row_cnt==768)
		row_cnt <= 0;
	else if(bao_cnt==2&&cnt_rgb==735)
		row_cnt <= row_cnt+1;	
		


always @(posedge sclk or negedge rst_n)
	if(!rst_n)
		data_o <= 0;
	else if((cnt_head<7&&cnt_head_en==1)||(cnt_rgb<7&&cnt_rgb_en==1))
		data_o <= 8'h55;
	else if((cnt_head==7)||(cnt_rgb==7))
		data_o <= 8'hd5;
	else if((cnt_head>=50 &&cnt_head<=56)||(cnt_rgb>=50&&cnt_rgb<=56))
		data_o <= 8'haa;	
	else if(cnt_head==57)
		data_o <= 8'hfa;
	else if(cnt_rgb==57&&row_cnt==767)
		data_o <= 8'hf6;	
	else if(cnt_rgb==57)
		data_o <= 8'hf5;
	else if(cnt_head_en==1)
		data_o <=  cnt_head-7;		
	else if(cnt_rgb_en==1)
		data_o <=  cnt_rgb-7;		
	else
		data_o <= 0;	
always @(posedge sclk or negedge rst_n)
	if(!rst_n)
		data_en <= 	0;
	else if(cnt_head_en==1 || cnt_rgb_en==1)
		data_en <= 	1;
	else 
		data_en <= 	0;
endmodule