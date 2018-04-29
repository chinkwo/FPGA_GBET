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
wire		wr1_cmd_en	;//命令fifo读使能                                      
wire[2:0]	wr1_cmd_instr	;//ddr3 写指令 3'b000
wire[6:0]	wr1_cmd_bl	;//ddr3 写突发长度 1~64代表写入1~64个数
wire[27:0]	wr1_cmd_init_addr;//ddr3 写突发的初始地址
wire		wr1_cmd_empty	;//命令fifo空标志
                                    
wire		wr2_cmd_en	;//命令fifo读使能                                      
wire[2:0]	wr2_cmd_instr	;//ddr3 写指令 3'b000
wire[6:0]	wr2_cmd_bl	;//ddr3 写突发长度 1~64代表写入1~64个数
wire[27:0]	wr2_cmd_init_addr;//ddr3 写突发的初始地址
wire		wr2_cmd_empty	;//命令fifo空标志
                                      
wire		wr3_cmd_en	;//命令fifo读使能                                    
wire[2:0]	wr3_cmd_instr	;//ddr3 写指令 3'b000
wire[6:0]	wr3_cmd_bl	;//ddr3 写突发长度 1~64代表写入1~64个数
wire[27:0]	wr3_cmd_init_addr;//ddr3 写突发的初始地址                          
wire		wr3_cmd_empty	;//命令fifo空标志
                                     
wire		wr4_cmd_en	;//命令fifo读使能                                    
wire[2:0]	wr4_cmd_instr	;//ddr3 写指令 3'b000
wire[6:0]	wr4_cmd_bl	;//ddr3 写突发长度 1~64代表写入1~64个数
wire[27:0]	wr4_cmd_init_addr;//ddr3 写突发的初始地址                         
wire		wr4_cmd_empty	;//命令fifo空标志
                                                            
wire		wr1_en		;//数据fifo读使能                                      
wire[15:0]	wr1_mask	;//掩码
wire[127:0]	wr1_data	;//写数据
                           
wire		wr2_en		;//数据fifo读使能                                    
wire[15:0]	wr2_mask	;//掩码
wire[127:0]	wr2_data	;//写数据
                             
wire		wr3_en		;//数据fifo读使能                          
wire[15:0]	wr3_mask	;//掩码
wire[127:0]	wr3_data	;//写数据
                           
wire		wr4_en		;//数据fifo读使能                          
wire[15:0]	wr4_mask	;//掩码
wire[127:0]	wr4_data	;//写数据

wire		rd5_cmd_en	;//命令fifo读使能                      
wire[2:0]	rd5_cmd_instr	;//ddr3 读指令 3'b001
wire[6:0]	rd5_cmd_bl	;//ddr3 读突发长度 1~64代表写入1~64个数
wire[27:0]	rd5_cmd_init_addr;//ddr3 读突发的初始地址                      
wire		rd5_cmd_empty	;//命令fifo空标志
                                
wire		rd6_cmd_en	;//命令fifo读使能                               
wire[2:0]	rd6_cmd_instr	;//ddr3 读指令 3'b001
wire[6:0]	rd6_cmd_bl	;//ddr3 读突发长度 1~64代表写入1~64个数
wire[27:0]	rd6_cmd_init_addr;//ddr3 读突发的初始地址                         
wire		rd6_cmd_empty	;//命令fifo空标志
                                      
wire		rd7_cmd_en	;//命令fifo读使能                                     
wire[2:0]	rd7_cmd_instr	;//ddr3 读指令 3'b001
wire[6:0]	rd7_cmd_bl	;//ddr3 读突发长度 1~64代表写入1~64个数
wire[27:0]	rd7_cmd_init_addr;//ddr3 读突发的初始地址
wire		rd7_cmd_empty	;//命令fifo空标志
                           
wire		rd8_cmd_en	;//命令fifo读使能
wire[2:0]	rd8_cmd_instr	;//ddr3 读指令 3'b001
wire[6:0]	rd8_cmd_bl	;//ddr3 读突发长度 1~64代表写入1~64个数
wire[27:0]	rd8_cmd_init_addr;//ddr3 读突发的初始地址
wire		rd8_cmd_empty	;//命令fifo空标志
                        
