module	wr_path_ctrl(
input	wire		ui_clk		,// 
//cmd port1
input	wire		p1_wr_cmd_clk	,//命令fifo写时钟
input	wire		p1_wr_cmd_en	,//命令fifo写使能
input	wire[2:0]	p1_wr_cmd_instr	,//ddr3 写指令 3'b000
input	wire[6:0]	p1_wr_cmd_bl	,//ddr3 写突发长度 1~64代表写入1~64个数
input	wire[27:0]	p1_wr_cmd_init_addr,//ddr3 写突发的初始地址
output	wire		p1_wr_cmd_empty	,//命令fifo空标志
output	wire		p1_wr_cmd_full	,//命令fifo满标志
input	wire		p1_wr_clk	,//数据fifo写时钟
input	wire		p1_wr_en		,//数据fifo写使能
input	wire[15:0]	p1_wr_mask	,//掩码
input	wire[127:0]	p1_wr_data	,//写数据
output	wire		p1_wr_empty	,//数据fifo空标志
output	wire		p1_wr_full	,//数据fifo满标志
output	wire[5:0]	p1_wr_count	,//数据fifo内数据量
input	wire		wr1_cmd_en	,//命令fifo读使能
output	wire[2:0]	wr1_cmd_instr	,//ddr3 写指令 3'b000
output	wire[6:0]	wr1_cmd_bl	,//ddr3 写突发长度 1~64代表写入1~64个数
output	wire[27:0]	wr1_cmd_init_addr,//ddr3 写突发的初始地址
output	wire		wr1_cmd_empty	,//命令fifo空标志
output	wire		wr1_cmd_full	,//命令fifo满标志
input	wire		wr1_en		,//数据fifo读使能
output	wire[15:0]	wr1_mask	,//掩码
output	wire[127:0]	wr1_data	,//写数据
//cmd port2
input	wire		p2_wr_cmd_clk	,//命令fifo写时钟
input	wire		p2_wr_cmd_en	,//命令fifo写使能
input	wire[2:0]	p2_wr_cmd_instr	,//ddr3 写指令 3'b000
input	wire[6:0]	p2_wr_cmd_bl	,//ddr3 写突发长度 1~64代表写入1~64个数
input	wire[27:0]	p2_wr_cmd_init_addr,//ddr3 写突发的初始地址
output	wire		p2_wr_cmd_empty	,//命令fifo空标志
output	wire		p2_wr_cmd_full	,//命令fifo满标志
input	wire		p2_wr_clk	,//数据fifo写时钟
input	wire		p2_wr_en		,//数据fifo写使能
input	wire[15:0]	p2_wr_mask	,//掩码
input	wire[127:0]	p2_wr_data	,//写数据
output	wire		p2_wr_empty	,//数据fifo空标志
output	wire		p2_wr_full	,//数据fifo满标志
output	wire[5:0]	p2_wr_count	,//数据fifo内数据量
input	wire		wr2_cmd_en	,//命令fifo读使能
output	wire[2:0]	wr2_cmd_instr	,//ddr3 写指令 3'b000
output	wire[6:0]	wr2_cmd_bl	,//ddr3 写突发长度 1~64代表写入1~64个数
output	wire[27:0]	wr2_cmd_init_addr,//ddr3 写突发的初始地址
output	wire		wr2_cmd_empty	,//命令fifo空标志
output	wire		wr2_cmd_full	,//命令fifo满标志
input	wire		wr2_en		,//数据fifo读使能
output	wire[15:0]	wr2_mask	,//掩码
output	wire[127:0]	wr2_data	,//写数据
//cmd port3
input	wire		p3_wr_cmd_clk	,//命令fifo写时钟
input	wire		p3_wr_cmd_en	,//命令fifo写使能
input	wire[2:0]	p3_wr_cmd_instr,//ddr3 写指令 3'b000
input	wire[6:0]	p3_wr_cmd_bl,//ddr3 写突发长度 1~64代表写入1~64个数
input	wire[27:0]	p3_wr_cmd_init_addr,//ddr3 写突发的初始地址
output	wire		p3_wr_cmd_empty,//命令fifo空标志
output	wire		p3_wr_cmd_full,//命令fifo满标志
input	wire		p3_wr_clk	,//数据fifo写时钟
input	wire		p3_wr_en		,//数据fifo写使能
input	wire[15:0]	p3_wr_mask	,//掩码
input	wire[127:0]	p3_wr_data	,//写数据
output	wire		p3_wr_empty	,//数据fifo空标志
output	wire		p3_wr_full	,//数据fifo满标志
output	wire[5:0]	p3_wr_count	,//数据fifo内数据量
input	wire		wr3_cmd_en	,//命令fifo读使能
output	wire[2:0]	wr3_cmd_instr	,//ddr3 写指令 3'b000
output	wire[6:0]	wr3_cmd_bl	,//ddr3 写突发长度 1~64代表写入1~64个数
output	wire[27:0]	wr3_cmd_init_addr,//ddr3 写突发的初始地址
output	wire		wr3_cmd_empty	,//命令fifo空标志
output	wire		wr3_cmd_full	,//命令fifo满标志
input	wire		wr3_en		,//数据fifo读使能
output	wire[15:0]	wr3_mask	,//掩码
output	wire[127:0]	wr3_data	,//写数据
//cmd port4
input	wire		p4_wr_cmd_clk	,//命令fifo写时钟
input	wire		p4_wr_cmd_en	,//命令fifo写使能
input	wire[2:0]	p4_wr_cmd_instr	,//ddr3 写指令 3'b000
input	wire[6:0]	p4_wr_cmd_bl	,//ddr3 写突发长度 1~64代表写入1~64个数
input	wire[27:0]	p4_wr_cmd_init_addr,//ddr3 写突发的初始地址
output	wire		p4_wr_cmd_empty	,//命令fifo空标志
output	wire		p4_wr_cmd_full	,//命令fifo满标志
input	wire		p4_wr_clk	,//数据fifo写时钟
input	wire		p4_wr_en		,//数据fifo写使能
input	wire[15:0]	p4_wr_mask	,//掩码
input	wire[127:0]	p4_wr_data	,//写数据
output	wire		p4_wr_empty	,//数据fifo空标志
output	wire		p4_wr_full	,//数据fifo满标志
output	wire[5:0]	p4_wr_count	,//数据fifo内数据量
input	wire		wr4_cmd_en	,//命令fifo读使能
output	wire[2:0]	wr4_cmd_instr	,//ddr3 写指令 3'b000
output	wire[6:0]	wr4_cmd_bl	,//ddr3 写突发长度 1~64代表写入1~64个数
output	wire[27:0]	wr4_cmd_init_addr,//ddr3 写突发的初始地址
output	wire		wr4_cmd_empty	,//命令fifo空标志
output	wire		wr4_cmd_full	,//命令fifo满标志
input	wire		wr4_en		,//数据fifo读使能
output	wire[15:0]	wr4_mask	,//掩码
output	wire[127:0]	wr4_data	//写数据
);

