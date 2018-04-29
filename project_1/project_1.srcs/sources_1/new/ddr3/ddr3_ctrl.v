module	ddr3_ctrl
#(
//ddr3 sdram
parameter	MEM_ADDR_WITH	  = 14	,
parameter	MEM_BANKADDR_WITH = 3	,

//user port
parameter	P_ADDR_WITH	  = 28
)
(
input	wire		clk_200M	,
input	wire		rst_n		,

//---------------WRITE PATH--------------
//wr cmd port
input	wire		p1_wr_cmd_clk	,
input	wire		p1_wr_cmd_en	,
input	wire[2:0]	p1_wr_cmd_instr	,
input	wire[6:0]	p1_wr_cmd_bl	,
input	wire[P_ADDR_WITH-1:0]	p1_wr_cmd_init_addr,

output	wire		p1_wr_cmd_empty	,
output	wire		p1_wr_cmd_full	,

//wr data port
input	wire		p1_wr_clk	,
input	wire		p1_wr_en	,
input	wire[15:0]	p1_wr_mask	,
input	wire[127:0]	p1_wr_data	,

output	wire		p1_wr_empty	,
output	wire		p1_wr_full	,
output	wire[5:0]	p1_wr_count	,
//wr cmd port
input	wire		p2_wr_cmd_clk	,
input	wire		p2_wr_cmd_en	,
input	wire[2:0]	p2_wr_cmd_instr	,
input	wire[6:0]	p2_wr_cmd_bl	,
input	wire[P_ADDR_WITH-1:0]	p2_wr_cmd_init_addr,

output	wire		p2_wr_cmd_empty	,
output	wire		p2_wr_cmd_full	,

//wr data port
input	wire		p2_wr_clk	,
input	wire		p2_wr_en	,
input	wire[15:0]	p2_wr_mask	,
input	wire[127:0]	p2_wr_data	,

output	wire		p2_wr_empty	,
output	wire		p2_wr_full	,
output	wire[5:0]	p2_wr_count	,

//wr cmd port
input	wire		p3_wr_cmd_clk	,
input	wire		p3_wr_cmd_en	,
input	wire[2:0]	p3_wr_cmd_instr	,
input	wire[6:0]	p3_wr_cmd_bl	,
input	wire[P_ADDR_WITH-1:0]	p3_wr_cmd_init_addr,

output	wire		p3_wr_cmd_empty	,
output	wire		p3_wr_cmd_full	,

//wr data port
input	wire		p3_wr_clk	,
input	wire		p3_wr_en	,
input	wire[15:0]	p3_wr_mask	,
input	wire[127:0]	p3_wr_data	,

output	wire		p3_wr_empty	,
output	wire		p3_wr_full	,
output	wire[5:0]	p3_wr_count	,

//wr cmd port
input	wire		p4_wr_cmd_clk	,
input	wire		p4_wr_cmd_en	,
input	wire[2:0]	p4_wr_cmd_instr	,
input	wire[6:0]	p4_wr_cmd_bl	,
input	wire[P_ADDR_WITH-1:0]	p4_wr_cmd_init_addr,

output	wire		p4_wr_cmd_empty	,
output	wire		p4_wr_cmd_full	,

//wr data port
input	wire		p4_wr_clk	,
input	wire		p4_wr_en	,
input	wire[15:0]	p4_wr_mask	,
input	wire[127:0]	p4_wr_data	,

output	wire		p4_wr_empty	,
output	wire		p4_wr_full	,
output	wire[5:0]	p4_wr_count	,

//---------------READ PATH--------------
//rd cmd port
input	wire		p5_rd_cmd_clk	,
input	wire		p5_rd_cmd_en	,
input	wire[2:0]	p5_rd_cmd_instr	,
input	wire[6:0]	p5_rd_cmd_bl	,
input	wire[P_ADDR_WITH-1:0]	p5_rd_cmd_init_addr,

output	wire		p5_rd_cmd_empty	,
output	wire		p5_rd_cmd_full	,

//rd data port
input	wire		p5_rd_clk	,
input	wire		p5_rd_en	,

output	wire		p5_rd_data_valid,	
output	wire[127:0]	p5_rd_data	,                         
output	wire		p5_rd_empty	,
output	wire		p5_rd_full	,
output	wire[5:0]	p5_rd_count	,

//rd cmd port
input	wire		p6_rd_cmd_clk	,
input	wire		p6_rd_cmd_en	,
input	wire[2:0]	p6_rd_cmd_instr	,
input	wire[6:0]	p6_rd_cmd_bl	,
input	wire[P_ADDR_WITH-1:0]	p6_rd_cmd_init_addr,

output	wire		p6_rd_cmd_empty	,
output	wire		p6_rd_cmd_full	,

//rd data port
input	wire		p6_rd_clk	,
input	wire		p6_rd_en	,

output	wire		p6_rd_data_valid,
output	wire[127:0]	p6_rd_data	,                         
output	wire		p6_rd_empty	,
output	wire		p6_rd_full	,
output	wire[5:0]	p6_rd_count	,

//rd cmd port
input	wire		p7_rd_cmd_clk	,
input	wire		p7_rd_cmd_en	,
input	wire[2:0]	p7_rd_cmd_instr	,
input	wire[6:0]	p7_rd_cmd_bl	,
input	wire[P_ADDR_WITH-1:0]	p7_rd_cmd_init_addr,

output	wire		p7_rd_cmd_empty	,
output	wire		p7_rd_cmd_full	,

//rd data port
input	wire		p7_rd_clk	,
input	wire		p7_rd_en	,

output	wire		p7_rd_data_valid,
output	wire[127:0]	p7_rd_data	,                         
output	wire		p7_rd_empty	,
output	wire		p7_rd_full	,
output	wire[5:0]	p7_rd_count	,

//rd cmd port
input	wire		p8_rd_cmd_clk	,
input	wire		p8_rd_cmd_en	,
input	wire[2:0]	p8_rd_cmd_instr	,
input	wire[6:0]	p8_rd_cmd_bl	,
input	wire[P_ADDR_WITH-1:0]	p8_rd_cmd_init_addr,

output	wire		p8_rd_cmd_empty	,
output	wire		p8_rd_cmd_full	,

//rd data port
input	wire		p8_rd_clk	,
input	wire		p8_rd_en	,

output	wire		p8_rd_data_valid,
output	wire[127:0]	p8_rd_data	,                         
output	wire		p8_rd_empty	,
output	wire		p8_rd_full	,
output	wire[5:0]	p8_rd_count	,

output	wire		init_calib_complete,


//---------------DDR3 SDRAM-------------
// Inouts
inout [15:0]	ddr3_dq		,
inout [1:0]	ddr3_dqs_n	,
inout [1:0]	ddr3_dqs_p	,
// Outputs
output [MEM_ADDR_WITH-1:0]	ddr3_addr	,
output [MEM_BANKADDR_WITH-1:0]	ddr3_ba		,
output		ddr3_ras_n	,
output		ddr3_cas_n	,
output		ddr3_we_n	,
output		ddr3_reset_n	,
output [0:0]	ddr3_ck_p	,
output [0:0]	ddr3_ck_n	,
output [0:0]	ddr3_cke	,
output [0:0]	ddr3_cs_n	,
output [1:0]	ddr3_dm		,
output [0:0]	ddr3_odt	
);

