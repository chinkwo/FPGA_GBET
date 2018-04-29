onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib rd_data_opt

do {wave.do}

view wave
view structure
view signals

do {rd_data.udo}

run -all

quit -force
