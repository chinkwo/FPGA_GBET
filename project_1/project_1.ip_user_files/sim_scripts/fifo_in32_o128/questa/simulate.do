onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib fifo_in32_o128_opt

do {wave.do}

view wave
view structure
view signals

do {fifo_in32_o128.udo}

run -all

quit -force
