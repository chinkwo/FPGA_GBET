onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib pll2_50M_opt

do {wave.do}

view wave
view structure
view signals

do {pll2_50M.udo}

run -all

quit -force