wire		rd5_en		;//数据fifo写使能
wire[127:0]	rd5_data	;//数据fifo写数据
                               
wire		rd6_en		;//数据fifo写使能                         
wire[127:0]	rd6_data	;//数据fifo写数据
                               
wire		rd7_en		;//数据fifo写使能                     
wire[127:0]	rd7_data	;//数据fifo写数据
                               
wire		rd8_en		;//数据fifo写使能                      
wire[127:0]	rd8_data	;//数据fifo写数据

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
.wr1_cmd_en	(wr1_cmd_en	 ),//命令fifo读使能 

.wr1_cmd_instr	(wr1_cmd_instr	 ),//ddr3 写指令 3'b000
.wr1_cmd_bl	(wr1_cmd_bl	 ),//ddr3 写突发长度 1~64代表写入1~64个数
.wr1_cmd_init_addr(wr1_cmd_init_addr),//ddr3 写突发的初始地址

.wr1_cmd_empty	(wr1_cmd_empty	 ),//命令fifo空标志
            
.wr2_cmd_en	(wr2_cmd_en	 ),//命令fifo读使能 
              
.wr2_cmd_instr	(wr2_cmd_instr	 ),//ddr3 写指令 3'b000
.wr2_cmd_bl	(wr2_cmd_bl	 ),//ddr3 写突发长度 1~64代表写入1~64个数
.wr2_cmd_init_addr(wr2_cmd_init_addr),//ddr3 写突发的初始地址

.wr2_cmd_empty	(wr2_cmd_empty	 ),//命令fifo空标志
           
.wr3_cmd_en	(wr3_cmd_en	 ),//命令fifo读使能 

.wr3_cmd_instr	(wr3_cmd_instr	 ),//ddr3 写指令 3'b000
.wr3_cmd_bl	(wr3_cmd_bl	 ),//ddr3 写突发长度 1~64代表写入1~64个数
.wr3_cmd_init_addr(wr3_cmd_init_addr),//ddr3 写突发的初始地址

.wr3_cmd_empty	(wr3_cmd_empty	 ),//命令fifo空标志

.wr4_cmd_en	(wr4_cmd_en	 ),//命令fifo读使能 

.wr4_cmd_instr	(wr4_cmd_instr	 ),//ddr3 写指令 3'b000
.wr4_cmd_bl	(wr4_cmd_bl	 ),//ddr3 写突发长度 1~64代表写入1~64个数
.wr4_cmd_init_addr(wr4_cmd_init_addr),//ddr3 写突发的初始地址
  
.wr4_cmd_empty	(wr4_cmd_empty	 ),//命令fifo空标志
                                       
//data port                            
.wr1_en		(wr1_en		 ),//数据fifo读使能

.wr1_mask	(wr1_mask	 ),//掩码
.wr1_data	(wr1_data	 ),//写数据

.wr2_en		(wr2_en		 ),//数据fifo读使能

.wr2_mask	(wr2_mask	 ),//掩码
.wr2_data	(wr2_data	 ),//写数据

.wr3_en		(wr3_en		 ),//数据fifo读使能

.wr3_mask	(wr3_mask	 ),//掩码
.wr3_data	(wr3_data	 ),//写数据

.wr4_en		(wr4_en		 ),//数据fifo读使能

.wr4_mask	(wr4_mask	 ),//掩码
.wr4_data	(wr4_data	 ),//写数据
                                        
//-------- fifo read port------------------
//cmd port                              
.rd5_cmd_en	(rd5_cmd_en	 ),//命令fifo读使能

.rd5_cmd_instr	(rd5_cmd_instr	 ),//ddr3 读指令 3'b001
.rd5_cmd_bl	(rd5_cmd_bl	 ),//ddr3 读突发长度 1~64代表写入1~64个数
.rd5_cmd_init_addr(rd5_cmd_init_addr),//ddr3 读突发的初始地址