//wr ctrl port
wire		wr_start	;
wire		app_rdy		;
wire		app_wdf_rdy	;
wire[2:0]	wr_cmd		;
wire[6:0]	wr_bl		;
wire[15:0]	wr_mask		;
wire[27:0]	wr_init_addr	;
wire[127:0]	wr_data		;

wire		app_wdf_en	;
wire		app_wdf_end	;
wire[15:0]	app_wdf_mask	;
wire[127:0]	app_wdf_data	;
wire		app_en_w	;
wire[2:0]	app_cmd_w	;
wire[27:0]	app_addr_w	;

wire		data_req	;
wire		wr_end		;

//rd ctrl port                                    
wire		rd_start	;
wire		app_rd_data_valid;
wire[2:0]	rd_cmd		;
wire[6:0]	rd_bl		;
wire[27:0]	rd_init_addr	;
wire[127:0]	app_rd_data	;

wire		app_en_r	;
wire[2:0]	app_cmd_r	;
wire[27:0]	app_addr_r	;

wire		rd_data_valid	;
wire[127:0]	rd_data		;

wire		rd_end		;

//fifo arbit port
wire		wr1_cmd_en	;//����fifo��ʹ��                                      
wire[2:0]	wr1_cmd_instr	;//ddr3 дָ�� 3'b000
wire[6:0]	wr1_cmd_bl	;//ddr3 дͻ������ 1~64����д��1~64����
wire[27:0]	wr1_cmd_init_addr;//ddr3 дͻ���ĳ�ʼ��ַ
wire		wr1_cmd_empty	;//����fifo�ձ�־
                                    
wire		wr2_cmd_en	;//����fifo��ʹ��                                      
wire[2:0]	wr2_cmd_instr	;//ddr3 дָ�� 3'b000
wire[6:0]	wr2_cmd_bl	;//ddr3 дͻ������ 1~64����д��1~64����
wire[27:0]	wr2_cmd_init_addr;//ddr3 дͻ���ĳ�ʼ��ַ
wire		wr2_cmd_empty	;//����fifo�ձ�־
                                      
wire		wr3_cmd_en	;//����fifo��ʹ��                                    
wire[2:0]	wr3_cmd_instr	;//ddr3 дָ�� 3'b000
wire[6:0]	wr3_cmd_bl	;//ddr3 дͻ������ 1~64����д��1~64����
wire[27:0]	wr3_cmd_init_addr;//ddr3 дͻ���ĳ�ʼ��ַ                          
wire		wr3_cmd_empty	;//����fifo�ձ�־
                                     
wire		wr4_cmd_en	;//����fifo��ʹ��                                    
wire[2:0]	wr4_cmd_instr	;//ddr3 дָ�� 3'b000
wire[6:0]	wr4_cmd_bl	;//ddr3 дͻ������ 1~64����д��1~64����
wire[27:0]	wr4_cmd_init_addr;//ddr3 дͻ���ĳ�ʼ��ַ                         
wire		wr4_cmd_empty	;//����fifo�ձ�־
                                                            
wire		wr1_en		;//����fifo��ʹ��                                      
wire[15:0]	wr1_mask	;//����
wire[127:0]	wr1_data	;//д����
                           
wire		wr2_en		;//����fifo��ʹ��                                    
wire[15:0]	wr2_mask	;//����
wire[127:0]	wr2_data	;//д����
                             
wire		wr3_en		;//����fifo��ʹ��                          
wire[15:0]	wr3_mask	;//����
wire[127:0]	wr3_data	;//д����
                           
wire		wr4_en		;//����fifo��ʹ��                          
wire[15:0]	wr4_mask	;//����
wire[127:0]	wr4_data	;//д����

