module	wr_fifo_path(
input	wire		ui_clk		,// 

//--------fifo write port------------------
//cmd port
input	wire		p_wr_cmd_clk	,//命令fifo写时钟
input	wire		p_wr_cmd_en	,//命令fifo写使能
input	wire[2:0]	p_wr_cmd_instr	,//ddr3 写指令 3'b000
input	wire[6:0]	p_wr_cmd_bl	,//ddr3 写突发长度 1~64代表写入1~64个数
input	wire[27:0]	p_wr_cmd_init_addr,//ddr3 写突发的初始地址

output	wire		p_wr_cmd_empty	,//命令fifo空标志
output	wire		p_wr_cmd_full	,//命令fifo满标志

//data port
input	wire		p_wr_clk	,//数据fifo写时钟
input	wire		p_wr_en		,//数据fifo写使能
input	wire[15:0]	p_wr_mask	,//掩码
input	wire[127:0]	p_wr_data	,//写数据

output	wire		p_wr_empty	,//数据fifo空标志
output	wire		p_wr_full	,//数据fifo满标志
output	wire[5:0]	p_wr_count	,//数据fifo内数据量

//--------fifo read port------------------
//cmd port
input	wire		wr_cmd_en	,//命令fifo读使能

output	wire[2:0]	wr_cmd_instr	,//ddr3 写指令 3'b000
output	wire[6:0]	wr_cmd_bl	,//ddr3 写突发长度 1~64代表写入1~64个数
output	wire[27:0]	wr_cmd_init_addr,//ddr3 写突发的初始地址

output	wire		wr_cmd_empty	,//命令fifo空标志
output	wire		wr_cmd_full	,//命令fifo满标志

//data port
input	wire		wr_en		,//数据fifo读使能

output	wire[15:0]	wr_mask		,//掩码
output	wire[127:0]	wr_data		//写数据

);

//cmd_fifo
cmd_fifo	cmd_fifo_inst(
.wr_clk	(p_wr_cmd_clk	),//input wire wr_clk
.rd_clk	(ui_clk		),//input wire rd_clk
.din	({p_wr_cmd_init_addr,p_wr_cmd_instr,p_wr_cmd_bl}),//input wire[39:0] din
.wr_en	(p_wr_cmd_en	),//input wire wr_en
.rd_en	(wr_cmd_en	),//input wire rd_en
.dout	({wr_cmd_init_addr,wr_cmd_instr,wr_cmd_bl}),//output wire[39:0] dout
.full	(p_wr_cmd_full	),//output wire full
.empty	(p_wr_cmd_empty	)//output wire empty
);

//data_fifo
wr_data	w_data_fifo_inst(
.wr_clk	(p_wr_clk	),//input wire wr_clk
.rd_clk	(ui_clk		),//input wire rd_clk
.din	({p_wr_data,p_wr_mask}),//input wire[143:0] din
.wr_en	(p_wr_en	),//input wire wr_en
.rd_en	(wr_en		),//input wire rd_en
.dout	({wr_data,wr_mask}),//output wire[143:0] dout
.full	(p_wr_full	),//output wire full
.empty	(p_wr_empty	),//output wire empty
.wr_data_count(p_wr_count)//output wire[6:0]wr_data_count
);

assign	wr_cmd_full	=	p_wr_cmd_full;

assign	wr_cmd_empty	=	p_wr_cmd_empty;

endmodule