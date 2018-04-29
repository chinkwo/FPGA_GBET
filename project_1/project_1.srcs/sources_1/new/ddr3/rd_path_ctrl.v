module	rd_path_ctrl(
input	wire		ui_clk		,// 

//--------fifo write port------------------
//cmd port5
input	wire		p5_rd_cmd_clk	,//����fifoдʱ��
input	wire		p5_rd_cmd_en	,//����fifoдʹ��
input	wire[2:0]	p5_rd_cmd_instr	,//ddr3 ��ָ�� 3'b001
input	wire[6:0]	p5_rd_cmd_bl	,//ddr3 ��ͻ������ 1~64����д��1~64����
input	wire[27:0]	p5_rd_cmd_init_addr,//ddr3 ��ͻ���ĳ�ʼ��ַ
output	wire		p5_rd_cmd_empty	,//����fifo�ձ�־
output	wire		p5_rd_cmd_full	,//����fifo����־
input	wire		p5_rd_clk	,//����fifo��ʱ��
input	wire		p5_rd_en	,//����fifo��ʹ��
output	wire		p5_rd_data_valid,//������������Ч��־
output	wire[127:0]	p5_rd_data	,//����������
output	wire		p5_rd_empty	,//����fifo�ձ�־
output	wire		p5_rd_full	,//����fifo����־
output	wire[5:0]	p5_rd_count	,//����fifo��������
input	wire		rd5_cmd_en	,//����fifo��ʹ��
output	wire[2:0]	rd5_cmd_instr	,//ddr3 ��ָ�� 3'b001
output	wire[6:0]	rd5_cmd_bl	,//ddr3 ��ͻ������ 1~64����д��1~64����
output	wire[27:0]	rd5_cmd_init_addr,//ddr3 ��ͻ���ĳ�ʼ��ַ               
output	wire		rd5_cmd_empty	,//����fifo�ձ�־
output	wire		rd5_cmd_full	,//����fifo����־
input	wire		rd5_en		,//����fifoдʹ��
input	wire[127:0]	rd5_data	,//����fifoд����
//cmd port6
input	wire		p6_rd_cmd_clk	,//����fifoдʱ��
input	wire		p6_rd_cmd_en	,//����fifoдʹ��
input	wire[2:0]	p6_rd_cmd_instr,//ddr3 ��ָ�� 3'b001
input	wire[6:0]	p6_rd_cmd_bl	,//ddr3 ��ͻ������ 1~64����д��1~64����
input	wire[27:0]	p6_rd_cmd_init_addr,//ddr3 ��ͻ���ĳ�ʼ��ַ
output	wire		p6_rd_cmd_empty,//����fifo�ձ�־
output	wire		p6_rd_cmd_full,//����fifo����־
input	wire		p6_rd_clk	,//����fifo��ʱ��
input	wire		p6_rd_en	,//����fifo��ʹ��
output	wire		p6_rd_data_valid,//������������Ч��־
output	wire[127:0]	p6_rd_data	,//����������
output	wire		p6_rd_empty	,//����fifo�ձ�־
output	wire		p6_rd_full	,//����fifo����־
output	wire[5:0]	p6_rd_count	,//����fifo��������
input	wire		rd6_cmd_en	,//����fifo��ʹ��
output	wire[2:0]	rd6_cmd_instr	,//ddr3 ��ָ�� 3'b001
output	wire[6:0]	rd6_cmd_bl	,//ddr3 ��ͻ������ 1~64����д��1~64����
output	wire[27:0]	rd6_cmd_init_addr,//ddr3 ��ͻ���ĳ�ʼ��ַ                   
output	wire		rd6_cmd_empty	,//����fifo�ձ�־
output	wire		rd6_cmd_full	,//����fifo����־
input	wire		rd6_en		,//����fifoдʹ��
input	wire[127:0]	rd6_data	,//����fifoд����
//cmd port7
input	wire		p7_rd_cmd_clk	,//����fifoдʱ��
input	wire		p7_rd_cmd_en	,//����fifoдʹ��
input	wire[2:0]	p7_rd_cmd_instr	,//ddr3 ��ָ�� 3'b001
input	wire[6:0]	p7_rd_cmd_bl	,//ddr3 ��ͻ������ 1~64����д��1~64����
input	wire[27:0]	p7_rd_cmd_init_addr,//ddr3 ��ͻ���ĳ�ʼ��ַ
output	wire		p7_rd_cmd_empty	,//����fifo�ձ�־
output	wire		p7_rd_cmd_full	,//����fifo����־
input	wire		p7_rd_clk	,//����fifo��ʱ��
input	wire		p7_rd_en	,//����fifo��ʹ��
output	wire		p7_rd_data_valid,//������������Ч��־
output	wire[127:0]	p7_rd_data	,//����������
output	wire		p7_rd_empty	,//����fifo�ձ�־
output	wire		p7_rd_full	,//����fifo����־
output	wire[5:0]	p7_rd_count	,//����fifo��������
input	wire		rd7_cmd_en	,//����fifo��ʹ��
output	wire[2:0]	rd7_cmd_instr	,//ddr3 ��ָ�� 3'b001
output	wire[6:0]	rd7_cmd_bl	,//ddr3 ��ͻ������ 1~64����д��1~64����
output	wire[27:0]	rd7_cmd_init_addr,//ddr3 ��ͻ���ĳ�ʼ��ַ          
output	wire		rd7_cmd_empty	,//����fifo�ձ�־
output	wire		rd7_cmd_full	,//����fifo����־
input	wire		rd7_en		,//����fifoдʹ��
input	wire[127:0]	rd7_data	,//����fifoд����
//cmd port8
input	wire		p8_rd_cmd_clk	,//����fifoдʱ��
input	wire		p8_rd_cmd_en	,//����fifoдʹ��
input	wire[2:0]	p8_rd_cmd_instr,//ddr3 ��ָ�� 3'b001
input	wire[6:0]	p8_rd_cmd_bl	,//ddr3 ��ͻ������ 1~64����д��1~64����
input	wire[27:0]	p8_rd_cmd_init_addr,//ddr3 ��ͻ���ĳ�ʼ��ַ
output	wire		p8_rd_cmd_empty,//����fifo�ձ�־
output	wire		p8_rd_cmd_full,//����fifo����־
input	wire		p8_rd_clk	,//����fifo��ʱ��
input	wire		p8_rd_en	,//����fifo��ʹ��
output	wire		p8_rd_data_valid,//������������Ч��־
output	wire[127:0]	p8_rd_data	,//����������
output	wire		p8_rd_empty	,//����fifo�ձ�־
output	wire		p8_rd_full	,//����fifo����־
output	wire[5:0]	p8_rd_count	,//����fifo��������
input	wire		rd8_cmd_en	,//����fifo��ʹ��
output	wire[2:0]	rd8_cmd_instr	,//ddr3 ��ָ�� 3'b001
output	wire[6:0]	rd8_cmd_bl	,//ddr3 ��ͻ������ 1~64����д��1~64����
output	wire[27:0]	rd8_cmd_init_addr,//ddr3 ��ͻ���ĳ�ʼ��ַ                      
output	wire		rd8_cmd_empty	,//����fifo�ձ�־
output	wire		rd8_cmd_full	,//����fifo����־
input	wire		rd8_en		,//����fifoдʹ��
input	wire[127:0]	rd8_data	//����fifoд����

);

