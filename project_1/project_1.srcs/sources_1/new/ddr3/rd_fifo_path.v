module	rd_fifo_path(
input	wire		ui_clk		,// 

//--------fifo write port------------------
//cmd port
input	wire		p_rd_cmd_clk	,//命令fifo写时钟
input	wire		p_rd_cmd_en	,//命令fifo写使能
input	wire[2:0]	p_rd_cmd_instr	,//ddr3 读指令 3'b001
input	wire[6:0]	p_rd_cmd_bl	,//ddr3 读突发长度 1~64代表写入1~64个数
input	wire[29:0]	p_rd_cmd_init_addr,//ddr3 读突发的初始地址

output	wire		p_rd_cmd_empty	,//命令fifo空标志
output	wire		p_rd_cmd_full	,//命令fifo满标志

//data port
input	wire		p_rd_clk	,//数据fifo读时钟
input	wire		p_rd_en		,//数据fifo读使能

output	reg		p_rd_data_valid	,//读出的数据有效标志
output	wire[127:0]	p_rd_data	,//读出的数据

output	wire		p_rd_empty	,//数据fifo空标志
output	wire		p_rd_full	,//数据fifo满标志
output	wire[5:0]	p_rd_count	,//数据fifo内数据量

//--------fifo read port------------------
//cmd port
input	wire		rd_cmd_en	,//命令fifo读使能

output	wire[2:0]	rd_cmd_instr	,//ddr3 读指令 3'b001
output	wire[6:0]	rd_cmd_bl	,//ddr3 读突发长度 1~64代表写入1~64个数
output	wire[29:0]	rd_cmd_init_addr,//ddr3 读突发的初始地址
                        
output	wire		rd_cmd_empty	,//命令fifo空标志
output	wire		rd_cmd_full	,//命令fifo满标志

//data port
input	wire		rd_en		,//数据fifo写使能

input	wire[127:0]	rd_data		//数据fifo写数据

);
//cmd_fifo
cmd_fifo	cmd_fifo_inst(
.wr_clk	(p_rd_cmd_clk	),//input wire wr_clk
.rd_clk	(ui_clk		),//input wire rd_clk
.din	({p_rd_cmd_init_addr,p_rd_cmd_instr,p_rd_cmd_bl}),//input wire[39:0] din
.wr_en	(p_rd_cmd_en	),//input wire wr_en
.rd_en	(rd_cmd_en	),//input wire rd_en
.dout	({rd_cmd_init_addr,rd_cmd_instr,rd_cmd_bl}),//output wire[39:0] dout
.full	(p_rd_cmd_full	),//output wire full
.empty	(p_rd_cmd_empty	)//output wire empty
);

//data_fifo
rd_data	r_data_fifo_inst(
.wr_clk	(ui_clk		),//input wire wr_clk
.rd_clk	(p_rd_clk	),//input wire rd_clk
.din	(rd_data	),//input wire[127:0] din
.wr_en	(rd_en		),//input wire wr_en
.rd_en	(p_rd_en	),//input wire rd_en
.dout	(p_rd_data	),//output wire[39:0] dout
.full	(p_rd_full	),//output wire full
.empty	(p_rd_empty	),//output wire empty
.rd_data_count(p_rd_count)//output wire[6:0]wr_data_count
);

assign	rd_cmd_full	=	p_rd_cmd_full;

assign	rd_cmd_empty	=	p_rd_cmd_empty;

always@(posedge	p_rd_clk)
	p_rd_data_valid	<=	p_rd_en;

endmodule