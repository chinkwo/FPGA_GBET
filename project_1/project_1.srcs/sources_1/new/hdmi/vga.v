//vga模块  1024x768@60Hz  时钟65MHz
module	vga(
input	wire		vga_clk		,
input	wire		s_rst_n		,
output	wire		h_sync		,	
output	wire		v_sync		,
output	reg		h_de,
output	reg		de		,//有效区域
output	wire		po_start_flag	//一场图像的开始时刻
);
reg[10:0]	h_cnt;	
reg[10:0]	v_cnt;	
parameter	
		H_ALL	=	1344,	//行总像素点
		H_SYNC	=	136,	//行同步时间	
		H_BP	=	160,	//行后肩时间
		H_LB	=	0,	//行左边框时间
		H_ACT	=	1024,	//行有效区域像素点
		H_RB	=	0,	//行右边框时间	
		H_FP	=	24,	//行前肩时间
		V_ALL	=	806,	//场总行数点      
		V_SYNC	=	6,	//行同步时间	  	
		V_BP	=	29,	//行后肩时间      
		V_TB	=	0,	//行上边框时间    
		V_ACT	=	768,	//场有效区域行数
		V_BB	=	0,	//场右边框时间	  
		V_FP	=	3;      //场前肩时间 

//po_start_flag一场图像的开始时刻		
assign	po_start_flag	=(h_cnt==H_SYNC&&v_cnt==V_SYNC)?1'b1:1'b0;

//产生行列同步
assign	h_sync	=	(h_cnt<=H_SYNC-1'b1)?1'b1:1'b0;
assign	v_sync	=	(v_cnt<=V_SYNC-1'b1)?1'b1:1'b0;

/********************************行扫描计数器*******************************/		
always@(posedge	vga_clk	or	negedge	s_rst_n)
	if(s_rst_n==1'b0)
		h_cnt	<=	10'd0;
	else if(h_cnt==H_ALL-1'b1)
		h_cnt	<=	10'd0;
	else
		h_cnt	<=	h_cnt+1'b1;


/*******列扫描计数器********/		
always@(posedge	vga_clk	or	negedge	s_rst_n)
	if(s_rst_n==1'b0)
		v_cnt	<=	10'd0;
	else if(h_cnt==(H_ALL-1'b1)&&v_cnt==(V_ALL-1'b1))
		v_cnt	<=	10'd0;
	else if(h_cnt==(H_ALL-1'b1))
		v_cnt	<=	v_cnt+1'b1;
always@(posedge vga_clk  or negedge s_rst_n)
	if(!s_rst_n)
		h_de  <=  1'b0  ;
	else   if(h_cnt >293 &&  h_cnt  < 1318 && v_cnt  > 34  &&  v_cnt  < 803  )
		h_de  <=  1'b1  ;
	else    h_de  <=  1'b0  ;	
always@(posedge  vga_clk)
		de  <=  h_de;
endmodule