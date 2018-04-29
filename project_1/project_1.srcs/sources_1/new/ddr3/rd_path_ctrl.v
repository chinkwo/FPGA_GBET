module	rd_path_ctrl(
input	wire		ui_clk		,// 

//--------fifo write port------------------
//cmd port5
input	wire		p5_rd_cmd_clk	,//命令fifo写时钟
input	wire		p5_rd_cmd_en	,//命令fifo写使能
input	wire[2:0]	p5_rd_cmd_instr	,//ddr3 读指令 3'b001
input	wire[6:0]	p5_rd_cmd_bl	,//ddr3 读突发长度 1~64代表写入1~64个数
input	wire[27:0]	p5_rd_cmd_init_addr,//ddr3 读突发的初始地址
output	wire		p5_rd_cmd_empty	,//命令fifo空标志
output	wire		p5_rd_cmd_full	,//命令fifo满标志
input	wire		p5_rd_clk	,//数据fifo读时钟
input	wire		p5_rd_en	,//数据fifo读使能
output	wire		p5_rd_data_valid,//读出的数据有效标志
output	wire[127:0]	p5_rd_data	,//读出的数据
output	wire		p5_rd_empty	,//数据fifo空标志
output	wire		p5_rd_full	,//数据fifo满标志
output	wire[5:0]	p5_rd_count	,//数据fifo内数据量
input	wire		rd5_cmd_en	,//命令fifo读使能
output	wire[2:0]	rd5_cmd_instr	,//ddr3 读指令 3'b001
output	wire[6:0]	rd5_cmd_bl	,//ddr3 读突发长度 1~64代表写入1~64个数
output	wire[27:0]	rd5_cmd_init_addr,//ddr3 读突发的初始地址               
output	wire		rd5_cmd_empty	,//命令fifo空标志
output	wire		rd5_cmd_full	,//命令fifo满标志
input	wire		rd5_en		,//数据fifo写使能
input	wire[127:0]	rd5_data	,//数据fifo写数据
//cmd port6
input	wire		p6_rd_cmd_clk	,//命令fifo写时钟
input	wire		p6_rd_cmd_en	,//命令fifo写使能
input	wire[2:0]	p6_rd_cmd_instr,//ddr3 读指令 3'b001
input	wire[6:0]	p6_rd_cmd_bl	,//ddr3 读突发长度 1~64代表写入1~64个数
input	wire[27:0]	p6_rd_cmd_init_addr,//ddr3 读突发的初始地址
output	wire		p6_rd_cmd_empty,//命令fifo空标志
output	wire		p6_rd_cmd_full,//命令fifo满标志
input	wire		p6_rd_clk	,//数据fifo读时钟
input	wire		p6_rd_en	,//数据fifo读使能
output	wire		p6_rd_data_valid,//读出的数据有效标志
output	wire[127:0]	p6_rd_data	,//读出的数据
output	wire		p6_rd_empty	,//数据fifo空标志
output	wire		p6_rd_full	,//数据fifo满标志
output	wire[5:0]	p6_rd_count	,//数据fifo内数据量
input	wire		rd6_cmd_en	,//命令fifo读使能
output	wire[2:0]	rd6_cmd_instr	,//ddr3 读指令 3'b001
output	wire[6:0]	rd6_cmd_bl	,//ddr3 读突发长度 1~64代表写入1~64个数
output	wire[27:0]	rd6_cmd_init_addr,//ddr3 读突发的初始地址                   
output	wire		rd6_cmd_empty	,//命令fifo空标志
output	wire		rd6_cmd_full	,//命令fifo满标志
input	wire		rd6_en		,//数据fifo写使能
input	wire[127:0]	rd6_data	,//数据fifo写数据
//cmd port7
input	wire		p7_rd_cmd_clk	,//命令fifo写时钟
input	wire		p7_rd_cmd_en	,//命令fifo写使能
input	wire[2:0]	p7_rd_cmd_instr	,//ddr3 读指令 3'b001
input	wire[6:0]	p7_rd_cmd_bl	,//ddr3 读突发长度 1~64代表写入1~64个数
input	wire[27:0]	p7_rd_cmd_init_addr,//ddr3 读突发的初始地址
output	wire		p7_rd_cmd_empty	,//命令fifo空标志
output	wire		p7_rd_cmd_full	,//命令fifo满标志
input	wire		p7_rd_clk	,//数据fifo读时钟
input	wire		p7_rd_en	,//数据fifo读使能
output	wire		p7_rd_data_valid,//读出的数据有效标志
output	wire[127:0]	p7_rd_data	,//读出的数据
output	wire		p7_rd_empty	,//数据fifo空标志
output	wire		p7_rd_full	,//数据fifo满标志
output	wire[5:0]	p7_rd_count	,//数据fifo内数据量
input	wire		rd7_cmd_en	,//命令fifo读使能
output	wire[2:0]	rd7_cmd_instr	,//ddr3 读指令 3'b001
output	wire[6:0]	rd7_cmd_bl	,//ddr3 读突发长度 1~64代表写入1~64个数
output	wire[27:0]	rd7_cmd_init_addr,//ddr3 读突发的初始地址          
output	wire		rd7_cmd_empty	,//命令fifo空标志
output	wire		rd7_cmd_full	,//命令fifo满标志
input	wire		rd7_en		,//数据fifo写使能
input	wire[127:0]	rd7_data	,//数据fifo写数据
//cmd port8
input	wire		p8_rd_cmd_clk	,//命令fifo写时钟
input	wire		p8_rd_cmd_en	,//命令fifo写使能
input	wire[2:0]	p8_rd_cmd_instr,//ddr3 读指令 3'b001
input	wire[6:0]	p8_rd_cmd_bl	,//ddr3 读突发长度 1~64代表写入1~64个数
input	wire[27:0]	p8_rd_cmd_init_addr,//ddr3 读突发的初始地址
output	wire		p8_rd_cmd_empty,//命令fifo空标志
output	wire		p8_rd_cmd_full,//命令fifo满标志
input	wire		p8_rd_clk	,//数据fifo读时钟
input	wire		p8_rd_en	,//数据fifo读使能
output	wire		p8_rd_data_valid,//读出的数据有效标志
output	wire[127:0]	p8_rd_data	,//读出的数据
output	wire		p8_rd_empty	,//数据fifo空标志
output	wire		p8_rd_full	,//数据fifo满标志
output	wire[5:0]	p8_rd_count	,//数据fifo内数据量
input	wire		rd8_cmd_en	,//命令fifo读使能
output	wire[2:0]	rd8_cmd_instr	,//ddr3 读指令 3'b001
output	wire[6:0]	rd8_cmd_bl	,//ddr3 读突发长度 1~64代表写入1~64个数
output	wire[27:0]	rd8_cmd_init_addr,//ddr3 读突发的初始地址                      
output	wire		rd8_cmd_empty	,//命令fifo空标志
output	wire		rd8_cmd_full	,//命令fifo满标志
input	wire		rd8_en		,//数据fifo写使能
input	wire[127:0]	rd8_data	//数据fifo写数据

);

