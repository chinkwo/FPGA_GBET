//***********************
//*****成桢模块********
//**********************
//不加crc校验，checksum用零替代
module tx_geb_frame(
	input	wire		sclk,//输入的125M的时钟
	input	wire		rst_n,
	input	wire		Tx_start_en,
	input	wire[9:0]	fifo3_rd_count,
	input	wire[127:0]	fifo3_read_data,
	
	output	reg		read_fifo3_rd_en,
	output	reg		tx_end_flag,

	output	reg[15:0]	UDP_len,
	output	reg[7:0]	po_gen_data,
	output	reg		po_gen_data_en
);


//图像宽高
parameter	IMG_W_DATA=16'H03FF;
parameter	IMG_H_DTAT=16'H02FF ;
//源mac
parameter	MAC_S0=8'HA8;
parameter	MAC_S1=8'HBB;
parameter	MAC_S2=8'HCF;
parameter	MAC_S3=8'H07;
parameter	MAC_S4=8'HD9;
parameter	MAC_S5=8'H9F;

parameter	H_IP_LEN=16'H011C;//头包iplen
parameter	rgb1_IP_LEN=16'h04d6;//数据包1 2 iplen
parameter	rgb3_IP_LEN=16'h02c6;//数据包3   iplen

parameter	H_UDP_LEN=16'H0108;  //头包udp_len
parameter	rgb1_UDP_LEN=16'H04c2;  //数据包1 2udp_len
parameter	rgb3_UDP_LEN=16'H02b2;  //数据包3 udp_len


//源ip地址
parameter	IP_S0=8'Hc0;
parameter	IP_S1=8'Ha8;
parameter	IP_S2=8'H00;
parameter	IP_S3=8'H01;
//目的源ip地址
parameter	IP_D0=8'HFF;
parameter	IP_D1=8'HFF;
parameter	IP_D2=8'HFF;
parameter	IP_D3=8'HFF;
 //源端口号 
parameter	P_S0=8'H00;  
parameter	P_S1=8'H7b; 
 //目的端口号  
parameter	P_D0=8'H04;  
parameter	P_D1=8'Hd2;  


reg[15:0]	IP_len;


reg			shift_en;
reg[3:0]	shift_cnt;

reg		Head_cnt_en;
reg[8:0]	head_cnt;//头包计数
reg[7:0]	Head_data;
reg		Head_en;	


reg[16:0]	wait_cnt;
reg		wait_en;
parameter	WAIT_MAX = 16;

	 
reg		Gen_image_cnt_en;
reg[10:0]	Gen_image_cnt;
reg[7:0]	Gen_image_data;
reg		Gen_image__en;
reg[1:0]	Pik_gen_cnt	; 
reg[15:0]	img_row_cnt;






//头包标志位
always@(posedge  sclk )
  	if(!rst_n)
  		Head_cnt_en  <=  1'b0  ;
  	else  if(head_cnt  ==  305)
  		Head_cnt_en  <=  1'b0   ;	
  	else  if(Tx_start_en  ==  1'b1  &&  fifo3_rd_count>=256  &&  head_cnt  ==  10'd0)
		Head_cnt_en  <=  1'b1 ;