.rd5_cmd_empty	(rd5_cmd_empty	 ),//命令fifo空标志

.rd6_cmd_en	(rd6_cmd_en	 ),//命令fifo读使能

.rd6_cmd_instr	(rd6_cmd_instr	 ),//ddr3 读指令 3'b001
.rd6_cmd_bl	(rd6_cmd_bl	 ),//ddr3 读突发长度 1~64代表写入1~64个数
.rd6_cmd_init_addr(rd6_cmd_init_addr),//ddr3 读突发的初始地址
 
.rd6_cmd_empty	(rd6_cmd_empty	 ),//命令fifo空标志

.rd7_cmd_en	(rd7_cmd_en	 ),//命令fifo读使能

.rd7_cmd_instr	(rd7_cmd_instr	 ),//ddr3 读指令 3'b001
.rd7_cmd_bl	(rd7_cmd_bl	 ),//ddr3 读突发长度 1~64代表写入1~64个数
.rd7_cmd_init_addr(rd7_cmd_init_addr),//ddr3 读突发的初始地址

.rd7_cmd_empty	(rd7_cmd_empty	 ),//命令fifo空标志

.rd8_cmd_en	(rd8_cmd_en	 ),//命令fifo读使能

.rd8_cmd_instr	(rd8_cmd_instr	 ),//ddr3 读指令 3'b001
.rd8_cmd_bl	(rd8_cmd_bl	 ),//ddr3 读突发长度 1~64代表写入1~64个数
.rd8_cmd_init_addr(rd8_cmd_init_addr),//ddr3 读突发的初始地址

.rd8_cmd_empty	(rd8_cmd_empty	),//命令fifo空标志
//data port                        
.rd5_en		(rd5_en		),//数据fifo写使能
.rd5_data	(rd5_data	),//数据fifo写数据

.rd6_en		(rd6_en		),//数据fifo写使能                         
.rd6_data	(rd6_data	),//数据fifo写数据

.rd7_en		(rd7_en		),//数据fifo写使能                     
.rd7_data	(rd7_data	),//数据fifo写数据

.rd8_en		(rd8_en		),//数据fifo写使能                      
.rd8_data	(rd8_data	),//数据fifo写数据
                                   
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
.p1_wr_cmd_clk	(p1_wr_cmd_clk	        ),//命令fifo写时钟
.p1_wr_cmd_en	(p1_wr_cmd_en	        ),//命令fifo写使能
.p1_wr_cmd_instr(p1_wr_cmd_instr	),//ddr3 写指令 3'b000
.p1_wr_cmd_bl	(p1_wr_cmd_bl	        ),//ddr3 写突发长度 1~64代表写入1~64个数
.p1_wr_cmd_init_addr(p1_wr_cmd_init_addr),//ddr3 写突发的初始地址

.p1_wr_cmd_empty(p1_wr_cmd_empty	),//命令fifo空标志
.p1_wr_cmd_full	(p1_wr_cmd_full	        ),//命令fifo满标志
                                      
//data port                           
.p1_wr_clk	(p1_wr_clk	        ),//数据fifo写时钟
.p1_wr_en	(p1_wr_en	        ),//数据fifo写使能
.p1_wr_mask	(p1_wr_mask	        ),//掩码
.p1_wr_data	(p1_wr_data	        ),//写数据
              
.p1_wr_empty	(p1_wr_empty	        ),//数据fifo空标志
.p1_wr_full	(p1_wr_full	        ),//数据fifo满标志
.p1_wr_count	(p1_wr_count	        ),//数据fifo内数据量
                                        
//-----------fifo read port start---------------
//cmd port                              
.wr1_cmd_en	(wr1_cmd_en	        ),//命令fifo读使能
             
.wr1_cmd_instr	(wr1_cmd_instr	        ),//ddr3 写指令 3'b000
.wr1_cmd_bl	(wr1_cmd_bl	        ),//ddr3 写突发长度 1~64代表写入1~64个数
.wr1_cmd_init_addr(wr1_cmd_init_addr	),//ddr3 写突发的初始地址

