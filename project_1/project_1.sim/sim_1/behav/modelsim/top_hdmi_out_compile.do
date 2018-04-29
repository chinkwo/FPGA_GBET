######################################################################
#
# File name : top_hdmi_out_compile.do
# Created on: Tue Mar 20 16:42:38 +0800 2018
#
# Auto generated by Vivado for 'behavioral' simulation
#
######################################################################
vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -64 -incr -work xil_defaultlib  \
"../../../../project_1.srcs/sources_1/new/hdmi/encode.v" \
"../../../../project_1.srcs/sources_1/new/hdmi/par2ser.v" \
"../../../../project_1.srcs/sources_1/new/hdmi/vga.v" \
"../../../../project_1.srcs/sources_1/new/hdmi/top_hdmi_out.v" \


# compile glbl module
vlog -work xil_defaultlib "glbl.v"

quit -force

