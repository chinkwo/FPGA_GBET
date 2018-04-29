module	rd_ctrl
#(
parameter	APP_ADDR_WIDTH = 28
)
(
input	wire		sclk		,
input	wire		rst_n		,
input	wire		rd_start	,
input	wire		app_rdy		,
input	wire		app_rd_data_valid,
input	wire[2:0]	rd_cmd		,
input	wire[6:0]	rd_bl		,
input	wire[27:0]	rd_init_addr	,
input	wire[127:0]	app_rd_data	,

output	reg		app_en		,
output	wire[2:0]	app_cmd		,
output	reg[APP_ADDR_WIDTH-1:0]	app_addr	,

output	reg		rd_data_valid	,
output	reg[127:0]	rd_data		,

output	reg		rd_end			

);
reg[6:0]	cmd_cnt	;

reg[6:0]	data_cnt;

//app_en
always@(posedge	sclk	or	negedge	rst_n)
if(rst_n==1'b0)
	app_en	<=	1'b0;
else if(cmd_cnt==rd_bl-1'b1&&app_rdy==1'b1)
	app_en	<=	1'b0;
else if(rd_start==1'b1)
	app_en	<=	1'b1;

//cmd_cnt
always@(posedge	sclk	or	negedge	rst_n)
if(rst_n==1'b0)
	cmd_cnt	<=	7'b0;
else if(cmd_cnt==rd_bl-1'b1&&app_rdy==1'b1)
	cmd_cnt	<=	7'b0;
else if(app_en==1'b1&&app_rdy==1'b1)
	cmd_cnt	<=	cmd_cnt+1'b1;

//app_cmd
assign	app_cmd	=	rd_cmd;

//app_addr
always@(posedge	sclk	or	negedge	rst_n)
if(rst_n==1'b0)
	app_addr	<=	7'b0;
else if(rd_start==1'b1)
	app_addr	<=	rd_init_addr;
else if(app_en==1'b0)
	app_addr	<=	7'b0;
else if(app_en==1'b1&&app_rdy==1'b1)
	app_addr	<=	app_addr+8;

//rd_data_valid
always@(posedge	sclk	or	negedge	rst_n)
if(rst_n==1'b0)
	rd_data_valid	<=	1'b0;
else 
	rd_data_valid	<=	app_rd_data_valid;

//rd_data
always@(posedge	sclk	or	negedge	rst_n)
if(rst_n==1'b0)
	rd_data	<=	128'b0;
else 
	rd_data	<=	app_rd_data;

//data_cnt
always@(posedge	sclk	or	negedge	rst_n)
if(rst_n==1'b0)
	data_cnt	<=	7'b0;
else if(data_cnt==rd_bl)	
	data_cnt	<=	7'b0;
else if(rd_data_valid==1'b1)
	data_cnt	<=	data_cnt+1'b1;

//rd_end
always@(posedge	sclk	or	negedge	rst_n)
if(rst_n==1'b0)
	rd_end	<=	1'b0;
else if(data_cnt==rd_bl)	
	rd_end	<=	1'b1;
else
	rd_end	<=	1'b0;

endmodule