//write path 1
wr_fifo_path	wr_fifo_path1_inst(
.ui_clk		(ui_clk		 ),// 
                                      
//--------fifo write port------------------
//cmd port                              
.p_wr_cmd_clk		(p1_wr_cmd_clk	),//命令fifo写时钟
.p_wr_cmd_en		(p1_wr_cmd_en	 	),//命令fifo写使能
.p_wr_cmd_instr	(p1_wr_cmd_instr	),//ddr3 写指令 3'b000
.p_wr_cmd_bl		(p1_wr_cmd_bl	 	),//ddr3 写突发长度 1~64代表写入1~64个数
.p_wr_cmd_init_addr	(p1_wr_cmd_init_addr	),//ddr3 写突发的初始地址
.p_wr_cmd_empty	(p1_wr_cmd_empty	),//命令fifo空标志
.p_wr_cmd_full	(p1_wr_cmd_full	),//命令fifo满标志                            
.p_wr_clk		(p1_wr_clk	       ),//数据fifo写时钟
.p_wr_en		(p1_wr_en		),//数据fifo写使能
.p_wr_mask		(p1_wr_mask	       ),//掩码
.p_wr_data		(p1_wr_data	       ),//写数据      
.p_wr_empty		(p1_wr_empty	       ),//数据fifo空标志
.p_wr_full		(p1_wr_full	       ),//数据fifo满标志
.p_wr_count		(p1_wr_count	       ),//数据fifo内数据量                           
.wr_cmd_en		(wr1_cmd_en	    	),//命令fifo读使能      
.wr_cmd_instr		(wr1_cmd_instr	),//ddr3 写指令 3'b000
.wr_cmd_bl		(wr1_cmd_bl	  	),//ddr3 写突发长度 1~64代表写入1~64个数
.wr_cmd_init_addr	(wr1_cmd_init_addr	),//ddr3 写突发的初始地址 
.wr_cmd_empty		(wr1_cmd_empty	),//命令fifo空标志
.wr_cmd_full		(wr1_cmd_full	       ),//命令fifo满标志                          
.wr_en			(wr1_en		),//数据fifo读使能           
.wr_mask		(wr1_mask		),//掩码
.wr_data		(wr1_data		)//写数据
);

