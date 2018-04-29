module top_ddr3_GEBT_HDMI(
input	wire		sclk	,//input 1bit
input	wire		rst_n	,//input 1bit
//*********ddr3 ****//
inout 	wire[15:0]	ddr3_dq	,
inout 	wire[1:0]	ddr3_dqs_n	,
inout 	wire[1:0]	ddr3_dqs_p	,
output wire[13:0]	ddr3_addr	,
output wire[2:0]	ddr3_ba	,
output	wire		ddr3_ras_n	,
output	wire		ddr3_cas_n	,
output	wire		ddr3_we_n	,
output	wire		ddr3_reset_n	,
output wire[0:0]	ddr3_ck_p	,
output wire[0:0]	ddr3_ck_n	,
output wire[0:0]	ddr3_cke	,
output wire[1:0]	ddr3_dm	,
output wire[0:0]	ddr3_odt	,
//*********hdmi********//
output	wire		tmds_clk_p	,
output	wire		tmds_clk_n	,
output	wire		tmds_r_p	,
output	wire		tmds_r_n	,
output	wire		tmds_g_p	,
output	wire		tmds_g_n	,
output	wire		tmds_b_p	,
output	wire		tmds_b_n	,
output	wire		hdmi_en	,
//*********regmii*******//
input	wire		rx_clk	,//千兆以太网的125m时钟
input	wire		rx_ctrl	,//千兆以太网有效信号
input	wire[3:0]	rx_dat,//双沿采样
output	wire		phy_rst_n ,
output	wire		tx_clk	,//千兆以太网的125m时钟
output	wire		tx_ctrl	,//千兆以太网有效信号
output	wire[3:0]	tx_dat//双沿采样
);
//--------------p1 wr----------------
wire		p1_wr_cmd_clk	;//input 1bit
wire		p1_wr_cmd_en	;//input 1bit
wire[2:0]	p1_wr_cmd_instr;//input 3bit
wire[6:0]	p1_wr_cmd_bl	;//input 6bit
wire[27:0]	p1_wr_cmd_init_addr;//input 29bit
wire		p1_wr_cmd_empty;//input 1bit
wire		p1_wr_cmd_full;//input 1bit
wire		p1_wr_clk	;//input 1bit
wire		p1_wr_en	;//input 1bit
wire[15:0]	p1_wr_mask	;//input 16bit
wire[127:0]	p1_wr_data	;//input 128bit
wire[5:0]	p1_wr_count	;//input 6bit
wire		p1_wr_empty	;//input 1bit
wire		p1_wr_full	;//input 1bit
//--------------p2 wr----------------
wire		p2_wr_cmd_clk	;//input 1bit
wire		p2_wr_cmd_en	;//input 1bit
wire[2:0]	p2_wr_cmd_instr;//input 3bit
wire[6:0]	p2_wr_cmd_bl	;//input 6bit
wire[27:0]	p2_wr_cmd_init_addr;//input 29bit
wire		p2_wr_cmd_empty;//input 1bit
wire		p2_wr_cmd_full;//input 1bit
wire		p2_wr_clk	;//input 1bit
wire		p2_wr_en	;//input 1bit
wire[15:0]	p2_wr_mask	;//input 16bit
wire[127:0]	p2_wr_data	;//input 128bit
wire[5:0]	p2_wr_count	;//input 6bit
wire		p2_wr_empty	;//input 1bit
wire		p2_wr_full	;//input 1bit
//--------------p3 wr----------------
wire		p3_wr_cmd_clk	;//input 1bit
wire		p3_wr_cmd_en	;//input 1bit
wire[2:0]	p3_wr_cmd_instr;//input 3bit
wire[6:0]	p3_wr_cmd_bl	;//input 6bit
wire[27:0]	p3_wr_cmd_init_addr;//input 29bit
wire		p3_wr_cmd_empty;//input 1bit
wire		p3_wr_cmd_full;//input 1bit
wire		p3_wr_clk	;//input 1bit
wire		p3_wr_en	;//input 1bit
wire[15:0]	p3_wr_mask	;//input 16bit
wire[127:0]	p3_wr_data	;//input 128bit
wire[5:0]	p3_wr_count	;//input 6bit
wire		p3_wr_empty	;//input 1bit
wire		p3_wr_full	;//input 1bit
//--------------p4 wr----------------
wire		p4_wr_cmd_clk	;//input 1bit
wire		p4_wr_cmd_en	;//input 1bit
wire[2:0]	p4_wr_cmd_instr;//input 3bit
wire[5:0]	p4_wr_cmd_bl	;//input 6bit
wire[27:0]	p4_wr_cmd_init_addr;//input 29bit
wire		p4_wr_cmd_empty;//input 1bit
wire		p4_wr_cmd_full;//input 1bit
wire		p4_wr_clk	;//input 1bit
wire		p4_wr_en	;//input 1bit
wire[15:0]	p4_wr_mask	;//input 16bit
wire[127:0]	p4_wr_data	;//input 128bit
wire[5:0]	p4_wr_count	;//input 6bit
wire		p4_wr_empty	;//input 1bit
wire		p4_wr_full	;//input 1bit
//--------------p5 rd----------------
wire		p5_rd_cmd_clk	;//input 1bit
wire		p5_rd_cmd_en	;//input 1bit
wire[2:0]	p5_rd_cmd_instr;//input 3bit
wire[6:0]	p5_rd_cmd_bl	;//input 6bit
wire[27:0]	p5_rd_cmd_init_addr;//input 29bit                 
wire		p5_rd_cmd_empty;//input 1bit
wire		p5_rd_cmd_full;//input 1bit
wire		p5_rd_clk	;//input 1bit
wire		p5_rd_en	;//input 1bit
wire[127:0]	p5_rd_data	;//output 128bit                          
wire[5:0]	p5_rd_count	;//input 6bit
wire		p5_rd_empty	;//input 1bit
wire		p5_rd_full	;//input 1bit
//--------------p6 rd----------------
wire		p6_rd_cmd_clk	;//input 1bit
wire		p6_rd_cmd_en	;//input 1bit
wire[2:0]	p6_rd_cmd_instr;//input 3bit
wire[6:0]	p6_rd_cmd_bl	;//input 6bit
wire[27:0]	p6_rd_cmd_init_addr;//input 29bit                  
wire		p6_rd_cmd_empty;//input 1bit
wire		p6_rd_cmd_full;//input 1bit
wire		p6_rd_clk	;//input 1bit
wire		p6_rd_en	;//input 1bit                                
wire[127:0]	p6_rd_data	;//output 128bit                          
wire[5:0]	p6_rd_count	;//input 6bit
wire		p6_rd_empty	;//input 1bit
wire		p6_rd_full	;//input 1bit
//--------------p7 rd----------------
wire		p7_rd_cmd_clk	;//input 1bit
wire		p7_rd_cmd_en	;//input 1bit
wire[2:0]	p7_rd_cmd_instr;//input 3bit
wire[6:0]	p7_rd_cmd_bl	;//input 6bit
wire[27:0]	p7_rd_cmd_init_addr;//input 29bit                 
wire		p7_rd_cmd_empty;//input 1bit
wire		p7_rd_cmd_full;//input 1bit
wire		p7_rd_clk	;//input 1bit
wire		p7_rd_en	;//input 1bit                              
wire[127:0]	p7_rd_data	;//output 128bit                          
wire[6:0]	p7_rd_count	;//input 6bit
wire		p7_rd_empty	;//input 1bit
wire		p7_rd_full	;//input 1bit
//--------------p8 rd----------------
wire		p8_rd_cmd_clk	;//input 1bit
wire		p8_rd_cmd_en	;//input 1bit
wire[2:0]	p8_rd_cmd_instr;//input 3bit
wire[6:0]	p8_rd_cmd_bl	;//input 6bit
wire[27:0]	p8_rd_cmd_init_addr;//input 29bit                 
wire		p8_rd_cmd_empty;//input 1bit
wire		p8_rd_cmd_full;//input 1bit
wire		p8_rd_clk	;//input 1bit
wire		p8_rd_en	;//input 1bit
wire[127:0]	p8_rd_data	;//output 128bit                          
wire[5:0]	p8_rd_count	;//input 6bit
wire		p8_rd_empty	;//input 1bit
wire		p8_rd_full	;//input 1bit


