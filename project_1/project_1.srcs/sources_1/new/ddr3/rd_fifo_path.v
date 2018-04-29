module	rd_fifo_path(
input	wire		ui_clk		,// 

//--------fifo write port------------------
//cmd port
input	wire		p_rd_cmd_clk	,//����fifoдʱ��
input	wire		p_rd_cmd_en	,//����fifoдʹ��
input	wire[2:0]	p_rd_cmd_instr	,//ddr3 ��ָ�� 3'b001
input	wire[6:0]	p_rd_cmd_bl	,//ddr3 ��ͻ������ 1~64����д��1~64����
input	wire[29:0]	p_rd_cmd_init_addr,//ddr3 ��ͻ���ĳ�ʼ��ַ

output	wire		p_rd_cmd_empty	,//����fifo�ձ�־
output	wire		p_rd_cmd_full	,//����fifo����־

//data port
input	wire		p_rd_clk	,//����fifo��ʱ��
input	wire		p_rd_en		,//����fifo��ʹ��

output	reg		p_rd_data_valid	,//������������Ч��־
output	wire[127:0]	p_rd_data	,//����������

output	wire		p_rd_empty	,//����fifo�ձ�־
output	wire		p_rd_full	,//����fifo����־
output	wire[5:0]	p_rd_count	,//����fifo��������

//--------fifo read port------------------
//cmd port
input	wire		rd_cmd_en	,//����fifo��ʹ��

output	wire[2:0]	rd_cmd_instr	,//ddr3 ��ָ�� 3'b001
output	wire[6:0]	rd_cmd_bl	,//ddr3 ��ͻ������ 1~64����д��1~64����
output	wire[29:0]	rd_cmd_init_addr,//ddr3 ��ͻ���ĳ�ʼ��ַ
                        
output	wire		rd_cmd_empty	,//����fifo�ձ�־
output	wire		rd_cmd_full	,//����fifo����־

//data port
input	wire		rd_en		,//����fifoдʹ��

input	wire[127:0]	rd_data		//����fifoд����

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