//write path 5
rd_fifo_path	rd_fifo_path5_inst(
.ui_clk		(ui_clk		),//                              
.p_rd_cmd_clk		(p5_rd_cmd_clk	),//命令fifo写时钟
.p_rd_cmd_en		(p5_rd_cmd_en		),//命令fifo写使能
.p_rd_cmd_instr	(p5_rd_cmd_instr	),//ddr3 读指令 3'b001
.p_rd_cmd_bl		(p5_rd_cmd_bl		),//ddr3 读突发长度 1~64代表写入1~64个数
.p_rd_cmd_init_addr	(p5_rd_cmd_init_addr	),//ddr3 读突发的初始地址
.p_rd_cmd_empty	(p5_rd_cmd_empty	),//命令fifo空标志
.p_rd_cmd_full	(p5_rd_cmd_full	),//命令fifo满标志                         
.p_rd_clk		(p5_rd_clk		),//数据fifo读时钟
.p_rd_en		(p5_rd_en		),//数据fifo读使能
.p_rd_data_valid	(p5_rd_data_valid	),//读出的数据有效标志
.p_rd_data		(p5_rd_data		),//读出的数据
.p_rd_empty		(p5_rd_empty		),//数据fifo空标志
.p_rd_full		(p5_rd_full		),//数据fifo满标志
.p_rd_count		(p5_rd_count		),//数据fifo内数据量                             
.rd_cmd_en		(rd5_cmd_en		),//命令fifo读使能
.rd_cmd_instr		(rd5_cmd_instr	),//ddr3 读指令 3'b001
.rd_cmd_bl		(rd5_cmd_bl		),//ddr3 读突发长度 1~64代表写入1~64个数
.rd_cmd_init_addr	(rd5_cmd_init_addr	),//ddr3 读突发的初始地址
.rd_cmd_empty		(rd5_cmd_empty	),//命令fifo空标志
.rd_cmd_full		(rd5_cmd_full		),//命令fifo满标志                         
.rd_en			(rd5_en		),//数据fifo写使能
.rd_data		(rd5_data		)//数据fifo写数据
);

