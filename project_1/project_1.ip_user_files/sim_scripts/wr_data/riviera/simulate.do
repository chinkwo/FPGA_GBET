onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+wr_data -L xil_defaultlib -L xpm -L fifo_generator_v13_2_1 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.wr_data xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {wr_data.udo}

run -all

endsim

quit -force
