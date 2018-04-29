module	wr_path_ctrl(
input	wire		ui_clk		,// 
//cmd port1
input	wire		p1_wr_cmd_clk	,//����fifoдʱ��
input	wire		p1_wr_cmd_en	,//����fifoдʹ��
input	wire[2:0]	p1_wr_cmd_instr	,//ddr3 дָ�� 3'b000
input	wire[6:0]	p1_wr_cmd_bl	,//ddr3 дͻ������ 1~64����д��1~64����
input	wire[27:0]	p1_wr_cmd_init_addr,//ddr3 дͻ���ĳ�ʼ��ַ
output	wire		p1_wr_cmd_empty	,//����fifo�ձ�־
output	wire		p1_wr_cmd_full	,//����fifo����־
input	wire		p1_wr_clk	,//����fifoдʱ��
input	wire		p1_wr_en		,//����fifoдʹ��
input	wire[15:0]	p1_wr_mask	,//����
input	wire[127:0]	p1_wr_data	,//д����
output	wire		p1_wr_empty	,//����fifo�ձ�־
output	wire		p1_wr_full	,//����fifo����־
output	wire[5:0]	p1_wr_count	,//����fifo��������
input	wire		wr1_cmd_en	,//����fifo��ʹ��
output	wire[2:0]	wr1_cmd_instr	,//ddr3 дָ�� 3'b000
output	wire[6:0]	wr1_cmd_bl	,//ddr3 дͻ������ 1~64����д��1~64����
output	wire[27:0]	wr1_cmd_init_addr,//ddr3 дͻ���ĳ�ʼ��ַ
output	wire		wr1_cmd_empty	,//����fifo�ձ�־
output	wire		wr1_cmd_full	,//����fifo����־
input	wire		wr1_en		,//����fifo��ʹ��
output	wire[15:0]	wr1_mask	,//����
output	wire[127:0]	wr1_data	,//д����
//cmd port2
input	wire		p2_wr_cmd_clk	,//����fifoдʱ��
input	wire		p2_wr_cmd_en	,//����fifoдʹ��
input	wire[2:0]	p2_wr_cmd_instr	,//ddr3 дָ�� 3'b000
input	wire[6:0]	p2_wr_cmd_bl	,//ddr3 дͻ������ 1~64����д��1~64����
input	wire[27:0]	p2_wr_cmd_init_addr,//ddr3 дͻ���ĳ�ʼ��ַ
output	wire		p2_wr_cmd_empty	,//����fifo�ձ�־
output	wire		p2_wr_cmd_full	,//����fifo����־
input	wire		p2_wr_clk	,//����fifoдʱ��
input	wire		p2_wr_en		,//����fifoдʹ��
input	wire[15:0]	p2_wr_mask	,//����
input	wire[127:0]	p2_wr_data	,//д����
output	wire		p2_wr_empty	,//����fifo�ձ�־
output	wire		p2_wr_full	,//����fifo����־
output	wire[5:0]	p2_wr_count	,//����fifo��������
input	wire		wr2_cmd_en	,//����fifo��ʹ��
output	wire[2:0]	wr2_cmd_instr	,//ddr3 дָ�� 3'b000
output	wire[6:0]	wr2_cmd_bl	,//ddr3 дͻ������ 1~64����д��1~64����
output	wire[27:0]	wr2_cmd_init_addr,//ddr3 дͻ���ĳ�ʼ��ַ
output	wire		wr2_cmd_empty	,//����fifo�ձ�־
output	wire		wr2_cmd_full	,//����fifo����־
input	wire		wr2_en		,//����fifo��ʹ��
output	wire[15:0]	wr2_mask	,//����
output	wire[127:0]	wr2_data	,//д����
//cmd port3
input	wire		p3_wr_cmd_clk	,//����fifoдʱ��
input	wire		p3_wr_cmd_en	,//����fifoдʹ��
input	wire[2:0]	p3_wr_cmd_instr,//ddr3 дָ�� 3'b000
input	wire[6:0]	p3_wr_cmd_bl,//ddr3 дͻ������ 1~64����д��1~64����
input	wire[27:0]	p3_wr_cmd_init_addr,//ddr3 дͻ���ĳ�ʼ��ַ
output	wire		p3_wr_cmd_empty,//����fifo�ձ�־
output	wire		p3_wr_cmd_full,//����fifo����־
input	wire		p3_wr_clk	,//����fifoдʱ��
input	wire		p3_wr_en		,//����fifoдʹ��
input	wire[15:0]	p3_wr_mask	,//����
input	wire[127:0]	p3_wr_data	,//д����
output	wire		p3_wr_empty	,//����fifo�ձ�־
output	wire		p3_wr_full	,//����fifo����־
output	wire[5:0]	p3_wr_count	,//����fifo��������
input	wire		wr3_cmd_en	,//����fifo��ʹ��
output	wire[2:0]	wr3_cmd_instr	,//ddr3 дָ�� 3'b000
output	wire[6:0]	wr3_cmd_bl	,//ddr3 дͻ������ 1~64����д��1~64����
output	wire[27:0]	wr3_cmd_init_addr,//ddr3 дͻ���ĳ�ʼ��ַ
output	wire		wr3_cmd_empty	,//����fifo�ձ�־
output	wire		wr3_cmd_full	,//����fifo����־
input	wire		wr3_en		,//����fifo��ʹ��
output	wire[15:0]	wr3_mask	,//����
output	wire[127:0]	wr3_data	,//д����
//cmd port4
input	wire		p4_wr_cmd_clk	,//����fifoдʱ��
input	wire		p4_wr_cmd_en	,//����fifoдʹ��
input	wire[2:0]	p4_wr_cmd_instr	,//ddr3 дָ�� 3'b000
input	wire[6:0]	p4_wr_cmd_bl	,//ddr3 дͻ������ 1~64����д��1~64����
input	wire[27:0]	p4_wr_cmd_init_addr,//ddr3 дͻ���ĳ�ʼ��ַ
output	wire		p4_wr_cmd_empty	,//����fifo�ձ�־
output	wire		p4_wr_cmd_full	,//����fifo����־
input	wire		p4_wr_clk	,//����fifoдʱ��
input	wire		p4_wr_en		,//����fifoдʹ��
input	wire[15:0]	p4_wr_mask	,//����
input	wire[127:0]	p4_wr_data	,//д����
output	wire		p4_wr_empty	,//����fifo�ձ�־
output	wire		p4_wr_full	,//����fifo����־
output	wire[5:0]	p4_wr_count	,//����fifo��������
input	wire		wr4_cmd_en	,//����fifo��ʹ��
output	wire[2:0]	wr4_cmd_instr	,//ddr3 дָ�� 3'b000
output	wire[6:0]	wr4_cmd_bl	,//ddr3 дͻ������ 1~64����д��1~64����
output	wire[27:0]	wr4_cmd_init_addr,//ddr3 дͻ���ĳ�ʼ��ַ
output	wire		wr4_cmd_empty	,//����fifo�ձ�־
output	wire		wr4_cmd_full	,//����fifo����־
input	wire		wr4_en		,//����fifo��ʹ��
output	wire[15:0]	wr4_mask	,//����
output	wire[127:0]	wr4_data	//д����
);

