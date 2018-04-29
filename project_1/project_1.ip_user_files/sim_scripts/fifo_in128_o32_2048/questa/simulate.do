onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib fifo_in128_o32_2048_opt

do {wave.do}

view wave
view structure
view signals

do {fifo_in128_o32_2048.udo}

run -all

quit -force