//write path 5
rd_fifo_path	rd_fifo_path5_inst(
.ui_clk		(ui_clk		),//                              
.p_rd_cmd_clk		(p5_rd_cmd_clk	),//����fifoдʱ��
.p_rd_cmd_en		(p5_rd_cmd_en		),//����fifoдʹ��
.p_rd_cmd_instr	(p5_rd_cmd_instr	),//ddr3 ��ָ�� 3'b001
.p_rd_cmd_bl		(p5_rd_cmd_bl		),//ddr3 ��ͻ������ 1~64����д��1~64����
.p_rd_cmd_init_addr	(p5_rd_cmd_init_addr	),//ddr3 ��ͻ���ĳ�ʼ��ַ
.p_rd_cmd_empty	(p5_rd_cmd_empty	),//����fifo�ձ�־
.p_rd_cmd_full	(p5_rd_cmd_full	),//����fifo����־                         
.p_rd_clk		(p5_rd_clk		),//����fifo��ʱ��
.p_rd_en		(p5_rd_en		),//����fifo��ʹ��
.p_rd_data_valid	(p5_rd_data_valid	),//������������Ч��־
.p_rd_data		(p5_rd_data		),//����������
.p_rd_empty		(p5_rd_empty		),//����fifo�ձ�־
.p_rd_full		(p5_rd_full		),//����fifo����־
.p_rd_count		(p5_rd_count		),//����fifo��������                             
.rd_cmd_en		(rd5_cmd_en		),//����fifo��ʹ��
.rd_cmd_instr		(rd5_cmd_instr	),//ddr3 ��ָ�� 3'b001
.rd_cmd_bl		(rd5_cmd_bl		),//ddr3 ��ͻ������ 1~64����д��1~64����
.rd_cmd_init_addr	(rd5_cmd_init_addr	),//ddr3 ��ͻ���ĳ�ʼ��ַ
.rd_cmd_empty		(rd5_cmd_empty	),//����fifo�ձ�־
.rd_cmd_full		(rd5_cmd_full		),//����fifo����־                         
.rd_en			(rd5_en		),//����fifoдʹ��
.rd_data		(rd5_data		)//����fifoд����
);