wire		rd5_cmd_en	;//����fifo��ʹ��                      
wire[2:0]	rd5_cmd_instr	;//ddr3 ��ָ�� 3'b001
wire[6:0]	rd5_cmd_bl	;//ddr3 ��ͻ������ 1~64����д��1~64����
wire[27:0]	rd5_cmd_init_addr;//ddr3 ��ͻ���ĳ�ʼ��ַ                      
wire		rd5_cmd_empty	;//����fifo�ձ�־
                                
wire		rd6_cmd_en	;//����fifo��ʹ��                               
wire[2:0]	rd6_cmd_instr	;//ddr3 ��ָ�� 3'b001
wire[6:0]	rd6_cmd_bl	;//ddr3 ��ͻ������ 1~64����д��1~64����
wire[27:0]	rd6_cmd_init_addr;//ddr3 ��ͻ���ĳ�ʼ��ַ                         
wire		rd6_cmd_empty	;//����fifo�ձ�־
                                      
wire		rd7_cmd_en	;//����fifo��ʹ��                                     
wire[2:0]	rd7_cmd_instr	;//ddr3 ��ָ�� 3'b001
wire[6:0]	rd7_cmd_bl	;//ddr3 ��ͻ������ 1~64����д��1~64����
wire[27:0]	rd7_cmd_init_addr;//ddr3 ��ͻ���ĳ�ʼ��ַ
wire		rd7_cmd_empty	;//����fifo�ձ�־
                           
wire		rd8_cmd_en	;//����fifo��ʹ��
wire[2:0]	rd8_cmd_instr	;//ddr3 ��ָ�� 3'b001
wire[6:0]	rd8_cmd_bl	;//ddr3 ��ͻ������ 1~64����д��1~64����
wire[27:0]	rd8_cmd_init_addr;//ddr3 ��ͻ���ĳ�ʼ��ַ
wire		rd8_cmd_empty	;//����fifo�ձ�־
                        
wire		rd5_en		;//����fifoдʹ��
wire[127:0]	rd5_data	;//����fifoд����
                               
wire		rd6_en		;//����fifoдʹ��                         
wire[127:0]	rd6_data	;//����fifoд����
                               
wire		rd7_en		;//����fifoдʹ��                     
wire[127:0]	rd7_data	;//����fifoд����
                               
wire		rd8_en		;//����fifoдʹ��                      
wire[127:0]	rd8_data	;//����fifoд����

wire		swap		;                                    


//wr path ctrl port
wire		ui_clk		;
wire		app_en		;
wire[2:0]	app_cmd		;
wire[27:0]	app_addr	;

assign	app_en	=	app_en_r|app_en_w;
assign	app_cmd	=	{2'b0,swap};
assign	app_addr=	app_addr_r|app_addr_w;

//a7 ddr3 mig ip core instance
A7_ddr3_mig a7_ddr3_mig_inst(

// Memory interface ports
.ddr3_addr                      (ddr3_addr),  // output [13:0]		ddr3_addr
.ddr3_ba                        (ddr3_ba),  // output [2:0]		ddr3_ba
.ddr3_cas_n                     (ddr3_cas_n),  // output			ddr3_cas_n
.ddr3_ck_n                      (ddr3_ck_n),  // output [0:0]		ddr3_ck_n
.ddr3_ck_p                      (ddr3_ck_p),  // output [0:0]		ddr3_ck_p
.ddr3_cke                       (ddr3_cke),  // output [0:0]		ddr3_cke
.ddr3_ras_n                     (ddr3_ras_n),  // output			ddr3_ras_n
.ddr3_reset_n                   (ddr3_reset_n),  // output			ddr3_reset_n
.ddr3_we_n                      (ddr3_we_n),  // output			ddr3_we_n
.ddr3_dq                        (ddr3_dq),  // inout [15:0]		ddr3_dq
.ddr3_dqs_n                     (ddr3_dqs_n),  // inout [1:0]		ddr3_dqs_n
.ddr3_dqs_p                     (ddr3_dqs_p),  // inout [1:0]		ddr3_dqs_p
.init_calib_complete            (init_calib_complete),  // output			init_calib_complete

.ddr3_cs_n                      (ddr3_cs_n),  // output [0:0]		ddr3_cs_n
.ddr3_dm                        (ddr3_dm),  // output [1:0]		ddr3_dm
.ddr3_odt                       (ddr3_odt),  // output [0:0]		ddr3_odt
// Application interface ports
.app_addr                       (app_addr),  // input [27:0]		app_addr
.app_cmd                        (app_cmd),  // input [2:0]		app_cmd
.app_en                         (app_en),  // input				app_en
.app_wdf_data                   (app_wdf_data),  // input [127:0]		app_wdf_data
.app_wdf_end                    (app_wdf_end),  // input				app_wdf_end
.app_wdf_wren                   (app_wdf_en),  // input				app_wdf_wren
.app_rd_data                    (app_rd_data),  // output [127:0]		app_rd_data
.app_rd_data_end                (),  // output			app_rd_data_end
.app_rd_data_valid              (app_rd_data_valid),  // output			app_rd_data_valid
.app_rdy                        (app_rdy),  // output			app_rdy
.app_wdf_rdy                    (app_wdf_rdy),  // output			app_wdf_rdy
.app_sr_req                     (0),  // input			app_sr_req
.app_ref_req                    (0),  // input			app_ref_req
.app_zq_req                     (0),  // input			app_zq_req
.app_sr_active                  (),  // output			app_sr_active
.app_ref_ack                    (),  // output			app_ref_ack
.app_zq_ack                     (),  // output			app_zq_ack
.ui_clk                         (ui_clk),  // output			ui_clk
.ui_clk_sync_rst                (ui_clk_sync_rst),  // output			ui_clk_sync_rst
.app_wdf_mask                   (app_wdf_mask),  // input [15:0]		app_wdf_mask
// System Clock Ports
.sys_clk_i                       (clk_200M),
.sys_rst                        (rst_n) // input sys_rst
);

// wr ctrl instance
wr_ctrl	
#(
.APP_ADDR_WIDTH(28)
)
wr_ctrl_inst(
.sclk		(ui_clk		),
.rst_n		(rst_n		),
.wr_start	(wr_start	),
.app_rdy	(app_rdy	),
.app_wdf_rdy	(app_wdf_rdy	),
.wr_cmd		(wr_cmd		),
.wr_bl		(wr_bl		),
.wr_mask	(wr_mask	),
.wr_init_addr	(wr_init_addr	),
.wr_data	(wr_data	),

.app_wdf_en	(app_wdf_en	),
.app_wdf_end	(app_wdf_end	),
.app_wdf_mask	(app_wdf_mask	),
.app_wdf_data	(app_wdf_data	),
.app_en		(app_en_w	),
.app_cmd	(app_cmd_w	),
.app_addr	(app_addr_w	),
           
.data_req	(data_req	),
.wr_end		(wr_end		)
);