.wr1_cmd_empty	(wr1_cmd_empty	        ),//命令fifo空标志
.wr1_cmd_full	(wr1_cmd_full	        ),//命令fifo满标志
                                        
//data port                             
.wr1_en		(wr1_en		        ),//数据fifo读使能
               
.wr1_mask	(wr1_mask	        ),//掩码
.wr1_data	(wr1_data	        ),//写数据
                                        
//--------port 2 fifo write port------------------
//cmd port                              
.p2_wr_cmd_clk	(p2_wr_cmd_clk	        ),//命令fifo写时钟
.p2_wr_cmd_en	(p2_wr_cmd_en	        ),//命令fifo写使能
.p2_wr_cmd_instr(p2_wr_cmd_instr	),//ddr3 写指令 3'b000
.p2_wr_cmd_bl	(p2_wr_cmd_bl	        ),//ddr3 写突发长度 1~64代表写入1~64个数
.p2_wr_cmd_init_addr(p2_wr_cmd_init_addr),//ddr3 写突发的初始地址

.p2_wr_cmd_empty(p2_wr_cmd_empty	),//命令fifo空标志
.p2_wr_cmd_full	(p2_wr_cmd_full	        ),//命令fifo满标志
                                        
//data port                             
.p2_wr_clk	(p2_wr_clk	        ),//数据fifo写时钟
.p2_wr_en	(p2_wr_en	        ),//数据fifo写使能
.p2_wr_mask	(p2_wr_mask	        ),//掩码
.p2_wr_data	(p2_wr_data	        ),//写数据

.p2_wr_empty	(p2_wr_empty	        ),//数据fifo空标志
.p2_wr_full	(p2_wr_full	        ),//数据fifo满标志
.p2_wr_count	(p2_wr_count	        ),//数据fifo内数据量
                                        
//-----------fifo read port start---------------
//cmd port                              
.wr2_cmd_en	(wr2_cmd_en	        ),//命令fifo读使能

.wr2_cmd_instr	(wr2_cmd_instr	        ),//ddr3 写指令 3'b000
.wr2_cmd_bl	(wr2_cmd_bl	        ),//ddr3 写突发长度 1~64代表写入1~64个数
.wr2_cmd_init_addr(wr2_cmd_init_addr	),//ddr3 写突发的初始地址

.wr2_cmd_empty	(wr2_cmd_empty	        ),//命令fifo空标志
.wr2_cmd_full	(wr2_cmd_full	        ),//命令fifo满标志
                                       
//data port                            
.wr2_en		(wr2_en		        ),//数据fifo读使能

.wr2_mask	(wr2_mask	        ),//掩码
.wr2_data	(wr2_data	        ),//写数据
                                        
//--------port 3 fifo write port------------------
//cmd port                              
.p3_wr_cmd_clk	(p3_wr_cmd_clk	        ),//命令fifo写时钟
.p3_wr_cmd_en	(p3_wr_cmd_en	        ),//命令fifo写使能
.p3_wr_cmd_instr(p3_wr_cmd_instr	),//ddr3 写指令 3'b000
.p3_wr_cmd_bl	(p3_wr_cmd_bl	        ),//ddr3 写突发长度 1~64代表写入1~64个数
.p3_wr_cmd_init_addr(p3_wr_cmd_init_addr),//ddr3 写突发的初始地址

.p3_wr_cmd_empty(p3_wr_cmd_empty	),//命令fifo空标志
.p3_wr_cmd_full	(p3_wr_cmd_full	        ),//命令fifo满标志
                                       
//data port                            
.p3_wr_clk	(p3_wr_clk	        ),//数据fifo写时钟
.p3_wr_en	(p3_wr_en	        ),//数据fifo写使能
.p3_wr_mask	(p3_wr_mask	        ),//掩码
.p3_wr_data	(p3_wr_data	        ),//写数据

.p3_wr_empty	(p3_wr_empty	        ),//数据fifo空标志
.p3_wr_full	(p3_wr_full	        ),//数据fifo满标志
.p3_wr_count	(p3_wr_count	        ),//数据fifo内数据量
                                        
