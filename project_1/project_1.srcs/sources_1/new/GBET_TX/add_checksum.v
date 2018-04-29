//******************************
//*****桢加checksum模块********
//*****************************
//***********************
//*****计算checksum模块********
//**********************
//不加crc校验
module  add_checksum(
	input	wire		sclk,//输入的125M的时钟
	input	wire		rst_n,
	input	wire[15:0]	UDP_len,//在tx_geb_frame模块中计算出的UDP_len
	input	wire		tx_gen_data_en,//由tx_geb_frame模块传输来的成帧数据使能
	input	wire[7:0]	tx_gen_data,//由tx_geb_frame模块传输来的成帧数据

	output	reg[7:0]	tx_check_sum_data,//输出添加checksum后的成帧数据
	output	reg		tx_check_sum_en, //输出添加checksum后的成帧数据使能
	output	reg		frame_head_flag //在帧头的7*55 1*d5时为地，不参与crc校验
	
	);
reg[7:0]	tx_gen_data_dly;//对tx_gen_data延时一个时钟周期
reg		tx_gen_data_en_dly;//对tx_gen_data_en延时一个时钟周期	
reg		clc_flag;//对移位相加的ip_sum 和udp_sum清零标志
reg[10:0]	data_cnt ;//对tx_gen_data数据量基数并作为ram写地址
reg		shift_ip_en;//ip头部移位拼接使能
reg		shift_ip_en_dly;//ip头部移位拼接使能延时一个时钟周期 
reg		shift_ip_flag;//ip头部移位拼接完成相加标志位
reg[15:0]	shift_ip_data;//ip头部移位拼接数据

reg[31:0]	ip_sum ;//对ip头部移位拼接数据相加
reg[31:0]	ip_checksum;//锁存得到ip_checksum的相反数
reg[10:0]	latch__max;//锁存最后一个数据计数寄存器
reg		latch__flag;//锁存最后一个数据计数标志位




//tx_gen_data_en  tx_gen_data延时一拍
always@(posedge sclk  or negedge rst_n)
	if(!rst_n)
		begin
			tx_gen_data_en_dly <= 1'b0  ;
			tx_gen_data_dly    <= 8'b0;
		end
	else  
		begin
			tx_gen_data_en_dly <= tx_gen_data_en  ;
			tx_gen_data_dly    <= tx_gen_data;
		end
