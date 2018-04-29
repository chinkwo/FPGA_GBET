module	top_GBET_RX(
	input	wire		sclk,rst_n,////50M经过pll倍频为125M时钟
	//from phy
	input	wire[3:0]	rx_dat,//双沿4bit数据  一个时钟周期传输8bit数据
	input	wire		rx_ctrl,//上升沿对应dv  下降沿对应err
	input	wire		rx_clk,//phy时钟相移90度后时钟
	
	output	wire		begin_flag,
	output	wire[31:0]	rlst,//图像的w*h的值
	output	wire		rgb_en,//与po_rx_data同步的使能
	output	wire[7:0]	rgb_data,//图像信息
	output	wire		led,
	output	reg		phy_rst_n
);

wire[7:0]	rx_data;//单沿8bit数据         
wire		rx_en;//8bit数据对应有效信号 
wire		dout_en_o;//ram读出的与数据同步的使能                
wire[7:0]	dout_o;//ram的数据                                   
wire[5:0]	rd_cnt;//读计数到计数器为1对应read_data_o的第一个数  
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
	.rx_dat	(rx_dat	),//双沿4bit数据  一个时钟周期传输8bit数据
	.rx_ctrl	(rx_ctrl	),//上升沿对应dv  下降沿对应err
	.rx_clk	(rx_clk	),//phy传输来的时钟相移90
     
	.rx_data	(rx_data	),//单沿8bit数据
	.rx_en		(rx_en		)//8bit数据对应有效信号
);

run_clk_ctrl run_clk_ctrl_inst(
	.rx_clk	(rx_clk	),//phy传来的125M时钟
	.sclk		(sclk		),//系统125m时钟
	.rst_n		(rst_n		),
  
	.rx_en		(rx_en		),//双沿的rx使能
	.rx_data	(rx_data	),//双沿的rx数据
	
	.dout_en_o	(dout_en_o	),//ram读出的与数据同步的使能
	.dout_o	(dout_o	),//ram的数据
	.rd_cnt	(rd_cnt	),//读计数到计数器为1对应read_data_o的第一个数
	.Latch_max	(Latch_max	)  
);

image_ctrl	image_ctrl_inst(
	.sclk		(sclk		),
	.rst_n		(rst_n		),
	
	.dout_en_o	(dout_en_o	),
	.dout_o	(dout_o	),
	.rd_cnt	(rd_cnt	),
	.Latch_max	(Latch_max	),//锁存的w_cnt-1的值
	.begin_flag	(begin_flag	),
	.rlst		(rlst		),//图像的w*h/(64*4)的值
	.rgb_en	(rgb_en	),//与po_rx_data同步的使能
	.rgb_data	(rgb_data	)//图像信息
);




endmodule