//rd ctrl instance
rd_ctrl	
#(
.APP_ADDR_WIDTH(28)
)
rd_ctrl_inst(
.sclk		(ui_clk		),
.rst_n		(rst_n		),
.rd_start	(rd_start	),
.app_rdy	(app_rdy	),
.app_rd_data_valid(app_rd_data_valid),
.rd_cmd		(rd_cmd		),
.rd_bl		(rd_bl		),
.rd_init_addr	(rd_init_addr	),
.app_rd_data	(app_rd_data	),

.app_en		(app_en_r	),
.app_cmd	(app_cmd_r	),
.app_addr	(app_addr_r	),

.rd_data_valid	(rd_data_valid	),
.rd_data	(rd_data	),
               
.rd_end		(rd_end		)	
);

//fifo_ arbit instance

fifo_arbit	fifo_arbit_inst(
.ui_clk		(ui_clk		),// 
.rst_n		(init_calib_complete		),

//--------fifo write port------------------
//cmd port
.wr1_cmd_en	(wr1_cmd_en	 ),//����fifo��ʹ�� 

.wr1_cmd_instr	(wr1_cmd_instr	 ),//ddr3 дָ�� 3'b000
.wr1_cmd_bl	(wr1_cmd_bl	 ),//ddr3 дͻ������ 1~64����д��1~64����
.wr1_cmd_init_addr(wr1_cmd_init_addr),//ddr3 дͻ���ĳ�ʼ��ַ

.wr1_cmd_empty	(wr1_cmd_empty	 ),//����fifo�ձ�־
            
.wr2_cmd_en	(wr2_cmd_en	 ),//����fifo��ʹ�� 
              
.wr2_cmd_instr	(wr2_cmd_instr	 ),//ddr3 дָ�� 3'b000
.wr2_cmd_bl	(wr2_cmd_bl	 ),//ddr3 дͻ������ 1~64����д��1~64����
.wr2_cmd_init_addr(wr2_cmd_init_addr),//ddr3 дͻ���ĳ�ʼ��ַ

.wr2_cmd_empty	(wr2_cmd_empty	 ),//����fifo�ձ�־
           
.wr3_cmd_en	(wr3_cmd_en	 ),//����fifo��ʹ�� 

.wr3_cmd_instr	(wr3_cmd_instr	 ),//ddr3 дָ�� 3'b000
.wr3_cmd_bl	(wr3_cmd_bl	 ),//ddr3 дͻ������ 1~64����д��1~64����
.wr3_cmd_init_addr(wr3_cmd_init_addr),//ddr3 дͻ���ĳ�ʼ��ַ

.wr3_cmd_empty	(wr3_cmd_empty	 ),//����fifo�ձ�־

.wr4_cmd_en	(wr4_cmd_en	 ),//����fifo��ʹ�� 

.wr4_cmd_instr	(wr4_cmd_instr	 ),//ddr3 дָ�� 3'b000
.wr4_cmd_bl	(wr4_cmd_bl	 ),//ddr3 дͻ������ 1~64����д��1~64����
.wr4_cmd_init_addr(wr4_cmd_init_addr),//ddr3 дͻ���ĳ�ʼ��ַ
  
.wr4_cmd_empty	(wr4_cmd_empty	 ),//����fifo�ձ�־
                                       
//data port                            
.wr1_en		(wr1_en		 ),//����fifo��ʹ��

.wr1_mask	(wr1_mask	 ),//����
.wr1_data	(wr1_data	 ),//д����

.wr2_en		(wr2_en		 ),//����fifo��ʹ��

.wr2_mask	(wr2_mask	 ),//����
.wr2_data	(wr2_data	 ),//д����

.wr3_en		(wr3_en		 ),//����fifo��ʹ��

.wr3_mask	(wr3_mask	 ),//����
.wr3_data	(wr3_data	 ),//д����

.wr4_en		(wr4_en		 ),//����fifo��ʹ��

.wr4_mask	(wr4_mask	 ),//����
.wr4_data	(wr4_data	 ),//д����
                                        
//-------- fifo read port------------------
//cmd port                              
.rd5_cmd_en	(rd5_cmd_en	 ),//����fifo��ʹ��

.rd5_cmd_instr	(rd5_cmd_instr	 ),//ddr3 ��ָ�� 3'b001
.rd5_cmd_bl	(rd5_cmd_bl	 ),//ddr3 ��ͻ������ 1~64����д��1~64����
.rd5_cmd_init_addr(rd5_cmd_init_addr),//ddr3 ��ͻ���ĳ�ʼ��ַ

.rd5_cmd_empty	(rd5_cmd_empty	 ),//����fifo�ձ�־

.rd6_cmd_en	(rd6_cmd_en	 ),//����fifo��ʹ��

.rd6_cmd_instr	(rd6_cmd_instr	 ),//ddr3 ��ָ�� 3'b001
.rd6_cmd_bl	(rd6_cmd_bl	 ),//ddr3 ��ͻ������ 1~64����д��1~64����
.rd6_cmd_init_addr(rd6_cmd_init_addr),//ddr3 ��ͻ���ĳ�ʼ��ַ
 
.rd6_cmd_empty	(rd6_cmd_empty	 ),//����fifo�ձ�־

.rd7_cmd_en	(rd7_cmd_en	 ),//����fifo��ʹ��

.rd7_cmd_instr	(rd7_cmd_instr	 ),//ddr3 ��ָ�� 3'b001
.rd7_cmd_bl	(rd7_cmd_bl	 ),//ddr3 ��ͻ������ 1~64����д��1~64����
.rd7_cmd_init_addr(rd7_cmd_init_addr),//ddr3 ��ͻ���ĳ�ʼ��ַ

.rd7_cmd_empty	(rd7_cmd_empty	 ),//����fifo�ձ�־

.rd8_cmd_en	(rd8_cmd_en	 ),//����fifo��ʹ��

.rd8_cmd_instr	(rd8_cmd_instr	 ),//ddr3 ��ָ�� 3'b001
.rd8_cmd_bl	(rd8_cmd_bl	 ),//ddr3 ��ͻ������ 1~64����д��1~64����
.rd8_cmd_init_addr(rd8_cmd_init_addr),//ddr3 ��ͻ���ĳ�ʼ��ַ

.rd8_cmd_empty	(rd8_cmd_empty	),//����fifo�ձ�־
//data port                        
.rd5_en		(rd5_en		),//����fifoдʹ��
.rd5_data	(rd5_data	),//����fifoд����

.rd6_en		(rd6_en		),//����fifoдʹ��                         
.rd6_data	(rd6_data	),//����fifoд����

.rd7_en		(rd7_en		),//����fifoдʹ��                     
.rd7_data	(rd7_data	),//����fifoд����

.rd8_en		(rd8_en		),//����fifoдʹ��                      
.rd8_data	(rd8_data	),//����fifoд����
                                   
//-------------wr_ctrl  port---------------
.data_req	(data_req	),
.wr_end		(wr_end		),

.wr_cmd		(wr_cmd		),
.wr_bl		(wr_bl		),
.wr_mask	(wr_mask	),
.wr_init_addr	(wr_init_addr	),
.wr_data	(wr_data	),
.wr_start	(wr_start	),
	
//-------------rd_ctrl  port---------------
.rd_end		(rd_end		),
.rd_data_valid	(rd_data_valid	),
.rd_data	(rd_data	),

.rd_cmd		(rd_cmd		),
.rd_bl		(rd_bl		),
.rd_init_addr	(rd_init_addr	),
.rd_start	(rd_start	),

.swap		(swap		)
);


