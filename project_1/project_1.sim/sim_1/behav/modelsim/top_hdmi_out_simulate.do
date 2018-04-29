######################################################################
#
# File name : top_hdmi_out_simulate.do
# Created on: Tue Mar 20 16:42:40 +0800 2018
#
# Auto generated by Vivado for 'behavioral' simulation
#
######################################################################
vsim -voptargs="+acc" -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -L xpm -lib xil_defaultlib xil_defaultlib.top_hdmi_out xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {top_hdmi_out_wave.do}

view wave
view structure
view signals

do {top_hdmi_out.udo}

run 1000ns