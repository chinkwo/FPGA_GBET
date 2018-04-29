module	fifo_arbit(
input	wire		ui_clk		,// 
input	wire		rst_n		,

//--------fifo write port------------------
//cmd port
output	reg		wr1_cmd_en	,//命令fifo读使能 

input	wire[2:0]	wr1_cmd_instr	,//ddr3 写指令 3'b000
input	wire[6:0]	wr1_cmd_bl	,//ddr3 写突发长度 1~64代表写入1~64个数
input	wire[27:0]	wr1_cmd_init_addr,//ddr3 写突发的初始地址

input	wire		wr1_cmd_empty	,//命令fifo空标志

output	reg		wr2_cmd_en	,//命令fifo读使能 

input	wire[2:0]	wr2_cmd_instr	,//ddr3 写指令 3'b000
input	wire[6:0]	wr2_cmd_bl	,//ddr3 写突发长度 1~64代表写入1~64个数
input	wire[27:0]	wr2_cmd_init_addr,//ddr3 写突发的初始地址

input	wire		wr2_cmd_empty	,//命令fifo空标志

output	reg		wr3_cmd_en	,//命令fifo读使能 

input	wire[2:0]	wr3_cmd_instr	,//ddr3 写指令 3'b000
input	wire[6:0]	wr3_cmd_bl	,//ddr3 写突发长度 1~64代表写入1~64个数
input	wire[27:0]	wr3_cmd_init_addr,//ddr3 写突发的初始地址
                          
input	wire		wr3_cmd_empty	,//命令fifo空标志

output	reg		wr4_cmd_en	,//命令fifo读使能 

input	wire[2:0]	wr4_cmd_instr	,//ddr3 写指令 3'b000
input	wire[6:0]	wr4_cmd_bl	,//ddr3 写突发长度 1~64代表写入1~64个数
input	wire[27:0]	wr4_cmd_init_addr,//ddr3 写突发的初始地址
                          
input	wire		wr4_cmd_empty	,//命令fifo空标志

//data port
output	wire		wr1_en		,//数据fifo读使能

input	wire[15:0]	wr1_mask	,//掩码
input	wire[127:0]	wr1_data	,//写数据

output	wire		wr2_en		,//数据fifo读使能
                          
input	wire[15:0]	wr2_mask	,//掩码
input	wire[127:0]	wr2_data	,//写数据

output	wire		wr3_en		,//数据fifo读使能
                          
input	wire[15:0]	wr3_mask	,//掩码
input	wire[127:0]	wr3_data	,//写数据

output	wire		wr4_en		,//数据fifo读使能
                          
input	wire[15:0]	wr4_mask	,//掩码
input	wire[127:0]	wr4_data	,//写数据

//-------- fifo read port------------------
//cmd port
output	reg		rd5_cmd_en	,//命令fifo读使能

input	wire[2:0]	rd5_cmd_instr	,//ddr3 读指令 3'b001
input	wire[6:0]	rd5_cmd_bl	,//ddr3 读突发长度 1~64代表写入1~64个数
input	wire[27:0]	rd5_cmd_init_addr,//ddr3 读突发的初始地址
                        
input	wire		rd5_cmd_empty	,//命令fifo空标志

output	reg		rd6_cmd_en	,//命令fifo读使能

input	wire[2:0]	rd6_cmd_instr	,//ddr3 读指令 3'b001
input	wire[6:0]	rd6_cmd_bl	,//ddr3 读突发长度 1~64代表写入1~64个数
input	wire[27:0]	rd6_cmd_init_addr,//ddr3 读突发的初始地址
                          
input	wire		rd6_cmd_empty	,//命令fifo空标志

output	reg		rd7_cmd_en	,//命令fifo读使能
                          
input	wire[2:0]	rd7_cmd_instr	,//ddr3 读指令 3'b001
input	wire[6:0]	rd7_cmd_bl	,//ddr3 读突发长度 1~64代表写入1~64个数
input	wire[27:0]	rd7_cmd_init_addr,//ddr3 读突发的初始地址
                          
input	wire		rd7_cmd_empty	,//命令fifo空标志

output	reg		rd8_cmd_en	,//命令fifo读使能
                          
input	wire[2:0]	rd8_cmd_instr	,//ddr3 读指令 3'b001
input	wire[6:0]	rd8_cmd_bl	,//ddr3 读突发长度 1~64代表写入1~64个数
input	wire[27:0]	rd8_cmd_init_addr,//ddr3 读突发的初始地址
                          
input	wire		rd8_cmd_empty	,//命令fifo空标志
//data port
output	wire		rd5_en		,//数据fifo写使能
output	wire[127:0]	rd5_data	,//数据fifo写数据

output	wire		rd6_en		,//数据fifo写使能                         
output	wire[127:0]	rd6_data	,//数据fifo写数据

output	wire		rd7_en		,//数据fifo写使能                     
output	wire[127:0]	rd7_data	,//数据fifo写数据

output	wire		rd8_en		,//数据fifo写使能                      
output	wire[127:0]	rd8_data	,//数据fifo写数据

//-------------wr_ctrl  port---------------
input	wire		data_req	,
input	wire		wr_end		,

output	reg[2:0]	wr_cmd		,
output	reg[6:0]	wr_bl		,
output	reg[15:0]	wr_mask		,
output	reg[27:0]	wr_init_addr	,
output	reg[127:0]	wr_data		,
output	wire		wr_start	,

//-------------rd_ctrl  port---------------
input	wire		rd_end		,
input	wire		rd_data_valid	,
input	wire[127:0]	rd_data		,

output	reg[2:0]	rd_cmd		,
output	reg[6:0]	rd_bl		,
output	reg[27:0]	rd_init_addr	,
output	wire		rd_start	,


output	wire		swap
);