//clc_flag	 对寄存器清零标志	
always@(posedge sclk or negedge rst_n)
	if(!rst_n)
		clc_flag  <=  1'd0  ;
	else  if(tx_gen_data_en_dly==  1'b0&&tx_gen_data_en==1)
		clc_flag<=  1'b1;	
	else
		clc_flag  <=  1'd0  ;	
		
		
//ramd写地址
always@(posedge sclk or negedge rst_n)
	if(!rst_n)
		data_cnt  <=  11'd0  ;
	else  if(tx_gen_data_en_dly==  1'b0)
		data_cnt<=  11'b0;
	else  
		data_cnt  <=  data_cnt  +  1'b1  ;
//
always@(posedge sclk  or negedge rst_n)
	if(!rst_n)
		latch__flag<=  1'b0  ;
	else  if(tx_gen_data_en_dly==1 && tx_gen_data_en==0 )
		latch__flag  <=  1'b1  ;
	else  
		latch__flag  <=  1'b0  ;
always@(posedge sclk  or negedge rst_n)
	if(!rst_n)
		latch__max  <=  1'b0  ;
	else if(latch__flag==1)
		latch__max  <=  data_cnt-1  ;
//参与checksum的值移位使能Shift_ip_en	
always@(posedge sclk)
	if(!rst_n)
		shift_ip_en <= 1'd0 ;		
	else if(data_cnt==21)
		shift_ip_en <= 1'b1 ;
	else if(data_cnt==41)
		shift_ip_en <= 1'd0 ;
		
//Shift_ip_en_dly		
always@(posedge sclk  or negedge rst_n)
	if(!rst_n)
		shift_ip_en_dly <= 1'd0 ;		
	else 
		shift_ip_en_dly <= shift_ip_en ;	
			
//参与checksum的值移位
always@(posedge sclk  or negedge rst_n)
	if(!rst_n)
		shift_ip_data  <=  16'd0  ;
	else  if(shift_ip_en  ==  1'b1  )
		shift_ip_data  <=  {shift_ip_data[7:0],tx_gen_data_dly} ;

always@(posedge sclk  or negedge rst_n)
	if(!rst_n)
		shift_ip_flag<= 1'b0  ;
	else  if(shift_ip_en_dly  ==  1'b1)
		shift_ip_flag  <=  ~shift_ip_flag  ;

always@(posedge sclk  or negedge rst_n)
	if(!rst_n)
		ip_sum  <=  32'd0  ;
	else  if(shift_ip_flag  ==  1'b1)
		ip_sum  <=  ip_sum  +  shift_ip_data  ;
	else  if(clc_flag  ==  1'b1  )
		ip_sum  <= 32'd0  ;

//得到checksum的相反值	
always@(posedge sclk  or negedge rst_n)
	if(!rst_n)
        	ip_checksum  <=  32'd0  ;
	else  if(data_cnt  ==  43)
		ip_checksum  <=  ip_sum ;
	else  if(ip_checksum  >16'hffff)
		ip_checksum  <=  ip_checksum[31:16] +  ip_checksum[15:0] ;

/********************************/
/*************udp_check_sum**********/
/********************************/
reg		shift_udp_en;
reg		shift_udp_en_dly;//计数ip_checksum的标志位
reg		shift_udp_flag;
reg[15:0]	shift_udp_data;//对参与checksum的数据移位

reg[31:0]	udp_sum ;//对最终结果寄存

reg[31:0]	udp_checksum;//得到checksum的相反数

reg		add_pse_flag;//将udp相加后的数据和ip伪头部相加标志
reg[15:0]	latch_UDP_len;//锁存UDP_len

always@(posedge sclk or negedge rst_n)
	if(!rst_n)
		latch_UDP_len  <=  'd0  ;
	else  if(tx_gen_data_en_dly==  1'b0&&tx_gen_data_en==1)
		latch_UDP_len<=  UDP_len;	


/*************ip伪头部计算**********/
//IP源地址+IP目的地址+协议(17)H’11+UDP len 
wire[31:0]	ip_head_pseudo;//ip伪头部
assign	ip_head_pseudo = 16'hc0a8+16'h0001+16'hffff+16'hffff+16'h0011+	latch_UDP_len;

//参与checksum的值移位使能Shift_ip_en	
always@(posedge sclk  or negedge rst_n)
	if(!rst_n)
		shift_udp_en <= 1'd0 ;		
	else if(data_cnt==41&&shift_ip_en==1)
		shift_udp_en <= 1'b1 ;
	else if(tx_gen_data_en==0&&tx_gen_data_en_dly==1)
		shift_udp_en <= 1'd0 ;
		
//Shift_ip_en_dly		
always@(posedge sclk  or negedge rst_n)
	if(!rst_n)
		shift_udp_en_dly <= 1'd0 ;		
	else 
		shift_udp_en_dly <= shift_udp_en ;	
			
//参与checksum的值移位
always@(posedge sclk  or negedge rst_n)
	if(!rst_n)
		shift_udp_data  <=  16'd0  ;
	else  if(shift_udp_en  ==  1'b1  )
		shift_udp_data  <=  {shift_udp_data[7:0],tx_gen_data_dly} ;

always@(posedge sclk  or negedge rst_n)
	if(!rst_n)
		shift_udp_flag<= 1'b0  ;
	else  if(shift_udp_en_dly  ==  1'b1)
		shift_udp_flag  <=  ~shift_udp_flag  ;

always@(posedge sclk  or negedge rst_n)
	if(!rst_n)
		udp_sum  <=  32'd0  ;
	else  if(shift_udp_flag  ==  1'b1)
		udp_sum  <=  udp_sum  +  shift_udp_data  ;
	else  if(clc_flag  ==  1'b1  )
		udp_sum  <= 32'd0  ;

always@(posedge sclk  or negedge rst_n)
	if(!rst_n)
		add_pse_flag <=  1'b0;
	else
		add_pse_flag <= latch__flag;
//得到checksum的相反值	
always@(posedge sclk  or negedge rst_n)
	if(!rst_n)
        	udp_checksum  <=  32'd0  ;
	else  if(add_pse_flag  ==  1)
		udp_checksum  <=  udp_sum +ip_head_pseudo;
	else  if(udp_checksum  >16'hffff)
		udp_checksum  <=  udp_checksum[31:16] +  udp_checksum[15:0] ;
/*******************读ram控制***************************************/
reg		rd_en;
reg		rd_dout_en;
reg[10:0]	rd_addr;
wire[7:0]	rd_dout;

always@(posedge sclk  or negedge rst_n)
	if(!rst_n)
		rd_en <=  1'b0;
	else if(add_pse_flag==1)
		rd_en <= 1'b1;
	else if(rd_addr==latch__max)
		rd_en <=  1'b0;
always@(posedge sclk  or negedge rst_n)
	if(!rst_n)
		rd_dout_en <= 1'b0;
	else 
		rd_dout_en <= rd_en;		
always@(posedge sclk  or negedge rst_n)
	if(!rst_n)
		rd_addr <=  11'h0;	
	else if(rd_en==1)
		rd_addr <= rd_addr + 1'b1 ;
	else
		rd_addr <= 11'h0 ;
		
always@(posedge sclk  or negedge rst_n)
	if(!rst_n)
		tx_check_sum_data <=  'h0;	
	else case(rd_addr)
		11'd33:	tx_check_sum_data <= ~ip_checksum[15:8] ;
		11'd34:	tx_check_sum_data <= ~ip_checksum[7:0] ;
		11'd49:	tx_check_sum_data <= ~udp_checksum[15:8] ;
		11'd50:	tx_check_sum_data <= ~udp_checksum[7:0] ;
		default:	tx_check_sum_data <= rd_dout ;
	endcase
always@(posedge sclk  or negedge rst_n)
	if(!rst_n)
		tx_check_sum_en <= 1'b0;
	else 
		tx_check_sum_en <= rd_dout_en;					
ram_2048x8 ram_2048x8_inst (
  .clka(sclk),    // input wire clka
  .wea(tx_gen_data_en_dly),      // input wire [0 : 0] wea
  .addra(data_cnt),  // input wire [10 : 0] addra
  .dina(tx_gen_data_dly),    // input wire [7 : 0] dina
  .clkb(sclk),    // input wire clkb
  .addrb(rd_addr),  // input wire [10 : 0] addrb
  .doutb(rd_dout)  // output wire [7 : 0] doutb
);


//在帧头的7*55 1*d5时为地，不参与crc校验
always@(posedge  sclk  or negedge rst_n)
	if(!rst_n)
		frame_head_flag  <=  1'b0  ;
	else  if(rd_addr  >11'd10)
		frame_head_flag  <=  1'b0;
	else  
		frame_head_flag  <=  1'b1;



endmodule
