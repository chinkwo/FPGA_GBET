######################################################################
#
# File name : tb_simulate.do
# Created on: Mon Apr 02 16:52:08 +0800 2018
#
# Auto generated by Vivado for 'behavioral' simulation
#
######################################################################
vsim -voptargs="+acc" -L fifo_generator_v13_2_1 -L xil_defaultlib -L blk_mem_gen_v8_4_1 -L xbip_utils_v3_0_8 -L xbip_pipe_v3_0_4 -L xbip_bram18k_v3_0_4 -L mult_gen_v12_0_13 -L unisims_ver -L unimacro_ver -L secureip -L xpm -lib xil_defaultlib xil_defaultlib.tb xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {tb_wave.do}

view wave
view structure
view signals

do {tb.udo}

run 1000ns