//write path 1
wr_fifo_path	wr_fifo_path1_inst(
.ui_clk		(ui_clk		 ),// 
                                      
//--------fifo write port------------------
//cmd port                              
.p_wr_cmd_clk		(p1_wr_cmd_clk	),//����fifoдʱ��
.p_wr_cmd_en		(p1_wr_cmd_en	 	),//����fifoдʹ��
.p_wr_cmd_instr	(p1_wr_cmd_instr	),//ddr3 дָ�� 3'b000
.p_wr_cmd_bl		(p1_wr_cmd_bl	 	),//ddr3 дͻ������ 1~64����д��1~64����
.p_wr_cmd_init_addr	(p1_wr_cmd_init_addr	),//ddr3 дͻ���ĳ�ʼ��ַ
.p_wr_cmd_empty	(p1_wr_cmd_empty	),//����fifo�ձ�־
.p_wr_cmd_full	(p1_wr_cmd_full	),//����fifo����־                            
.p_wr_clk		(p1_wr_clk	       ),//����fifoдʱ��
.p_wr_en		(p1_wr_en		),//����fifoдʹ��
.p_wr_mask		(p1_wr_mask	       ),//����
.p_wr_data		(p1_wr_data	       ),//д����      
.p_wr_empty		(p1_wr_empty	       ),//����fifo�ձ�־
.p_wr_full		(p1_wr_full	       ),//����fifo����־
.p_wr_count		(p1_wr_count	       ),//����fifo��������                           
.wr_cmd_en		(wr1_cmd_en	    	),//����fifo��ʹ��      
.wr_cmd_instr		(wr1_cmd_instr	),//ddr3 дָ�� 3'b000
.wr_cmd_bl		(wr1_cmd_bl	  	),//ddr3 дͻ������ 1~64����д��1~64����
.wr_cmd_init_addr	(wr1_cmd_init_addr	),//ddr3 дͻ���ĳ�ʼ��ַ 
.wr_cmd_empty		(wr1_cmd_empty	),//����fifo�ձ�־
.wr_cmd_full		(wr1_cmd_full	       ),//����fifo����־                          
.wr_en			(wr1_en		),//����fifo��ʹ��           
.wr_mask		(wr1_mask		),//����
.wr_data		(wr1_data		)//д����
);