//头包计数
always  @(posedge  sclk )
	if(!rst_n)
		head_cnt  <=  0  ;
	else  if(Head_cnt_en  ==  1'b1)
		head_cnt  <=  head_cnt  +  1'b1  ;
	else if(tx_end_flag==1)	
		head_cnt  <=  0  ;
			
//ip_len
always  @(posedge  sclk )
	if(!rst_n)
		IP_len  <=  16'h0  ;
	else  if(Head_cnt_en  ==  1'b1)
		IP_len  <=  H_IP_LEN  ;
	else if(Pik_gen_cnt<2)	
		IP_len  <=  rgb1_IP_LEN  ;			
	else if(Pik_gen_cnt==2)	
		IP_len  <=  rgb3_IP_LEN  ;			
//udp_len
always  @(posedge  sclk )
	if(!rst_n)
		UDP_len  <=  16'h0  ;
	else  if(Head_cnt_en  ==  1'b1)
		UDP_len  <=  H_UDP_LEN  ;
	else if(Pik_gen_cnt<2)	
		UDP_len  <=  rgb1_UDP_LEN ;			
	else if(Pik_gen_cnt==2)	
		UDP_len  <=  rgb3_UDP_LEN ;				
			

//头包数据
always@(posedge  sclk)
	if(!rst_n)
		Head_data  <=  8'hdd;
	else 	case (head_cnt)
		0,1,2,3,4,5,6		:  	Head_data  <=  8'h55;
		7			:  	Head_data  <=  8'hd5;
		8,9,10,11,12,13 	:  	Head_data  <=  8'hff;
		14			:  	Head_data  <=  MAC_S0;
		15			:  	Head_data  <=  MAC_S1;			       
		16			:  	Head_data  <=  MAC_S2;
		17			:  	Head_data  <=  MAC_S3;
		18			:  	Head_data  <=  MAC_S4;
		19			:  	Head_data  <=  MAC_S5;
		20			:  	Head_data  <=  8'h08;
		21			:  	Head_data  <=  8'h00;
		22			:  	Head_data  <=  8'h45;
		23			:  	Head_data  <=  8'h00; 
		24			:  	Head_data  <=  IP_len[15:8] ;
		25			:  	Head_data  <=  IP_len[7:0] ;
		26,27,28,29		:  	Head_data  <=  8'h00;
		30			:  	Head_data  <=  8'h80; 
		31			:  	Head_data  <=  8'h11; 
		32,33			:  	Head_data  <=  8'h00; 				
		34			:  	Head_data  <=  IP_S0;
		35			:  	Head_data  <=  IP_S1;
		36			:  	Head_data  <=  IP_S2;
		37			:  	Head_data  <=  IP_S3; 
		38,39,40,41		:  	Head_data  <=  8'hff;
						
		42			:  	Head_data  <=  P_S0;
		43			:  	Head_data  <=  P_S1;
		44			:  	Head_data  <=  P_D0;
		45			:  	Head_data  <=  P_D1;
		46			:  	Head_data  <=  UDP_len[15:8]; 
		47			:  	Head_data  <=  UDP_len[7:0];
		48,49			:  	Head_data  <=  8'h00  ;
		50,51,52,53,54,55,56	:  	Head_data  <=  8'hAA ;
		57			:  	Head_data  <=  8'hfa ;
		58			:  	Head_data  <=  IMG_W_DATA[15:8];
		59			:  	Head_data  <=  IMG_W_DATA[7:0] ;
		60			:  	Head_data  <=  IMG_H_DTAT[15:8]; 
		61			:  	Head_data  <=  IMG_H_DTAT[7:0] ;
		304			:  	Head_data  <=  8'h02;
		305			:  	Head_data  <=  8'h03;
		default		: 	Head_data  <=  8'h00;
endcase


//头包数据对应标志使能
always  @(posedge sclk  )
	if(!rst_n)
		 Head_en  <=  1'b0  ;
	else  
		 Head_en  <=  Head_cnt_en  ;
		 
/****************************************************************/	
/****************************************************************/	
//数据包组帧
/****************************************************************/	
/****************************************************************/	

reg[7:0]	PR;


	
//延时标志
always  @(posedge sclk  )
	if(!rst_n)
		 wait_en  <=  1'b0  ;
	else  if( wait_cnt[WAIT_MAX]==  1'b1)
		 wait_en  <=  1'b0  ;
	else  if(head_cnt  ==  305  ||  Gen_image_cnt  ==  1259  ||(Gen_image_cnt  ==  731&& Pik_gen_cnt  ==  2'd2  && img_row_cnt  != 10'd767  )  )
		 wait_en  <=  1'b1  ;
//延时计数
always@(posedge sclk )
	if(!rst_n)
		 wait_cnt  <=  0  ;
	else  if( wait_en  ==  1'b1)
		 wait_cnt  <=   wait_cnt  +  1'b1  ;
	else  
		 wait_cnt  <=  1'b0  ;
//数据包标志位
always@(posedge  sclk)
	if(!rst_n)
		Gen_image_cnt_en  <=  1'b0  ;
	else  if(Gen_image_cnt  ==  1259||(Gen_image_cnt  ==  731  &&  Pik_gen_cnt  ==  2'd2)  )
		Gen_image_cnt_en  <=  1'b0  ;
	else  if( wait_cnt[WAIT_MAX]==  1'b1)
		Gen_image_cnt_en  <=  1'b1  ;
		
//数据计数器
always@(posedge  sclk)
	if(!rst_n)
		Gen_image_cnt  <=  0  ;
	else  if(Gen_image_cnt_en  ==  1 )
		Gen_image_cnt  <=  Gen_image_cnt+1'b1  ;
	else  
		Gen_image_cnt  <=  1'b0  ;		
		
		

//多每行的三个包012循环计数
always@(posedge  sclk)
	if(!rst_n)
		Pik_gen_cnt  <=  2'b0  ;
	else  if(Pik_gen_cnt  ==  2'd2  &&  Gen_image_cnt  ==  731 )
		Pik_gen_cnt  <=  2'd0  ;
	else  if(Gen_image_cnt  ==  1259)
		Pik_gen_cnt  <=  Pik_gen_cnt  +  1'b1  ;
//行计数
always@(posedge  sclk  )
	if(!rst_n)
		img_row_cnt  <=	 16'd0  ;
	else  if(img_row_cnt  ==  16'd768)
		img_row_cnt  <=  16'd0  ;
	else  if(Pik_gen_cnt  ==  2'd2  &&  Gen_image_cnt  ==  731)
		img_row_cnt  <=  img_row_cnt  +  1'b1  ;
		

always@(posedge  sclk)
	if(!rst_n)
		PR  <=  8'd0  ;
	else  if(img_row_cnt  == 16'd767 )
		PR  <=  8'hf6  ;
	else  
		PR  <=  8'hf5  ;
		



//多每行的三个包012循环计数
always@(posedge  sclk)
	if(!rst_n)
		tx_end_flag  <=  1'b0  ;
	else  if( img_row_cnt  ==  768 )
		tx_end_flag  <=  1'b1  ;
	else  
		tx_end_flag  <=  1'b0  ;




	
//向p4的传一个标志物，fifo开始出数据	
always@(posedge sclk)
	if(!rst_n)
		shift_en  <=  1'b0;
	else  if(Gen_image_cnt ==  1259  ||(Pik_gen_cnt  ==  2'd2 &&  Gen_image_cnt  ==  731))
		shift_en  <=  1'b0;
	else if(Gen_image_cnt  ==  59)
		shift_en<=  1'b1 ;
always@(posedge sclk)
	if(!rst_n)
		shift_cnt  <=  'b0;
	else  if(shift_en==0)
		shift_cnt  <=  'b0;
	else  if(shift_cnt==11)
		shift_cnt  <=  'b0;	
	else if(shift_en  ==  1)
		shift_cnt<=  shift_cnt+1'b1 ;	
		
always@(posedge sclk)
	if(!rst_n)
		read_fifo3_rd_en  <=  1'b0;
	
	else if(shift_cnt  ==  10)
		read_fifo3_rd_en<=  1'b1 ;				
	else 
		read_fifo3_rd_en  <=  1'b0;			
	
		
//数据包数据	
always@(posedge  sclk)
	if(!rst_n)
		Gen_image_data  <=  8'hdd;
	else if(shift_en==1)begin
		 case(shift_cnt)	
		 0:      Gen_image_data  <= fifo3_read_data[119:112];
		 1:      Gen_image_data  <= fifo3_read_data[111:104];
		 2:      Gen_image_data  <= fifo3_read_data[103:96];
		 
		 3:      Gen_image_data  <= fifo3_read_data[87:80];
		 4:      Gen_image_data  <= fifo3_read_data[79:72];
		 5:      Gen_image_data  <= fifo3_read_data[71:64];
		 
		 6:      Gen_image_data  <= fifo3_read_data[55:48];
		 7:      Gen_image_data  <= fifo3_read_data[47:40];
		 8:      Gen_image_data  <= fifo3_read_data[39:32];
		 
		 9:      Gen_image_data  <= fifo3_read_data[23:16];
		 10:     Gen_image_data  <= fifo3_read_data[15:8];
		 11:     Gen_image_data  <= fifo3_read_data[7:0];
		 default:;
		endcase  
		end

	else case (Gen_image_cnt)
		0,1,2,3,4,5,6 	:  	Gen_image_data  <=  8'h55;
		7			:  	Gen_image_data  <=  8'hd5;
		8,9,10,11,12,13 	:  	Gen_image_data  <=  8'hff;
		14			:  	Gen_image_data  <=  MAC_S0;
		15			:  	Gen_image_data  <=  MAC_S1;			       
		16			:  	Gen_image_data  <=  MAC_S2;
		17			:  	Gen_image_data  <=  MAC_S3;
		18			:  	Gen_image_data  <=  MAC_S4;
		19			:  	Gen_image_data  <=  MAC_S5;
		20			:  	Gen_image_data  <=  8'h08;
		21			:  	Gen_image_data  <=  8'h00;
		22			:  	Gen_image_data  <=  8'h45;
		23			:  	Gen_image_data  <=  8'h00; 
		24			:  	Gen_image_data  <=  IP_len[15:8] ;
		25			:  	Gen_image_data  <=  IP_len[7:0] ;
		26,27,28,29		:  	Gen_image_data  <=  8'h00;
		30			:  	Gen_image_data  <=  8'h80; 
		31			:  	Gen_image_data  <=  8'h11; 
		32,33			:  	Gen_image_data  <=  8'h00; 				
		34			:  	Gen_image_data  <=  IP_S0;
		35			:  	Gen_image_data  <=  IP_S1;
		36			:  	Gen_image_data  <=  IP_S2;
		37			:  	Gen_image_data  <=  IP_S3; 
		38,39,40,41		:  	Gen_image_data  <=  8'hff;
		42			:  	Gen_image_data  <=  P_S0;
		43			:  	Gen_image_data  <=  P_S1;
		44			:  	Gen_image_data  <=  P_D0;
		45			:  	Gen_image_data  <=  P_D1;
		46   			:  	Gen_image_data  <=  UDP_len[15:8]; 
		47			:  	Gen_image_data  <=  UDP_len[7:0];
		48,49			:  	Gen_image_data  <=  8'h00 ;
		50,51,52,53,54,55,56	:  	Gen_image_data  <=  8'hAA ;
		57			:  	Gen_image_data  <= PR; 
		58			:  	Gen_image_data  <=  img_row_cnt[15:8];
		59			:  	Gen_image_data  <=  img_row_cnt[7:0] ;
		default:;
	endcase

//数据包标志位
always@(posedge  sclk)
	if(!rst_n)
		Gen_image__en  <=  1'b0  ;
	else  
		Gen_image__en <= Gen_image_cnt_en ;




//数据包标志位
always@(posedge  sclk)
	if(!rst_n)
		po_gen_data  <=  8'b0  ;
	else  if(Head_en==1)
		po_gen_data <= Head_data ;
	else  if(Gen_image__en==1)
		po_gen_data <= Gen_image_data ;
	else
		po_gen_data  <=  8'b0  ;

//数据包标志位
always@(posedge  sclk)
	if(!rst_n)
		po_gen_data_en  <=  1'b0  ;
	else  if(Head_en==1||Gen_image__en==1)
		po_gen_data_en <= 1'b1 ;
	else  
		po_gen_data_en <= 1'b0 ;



endmodule