//wr path ctrl instance
wr_path_ctrl	wr_path_ctrl_inst(
.ui_clk		(ui_clk		        ),// 
                                        
//--------port 1 fifo write port------------------
//cmd port                              
.p1_wr_cmd_clk	(p1_wr_cmd_clk	        ),//����fifoдʱ��
.p1_wr_cmd_en	(p1_wr_cmd_en	        ),//����fifoдʹ��
.p1_wr_cmd_instr(p1_wr_cmd_instr	),//ddr3 дָ�� 3'b000
.p1_wr_cmd_bl	(p1_wr_cmd_bl	        ),//ddr3 дͻ������ 1~64����д��1~64����
.p1_wr_cmd_init_addr(p1_wr_cmd_init_addr),//ddr3 дͻ���ĳ�ʼ��ַ

.p1_wr_cmd_empty(p1_wr_cmd_empty	),//����fifo�ձ�־
.p1_wr_cmd_full	(p1_wr_cmd_full	        ),//����fifo����־
                                      
//data port                           
.p1_wr_clk	(p1_wr_clk	        ),//����fifoдʱ��
.p1_wr_en	(p1_wr_en	        ),//����fifoдʹ��
.p1_wr_mask	(p1_wr_mask	        ),//����
.p1_wr_data	(p1_wr_data	        ),//д����
              
.p1_wr_empty	(p1_wr_empty	        ),//����fifo�ձ�־
.p1_wr_full	(p1_wr_full	        ),//����fifo����־
.p1_wr_count	(p1_wr_count	        ),//����fifo��������
                                        
//-----------fifo read port start---------------
//cmd port                              
.wr1_cmd_en	(wr1_cmd_en	        ),//����fifo��ʹ��
             
.wr1_cmd_instr	(wr1_cmd_instr	        ),//ddr3 дָ�� 3'b000
.wr1_cmd_bl	(wr1_cmd_bl	        ),//ddr3 дͻ������ 1~64����д��1~64����
.wr1_cmd_init_addr(wr1_cmd_init_addr	),//ddr3 дͻ���ĳ�ʼ��ַ

.wr1_cmd_empty	(wr1_cmd_empty	        ),//����fifo�ձ�־
.wr1_cmd_full	(wr1_cmd_full	        ),//����fifo����־
                                        
//data port                             
.wr1_en		(wr1_en		        ),//����fifo��ʹ��
               
.wr1_mask	(wr1_mask	        ),//����
.wr1_data	(wr1_data	        ),//д����
                                        
//--------port 2 fifo write port------------------
//cmd port                              
.p2_wr_cmd_clk	(p2_wr_cmd_clk	        ),//����fifoдʱ��
.p2_wr_cmd_en	(p2_wr_cmd_en	        ),//����fifoдʹ��
.p2_wr_cmd_instr(p2_wr_cmd_instr	),//ddr3 дָ�� 3'b000
.p2_wr_cmd_bl	(p2_wr_cmd_bl	        ),//ddr3 дͻ������ 1~64����д��1~64����
.p2_wr_cmd_init_addr(p2_wr_cmd_init_addr),//ddr3 дͻ���ĳ�ʼ��ַ

.p2_wr_cmd_empty(p2_wr_cmd_empty	),//����fifo�ձ�־
.p2_wr_cmd_full	(p2_wr_cmd_full	        ),//����fifo����־
                                        
//data port                             
.p2_wr_clk	(p2_wr_clk	        ),//����fifoдʱ��
.p2_wr_en	(p2_wr_en	        ),//����fifoдʹ��
.p2_wr_mask	(p2_wr_mask	        ),//����
.p2_wr_data	(p2_wr_data	        ),//д����

.p2_wr_empty	(p2_wr_empty	        ),//����fifo�ձ�־
.p2_wr_full	(p2_wr_full	        ),//����fifo����־
.p2_wr_count	(p2_wr_count	        ),//����fifo��������
                                        
//-----------fifo read port start---------------
//cmd port                              
.wr2_cmd_en	(wr2_cmd_en	        ),//����fifo��ʹ��

.wr2_cmd_instr	(wr2_cmd_instr	        ),//ddr3 дָ�� 3'b000
.wr2_cmd_bl	(wr2_cmd_bl	        ),//ddr3 дͻ������ 1~64����д��1~64����
.wr2_cmd_init_addr(wr2_cmd_init_addr	),//ddr3 дͻ���ĳ�ʼ��ַ

.wr2_cmd_empty	(wr2_cmd_empty	        ),//����fifo�ձ�־
.wr2_cmd_full	(wr2_cmd_full	        ),//����fifo����־
                                       
//data port                            
.wr2_en		(wr2_en		        ),//����fifo��ʹ��

.wr2_mask	(wr2_mask	        ),//����
.wr2_data	(wr2_data	        ),//д����
                                        
//--------port 3 fifo write port------------------
//cmd port                              
.p3_wr_cmd_clk	(p3_wr_cmd_clk	        ),//����fifoдʱ��
.p3_wr_cmd_en	(p3_wr_cmd_en	        ),//����fifoдʹ��
.p3_wr_cmd_instr(p3_wr_cmd_instr	),//ddr3 дָ�� 3'b000
.p3_wr_cmd_bl	(p3_wr_cmd_bl	        ),//ddr3 дͻ������ 1~64����д��1~64����
.p3_wr_cmd_init_addr(p3_wr_cmd_init_addr),//ddr3 дͻ���ĳ�ʼ��ַ

.p3_wr_cmd_empty(p3_wr_cmd_empty	),//����fifo�ձ�־
.p3_wr_cmd_full	(p3_wr_cmd_full	        ),//����fifo����־
                                       
//data port                            
.p3_wr_clk	(p3_wr_clk	        ),//����fifoдʱ��
.p3_wr_en	(p3_wr_en	        ),//����fifoдʹ��
.p3_wr_mask	(p3_wr_mask	        ),//����
.p3_wr_data	(p3_wr_data	        ),//д����

.p3_wr_empty	(p3_wr_empty	        ),//����fifo�ձ�־
.p3_wr_full	(p3_wr_full	        ),//����fifo����־
.p3_wr_count	(p3_wr_count	        ),//����fifo��������
                                        
//-----------fifo read port start---------------
//cmd port                              
.wr3_cmd_en	(wr3_cmd_en	        ),//����fifo��ʹ��
              
.wr3_cmd_instr	(wr3_cmd_instr	        ),//ddr3 дָ�� 3'b000
.wr3_cmd_bl	(wr3_cmd_bl	        ),//ddr3 дͻ������ 1~64����д��1~64����
.wr3_cmd_init_addr(wr3_cmd_init_addr),//ddr3 дͻ���ĳ�ʼ��ַ

.wr3_cmd_empty	(wr3_cmd_empty	        ),//����fifo�ձ�־
.wr3_cmd_full	(wr3_cmd_full	        ),//����fifo����־
                                       
//data port                            
.wr3_en		(wr3_en		        ),//����fifo��ʹ��

.wr3_mask	(wr3_mask	        ),//����
.wr3_data	(wr3_data	        ),//д����
                                        
//--------port 4 fifo write port------------------
//cmd port                              
.p4_wr_cmd_clk	(p4_wr_cmd_clk	        ),//����fifoдʱ��
.p4_wr_cmd_en	(p4_wr_cmd_en	        ),//����fifoдʹ��
.p4_wr_cmd_instr(p4_wr_cmd_instr	),//ddr3 дָ�� 3'b000
.p4_wr_cmd_bl	(p4_wr_cmd_bl	        ),//ddr3 дͻ������ 1~64����д��1~64����
.p4_wr_cmd_init_addr(p4_wr_cmd_init_addr),//ddr3 дͻ���ĳ�ʼ��ַ

.p4_wr_cmd_empty(p4_wr_cmd_empty	),//����fifo�ձ�־
.p4_wr_cmd_full	(p4_wr_cmd_full	        ),//����fifo����־
                                       
//data port                            
.p4_wr_clk	(p4_wr_clk		),//����fifoдʱ��
.p4_wr_en	(p4_wr_en		),//����fifoдʹ��
.p4_wr_mask	(p4_wr_mask		),//����
.p4_wr_data	(p4_wr_data		),//д����

.p4_wr_empty	(p4_wr_empty		),//����fifo�ձ�־
.p4_wr_full	(p4_wr_full		),//����fifo����־
.p4_wr_count	(p4_wr_count		),//����fifo��������
                                        
//-----------fifo read port start---------------
//cmd port                              
.wr4_cmd_en	(wr4_cmd_en		),//����fifo��ʹ��
              
.wr4_cmd_instr	(wr4_cmd_instr		),//ddr3 дָ�� 3'b000
.wr4_cmd_bl	(wr4_cmd_bl		),//ddr3 дͻ������ 1~64����д��1~64����
.wr4_cmd_init_addr(wr4_cmd_init_addr	),//ddr3 дͻ���ĳ�ʼ��ַ

.wr4_cmd_empty	(wr4_cmd_empty		),//����fifo�ձ�־
.wr4_cmd_full	(wr4_cmd_full		),//����fifo����־
                                       
//data port                            
.wr4_en		(wr4_en			),//����fifo��ʹ��

.wr4_mask	(wr4_mask		),//����
.wr4_data	(wr4_data	 	)//д����
);

