onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L fifo_generator_v13_2_1 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -L xpm -lib xil_defaultlib xil_defaultlib.fifo_ddr3_rd_p6 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {fifo_ddr3_rd_p6.udo}

run -all

quit -force