//-----------fifo read port start---------------
//cmd port                              
.wr3_cmd_en	(wr3_cmd_en	        ),//命令fifo读使能
              
.wr3_cmd_instr	(wr3_cmd_instr	        ),//ddr3 写指令 3'b000
.wr3_cmd_bl	(wr3_cmd_bl	        ),//ddr3 写突发长度 1~64代表写入1~64个数
.wr3_cmd_init_addr(wr3_cmd_init_addr),//ddr3 写突发的初始地址

.wr3_cmd_empty	(wr3_cmd_empty	        ),//命令fifo空标志
.wr3_cmd_full	(wr3_cmd_full	        ),//命令fifo满标志
                                       
//data port                            
.wr3_en		(wr3_en		        ),//数据fifo读使能

.wr3_mask	(wr3_mask	        ),//掩码
.wr3_data	(wr3_data	        ),//写数据
                                        
//--------port 4 fifo write port------------------
//cmd port                              
.p4_wr_cmd_clk	(p4_wr_cmd_clk	        ),//命令fifo写时钟
.p4_wr_cmd_en	(p4_wr_cmd_en	        ),//命令fifo写使能
.p4_wr_cmd_instr(p4_wr_cmd_instr	),//ddr3 写指令 3'b000
.p4_wr_cmd_bl	(p4_wr_cmd_bl	        ),//ddr3 写突发长度 1~64代表写入1~64个数
.p4_wr_cmd_init_addr(p4_wr_cmd_init_addr),//ddr3 写突发的初始地址

.p4_wr_cmd_empty(p4_wr_cmd_empty	),//命令fifo空标志
.p4_wr_cmd_full	(p4_wr_cmd_full	        ),//命令fifo满标志
                                       
//data port                            
.p4_wr_clk	(p4_wr_clk		),//数据fifo写时钟
.p4_wr_en	(p4_wr_en		),//数据fifo写使能
.p4_wr_mask	(p4_wr_mask		),//掩码
.p4_wr_data	(p4_wr_data		),//写数据

.p4_wr_empty	(p4_wr_empty		),//数据fifo空标志
.p4_wr_full	(p4_wr_full		),//数据fifo满标志
.p4_wr_count	(p4_wr_count		),//数据fifo内数据量
                                        
//-----------fifo read port start---------------
//cmd port                              
.wr4_cmd_en	(wr4_cmd_en		),//命令fifo读使能
              
.wr4_cmd_instr	(wr4_cmd_instr		),//ddr3 写指令 3'b000
.wr4_cmd_bl	(wr4_cmd_bl		),//ddr3 写突发长度 1~64代表写入1~64个数
.wr4_cmd_init_addr(wr4_cmd_init_addr	),//ddr3 写突发的初始地址

.wr4_cmd_empty	(wr4_cmd_empty		),//命令fifo空标志
.wr4_cmd_full	(wr4_cmd_full		),//命令fifo满标志
                                       
//data port                            
.wr4_en		(wr4_en			),//数据fifo读使能

.wr4_mask	(wr4_mask		),//掩码
.wr4_data	(wr4_data	 	)//写数据
);