//write path 2
wr_fifo_path	wr_fifo_path2_inst(
.ui_clk		(ui_clk		),//                       
.p_wr_cmd_clk		(p2_wr_cmd_clk	),//命令fifo写时钟
.p_wr_cmd_en		(p2_wr_cmd_en	 	),//命令fifo写使能
.p_wr_cmd_instr	(p2_wr_cmd_instr	),//ddr3 写指令 3'b000
.p_wr_cmd_bl		(p2_wr_cmd_bl	 	),//ddr3 写突发长度 1~64代表写入1~64个数
.p_wr_cmd_init_addr	(p2_wr_cmd_init_addr),//ddr3 写突发的初始地址
.p_wr_cmd_empty	(p2_wr_cmd_empty	),//命令fifo空标志
.p_wr_cmd_full	(p2_wr_cmd_full	),//命令fifo满标志                           
.p_wr_clk		(p2_wr_clk		),//数据fifo写时钟
.p_wr_en		(p2_wr_en		),//数据fifo写使能
.p_wr_mask		(p2_wr_mask	  	),//掩码
.p_wr_data		(p2_wr_data	  	),//写数据            
.p_wr_empty		(p2_wr_empty	  	),//数据fifo空标志
.p_wr_full		(p2_wr_full	  	),//数据fifo满标志
.p_wr_count		(p2_wr_count	  	),//数据fifo内数据量                           
.wr_cmd_en		(wr2_cmd_en		),//命令fifo读使能            
.wr_cmd_instr		(wr2_cmd_instr	),//ddr3 写指令 3'b000
.wr_cmd_bl		(wr2_cmd_bl	  	),//ddr3 写突发长度 1~64代表写入1~64个数
.wr_cmd_init_addr	(wr2_cmd_init_addr	),//ddr3 写突发的初始地址      
.wr_cmd_empty		(wr2_cmd_empty	),//命令fifo空标志
.wr_cmd_full		(wr2_cmd_full	   	),//命令fifo满标志                           
.wr_en			(wr2_en		),//数据fifo读使能             
.wr_mask		(wr2_mask		),//掩码
.wr_data		(wr2_data		)//写数据
);

