onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib wr_data_opt

do {wave.do}

view wave
view structure
view signals

do {wr_data.udo}

run -all

quit -force