//wr path ctrl instance
rd_path_ctrl	rd_path_ctrl_inst(
.ui_clk		(ui_clk		        ),// 
                                        
//--------fifo write port------------------
//cmd port                              
.p5_rd_cmd_clk	(p5_rd_cmd_clk	        ),//����fifoдʱ��
.p5_rd_cmd_en	(p5_rd_cmd_en	        ),//����fifoдʹ��
.p5_rd_cmd_instr(p5_rd_cmd_instr	),//ddr3 ��ָ�� 3'b001
.p5_rd_cmd_bl	(p5_rd_cmd_bl	        ),//ddr3 ��ͻ������ 1~64����д��1~64����
.p5_rd_cmd_init_addr(p5_rd_cmd_init_addr),//ddr3 ��ͻ���ĳ�ʼ��ַ

.p5_rd_cmd_empty(p5_rd_cmd_empty	),//����fifo�ձ�־
.p5_rd_cmd_full	(p5_rd_cmd_full	        ),//����fifo����־
                                       
//data port                            
.p5_rd_clk	(p5_rd_clk	        ),//����fifo��ʱ��
.p5_rd_en	(p5_rd_en	        ),//����fifo��ʹ��

.p5_rd_data_valid(p5_rd_data_valid	),//������������Ч��־
.p5_rd_data	(p5_rd_data	        ),//����������

.p5_rd_empty	(p5_rd_empty	        ),//����fifo�ձ�־
.p5_rd_full	(p5_rd_full	        ),//����fifo����־
.p5_rd_count	(p5_rd_count	        ),//����fifo��������
                                        
//--------fifo read port------------------
//cmd port                              
.rd5_cmd_en	(rd5_cmd_en	        ),//����fifo��ʹ��

.rd5_cmd_instr	(rd5_cmd_instr	        ),//ddr3 ��ָ�� 3'b001
.rd5_cmd_bl	(rd5_cmd_bl	        ),//ddr3 ��ͻ������ 1~64����д��1~64����
.rd5_cmd_init_addr(rd5_cmd_init_addr	),//ddr3 ��ͻ���ĳ�ʼ��ַ

.rd5_cmd_empty	(rd5_cmd_empty	        ),//����fifo�ձ�־
.rd5_cmd_full	(rd5_cmd_full	        ),//����fifo����־
                                        
//data port                             
.rd5_en		(rd5_en		        ),//����fifoдʹ��

.rd5_data	(rd5_data	        ),//����fifoд����
                                        
//--------fifo  write port------------------
//cmd port                              
.p6_rd_cmd_clk	(p6_rd_cmd_clk	        ),//����fifoдʱ��
.p6_rd_cmd_en	(p6_rd_cmd_en	        ),//����fifoдʹ��
.p6_rd_cmd_instr(p6_rd_cmd_instr	),//ddr3 ��ָ�� 3'b001
.p6_rd_cmd_bl	(p6_rd_cmd_bl	        ),//ddr3 ��ͻ������ 1~64����д��1~64����
.p6_rd_cmd_init_addr(p6_rd_cmd_init_addr),//ddr3 ��ͻ���ĳ�ʼ��ַ

.p6_rd_cmd_empty(p6_rd_cmd_empty	),//����fifo�ձ�־
.p6_rd_cmd_full	(p6_rd_cmd_full	        ),//����fifo����־
                                        
//data port                             
.p6_rd_clk	(p6_rd_clk	        ),//����fifo��ʱ��
.p6_rd_en	(p6_rd_en	        ),//����fifo��ʹ��

.p6_rd_data_valid(p6_rd_data_valid	),//������������Ч��־
.p6_rd_data	(p6_rd_data	        ),//����������

.p6_rd_empty	(p6_rd_empty	        ),//����fifo�ձ�־
.p6_rd_full	(p6_rd_full	        ),//����fifo����־
.p6_rd_count	(p6_rd_count	        ),//����fifo��������
                                        
//--------fifo read port------------------
//cmd port                              
.rd6_cmd_en	(rd6_cmd_en	        ),//����fifo��ʹ��

.rd6_cmd_instr	(rd6_cmd_instr	        ),//ddr3 ��ָ�� 3'b001
.rd6_cmd_bl	(rd6_cmd_bl	        ),//ddr3 ��ͻ������ 1~64����д��1~64����
.rd6_cmd_init_addr(rd6_cmd_init_addr	),//ddr3 ��ͻ���ĳ�ʼ��ַ

.rd6_cmd_empty	(rd6_cmd_empty	        ),//����fifo�ձ�־
.rd6_cmd_full	(rd6_cmd_full	        ),//����fifo����־
                                        
//data port                             
.rd6_en		(rd6_en		        ),//����fifoдʹ��

.rd6_data	(rd6_data	        ),//����fifoд����
                                        
//--------fifo  write port------------------
//cmd port                              
.p7_rd_cmd_clk	(p7_rd_cmd_clk	        ),//����fifoдʱ��
.p7_rd_cmd_en	(p7_rd_cmd_en	        ),//����fifoдʹ��
.p7_rd_cmd_instr(p7_rd_cmd_instr	),//ddr3 ��ָ�� 3'b001
.p7_rd_cmd_bl	(p7_rd_cmd_bl	        ),//ddr3 ��ͻ������ 1~64����д��1~64����
.p7_rd_cmd_init_addr(p7_rd_cmd_init_addr),//ddr3 ��ͻ���ĳ�ʼ��ַ

.p7_rd_cmd_empty(p7_rd_cmd_empty	),//����fifo�ձ�־
.p7_rd_cmd_full	(p7_rd_cmd_full	        ),//����fifo����־
                                        
//data port                             
.p7_rd_clk	(p7_rd_clk		),//����fifo��ʱ��
.p7_rd_en	(p7_rd_en		),//����fifo��ʹ��

.p7_rd_data_valid(p7_rd_data_valid	),//������������Ч��־
.p7_rd_data	(p7_rd_data		),//����������

.p7_rd_empty	(p7_rd_empty		),//����fifo�ձ�־
.p7_rd_full	(p7_rd_full		),//����fifo����־
.p7_rd_count	(p7_rd_count		),//����fifo��������

//--------fifo read port------------------
//cmd port
.rd7_cmd_en	(rd7_cmd_en		),//����fifo��ʹ��

.rd7_cmd_instr	(rd7_cmd_instr		),//ddr3 ��ָ�� 3'b001
.rd7_cmd_bl	(rd7_cmd_bl		),//ddr3 ��ͻ������ 1~64����д��1~64����
.rd7_cmd_init_addr(rd7_cmd_init_addr),//ddr3 ��ͻ���ĳ�ʼ��ַ

.rd7_cmd_empty	(rd7_cmd_empty		),//����fifo�ձ�־
.rd7_cmd_full	(rd7_cmd_full		),//����fifo����־
                                        
//data port                             
.rd7_en		(rd7_en		        ),//����fifoдʹ��

.rd7_data	(rd7_data	        ),//����fifoд����
                                       
//--------fifo  write port-----------------
//cmd port                             
.p8_rd_cmd_clk	(p8_rd_cmd_clk	        ),//����fifoдʱ��
.p8_rd_cmd_en	(p8_rd_cmd_en	        ),//����fifoдʹ��
.p8_rd_cmd_instr(p8_rd_cmd_instr	),//ddr3 ��ָ�� 3'b001
.p8_rd_cmd_bl	(p8_rd_cmd_bl	        ),//ddr3 ��ͻ������ 1~64����д��1~64����
.p8_rd_cmd_init_addr(p8_rd_cmd_init_addr),//ddr3 ��ͻ���ĳ�ʼ��ַ

.p8_rd_cmd_empty(p8_rd_cmd_empty	),//����fifo�ձ�־
.p8_rd_cmd_full	(p8_rd_cmd_full	        ),//����fifo����־
                                        
//data port                             
.p8_rd_clk	(p8_rd_clk	        ),//����fifo��ʱ��
.p8_rd_en	(p8_rd_en	        ),//����fifo��ʹ��

.p8_rd_data_valid(p8_rd_data_valid	),//������������Ч��־
.p8_rd_data	(p8_rd_data	        ),//����������

.p8_rd_empty	(p8_rd_empty	        ),//����fifo�ձ�־
.p8_rd_full	(p8_rd_full	        ),//����fifo����־
.p8_rd_count	(p8_rd_count	        ),//����fifo��������
                                        
//--------fifo read port------------------
//cmd port                              
.rd8_cmd_en	(rd8_cmd_en	),//����fifo��ʹ��

.rd8_cmd_instr	(rd8_cmd_instr	),//ddr3 ��ָ�� 3'b001
.rd8_cmd_bl	(rd8_cmd_bl	),//ddr3 ��ͻ������ 1~64����д��1~64����
.rd8_cmd_init_addr(rd8_cmd_init_addr),//ddr3 ��ͻ���ĳ�ʼ��ַ

.rd8_cmd_empty	(rd8_cmd_empty	 ),//����fifo�ձ�־
.rd8_cmd_full	(rd8_cmd_full	 ),//����fifo����־
                                      
//data port                           
.rd8_en		(rd8_en		 ),//����fifoдʹ��

.rd8_data	(rd8_data	 )//����fifoд����

);

endmodule