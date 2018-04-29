`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/08/11 17:02:43
// Design Name: 
// Module Name: top_hdmi_out
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_hdmi_out(
input	wire		vga_clk		,
input	wire		vga_5xclk,
input	wire		rst_n		,
input	wire	[7:0]	r,
input	wire	[7:0]	g,
input	wire	[7:0]	b,

output	wire		h_de	,
output	wire		frame_head,

		
output	wire		tmds_clk_p	,
output	wire		tmds_clk_n	,
output	wire		tmds_r_p	,
output	wire		tmds_r_n	,
output	wire		tmds_g_p	,
output	wire		tmds_g_n	,
output	wire		tmds_b_p	,
output	wire		tmds_b_n	,

output	wire		hdmi_en
);
wire		de	;
wire[9:0]	r_10bit	;	
wire[9:0]	g_10bit	;	
wire[9:0]	b_10bit	;	
wire		h_sync	;	
wire		v_sync	;


wire[9:0]	r_d;
wire[9:0]	g_d;
wire[9:0]	b_d;

assign	hdmi_en = 1'b1;
//vga
vga	vga_inst(
.vga_clk	(vga_clk),
.s_rst_n	(rst_n),
.h_sync		(h_sync	),	
.v_sync		(v_sync	),
.de		(de),//有效区域
.h_de		(h_de),
.po_start_flag	(frame_head)//一场图像的开始时刻
);

//r encode  8b-10b
encode	encode_r_inst(
.clkin	(vga_clk),    // pixel clock input
.rstin	(~rst_n),    // async. reset input (active high)
.din	(r),      // data inputs: expect registered
.c0	(1'b0),       // c0 input
.c1	(1'b0),       // c1 input
.de	(de),       // de input
.dout 	(r_10bit)     // data outputs
);

//g encode
encode	encode_g_inst(
.clkin	(vga_clk),    // pixel clock input
.rstin	(~rst_n),    // async. reset input (active high)
.din	(g),      // data inputs: expect registered
.c0	(1'b0),       // c0 input
.c1	(1'b0),       // c1 input
.de	(de),       // de input
.dout 	(g_10bit)     // data outputs
);

//b encode
encode	encode_b_inst(
.clkin	(vga_clk),    // pixel clock input
.rstin	(~rst_n),    // async. reset input (active high)
.din	(b),      // data inputs: expect registered
.c0	(h_sync),       // c0 input
.c1	(v_sync),       // c1 input
.de	(de),       // de input
.dout 	(b_10bit)     // data outputs
);

//r par2ser 
par2ser	par2ser_r_inst(
.clk		(vga_clk),//慢时钟
.clk_5x		(vga_5xclk),//快时钟
.rst_n		(rst_n),//复位，低有效
.i_dat_10bit	(r_10bit),//输入10bit数据

.ser_p		(tmds_r_p),//输出1bit差分数据		
.ser_n		(tmds_r_n)
);

//g par2ser 
par2ser	par2ser_g_inst(
.clk		(vga_clk),//慢时钟
.clk_5x		(vga_5xclk),//快时钟
.rst_n		(rst_n),//复位，低有效
.i_dat_10bit	(g_10bit),//输入10bit数据

.ser_p		(tmds_g_p),//输出1bit差分数据		
.ser_n		(tmds_g_n)
);

//b par2ser 
par2ser	par2ser_b_inst(
.clk		(vga_clk),//慢时钟
.clk_5x		(vga_5xclk),//快时钟
.rst_n		(rst_n),//复位，低有效
.i_dat_10bit	(b_10bit),//输入10bit数据

.ser_p		(tmds_b_p),//输出1bit差分数据		
.ser_n		(tmds_b_n)
);

//clk par2ser 
par2ser	par2ser_clk_inst(
.clk		(vga_clk),//慢时钟
.clk_5x		(vga_5xclk),//快时钟
.rst_n		(rst_n),//复位，低有效
.i_dat_10bit	(10'b11111_00000),//输入10bit数据

.ser_p		(tmds_clk_p),//输出1bit差分数据		
.ser_n		(tmds_clk_n)
);

endmodule
