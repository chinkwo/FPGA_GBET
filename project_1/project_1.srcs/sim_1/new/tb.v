`timescale 1ns / 1ps
module tb();

wire[15:0]	ddr3_dq;
wire[1:0]	ddr3_dqs_n;
wire[1:0]	ddr3_dqs_p;
// Outputs
wire[13:0]	ddr3_addr;
wire[2:0]	ddr3_ba;
wire		ddr3_ras_n;
wire		ddr3_cas_n;
wire		ddr3_we_n;
wire		ddr3_reset_n;
wire[0:0]	ddr3_ck_p;
wire[0:0]	ddr3_ck_n;
wire[0:0]	ddr3_cke;
wire[0:0]	ddr3_cs_n;
wire[1:0]	ddr3_dm;
wire[0:0]	ddr3_odt;

wire[3:0]	rx_dat;//双沿4bit数据  一个时钟周期传输8bit数据
wire		rx_ctrl;//上升沿对应dv  下降沿对应err
wire		rx_clk_in;
wire		phy_rst_n;
reg		sclk_125M;
//ddr3 pin end

reg		sclk_in	;//input 1bit
reg		rst_n	;//input 1bit

wire		tx_ctrl;
wire[7:0]	tx_data;




initial
	begin
		sclk_in	=	1'b1;
		rst_n	<=	1'b0;
	
		#200
		rst_n	<=	1'b1;
	end
always	#10	sclk_in	=	~sclk_in;	
   
initial	force sclk_125M = top_ddr3_GEBT_HDMI_inst.sclk_125M;


tx_data_up tx_data_up_inst(
.sclk		(sclk_125M),
.rst_n		(rst_n),
.start_flag	(phy_rst_n),
  
.data_o		(tx_data),
.data_en	(tx_ctrl)

);		

oddr_ctrl oddr_ctrl_inst(
	.rst_n		(rst_n),
	.sclk		(sclk_125M),//输入的125M时钟
	.tx_ctrl	(tx_ctrl),
	.tx_data	(tx_data),

	.tx_dat		(rx_dat),
	.tx_en		(rx_ctrl),
	.tx_clk		(rx_clk_in)
);






		
//end
top_ddr3_GEBT_HDMI	top_ddr3_GEBT_HDMI_inst(
.sclk(sclk_in),
.rst_n(rst_n),

.ddr3_dq	(ddr3_dq),
.ddr3_dqs_n	(ddr3_dqs_n),
.ddr3_dqs_p	(ddr3_dqs_p),
.ddr3_addr	(ddr3_addr),
.ddr3_ba	(ddr3_ba),
.ddr3_ras_n	(ddr3_ras_n),
.ddr3_cas_n	(ddr3_cas_n),
.ddr3_we_n	(ddr3_we_n),
.ddr3_reset_n	(ddr3_reset_n),
.ddr3_ck_p	(ddr3_ck_p),
.ddr3_ck_n	(ddr3_ck_n),
.ddr3_cke	(ddr3_cke),
.ddr3_dm	(ddr3_dm),
.ddr3_odt	(ddr3_odt),
//ddr3 pin end
.rx_clk		(rx_clk_in	),
.rx_ctrl	(rx_ctrl),
.rx_dat		(rx_dat),//input	wire		//千兆以太网的125m时钟
.phy_rst_n 	(phy_rst_n)//output	wire		
);


//model
ddr3_model	ddr3_model_inst(
.rst_n	(ddr3_reset_n),
.ck	(ddr3_ck_p),
.ck_n	(ddr3_ck_n),
.cke	(ddr3_cke),
.cs_n	(1'b0),
.ras_n	(ddr3_ras_n),
.cas_n	(ddr3_cas_n),
.we_n	(ddr3_we_n),
.dm_tdqs(ddr3_dm),
.ba	(ddr3_ba),
.addr	(ddr3_addr),
.dq	(ddr3_dq),
.dqs	(ddr3_dqs_p),
.dqs_n	(ddr3_dqs_n),
.tdqs_n	(),
.odt	(ddr3_odt)
);


endmodule
