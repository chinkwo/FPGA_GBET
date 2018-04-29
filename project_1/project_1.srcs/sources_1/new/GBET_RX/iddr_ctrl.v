module	iddr_ctrl(
	input	wire		rst_n,
	//from phy
	input	wire[3:0]	rx_dat,//双沿4bit数据  一个时钟周期传输8bit数据
	input	wire		rx_ctrl,//上升沿对应dv  下降沿对应err
	input	wire		rx_clk,//phy传输来的时钟相移90
	//to mac
	output	reg[7:0]	rx_data,//单沿8bit数据
	output	reg		rx_en//8bit数据对应有效信号
);

wire		tmp_dv;
wire		tmp_err;
wire[7:0]	tmp_data;

 IDDR #(
      .DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("ASYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_dv (
      .Q1(tmp_dv), // 1-bit output for positive edge of clock 
      .Q2(tmp_err), // 1-bit output for negative edge of clock
      .C(rx_clk),   // 1-bit clock input
      .CE(1'b1), // 1-bit clock enable input
      .D(rx_ctrl),   // 1-bit DDR data input
      .R(1'b0),   // 1-bit reset
      .S(~rst_n)    // 1-bit set
   );

genvar i;
generate
      for (i=0; i < 4; i=i+1)
      begin
         IDDR #(
      .DDR_CLK_EDGE("OPPOSITE_EDGE"), // "OPPOSITE_EDGE", "SAME_EDGE" 
                                      //    or "SAME_EDGE_PIPELINED" 
      .INIT_Q1(1'b0), // Initial value of Q1: 1'b0 or 1'b1
      .INIT_Q2(1'b0), // Initial value of Q2: 1'b0 or 1'b1
      .SRTYPE("ASYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) IDDR_data (
      .Q1(tmp_data[i]), // 1-bit output for positive edge of clock 
      .Q2(tmp_data[i+4]), // 1-bit output for negative edge of clock
      .C(rx_clk),   // 1-bit clock input
      .CE(1'b1), // 1-bit clock enable input
      .D(rx_dat[i]),   // 1-bit DDR data input
      .R(1'b0),   // 1-bit reset
      .S(~rst_n)    // 1-bit set
   );
      end
endgenerate

always @(posedge rx_clk or negedge rst_n)
	if(!rst_n)
		rx_en <= 1'b0;
	else
		rx_en <= tmp_dv;

always @(posedge rx_clk or negedge rst_n)
	if(!rst_n)
		rx_data <= 8'b0;
	else
		rx_data <= tmp_data;

endmodule