wire		video_h_de	;
wire		frame_head	;
wire		hdmi_clk	;
wire		hdmi_5xclk	;

wire		clk_200M	; 
wire		sclk_125M	; 
wire		rx_clk_90deg	;
wire		clk_125_90deg	;


wire	[7:0]	image_data;
wire		image_en;
wire	[25:0]	rslt   ;   

wire		frame_rx_end;
wire	[9:0]	read_fifo3_rd_count;
wire		read_fifo3_rd_en;
wire	[127:0]	read_fifo3_read_data;
wire		c3_calib_done;
wire	[23:0]	rgb;   
assign  rslt   =  'd3071;//3071<<8;
parameter	BL=63;
parameter	ADDR=512;
//----------- Begin Cut here for INSTANTIATION Template ---// INST_TAG

ddr3_ctrl
#(
//ddr3 sdram
.MEM_ADDR_WITH(14),
.MEM_BANKADDR_WITH(3	),
//user port
.P_ADDR_WITH(28)
)
ddr3_ctrl_inst(
.clk_200M		(clk_200M	),
.rst_n			(rst_n		),
//wr cmd port1
.p1_wr_cmd_clk	(sclk_125M       	),
.p1_wr_cmd_en		(p1_wr_cmd_en		),
.p1_wr_cmd_instr	(3'b0			),
.p1_wr_cmd_bl		(p1_wr_cmd_bl	+1	),
.p1_wr_cmd_init_addr	(p1_wr_cmd_init_addr	),
.p1_wr_cmd_empty	(p1_wr_cmd_empty	),
.p1_wr_cmd_full	(p1_wr_cmd_full	),                     
.p1_wr_clk		(sclk_125M	  	),
.p1_wr_en		(p1_wr_en	  	),
.p1_wr_mask		(p1_wr_mask	   	),
.p1_wr_data		(p1_wr_data	 	),             
.p1_wr_empty		(p1_wr_empty	 	),
.p1_wr_full		(p1_wr_full	 	),
.p1_wr_count		(p1_wr_count		),
//wr cmd port2                          
.p2_wr_cmd_clk	(sclk_125M		),
.p2_wr_cmd_en		(p2_wr_cmd_en		),
.p2_wr_cmd_instr	(3'b0			),
.p2_wr_cmd_bl		(p2_wr_cmd_bl	+1 	),
.p2_wr_cmd_init_addr	(p2_wr_cmd_init_addr),
.p2_wr_cmd_empty	(p2_wr_cmd_empty	),
.p2_wr_cmd_full	(p2_wr_cmd_full	),              
.p2_wr_clk		(sclk_125M		),
.p2_wr_en		(p2_wr_en		),
.p2_wr_mask		(p2_wr_mask		),
.p2_wr_data		(p2_wr_data		),        
.p2_wr_empty		(p2_wr_empty		),
.p2_wr_full		(p2_wr_full	       ),
.p2_wr_count		(p2_wr_count	       ),                                    
//wr cmd port3                           
.p3_wr_cmd_clk	(sclk_125M	       ),
.p3_wr_cmd_en		(p3_wr_cmd_en	       ),
.p3_wr_cmd_instr	(3'b0			),
.p3_wr_cmd_bl		(p3_wr_cmd_bl	+1	),
.p3_wr_cmd_init_addr	(p3_wr_cmd_init_addr	),
.p3_wr_cmd_empty	(p3_wr_cmd_empty	),
.p3_wr_cmd_full	(p3_wr_cmd_full	),                       
.p3_wr_clk		(sclk_125M	       ),
.p3_wr_en		(p3_wr_en	       ),
.p3_wr_mask		(p3_wr_mask	       ),
.p3_wr_data		(p3_wr_data	       ),         
.p3_wr_empty		(p3_wr_empty	  	),
.p3_wr_full		(p3_wr_full	  	),
.p3_wr_count		(p3_wr_count	  	),                                                    
//wr cmd port4                        	                      
.p4_wr_cmd_clk	(sclk_125M	  	),
.p4_wr_cmd_en		(p4_wr_cmd_en	  	),
.p4_wr_cmd_instr	(3'b0			),
.p4_wr_cmd_bl		(p4_wr_cmd_bl	+1 	),
.p4_wr_cmd_init_addr	(p4_wr_cmd_init_addr	),
.p4_wr_cmd_empty	(p4_wr_cmd_empty	),
.p4_wr_cmd_full	(p4_wr_cmd_full	),                                                    
.p4_wr_clk		(sclk_125M	 	),
.p4_wr_en		(p4_wr_en	 	),
.p4_wr_mask		(p4_wr_mask	 	),
.p4_wr_data		(p4_wr_data	 	), 	               	
.p4_wr_empty		(p4_wr_empty	 	),
.p4_wr_full		(p4_wr_full	 	),
.p4_wr_count		(p4_wr_count	 	),                            
//rd cmd port 5                                                   
.p5_rd_cmd_clk	(sclk_125M	       ),
.p5_rd_cmd_en		( p5_rd_cmd_en       ),
.p5_rd_cmd_instr	(3'b1			),
.p5_rd_cmd_bl		(p5_rd_cmd_bl	+1 	),
.p5_rd_cmd_init_addr	(p5_rd_cmd_init_addr	),
.p5_rd_cmd_empty	(p5_rd_cmd_empty	),
.p5_rd_cmd_full	(p5_rd_cmd_full	),                                               
.p5_rd_clk		(sclk_125M		),
.p5_rd_en		(p5_rd_en	       ),
.p5_rd_data_valid	(p5_rd_data_valid	),          
.p5_rd_data		(p5_rd_data		),                         
.p5_rd_empty		(p5_rd_empty		),
.p5_rd_full		(p5_rd_full		),
.p5_rd_count		(p5_rd_count		),  
//rd cmd port6                         
.p6_rd_cmd_clk	(sclk_125M	    	),
.p6_rd_cmd_en		(p6_rd_cmd_en        ),
.p6_rd_cmd_instr	(3'b1			),
.p6_rd_cmd_bl		(p6_rd_cmd_bl	+1 	),
.p6_rd_cmd_init_addr	(p6_rd_cmd_init_addr	),
.p6_rd_cmd_empty	(p6_rd_cmd_empty	),
.p6_rd_cmd_full	(p6_rd_cmd_full	),                                                  
.p6_rd_clk		(sclk_125M	       ),
.p6_rd_en		(p6_rd_en	       ),
.p6_rd_data_valid	(p6_rd_data_valid	),          
.p6_rd_data		(p6_rd_data	       ),                         
.p6_rd_empty		(p6_rd_empty	       ),
.p6_rd_full		(p6_rd_full	       ),
.p6_rd_count		(p6_rd_count	       ), 
//rd cmd port7                                                    
.p7_rd_cmd_clk	(sclk_125M	       ),
.p7_rd_cmd_en		(p7_rd_cmd_en	       ),
.p7_rd_cmd_instr	(3'b1			),
.p7_rd_cmd_bl		(p7_rd_cmd_bl	+1     ),
.p7_rd_cmd_init_addr	(p7_rd_cmd_init_addr	),
.p7_rd_cmd_empty	(p7_rd_cmd_empty	),
.p7_rd_cmd_full	(p7_rd_cmd_full	),                                               
.p7_rd_clk		(sclk_125M		),
.p7_rd_en		(p7_rd_en		),                            	
.p7_rd_data_valid	(),           	               
.p7_rd_data		(p7_rd_data		),                         
.p7_rd_empty		(p7_rd_empty		),
.p7_rd_full		(p7_rd_full		),
.p7_rd_count		(p7_rd_count		),              	                      
//rd cmd port8                      	                      
.p8_rd_cmd_clk	(sclk_125M		),
.p8_rd_cmd_en		(p8_rd_cmd_en		),
.p8_rd_cmd_instr	(3'b1			),
.p8_rd_cmd_bl		(p8_rd_cmd_bl	 +1   	),
.p8_rd_cmd_init_addr	(p8_rd_cmd_init_addr	),
.p8_rd_cmd_empty	(p8_rd_cmd_empty	),
.p8_rd_cmd_full	(p8_rd_cmd_full	),                                                
.p8_rd_clk		(sclk_125M	  	),
.p8_rd_en		(p8_rd_en	  	),
.p8_rd_data_valid	(),             	
.p8_rd_data		(p8_rd_data	  	),                         
.p8_rd_empty		(p8_rd_empty	  	),
.p8_rd_full		(p8_rd_full	  	),
.p8_rd_count		(p8_rd_count	  	),
.init_calib_complete	(c3_calib_done	),
//---------------DDR3 SDRAM-------------
.ddr3_dq		(ddr3_dq		),
.ddr3_dqs_n		(ddr3_dqs_n	       ),
.ddr3_dqs_p		(ddr3_dqs_p	       ),
.ddr3_addr		(ddr3_addr	       ),
.ddr3_ba		(ddr3_ba		),
.ddr3_ras_n		(ddr3_ras_n		),
.ddr3_cas_n		(ddr3_cas_n		),
.ddr3_we_n		(ddr3_we_n		),
.ddr3_reset_n		(ddr3_reset_n		),
.ddr3_ck_p		(ddr3_ck_p		),
.ddr3_ck_n		(ddr3_ck_n	       ),
.ddr3_cke		(ddr3_cke	       ),
.ddr3_cs_n		(ddr3_cs_n	       ),
.ddr3_dm		(ddr3_dm		),
.ddr3_odt		(ddr3_odt	       )
);

contrl_clk  contrl_clk_inst(
.sclk			(sclk			),//input	wire	50	
.rst_n			(rst_n			),//input	wire		
.rx_clk		(rx_clk		),//input	wire			

.ddr3_clk		(clk_200M		),//output	wire	
.user_125M		(sclk_125M		),	
.hdmi_clk		(hdmi_clk		),//output	wire	
.hdmi_5xclk		(hdmi_5xclk		),//output	wire	pin		
.rx_clk_90deg		(rx_clk_90deg		)//output	wire		
		
);

//ddr3写模块，将图片数据写入ddr3
ddr3_p1_write #
(
.WRITE_BL (BL),
.ADDR_BL  (ADDR)
)
ddr3_p1_write_inst (
.sclk			(sclk_125M		), 
.rst_n			(c3_calib_done	), 
.begin_flag		(begin_flag		),//begin_flag
.rx_po_data		(image_data		),//image_data
.rx_po_flag		(image_en		),//img_flag
.c3_p_wr_empty	(p1_wr_empty		),
.c3_p_wr_data		(p1_wr_data		), 
.c3_p_wr_en		(p1_wr_en		), 
.c3_p_wr_mask		(p1_wr_mask		), 
.c3_p_cmd_en		(p1_wr_cmd_en		), 
.rslt			(rslt			),
.c3_p_cmd_instr	(			), 
.c3_p_cmd_bl		(p1_wr_cmd_bl		), 
.c3_p_cmd_byte_addr	(p1_wr_cmd_init_addr	),
.frame_rx_end		(frame_rx_end		)
);
//ddr3 p5端口的读，将读出数据传给hdmi
ddr3_p5_read #
(
.READ_BL (BL )
)
ddr3_p5_read_inst (
.sclk			(sclk_125M		),
.hdmi_clk		(hdmi_clk		),
.rst_n			(c3_calib_done	),
.video_h_de		(video_h_de), 
.c3_p5_rd_count	(p5_rd_count), 
.rslt			(rslt),
.rgb			(rgb),
.begin_flag		(frame_head),
 .c3_p5_rd_data	(p5_rd_data), 
.c3_p5_rd_en		(p5_rd_en), 
.c3_p5_cmd_en		(p5_rd_cmd_en), 
.c3_p5_cmd_instr	(	), 
.c3_p5_cmd_bl		(p5_rd_cmd_bl), 
.c3_p5_cmd_byte_addr	(p5_rd_cmd_init_addr)
);
top_hdmi_out	top_hdmi_out_inst(
	.vga_clk	(hdmi_clk		),//input	wire		
	.vga_5xclk	(hdmi_5xclk	       ),//input	wire		
	.rst_n		(c3_calib_done		),//input	wire		
	.r		(rgb[23:16]		),//input	wire	[7:0]	
	.g		(rgb[15:8]		),//input	wire	[7:0]	
	.b		(rgb[7:0]	       ),//input	wire	[7:0]	
	.h_de		(video_h_de		),//output	wire		
	.frame_head	(frame_head		),//output	wire			                
	.tmds_clk_p	(tmds_clk_p	  	),//output	wire		
	.tmds_clk_n	(tmds_clk_n	 	),//output	wire		
	.tmds_r_p	(tmds_r_p		),//output	wire		
	.tmds_r_n	(tmds_r_n	 	),//output	wire		
	.tmds_g_p	(tmds_g_p	  	),//output	wire		
	.tmds_g_n	(tmds_g_n	 	),//output	wire		
	.tmds_b_p	(tmds_b_p	  	),//output	wire		
	.tmds_b_n	(tmds_b_n	 	),//output	wire		                       
	.hdmi_en      	(hdmi_en      		) //output	wire		
);

 
  //千兆的模块
top_GBET_RX	top_GBET_RX_inst(
	.sclk		(sclk_125M	),//50M经过pll倍频为125M时钟
	.rst_n		(c3_calib_done	),////50M经过pll倍频为125M时钟
	.rx_dat		(rx_dat		),//双沿4bit数据  一个时钟周期传输8bit数据
	.rx_ctrl	(rx_ctrl	),//上升沿对应dv  下降沿对应err
	.rx_clk		(rx_clk_90deg	),//phy时钟相移90度后时钟
	
	.begin_flag	(begin_flag	),
	.rlst		(		),//图像的w*h的值
	.rgb_en		(image_en	),//与po_rx_data同步的使能
	.rgb_data	(image_data	),//图像信息
	.led		(led		),
	.phy_rst_n	(phy_rst_n	)
);  
  



top_GBET_tx top_GBET_tx_inst(
	.sclk			(sclk_125M		),//输入的125M的时钟
	.rst_n			(c3_calib_done		),
	.Rx_end_flag		(frame_rx_end		),//DDR3写结束标志位
	.fifo3_rd_count		(read_fifo3_rd_count	),//DDR3 P3口读fifo计数器
	.fifo3_read_data	(read_fifo3_read_data	),//从DDR3 P3口读fifo的数据
      
	.read_fifo3_rd_en	(read_fifo3_rd_en	),//从DDR3 P3口读fifo的使能信号
	.tx_clk			(tx_clk			),
	.tx_dat			(tx_dat			),
	.tx_dv			(tx_ctrl		)
);

//ddr3 p6 读模块，将数据读出发到桢模块，形成桢，通过tx传出
 ddr3_p6_read #
 (
    .READ_BL (63 )
)
 ddr3_p6_read_inst (
    .sclk(sclk_125M), 
    .rst_n(c3_calib_done), 
    .p6_rd_empty(p6_rd_empty),
    .p6_rd_full	(p6_rd_full	        ),
    .c3_p6_rd_count(p6_rd_count), 
    .c3_p6_rd_data(p6_rd_data), 
    .rslt(rslt), 
    .frame_rx_end(frame_rx_end), 
    .read_fifo3_rd_en(read_fifo3_rd_en), 
    .c3_p6_rd_en(p6_rd_en), 
    .c3_p6_cmd_en(p6_rd_cmd_en), 
    .c3_p6_cmd_instr(), 
    .c3_p6_cmd_bl(p6_rd_cmd_bl), 
    .c3_p6_cmd_byte_addr(p6_rd_cmd_init_addr), 
    .read_fifo3_read_data(read_fifo3_read_data),
    .read_fifo3_rd_count(read_fifo3_rd_count)
    );    
  
endmodule
