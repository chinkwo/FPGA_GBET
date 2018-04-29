vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr "+incdir+D:/Xilinx/vivado1704/Vivado/2017.4/data/xilinx_vip/include" "+incdir+D:/Xilinx/vivado1704/Vivado/2017.4/data/xilinx_vip/include" \
"../../../../project_1.srcs/sources_1/ip/ram_2048x8/sim/ram_2048x8.v" \


vlog -work xil_defaultlib \
"glbl.v"