//write path 6
rd_fifo_path	rd_fifo_path6_inst(
.ui_clk		(ui_clk		),//                               
.p_rd_cmd_clk		(p6_rd_cmd_clk	),//����fifoдʱ��
.p_rd_cmd_en		(p6_rd_cmd_en		),//����fifoдʹ��
.p_rd_cmd_instr	(p6_rd_cmd_instr	),//ddr3 ��ָ�� 3'b001
.p_rd_cmd_bl		(p6_rd_cmd_bl		),//ddr3 ��ͻ������ 1~64����д��1~64����
.p_rd_cmd_init_addr	(p6_rd_cmd_init_addr	),//ddr3 ��ͻ���ĳ�ʼ��ַ
.p_rd_cmd_empty	(p6_rd_cmd_empty	),//����fifo�ձ�־
.p_rd_cmd_full	(p6_rd_cmd_full	),//����fifo����־                          
.p_rd_clk		(p6_rd_clk		),//����fifo��ʱ��
.p_rd_en		(p6_rd_en		),//����fifo��ʹ��
.p_rd_data_valid	(p6_rd_data_valid	),//������������Ч��־
.p_rd_data		(p6_rd_data		),//����������
.p_rd_empty		(p6_rd_empty		),//����fifo�ձ�־
.p_rd_full		(p6_rd_full		),//����fifo����־
.p_rd_count		(p6_rd_count		),//����fifo��������                              
.rd_cmd_en		(rd6_cmd_en		),//����fifo��ʹ��
.rd_cmd_instr		(rd6_cmd_instr	),//ddr3 ��ָ�� 3'b001
.rd_cmd_bl		(rd6_cmd_bl		),//ddr3 ��ͻ������ 1~64����д��1~64����
.rd_cmd_init_addr	(rd6_cmd_init_addr	),//ddr3 ��ͻ���ĳ�ʼ��ַ
.rd_cmd_empty		(rd6_cmd_empty	),//����fifo�ձ�־
.rd_cmd_full		(rd6_cmd_full		),//����fifo����־                          
.rd_en			(rd6_en		),//����fifoдʹ��
.rd_data		(rd6_data		)//����fifoд����
);

