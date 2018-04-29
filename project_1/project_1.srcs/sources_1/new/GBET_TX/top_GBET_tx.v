module	top_GBET_tx(
	input	wire			sclk,//输入的125M的时钟
	input	wire			rst_n,
	input	wire			Rx_end_flag,//DDR3写结束标志位
	input	wire[9:0]		fifo3_rd_count,//DDR3 P3口读fifo计数器
	input	wire[127:0]		fifo3_read_data,//从DDR3 P3口读fifo的数据


	output	wire 			read_fifo3_rd_en,//从DDR3 P3口读fifo的使能信号
	output	wire			tx_clk,
	output	wire[3:0]		tx_dat,
	output	wire			tx_dv
);
reg		Tx_start_en;//读DDR3 P3开始工作使能
reg		Rx_end_flag_dly;
wire		tx_end_flag;                                
wire[7:0]	po_gen_data;    
wire		po_gen_data_en; 
wire[15:0]	UDP_len;

wire[7:0]	tx_check_sum_data;    
wire		tx_check_sum_en;
wire		frame_head_flag;

wire[7:0]	tx_data_crc;    
wire		tx_data_crc_en;
	
always @(posedge sclk or negedge rst_n)
	if(!rst_n)
		Rx_end_flag_dly <= 0;
	else 
		Rx_end_flag_dly <= Rx_end_flag;

always @(posedge sclk or negedge rst_n)
	if(!rst_n)
		Tx_start_en <= 0;
	else if(Rx_end_flag==1&&Rx_end_flag_dly==0)
		Tx_start_en <= 1;
	else if(tx_end_flag==1)
              Tx_start_en <= 0;            
 




 
tx_geb_frame tx_geb_frame(
	.sclk			(sclk			),
	.rst_n			(rst_n			),
	.Tx_start_en		(Tx_start_en		),
	.fifo3_read_data	(fifo3_read_data	),
	.fifo3_rd_count	(fifo3_rd_count),

	.UDP_len		(UDP_len		),
	.read_fifo3_rd_en	(read_fifo3_rd_en	),
	.tx_end_flag		(tx_end_flag		),
	.po_gen_data		(po_gen_data),
	.po_gen_data_en	(po_gen_data_en)

);

add_checksum add_checksum_inst(
	.sclk			(sclk			),
	.rst_n			(rst_n			),
   	.UDP_len		(UDP_len		),
	.tx_gen_data		(po_gen_data		),//
	.tx_gen_data_en		(po_gen_data_en		),//
    
	.tx_check_sum_data	(tx_check_sum_data	),
	.tx_check_sum_en	(tx_check_sum_en	),
	.frame_head_flag	(frame_head_flag	)
	);
	
crc32_d8_send_02 crc32_d8_send_02_inst (
	.resetb(rst_n), 
    	.sclk(sclk), 
    	.dsin(tx_check_sum_en), 
    	.din(tx_check_sum_data), 
    	.pre_flag(frame_head_flag), 
    	.crc_err_en(0), 
    	.dsout(tx_data_crc_en), 
    	.dout(tx_data_crc)
    	);	
    	
rgmii_tx rgmii_tx (
    .sclk(sclk), 
    .rst_n(rst_n), 
    .tx_dat(tx_data_crc), 
    .tx_en(tx_data_crc_en), 
    
    
    .tx_data(tx_dat), 
    .tx_dv(tx_dv), 
    .tx_clk(tx_clk)
    );    	
    	
endmodule