//write path 3
wr_fifo_path	wr_fifo_path3_inst(
.ui_clk		(ui_clk		),//                             
.p_wr_cmd_clk		(p3_wr_cmd_clk	),//命令fifo写时钟
.p_wr_cmd_en		(p3_wr_cmd_en		),//命令fifo写使能
.p_wr_cmd_instr	(p3_wr_cmd_instr	),//ddr3 写指令 3'b000
.p_wr_cmd_bl		(p3_wr_cmd_bl	 	),//ddr3 写突发长度 1~64代表写入1~64个数
.p_wr_cmd_init_addr	(p3_wr_cmd_init_addr	),//ddr3 写突发的初始地址                     	
.p_wr_cmd_empty	(p3_wr_cmd_empty	),//命令fifo空标志
.p_wr_cmd_full	(p3_wr_cmd_full	),//命令fifo满标志                     
.p_wr_clk		(p3_wr_clk	       ),//数据fifo写时钟
.p_wr_en		(p3_wr_en		),//数据fifo写使能
.p_wr_mask		(p3_wr_mask	       ),//掩码
.p_wr_data		(p3_wr_data	       ),//写数据           
.p_wr_empty		(p3_wr_empty	       ),//数据fifo空标志
.p_wr_full		(p3_wr_full	       ),//数据fifo满标志
.p_wr_count		(p3_wr_count	       ),//数据fifo内数据量                          
.wr_cmd_en		(wr3_cmd_en	       ),//命令fifo读使能        
.wr_cmd_instr		(wr3_cmd_instr	),//ddr3 写指令 3'b000
.wr_cmd_bl		(wr3_cmd_bl	       ),//ddr3 写突发长度 1~64代表写入1~64个数
.wr_cmd_init_addr	(wr3_cmd_init_addr   ),//ddr3 写突发的初始地址             
.wr_cmd_empty		(wr3_cmd_empty	),//命令fifo空标志
.wr_cmd_full		(wr3_cmd_full	       ),//命令fifo满标志                
.wr_en			(wr3_en		),//数据fifo读使能           
.wr_mask		(wr3_mask		),//掩码
.wr_data		(wr3_data		)//写数据
);

//write path 4
wr_fifo_path	wr_fifo_path4_inst(
.ui_clk		(ui_clk		),//                               
.p_wr_cmd_clk		(p4_wr_cmd_clk	),//命令fifo写时钟
.p_wr_cmd_en		(p4_wr_cmd_en	 	),//命令fifo写使能
.p_wr_cmd_instr	(p4_wr_cmd_instr	),//ddr3 写指令 3'b000
.p_wr_cmd_bl		(p4_wr_cmd_bl	 	),//ddr3 写突发长度 1~64代表写入1~64个数
.p_wr_cmd_init_addr	(p4_wr_cmd_init_addr	),//ddr3 写突发的初始地址
.p_wr_cmd_empty	(p4_wr_cmd_empty	),//命令fifo空标志
.p_wr_cmd_full	(p4_wr_cmd_full	),//命令fifo满标志                            
.p_wr_clk	(p4_wr_clk	        	),//数据fifo写时钟
.p_wr_en	(p4_wr_en			),//数据fifo写使能
.p_wr_mask	(p4_wr_mask	       	),//掩码
.p_wr_data	(p4_wr_data	        	),//写数据  
.p_wr_empty	(p4_wr_empty	        	),//数据fifo空标志
.p_wr_full	(p4_wr_full	        	),//数据fifo满标志
.p_wr_count	(p4_wr_count	        	),//数据fifo内数据量                             
.wr_cmd_en	(wr4_cmd_en	        	),//命令fifo读使能        
.wr_cmd_instr	(wr4_cmd_instr	       ),//ddr3 写指令 3'b000
.wr_cmd_bl	(wr4_cmd_bl	        	),//ddr3 写突发长度 1~64代表写入1~64个数
.wr_cmd_init_addr(wr4_cmd_init_addr       ),//ddr3 写突发的初始地址         
.wr_cmd_empty	(wr4_cmd_empty	       ),//命令fifo空标志
.wr_cmd_full	(wr4_cmd_full	        	),//命令fifo满标志                             
.wr_en		(wr4_en		       ),//数据fifo读使能          
.wr_mask	(wr4_mask			),//掩码
.wr_data	(wr4_data			)//写数据
);


endmodule