//write path 6
rd_fifo_path	rd_fifo_path6_inst(
.ui_clk		(ui_clk		),//                               
.p_rd_cmd_clk		(p6_rd_cmd_clk	),//命令fifo写时钟
.p_rd_cmd_en		(p6_rd_cmd_en		),//命令fifo写使能
.p_rd_cmd_instr	(p6_rd_cmd_instr	),//ddr3 读指令 3'b001
.p_rd_cmd_bl		(p6_rd_cmd_bl		),//ddr3 读突发长度 1~64代表写入1~64个数
.p_rd_cmd_init_addr	(p6_rd_cmd_init_addr	),//ddr3 读突发的初始地址
.p_rd_cmd_empty	(p6_rd_cmd_empty	),//命令fifo空标志
.p_rd_cmd_full	(p6_rd_cmd_full	),//命令fifo满标志                          
.p_rd_clk		(p6_rd_clk		),//数据fifo读时钟
.p_rd_en		(p6_rd_en		),//数据fifo读使能
.p_rd_data_valid	(p6_rd_data_valid	),//读出的数据有效标志
.p_rd_data		(p6_rd_data		),//读出的数据
.p_rd_empty		(p6_rd_empty		),//数据fifo空标志
.p_rd_full		(p6_rd_full		),//数据fifo满标志
.p_rd_count		(p6_rd_count		),//数据fifo内数据量                              
.rd_cmd_en		(rd6_cmd_en		),//命令fifo读使能
.rd_cmd_instr		(rd6_cmd_instr	),//ddr3 读指令 3'b001
.rd_cmd_bl		(rd6_cmd_bl		),//ddr3 读突发长度 1~64代表写入1~64个数
.rd_cmd_init_addr	(rd6_cmd_init_addr	),//ddr3 读突发的初始地址
.rd_cmd_empty		(rd6_cmd_empty	),//命令fifo空标志
.rd_cmd_full		(rd6_cmd_full		),//命令fifo满标志                          
.rd_en			(rd6_en		),//数据fifo写使能
.rd_data		(rd6_data		)//数据fifo写数据
);