reg[9:0]	state		;
reg[4:0]	arbit_cnt	;

reg	wr1_req,wr2_req,wr3_req,wr4_req;
reg	rd5_req,rd6_req,rd7_req,rd8_req;

parameter	IDLE	=	10'b00_0000_0001;
parameter	ARBIT	=	10'b00_0000_0010;
parameter	WR1	=	10'b00_0000_0100;
parameter	WR2	=	10'b00_0000_1000;
parameter	WR3	=	10'b00_0001_0000;
parameter	WR4	=	10'b00_0010_0000;
parameter	RD5	=	10'b00_0100_0000;
parameter	RD6	=	10'b00_1000_0000;
parameter	RD7	=	10'b01_0000_0000;
parameter	RD8	=	10'b10_0000_0000;

//arbit_cnt
always@(posedge	ui_clk)
if(rst_n==1'b0)
	arbit_cnt	<=	5'b1;
else if(arbit_cnt==5'd8)
	arbit_cnt	<=	5'b1;
else
	arbit_cnt	<=	arbit_cnt+5'b1;

//wr1_req
always@(posedge	ui_clk)
if(rst_n==1'b0)
	wr1_req	<=	1'b0;
else if(state==WR1)
	wr1_req	<=	1'b0;
else if(state==ARBIT&&wr1_cmd_empty==1'b0)
	wr1_req	<=	1'b1;

//wr2_req
always@(posedge	ui_clk)
if(rst_n==1'b0)
	wr2_req	<=	1'b0;
else if(state==WR2)
	wr2_req	<=	1'b0;
else if(state==ARBIT&&wr2_cmd_empty==1'b0)
	wr2_req	<=	1'b1;

//wr3_req
always@(posedge	ui_clk)
if(rst_n==1'b0)
	wr3_req	<=	1'b0;
else if(state==WR3)
	wr3_req	<=	1'b0;
else if(state==ARBIT&&wr3_cmd_empty==1'b0)
	wr3_req	<=	1'b1;

//wr4_req
always@(posedge	ui_clk)
if(rst_n==1'b0)
	wr4_req	<=	1'b0;
else if(state==WR4)
	wr4_req	<=	1'b0;
else if(state==ARBIT&&wr4_cmd_empty==1'b0)
	wr4_req	<=	1'b1;

//rd5_req
always@(posedge	ui_clk)
if(rst_n==1'b0)
	rd5_req	<=	1'b0;
else if(state==RD5)
	rd5_req	<=	1'b0;
else if(state==ARBIT&&rd5_cmd_empty==1'b0)
	rd5_req	<=	1'b1;

//rd6_req
always@(posedge	ui_clk)
if(rst_n==1'b0)
	rd6_req	<=	1'b0;
else if(state==RD6)
	rd6_req	<=	1'b0;
else if(state==ARBIT&&rd6_cmd_empty==1'b0)
	rd6_req	<=	1'b1;

//rd7_req
always@(posedge	ui_clk)
if(rst_n==1'b0)
	rd7_req	<=	1'b0;
else if(state==RD7)
	rd7_req	<=	1'b0;
else if(state==ARBIT&&rd7_cmd_empty==1'b0)
	rd7_req	<=	1'b1;

//rd8_req
always@(posedge	ui_clk)
if(rst_n==1'b0)
	rd8_req	<=	1'b0;
else if(state==RD8)
	rd8_req	<=	1'b0;
else if(state==ARBIT&&rd8_cmd_empty==1'b0)
	rd8_req	<=	1'b1;
	
//state
always@(posedge	ui_clk)
if(rst_n==1'b0)
	state	<=	IDLE;
else case(state)
IDLE:	state	<=	ARBIT;
ARBIT:
if(wr1_req==1'b1&&arbit_cnt==5'd1)
	state	<=	WR1;
else if(wr2_req==1'b1&&arbit_cnt==5'd2)
	state	<=	WR2;
else if(wr3_req==1'b1&&arbit_cnt==5'd3)
	state	<=	WR3;
else if(wr4_req==1'b1&&arbit_cnt==5'd4)
	state	<=	WR4;
else if(rd5_req==1'b1&&arbit_cnt==5'd5)
	state	<=	RD5;
else if(rd6_req==1'b1&&arbit_cnt==5'd6)
	state	<=	RD6;
else if(rd7_req==1'b1&&arbit_cnt==5'd7)
	state	<=	RD7;
else if(rd8_req==1'b1&&arbit_cnt==5'd8)
	state	<=	RD8;
WR1:
if(wr_end==1'b1)
	state	<=	ARBIT;
WR2:
if(wr_end==1'b1)
	state	<=	ARBIT;
WR3:
if(wr_end==1'b1)
	state	<=	ARBIT;
WR4:
if(wr_end==1'b1)
	state	<=	ARBIT;
RD5:
if(rd_end==1'b1)
	state	<=	ARBIT;
RD6:
if(rd_end==1'b1)
	state	<=	ARBIT;
RD7:
if(rd_end==1'b1)
	state	<=	ARBIT;
RD8:
if(rd_end==1'b1)
	state	<=	ARBIT;
default:state	<=	ARBIT;
endcase

//wr1_cmd_en
always@(posedge	ui_clk)
if(rst_n==1'b0)
	wr1_cmd_en	<=	1'b0;
else if(state==WR1&&wr1_req==1'b1)
	wr1_cmd_en	<=	1'b1;
else
	wr1_cmd_en	<=	1'b0;

//wr2_cmd_en
always@(posedge	ui_clk)
if(rst_n==1'b0)
	wr2_cmd_en	<=	1'b0;
else if(state==WR2&&wr2_req==1'b1)
	wr2_cmd_en	<=	1'b1;
else
	wr2_cmd_en	<=	1'b0;

//wr3_cmd_en
always@(posedge	ui_clk)
if(rst_n==1'b0)
	wr3_cmd_en	<=	1'b0;
else if(state==WR3&&wr3_req==1'b1)
	wr3_cmd_en	<=	1'b1;
else
	wr3_cmd_en	<=	1'b0;

//wr4_cmd_en
always@(posedge	ui_clk)
if(rst_n==1'b0)
	wr4_cmd_en	<=	1'b0;
else if(state==WR4&&wr4_req==1'b1)
	wr4_cmd_en	<=	1'b1;
else
	wr4_cmd_en	<=	1'b0;

//rd5_cmd_en
always@(posedge	ui_clk)
if(rst_n==1'b0)
	rd5_cmd_en	<=	1'b0;
else if(state==RD5&&rd5_req==1'b1)
	rd5_cmd_en	<=	1'b1;
else
	rd5_cmd_en	<=	1'b0;

//rd6_cmd_en
always@(posedge	ui_clk)
if(rst_n==1'b0)
	rd6_cmd_en	<=	1'b0;
else if(state==RD6&&rd6_req==1'b1)
	rd6_cmd_en	<=	1'b1;
else
	rd6_cmd_en	<=	1'b0;

//rd7_cmd_en
always@(posedge	ui_clk)
if(rst_n==1'b0)
	rd7_cmd_en	<=	1'b0;
else if(state==RD7&&rd7_req==1'b1)
	rd7_cmd_en	<=	1'b1;
else
	rd7_cmd_en	<=	1'b0;

//rd8_cmd_en
always@(posedge	ui_clk)
if(rst_n==1'b0)
	rd8_cmd_en	<=	1'b0;
else if(state==RD8&&rd8_req==1'b1)
	rd8_cmd_en	<=	1'b1;
else
	rd8_cmd_en	<=	1'b0;

//wr_start
assign	wr_start = wr1_cmd_en|wr2_cmd_en|wr3_cmd_en|wr4_cmd_en;

//rd_start
assign	rd_start = rd5_cmd_en|rd6_cmd_en|rd7_cmd_en|rd8_cmd_en;

assign	swap = |state[9:6];

//wr1_en
assign	wr1_en = data_req&state[2];

//wr2_en
assign	wr2_en = data_req&state[3];

//wr3_en
assign	wr3_en = data_req&state[4];

//wr4_en
assign	wr4_en = data_req&state[5];

//wr_cmd
always@*
case(state)
WR1:wr_cmd = wr1_cmd_instr;
WR2:wr_cmd = wr2_cmd_instr;
WR3:wr_cmd = wr3_cmd_instr;
WR4:wr_cmd = wr4_cmd_instr;
default:wr_cmd = 3'b0;
endcase

//wr_bl
always@*
case(state)
WR1:wr_bl = wr1_cmd_bl;
WR2:wr_bl = wr2_cmd_bl;
WR3:wr_bl = wr3_cmd_bl;
WR4:wr_bl = wr4_cmd_bl;
default:wr_bl = 64;
endcase

//wr_mask
always@*
case(state)
WR1:wr_mask = wr1_mask;
WR2:wr_mask = wr2_mask;
WR3:wr_mask = wr3_mask;
WR4:wr_mask = wr4_mask;
default:wr_mask = 0;
endcase

//wr_init_addr
always@*
case(state)
WR1:wr_init_addr = wr1_cmd_init_addr;
WR2:wr_init_addr = wr2_cmd_init_addr;
WR3:wr_init_addr = wr3_cmd_init_addr;
WR4:wr_init_addr = wr4_cmd_init_addr;
default:wr_init_addr = 0;
endcase

//wr_data
always@*
case(state)
WR1:wr_data = wr1_data;
WR2:wr_data = wr2_data;
WR3:wr_data = wr3_data;
WR4:wr_data = wr4_data;
default:wr_data = 0;
endcase


//rd_cmd
always@*
case(state)
RD5:rd_cmd = rd5_cmd_instr;
RD6:rd_cmd = rd6_cmd_instr;
RD7:rd_cmd = rd7_cmd_instr;
RD8:rd_cmd = rd8_cmd_instr;
default:rd_cmd = 3'b1;
endcase
 
//rd_bl
always@*
case(state)
RD5:rd_bl = rd5_cmd_bl;
RD6:rd_bl = rd6_cmd_bl;
RD7:rd_bl = rd7_cmd_bl;
RD8:rd_bl = rd8_cmd_bl;
default:rd_bl = 64;
endcase

//rd_init_addr
always@*
case(state)
RD5:rd_init_addr = rd5_cmd_init_addr;
RD6:rd_init_addr = rd6_cmd_init_addr;
RD7:rd_init_addr = rd7_cmd_init_addr;
RD8:rd_init_addr = rd8_cmd_init_addr;
default:rd_init_addr = 0;
endcase

//rd5_en
assign	rd5_en = rd_data_valid&state[6];

//rd6_en
assign	rd6_en = rd_data_valid&state[7];

//rd7_en
assign	rd7_en = rd_data_valid&state[8];

//rd8_en
assign	rd8_en = rd_data_valid&state[9];

//rd5_data
assign	rd5_data = rd_data;

//rd6_data
assign	rd6_data = rd_data;

//rd7_data
assign	rd7_data = rd_data;

//rd8_data
assign	rd8_data = rd_data;
endmodule