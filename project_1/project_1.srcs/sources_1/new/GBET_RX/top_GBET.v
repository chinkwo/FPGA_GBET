module	top_GBET_RX(
	input	wire		sclk,rst_n,////50M����pll��ƵΪ125Mʱ��
	//from phy
	input	wire[3:0]	rx_dat,//˫��4bit����  һ��ʱ�����ڴ���8bit����
	input	wire		rx_ctrl,//�����ض�Ӧdv  �½��ض�Ӧerr
	input	wire		rx_clk,//phyʱ������90�Ⱥ�ʱ��
	
	output	wire		begin_flag,
	output	wire[31:0]	rlst,//ͼ���w*h��ֵ
	output	wire		rgb_en,//��po_rx_dataͬ����ʹ��
	output	wire[7:0]	rgb_data,//ͼ����Ϣ
	output	wire		led,
	output	reg		phy_rst_n
);

wire[7:0]	rx_data;//����8bit����         
wire		rx_en;//8bit���ݶ�Ӧ��Ч�ź� 
wire		dout_en_o;//ram������������ͬ����ʹ��                
wire[7:0]	dout_o;//ram������                                   
wire[5:0]	rd_cnt;//��������������Ϊ1��Ӧread_data_o�ĵ�һ����  
wire[5:0]	Latch_max;                                            
                                                                   
reg[19:0]	phy_rst_cnt;

assign	led = rx_en&(|rx_data);
always @(posedge sclk or negedge rst_n)
	if(!rst_n)
		phy_rst_cnt <= 0;
	else if(phy_rst_cnt[8]==0)
		phy_rst_cnt <= phy_rst_cnt + 1'b1;   
always @(posedge sclk or negedge rst_n)
	if(!rst_n)
		phy_rst_n <= 0;
	else 
		phy_rst_n <= phy_rst_cnt[8];
		      
iddr_ctrl iddr_ctrl_inst(
	.rst_n		(rst_n		),
	.rx_dat	(rx_dat	),//˫��4bit����  һ��ʱ�����ڴ���8bit����
	.rx_ctrl	(rx_ctrl	),//�����ض�Ӧdv  �½��ض�Ӧerr
	.rx_clk	(rx_clk	),//phy��������ʱ������90
     
	.rx_data	(rx_data	),//����8bit����
	.rx_en		(rx_en		)//8bit���ݶ�Ӧ��Ч�ź�
);

run_clk_ctrl run_clk_ctrl_inst(
	.rx_clk	(rx_clk	),//phy������125Mʱ��
	.sclk		(sclk		),//ϵͳ125mʱ��
	.rst_n		(rst_n		),
  
	.rx_en		(rx_en		),//˫�ص�rxʹ��
	.rx_data	(rx_data	),//˫�ص�rx����
	
	.dout_en_o	(dout_en_o	),//ram������������ͬ����ʹ��
	.dout_o	(dout_o	),//ram������
	.rd_cnt	(rd_cnt	),//��������������Ϊ1��Ӧread_data_o�ĵ�һ����
	.Latch_max	(Latch_max	)  
);

image_ctrl	image_ctrl_inst(
	.sclk		(sclk		),
	.rst_n		(rst_n		),
	
	.dout_en_o	(dout_en_o	),
	.dout_o	(dout_o	),
	.rd_cnt	(rd_cnt	),
	.Latch_max	(Latch_max	),//�����w_cnt-1��ֵ
	.begin_flag	(begin_flag	),
	.rlst		(rlst		),//ͼ���w*h/(64*4)��ֵ
	.rgb_en	(rgb_en	),//��po_rx_dataͬ����ʹ��
	.rgb_data	(rgb_data	)//ͼ����Ϣ
);




endmodule