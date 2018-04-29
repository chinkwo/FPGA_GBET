//******************************
//*****���checksumģ��********
//*****************************
//***********************
//*****����checksumģ��********
//**********************
//����crcУ��
module  add_checksum(
	input	wire		sclk,//�����125M��ʱ��
	input	wire		rst_n,
	input	wire[15:0]	UDP_len,//��tx_geb_frameģ���м������UDP_len
	input	wire		tx_gen_data_en,//��tx_geb_frameģ�鴫�����ĳ�֡����ʹ��
	input	wire[7:0]	tx_gen_data,//��tx_geb_frameģ�鴫�����ĳ�֡����

	output	reg[7:0]	tx_check_sum_data,//������checksum��ĳ�֡����
	output	reg		tx_check_sum_en, //������checksum��ĳ�֡����ʹ��
	output	reg		frame_head_flag //��֡ͷ��7*55 1*d5ʱΪ�أ�������crcУ��
	
	);
reg[7:0]	tx_gen_data_dly;//��tx_gen_data��ʱһ��ʱ������
reg		tx_gen_data_en_dly;//��tx_gen_data_en��ʱһ��ʱ������	
reg		clc_flag;//����λ��ӵ�ip_sum ��udp_sum�����־
reg[10:0]	data_cnt ;//��tx_gen_data��������������Ϊramд��ַ
reg		shift_ip_en;//ipͷ����λƴ��ʹ��
reg		shift_ip_en_dly;//ipͷ����λƴ��ʹ����ʱһ��ʱ������ 
reg		shift_ip_flag;//ipͷ����λƴ�������ӱ�־λ
reg[15:0]	shift_ip_data;//ipͷ����λƴ������

reg[31:0]	ip_sum ;//��ipͷ����λƴ���������
reg[31:0]	ip_checksum;//����õ�ip_checksum���෴��
reg[10:0]	latch__max;//�������һ�����ݼ����Ĵ���
reg		latch__flag;//�������һ�����ݼ�����־λ




//tx_gen_data_en  tx_gen_data��ʱһ��
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
//clc_flag	 �ԼĴ��������־	
always@(posedge sclk or negedge rst_n)
	if(!rst_n)
		clc_flag  <=  1'd0  ;
	else  if(tx_gen_data_en_dly==  1'b0&&tx_gen_data_en==1)
		clc_flag<=  1'b1;	
	else
		clc_flag  <=  1'd0  ;	
		
		
//ramdд��ַ
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
//����checksum��ֵ��λʹ��Shift_ip_en	
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
			
//����checksum��ֵ��λ
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

//�õ�checksum���෴ֵ	
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
reg		shift_udp_en_dly;//����ip_checksum�ı�־λ
reg		shift_udp_flag;
reg[15:0]	shift_udp_data;//�Բ���checksum��������λ

reg[31:0]	udp_sum ;//�����ս���Ĵ�

reg[31:0]	udp_checksum;//�õ�checksum���෴��

reg		add_pse_flag;//��udp��Ӻ�����ݺ�ipαͷ����ӱ�־
reg[15:0]	latch_UDP_len;//����UDP_len

always@(posedge sclk or negedge rst_n)
	if(!rst_n)
		latch_UDP_len  <=  'd0  ;
	else  if(tx_gen_data_en_dly==  1'b0&&tx_gen_data_en==1)
		latch_UDP_len<=  UDP_len;	


/*************ipαͷ������**********/
//IPԴ��ַ+IPĿ�ĵ�ַ+Э��(17)H��11+UDP len 
wire[31:0]	ip_head_pseudo;//ipαͷ��
assign	ip_head_pseudo = 16'hc0a8+16'h0001+16'hffff+16'hffff+16'h0011+	latch_UDP_len;

//����checksum��ֵ��λʹ��Shift_ip_en	
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
			
//����checksum��ֵ��λ
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
//�õ�checksum���෴ֵ	
always@(posedge sclk  or negedge rst_n)
	if(!rst_n)
        	udp_checksum  <=  32'd0  ;
	else  if(add_pse_flag  ==  1)
		udp_checksum  <=  udp_sum +ip_head_pseudo;
	else  if(udp_checksum  >16'hffff)
		udp_checksum  <=  udp_checksum[31:16] +  udp_checksum[15:0] ;
/*******************��ram����***************************************/
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


//��֡ͷ��7*55 1*d5ʱΪ�أ�������crcУ��
always@(posedge  sclk  or negedge rst_n)
	if(!rst_n)
		frame_head_flag  <=  1'b0  ;
	else  if(rd_addr  >11'd10)
		frame_head_flag  <=  1'b0;
	else  
		frame_head_flag  <=  1'b1;



endmodule