//write path 7
rd_fifo_path	rd_fifo_path7_inst(
.ui_clk		(ui_clk		),//                              
.p_rd_cmd_clk		(p7_rd_cmd_clk	),//����fifoдʱ��
.p_rd_cmd_en		(p7_rd_cmd_en		),//����fifoдʹ��
.p_rd_cmd_instr	(p7_rd_cmd_instr	),//ddr3 ��ָ�� 3'b001
.p_rd_cmd_bl		(p7_rd_cmd_bl		),//ddr3 ��ͻ������ 1~64����д��1~64����
.p_rd_cmd_init_addr	(p7_rd_cmd_init_addr	),//ddr3 ��ͻ���ĳ�ʼ��ַ
.p_rd_cmd_empty	(p7_rd_cmd_empty	),//����fifo�ձ�־
.p_rd_cmd_full	(p7_rd_cmd_full	),//����fifo����־                          
.p_rd_clk		(p7_rd_clk		),//����fifo��ʱ��
.p_rd_en		(p7_rd_en		),//����fifo��ʹ��
.p_rd_data_valid	(p7_rd_data_valid	),//������������Ч��־
.p_rd_data		(p7_rd_data		),//����������
.p_rd_empty		(p7_rd_empty		),//����fifo�ձ�־
.p_rd_full		(p7_rd_full		),//����fifo����־
.p_rd_count		(p7_rd_count		),//����fifo��������                           
.rd_cmd_en		(rd7_cmd_en		),//����fifo��ʹ��
.rd_cmd_instr		(rd7_cmd_instr	),//ddr3 ��ָ�� 3'b001
.rd_cmd_bl		(rd7_cmd_bl		),//ddr3 ��ͻ������ 1~64����д��1~64����
.rd_cmd_init_addr	(rd7_cmd_init_addr	),//ddr3 ��ͻ���ĳ�ʼ��ַ
.rd_cmd_empty		(rd7_cmd_empty	),//����fifo�ձ�־
.rd_cmd_full		(rd7_cmd_full		),//����fifo����־                        
.rd_en			(rd7_en		),//����fifoдʹ��
.rd_data		(rd7_data		)//����fifoд����
);

//write path 8
rd_fifo_path	rd_fifo_path8_inst(
.ui_clk		(ui_clk		),//                              
.p_rd_cmd_clk		(p8_rd_cmd_clk	),//����fifoдʱ��
.p_rd_cmd_en		(p8_rd_cmd_en		),//����fifoдʹ��
.p_rd_cmd_instr	(p8_rd_cmd_instr	),//ddr3 ��ָ�� 3'b001
.p_rd_cmd_bl		(p8_rd_cmd_bl		),//ddr3 ��ͻ������ 1~64����д��1~64����
.p_rd_cmd_init_addr	(p8_rd_cmd_init_addr	),//ddr3 ��ͻ���ĳ�ʼ��ַ
.p_rd_cmd_empty	(p8_rd_cmd_empty	),//����fifo�ձ�־
.p_rd_cmd_full	(p8_rd_cmd_full	),//����fifo����־                          
.p_rd_clk		(p8_rd_clk		),//����fifo��ʱ��
.p_rd_en		(p8_rd_en		),//����fifo��ʹ��
.p_rd_data_valid	(p8_rd_data_valid	),//������������Ч��־
.p_rd_data		(p8_rd_data		),//����������
.p_rd_empty		(p8_rd_empty		),//����fifo�ձ�־
.p_rd_full		(p8_rd_full		),//����fifo����־
.p_rd_count		(p8_rd_count		),//����fifo��������                              
.rd_cmd_en		(rd8_cmd_en		),//����fifo��ʹ��
.rd_cmd_instr		(rd8_cmd_instr	),//ddr3 ��ָ�� 3'b001
.rd_cmd_bl		(rd8_cmd_bl		),//ddr3 ��ͻ������ 1~64����д��1~64����
.rd_cmd_init_addr	(rd8_cmd_init_addr	),//ddr3 ��ͻ���ĳ�ʼ��ַ
.rd_cmd_empty		(rd8_cmd_empty	),//����fifo�ձ�־
.rd_cmd_full		(rd8_cmd_full		),//����fifo����־                          
.rd_en			(rd8_en		),//����fifoдʹ��
.rd_data		(rd8_data		)//����fifoд����
);	


endmodule