//write path 2
wr_fifo_path	wr_fifo_path2_inst(
.ui_clk		(ui_clk		),//                       
.p_wr_cmd_clk		(p2_wr_cmd_clk	),//����fifoдʱ��
.p_wr_cmd_en		(p2_wr_cmd_en	 	),//����fifoдʹ��
.p_wr_cmd_instr	(p2_wr_cmd_instr	),//ddr3 дָ�� 3'b000
.p_wr_cmd_bl		(p2_wr_cmd_bl	 	),//ddr3 дͻ������ 1~64����д��1~64����
.p_wr_cmd_init_addr	(p2_wr_cmd_init_addr),//ddr3 дͻ���ĳ�ʼ��ַ
.p_wr_cmd_empty	(p2_wr_cmd_empty	),//����fifo�ձ�־
.p_wr_cmd_full	(p2_wr_cmd_full	),//����fifo����־                           
.p_wr_clk		(p2_wr_clk		),//����fifoдʱ��
.p_wr_en		(p2_wr_en		),//����fifoдʹ��
.p_wr_mask		(p2_wr_mask	  	),//����
.p_wr_data		(p2_wr_data	  	),//д����            
.p_wr_empty		(p2_wr_empty	  	),//����fifo�ձ�־
.p_wr_full		(p2_wr_full	  	),//����fifo����־
.p_wr_count		(p2_wr_count	  	),//����fifo��������                           
.wr_cmd_en		(wr2_cmd_en		),//����fifo��ʹ��            
.wr_cmd_instr		(wr2_cmd_instr	),//ddr3 дָ�� 3'b000
.wr_cmd_bl		(wr2_cmd_bl	  	),//ddr3 дͻ������ 1~64����д��1~64����
.wr_cmd_init_addr	(wr2_cmd_init_addr	),//ddr3 дͻ���ĳ�ʼ��ַ      
.wr_cmd_empty		(wr2_cmd_empty	),//����fifo�ձ�־
.wr_cmd_full		(wr2_cmd_full	   	),//����fifo����־                           
.wr_en			(wr2_en		),//����fifo��ʹ��             
.wr_mask		(wr2_mask		),//����
.wr_data		(wr2_data		)//д����
);

