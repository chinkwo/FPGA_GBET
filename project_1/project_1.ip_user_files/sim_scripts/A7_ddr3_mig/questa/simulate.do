onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib A7_ddr3_mig_opt

do {wave.do}

view wave
view structure
view signals

do {A7_ddr3_mig.udo}

run -all

quit -force
