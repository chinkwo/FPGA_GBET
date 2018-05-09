// Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2018.1 (win64) Build 2188600 Wed Apr  4 18:40:38 MDT 2018
// Date        : Mon May  7 20:36:33 2018
// Host        : DESKTOP-JPATCP2 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               F:/FPGA_VIVADO/FPGA_GBET/project_1/project_1.srcs/sources_1/ip/cmd_fifo/cmd_fifo_stub.v
// Design      : cmd_fifo
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tfgg484-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "fifo_generator_v13_2_2,Vivado 2018.1" *)
module cmd_fifo(wr_clk, rd_clk, din, wr_en, rd_en, dout, full, empty)
/* synthesis syn_black_box black_box_pad_pin="wr_clk,rd_clk,din[38:0],wr_en,rd_en,dout[38:0],full,empty" */;
  input wr_clk;
  input rd_clk;
  input [38:0]din;
  input wr_en;
  input rd_en;
  output [38:0]dout;
  output full;
  output empty;
endmodule
