vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm
vlib riviera/fifo_generator_v13_2_1

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm
vmap fifo_generator_v13_2_1 riviera/fifo_generator_v13_2_1

vlog -work xil_defaultlib  -sv2k12 "+incdir+D:/Xilinx/vivado1704/Vivado/2017.4/data/xilinx_vip/include" "+incdir+D:/Xilinx/vivado1704/Vivado/2017.4/data/xilinx_vip/include" \
"D:/Xilinx/vivado1704/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Xilinx/vivado1704/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"D:/Xilinx/vivado1704/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work fifo_generator_v13_2_1  -v2k5 "+incdir+D:/Xilinx/vivado1704/Vivado/2017.4/data/xilinx_vip/include" "+incdir+D:/Xilinx/vivado1704/Vivado/2017.4/data/xilinx_vip/include" \
"../../../ipstatic/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_1 -93 \
"../../../ipstatic/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_1  -v2k5 "+incdir+D:/Xilinx/vivado1704/Vivado/2017.4/data/xilinx_vip/include" "+incdir+D:/Xilinx/vivado1704/Vivado/2017.4/data/xilinx_vip/include" \
"../../../ipstatic/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+D:/Xilinx/vivado1704/Vivado/2017.4/data/xilinx_vip/include" "+incdir+D:/Xilinx/vivado1704/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../project_1.srcs/sources_1/ip/fifo_ddr3_rd_p6/sim/fifo_ddr3_rd_p6.v" \

vlog -work xil_defaultlib \
"glbl.v"

