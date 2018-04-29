module	wr_ctrl
#(
parameter	APP_ADDR_WIDTH = 28
)
(
input	wire		sclk		,
input	wire		rst_n		,
input	wire		wr_start	,
input	wire		app_rdy		,
input	wire		app_wdf_rdy	,
input	wire[2:0]	wr_cmd		,
input	wire[6:0]	wr_bl		,
input	wire[15:0]	wr_mask		,
input	wire[27:0]	wr_init_addr	,
input	wire[127:0]	wr_data		,

output	reg		app_wdf_en	,
output	wire		app_wdf_end	,
output	wire[15:0]	app_wdf_mask	,
output	wire[127:0]	app_wdf_data	,
output	reg		app_en		,
output	wire[2:0]	app_cmd		,
output	reg[APP_ADDR_WIDTH-1:0]	app_addr	,

output	wire		data_req	,
output	reg		wr_end		
);

reg[6:0]	data_cnt;
reg[6:0]	cmd_cnt	;

//app_wdf_en
always@(posedge	sclk)
if(rst_n==1'b0)
	app_wdf_en	<=	1'b0;
else if(wr_start==1'b1)
	app_wdf_en	<=	1'b1;
else if(data_cnt==wr_bl-1'b1&&app_wdf_rdy==1'b1)
	app_wdf_en	<=	1'b0;

//app_wdf_end
assign	app_wdf_end	=	app_wdf_en;

//app_wdf_mask
assign	app_wdf_mask	=	wr_mask;

//data_cnt
always@(posedge	sclk	or	negedge	rst_n)
if(rst_n==1'b0)
	data_cnt	<=	7'b0;
else if(data_cnt==wr_bl-1'b1&&app_wdf_rdy==1'b1)
	data_cnt	<=	7'b0;	
else if(app_wdf_en==1'b1&&app_wdf_rdy==1'b1)
	data_cnt	<=	data_cnt+1'b1;

//app_en
always@(posedge	sclk	or	negedge	rst_n)
if(rst_n==1'b0)
	app_en	<=	1'b0;
else if(wr_start==1'b1)
	app_en	<=	1'b1;
else if(cmd_cnt==wr_bl-1'b1&&app_rdy==1'b1)
	app_en	<=	1'b0;
	
//cmd_cnt
always@(posedge	sclk	or	negedge	rst_n)
if(rst_n==1'b0)
	cmd_cnt	<=	7'b0;
else if(cmd_cnt==wr_bl-1'b1&&app_rdy==1'b1)
	cmd_cnt	<=	7'b0;	
else if(app_en==1'b1&&app_rdy==1'b1)
	cmd_cnt	<=	cmd_cnt+1'b1;

//app_addr
always@(posedge	sclk	or	negedge	rst_n)
if(rst_n==1'b0)
	app_addr	<=	28'b0;
else if(wr_start==1'b1)
	app_addr	<=	wr_init_addr;	
else if(app_en==1'b0)
	app_addr	<=	28'b0;
else if(app_en==1'b1&&app_rdy==1'b1)
	app_addr	<=	app_addr+4'd8;

//app_cmd
assign	app_cmd	=	wr_cmd;

//data_req
assign	data_req	=	app_wdf_en&&app_wdf_rdy;

//app_wdf_data
assign	app_wdf_data	=	wr_data;

//wr_end
always@(posedge	sclk	or	negedge	rst_n)
if(rst_n==1'b0)
	wr_end	<=	1'b0;
else if(cmd_cnt==wr_bl-1'b1&&app_rdy==1'b1)
	wr_end	<=	1'b1;
else
	wr_end	<=	1'b0;
	
endmodule