//write path 3
wr_fifo_path	wr_fifo_path3_inst(
.ui_clk		(ui_clk		),//                             
.p_wr_cmd_clk		(p3_wr_cmd_clk	),//����fifoдʱ��
.p_wr_cmd_en		(p3_wr_cmd_en		),//����fifoдʹ��
.p_wr_cmd_instr	(p3_wr_cmd_instr	),//ddr3 дָ�� 3'b000
.p_wr_cmd_bl		(p3_wr_cmd_bl	 	),//ddr3 дͻ������ 1~64����д��1~64����
.p_wr_cmd_init_addr	(p3_wr_cmd_init_addr	),//ddr3 дͻ���ĳ�ʼ��ַ                     	
.p_wr_cmd_empty	(p3_wr_cmd_empty	),//����fifo�ձ�־
.p_wr_cmd_full	(p3_wr_cmd_full	),//����fifo����־                     
.p_wr_clk		(p3_wr_clk	       ),//����fifoдʱ��
.p_wr_en		(p3_wr_en		),//����fifoдʹ��
.p_wr_mask		(p3_wr_mask	       ),//����
.p_wr_data		(p3_wr_data	       ),//д����           
.p_wr_empty		(p3_wr_empty	       ),//����fifo�ձ�־
.p_wr_full		(p3_wr_full	       ),//����fifo����־
.p_wr_count		(p3_wr_count	       ),//����fifo��������                          
.wr_cmd_en		(wr3_cmd_en	       ),//����fifo��ʹ��        
.wr_cmd_instr		(wr3_cmd_instr	),//ddr3 дָ�� 3'b000
.wr_cmd_bl		(wr3_cmd_bl	       ),//ddr3 дͻ������ 1~64����д��1~64����
.wr_cmd_init_addr	(wr3_cmd_init_addr   ),//ddr3 дͻ���ĳ�ʼ��ַ             
.wr_cmd_empty		(wr3_cmd_empty	),//����fifo�ձ�־
.wr_cmd_full		(wr3_cmd_full	       ),//����fifo����־                
.wr_en			(wr3_en		),//����fifo��ʹ��           
.wr_mask		(wr3_mask		),//����
.wr_data		(wr3_data		)//д����
);

//write path 4
wr_fifo_path	wr_fifo_path4_inst(
.ui_clk		(ui_clk		),//                               
.p_wr_cmd_clk		(p4_wr_cmd_clk	),//����fifoдʱ��
.p_wr_cmd_en		(p4_wr_cmd_en	 	),//����fifoдʹ��
.p_wr_cmd_instr	(p4_wr_cmd_instr	),//ddr3 дָ�� 3'b000
.p_wr_cmd_bl		(p4_wr_cmd_bl	 	),//ddr3 дͻ������ 1~64����д��1~64����
.p_wr_cmd_init_addr	(p4_wr_cmd_init_addr	),//ddr3 дͻ���ĳ�ʼ��ַ
.p_wr_cmd_empty	(p4_wr_cmd_empty	),//����fifo�ձ�־
.p_wr_cmd_full	(p4_wr_cmd_full	),//����fifo����־                            
.p_wr_clk	(p4_wr_clk	        	),//����fifoдʱ��
.p_wr_en	(p4_wr_en			),//����fifoдʹ��
.p_wr_mask	(p4_wr_mask	       	),//����
.p_wr_data	(p4_wr_data	        	),//д����  
.p_wr_empty	(p4_wr_empty	        	),//����fifo�ձ�־
.p_wr_full	(p4_wr_full	        	),//����fifo����־
.p_wr_count	(p4_wr_count	        	),//����fifo��������                             
.wr_cmd_en	(wr4_cmd_en	        	),//����fifo��ʹ��        
.wr_cmd_instr	(wr4_cmd_instr	       ),//ddr3 дָ�� 3'b000
.wr_cmd_bl	(wr4_cmd_bl	        	),//ddr3 дͻ������ 1~64����д��1~64����
.wr_cmd_init_addr(wr4_cmd_init_addr       ),//ddr3 дͻ���ĳ�ʼ��ַ         
.wr_cmd_empty	(wr4_cmd_empty	       ),//����fifo�ձ�־
.wr_cmd_full	(wr4_cmd_full	        	),//����fifo����־                             
.wr_en		(wr4_en		       ),//����fifo��ʹ��          
.wr_mask	(wr4_mask			),//����
.wr_data	(wr4_data			)//д����
);


endmodule