module contrl_clk(
	input	wire		sclk,
	input	wire		rst_n,
	input	wire		rx_clk,
	

	output	wire		ddr3_clk,
	output	wire		user_125M,
	output	wire		hdmi_clk,
	output	wire		hdmi_5xclk,
	output	wire		rx_clk_90deg
);
wire	pll_clk;



//进50m时钟，1出125m系统时钟，2出相移10°的125m系统时钟，3出125m的时钟，作为下一个pll的输入，4输出333.333m的时钟作为ddr3的输入时钟
     pll1_50M pll_tx_int
   (
    // Clock out ports
    .clk_out1(),     // output 125m
    .clk_out2(),      // OUT 125m 90deg
    .clk_out3(pll_clk),    // OUT125m pll2
   // Clock in ports
    .clk_in1(sclk));       // OUT  200Mhz
// INST_TAG_END ------ End INSTANTIATION Template ---------

//进125出65m时钟
     pll2_50M pll_hdmi_inst
   (
    // Clock out ports
    .clk_out1(hdmi_clk),      // OUT  65m
   // Clock in ports
    .clk_out2(hdmi_5xclk),      // OUT 125m 90deg
    .clk_in1(pll_clk));      // IN  125m 
  
    pll3_125m pll_rx_inst
   (
    // Clock out ports
    .clk_out1(rx_clk_90deg),     // output clk_out1
   // Clock in ports
    .clk_in1(rx_clk));      // input clk_in1
// INST_TAG_END ------ End INSTANTIATION Template ---------
  clk_ddr3 clk_ddr3_inst
   (
    // Clock out ports
    .clk_out1(ddr3_clk),     // output clk_out1
    .clk_out2(user_125M),     // output clk_out2
   // Clock in ports
    .clk_in1(pll_clk));      // input clk_in1
endmodule