//write path 7
rd_fifo_path	rd_fifo_path7_inst(
.ui_clk		(ui_clk		),//                              
.p_rd_cmd_clk		(p7_rd_cmd_clk	),//命令fifo写时钟
.p_rd_cmd_en		(p7_rd_cmd_en		),//命令fifo写使能
.p_rd_cmd_instr	(p7_rd_cmd_instr	),//ddr3 读指令 3'b001
.p_rd_cmd_bl		(p7_rd_cmd_bl		),//ddr3 读突发长度 1~64代表写入1~64个数
.p_rd_cmd_init_addr	(p7_rd_cmd_init_addr	),//ddr3 读突发的初始地址
.p_rd_cmd_empty	(p7_rd_cmd_empty	),//命令fifo空标志
.p_rd_cmd_full	(p7_rd_cmd_full	),//命令fifo满标志                          
.p_rd_clk		(p7_rd_clk		),//数据fifo读时钟
.p_rd_en		(p7_rd_en		),//数据fifo读使能
.p_rd_data_valid	(p7_rd_data_valid	),//读出的数据有效标志
.p_rd_data		(p7_rd_data		),//读出的数据
.p_rd_empty		(p7_rd_empty		),//数据fifo空标志
.p_rd_full		(p7_rd_full		),//数据fifo满标志
.p_rd_count		(p7_rd_count		),//数据fifo内数据量                           
.rd_cmd_en		(rd7_cmd_en		),//命令fifo读使能
.rd_cmd_instr		(rd7_cmd_instr	),//ddr3 读指令 3'b001
.rd_cmd_bl		(rd7_cmd_bl		),//ddr3 读突发长度 1~64代表写入1~64个数
.rd_cmd_init_addr	(rd7_cmd_init_addr	),//ddr3 读突发的初始地址
.rd_cmd_empty		(rd7_cmd_empty	),//命令fifo空标志
.rd_cmd_full		(rd7_cmd_full		),//命令fifo满标志                        
.rd_en			(rd7_en		),//数据fifo写使能
.rd_data		(rd7_data		)//数据fifo写数据
);

//write path 8
rd_fifo_path	rd_fifo_path8_inst(
.ui_clk		(ui_clk		),//                              
.p_rd_cmd_clk		(p8_rd_cmd_clk	),//命令fifo写时钟
.p_rd_cmd_en		(p8_rd_cmd_en		),//命令fifo写使能
.p_rd_cmd_instr	(p8_rd_cmd_instr	),//ddr3 读指令 3'b001
.p_rd_cmd_bl		(p8_rd_cmd_bl		),//ddr3 读突发长度 1~64代表写入1~64个数
.p_rd_cmd_init_addr	(p8_rd_cmd_init_addr	),//ddr3 读突发的初始地址
.p_rd_cmd_empty	(p8_rd_cmd_empty	),//命令fifo空标志
.p_rd_cmd_full	(p8_rd_cmd_full	),//命令fifo满标志                          
.p_rd_clk		(p8_rd_clk		),//数据fifo读时钟
.p_rd_en		(p8_rd_en		),//数据fifo读使能
.p_rd_data_valid	(p8_rd_data_valid	),//读出的数据有效标志
.p_rd_data		(p8_rd_data		),//读出的数据
.p_rd_empty		(p8_rd_empty		),//数据fifo空标志
.p_rd_full		(p8_rd_full		),//数据fifo满标志
.p_rd_count		(p8_rd_count		),//数据fifo内数据量                              
.rd_cmd_en		(rd8_cmd_en		),//命令fifo读使能
.rd_cmd_instr		(rd8_cmd_instr	),//ddr3 读指令 3'b001
.rd_cmd_bl		(rd8_cmd_bl		),//ddr3 读突发长度 1~64代表写入1~64个数
.rd_cmd_init_addr	(rd8_cmd_init_addr	),//ddr3 读突发的初始地址
.rd_cmd_empty		(rd8_cmd_empty	),//命令fifo空标志
.rd_cmd_full		(rd8_cmd_full		),//命令fifo满标志                          
.rd_en			(rd8_en		),//数据fifo写使能
.rd_data		(rd8_data		)//数据fifo写数据
);	


endmodule