//wr path ctrl instance
rd_path_ctrl	rd_path_ctrl_inst(
.ui_clk		(ui_clk		        ),// 
                                        
//--------fifo write port------------------
//cmd port                              
.p5_rd_cmd_clk	(p5_rd_cmd_clk	        ),//命令fifo写时钟
.p5_rd_cmd_en	(p5_rd_cmd_en	        ),//命令fifo写使能
.p5_rd_cmd_instr(p5_rd_cmd_instr	),//ddr3 读指令 3'b001
.p5_rd_cmd_bl	(p5_rd_cmd_bl	        ),//ddr3 读突发长度 1~64代表写入1~64个数
.p5_rd_cmd_init_addr(p5_rd_cmd_init_addr),//ddr3 读突发的初始地址

.p5_rd_cmd_empty(p5_rd_cmd_empty	),//命令fifo空标志
.p5_rd_cmd_full	(p5_rd_cmd_full	        ),//命令fifo满标志
                                       
//data port                            
.p5_rd_clk	(p5_rd_clk	        ),//数据fifo读时钟
.p5_rd_en	(p5_rd_en	        ),//数据fifo读使能

.p5_rd_data_valid(p5_rd_data_valid	),//读出的数据有效标志
.p5_rd_data	(p5_rd_data	        ),//读出的数据

.p5_rd_empty	(p5_rd_empty	        ),//数据fifo空标志
.p5_rd_full	(p5_rd_full	        ),//数据fifo满标志
.p5_rd_count	(p5_rd_count	        ),//数据fifo内数据量
                                        
//--------fifo read port------------------
//cmd port                              
.rd5_cmd_en	(rd5_cmd_en	        ),//命令fifo读使能

.rd5_cmd_instr	(rd5_cmd_instr	        ),//ddr3 读指令 3'b001
.rd5_cmd_bl	(rd5_cmd_bl	        ),//ddr3 读突发长度 1~64代表写入1~64个数
.rd5_cmd_init_addr(rd5_cmd_init_addr	),//ddr3 读突发的初始地址

.rd5_cmd_empty	(rd5_cmd_empty	        ),//命令fifo空标志
.rd5_cmd_full	(rd5_cmd_full	        ),//命令fifo满标志
                                        
//data port                             
.rd5_en		(rd5_en		        ),//数据fifo写使能

.rd5_data	(rd5_data	        ),//数据fifo写数据
                                        
//--------fifo  write port------------------
//cmd port                              
.p6_rd_cmd_clk	(p6_rd_cmd_clk	        ),//命令fifo写时钟
.p6_rd_cmd_en	(p6_rd_cmd_en	        ),//命令fifo写使能
.p6_rd_cmd_instr(p6_rd_cmd_instr	),//ddr3 读指令 3'b001
.p6_rd_cmd_bl	(p6_rd_cmd_bl	        ),//ddr3 读突发长度 1~64代表写入1~64个数
.p6_rd_cmd_init_addr(p6_rd_cmd_init_addr),//ddr3 读突发的初始地址

.p6_rd_cmd_empty(p6_rd_cmd_empty	),//命令fifo空标志
.p6_rd_cmd_full	(p6_rd_cmd_full	        ),//命令fifo满标志
                                        
//data port                             
.p6_rd_clk	(p6_rd_clk	        ),//数据fifo读时钟
.p6_rd_en	(p6_rd_en	        ),//数据fifo读使能

.p6_rd_data_valid(p6_rd_data_valid	),//读出的数据有效标志
.p6_rd_data	(p6_rd_data	        ),//读出的数据

.p6_rd_empty	(p6_rd_empty	        ),//数据fifo空标志
.p6_rd_full	(p6_rd_full	        ),//数据fifo满标志
.p6_rd_count	(p6_rd_count	        ),//数据fifo内数据量
                                        
//--------fifo read port------------------
//cmd port                              
.rd6_cmd_en	(rd6_cmd_en	        ),//命令fifo读使能

.rd6_cmd_instr	(rd6_cmd_instr	        ),//ddr3 读指令 3'b001
.rd6_cmd_bl	(rd6_cmd_bl	        ),//ddr3 读突发长度 1~64代表写入1~64个数
.rd6_cmd_init_addr(rd6_cmd_init_addr	),//ddr3 读突发的初始地址

.rd6_cmd_empty	(rd6_cmd_empty	        ),//命令fifo空标志
.rd6_cmd_full	(rd6_cmd_full	        ),//命令fifo满标志
                                        
//data port                             
.rd6_en		(rd6_en		        ),//数据fifo写使能

.rd6_data	(rd6_data	        ),//数据fifo写数据
                                        
//--------fifo  write port------------------
//cmd port                              
.p7_rd_cmd_clk	(p7_rd_cmd_clk	        ),//命令fifo写时钟
.p7_rd_cmd_en	(p7_rd_cmd_en	        ),//命令fifo写使能
.p7_rd_cmd_instr(p7_rd_cmd_instr	),//ddr3 读指令 3'b001
.p7_rd_cmd_bl	(p7_rd_cmd_bl	        ),//ddr3 读突发长度 1~64代表写入1~64个数
.p7_rd_cmd_init_addr(p7_rd_cmd_init_addr),//ddr3 读突发的初始地址

.p7_rd_cmd_empty(p7_rd_cmd_empty	),//命令fifo空标志
.p7_rd_cmd_full	(p7_rd_cmd_full	        ),//命令fifo满标志
                                        
//data port                             
.p7_rd_clk	(p7_rd_clk		),//数据fifo读时钟
.p7_rd_en	(p7_rd_en		),//数据fifo读使能

.p7_rd_data_valid(p7_rd_data_valid	),//读出的数据有效标志
.p7_rd_data	(p7_rd_data		),//读出的数据

.p7_rd_empty	(p7_rd_empty		),//数据fifo空标志
.p7_rd_full	(p7_rd_full		),//数据fifo满标志
.p7_rd_count	(p7_rd_count		),//数据fifo内数据量

//--------fifo read port------------------
//cmd port
.rd7_cmd_en	(rd7_cmd_en		),//命令fifo读使能

.rd7_cmd_instr	(rd7_cmd_instr		),//ddr3 读指令 3'b001
.rd7_cmd_bl	(rd7_cmd_bl		),//ddr3 读突发长度 1~64代表写入1~64个数
.rd7_cmd_init_addr(rd7_cmd_init_addr),//ddr3 读突发的初始地址

.rd7_cmd_empty	(rd7_cmd_empty		),//命令fifo空标志
.rd7_cmd_full	(rd7_cmd_full		),//命令fifo满标志
                                        
//data port                             
.rd7_en		(rd7_en		        ),//数据fifo写使能

.rd7_data	(rd7_data	        ),//数据fifo写数据
                                       
//--------fifo  write port-----------------
//cmd port                             
.p8_rd_cmd_clk	(p8_rd_cmd_clk	        ),//命令fifo写时钟
.p8_rd_cmd_en	(p8_rd_cmd_en	        ),//命令fifo写使能
.p8_rd_cmd_instr(p8_rd_cmd_instr	),//ddr3 读指令 3'b001
.p8_rd_cmd_bl	(p8_rd_cmd_bl	        ),//ddr3 读突发长度 1~64代表写入1~64个数
.p8_rd_cmd_init_addr(p8_rd_cmd_init_addr),//ddr3 读突发的初始地址

.p8_rd_cmd_empty(p8_rd_cmd_empty	),//命令fifo空标志
.p8_rd_cmd_full	(p8_rd_cmd_full	        ),//命令fifo满标志
                                        
//data port                             
.p8_rd_clk	(p8_rd_clk	        ),//数据fifo读时钟
.p8_rd_en	(p8_rd_en	        ),//数据fifo读使能

.p8_rd_data_valid(p8_rd_data_valid	),//读出的数据有效标志
.p8_rd_data	(p8_rd_data	        ),//读出的数据

.p8_rd_empty	(p8_rd_empty	        ),//数据fifo空标志
.p8_rd_full	(p8_rd_full	        ),//数据fifo满标志
.p8_rd_count	(p8_rd_count	        ),//数据fifo内数据量
                                        
//--------fifo read port------------------
//cmd port                              
.rd8_cmd_en	(rd8_cmd_en	),//命令fifo读使能

.rd8_cmd_instr	(rd8_cmd_instr	),//ddr3 读指令 3'b001
.rd8_cmd_bl	(rd8_cmd_bl	),//ddr3 读突发长度 1~64代表写入1~64个数
.rd8_cmd_init_addr(rd8_cmd_init_addr),//ddr3 读突发的初始地址

.rd8_cmd_empty	(rd8_cmd_empty	 ),//命令fifo空标志
.rd8_cmd_full	(rd8_cmd_full	 ),//命令fifo满标志
                                      
//data port                           
.rd8_en		(rd8_en		 ),//数据fifo写使能

.rd8_data	(rd8_data	 )//数据fifo写数据

);

endmodule