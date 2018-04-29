module	oddr_ctrl(
	input	wire		rst_n,
	input	wire		sclk,// ‰»Îµƒ125M ±÷”
	input	wire		tx_ctrl,
	input	wire[7:0]	tx_data,
	
	output	wire[3:0]	tx_dat,
	output	wire		tx_en,
	output	wire		tx_clk
);

   ODDR #(
      .DDR_CLK_EDGE("SAME_EDGE"), // "OPPOSITE_EDGE" or "SAME_EDGE" 
      .INIT(1'b0),    // Initial value of Q: 1'b0 or 1'b1
      .SRTYPE("ASYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) ODDR_en (
      .Q(tx_en),   // 1-bit DDR output
      .C(sclk),   // 1-bit clock input
      .CE(1'b1), // 1-bit clock enable input
      .D1(tx_ctrl), // 1-bit data input (positive edge)
      .D2(tx_ctrl), // 1-bit data input (negative edge)
      .R(1'b0),   // 1-bit reset
      .S(~rst_n)    // 1-bit set
   );

  ODDR #(
      .DDR_CLK_EDGE("SAME_EDGE"), // "OPPOSITE_EDGE" or "SAME_EDGE" 
      .INIT(1'b0),    // Initial value of Q: 1'b0 or 1'b1
      .SRTYPE("ASYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) ODDR_clk (
      .Q(tx_clk),   // 1-bit DDR output
      .C(sclk),   // 1-bit clock input
      .CE(1'b1), // 1-bit clock enable input
      .D1(1'b1), // 1-bit data input (positive edge)
      .D2(1'b0), // 1-bit data input (negative edge)
      .R(1'b0),   // 1-bit reset
      .S(~rst_n)    // 1-bit set
   );

genvar i;
generate
	for(i=0;i<4;i=i+1)begin
		 ODDR #(
      .DDR_CLK_EDGE("SAME_EDGE"), // "OPPOSITE_EDGE" or "SAME_EDGE" 
      .INIT(1'b0),    // Initial value of Q: 1'b0 or 1'b1
      .SRTYPE("ASYNC") // Set/Reset type: "SYNC" or "ASYNC" 
   ) ODDR_dat (
      .Q(tx_dat[i]),   // 1-bit DDR output
      .C(sclk),   // 1-bit clock input
      .CE(1'b1), // 1-bit clock enable input
      .D1(tx_data[i]), // 1-bit data input (positive edge)
      .D2(tx_data[i+4]), // 1-bit data input (negative edge)
      .R(1'b0),   // 1-bit reset
      .S(~rst_n)    // 1-bit set
   );
	end 

endgenerate

endmodule