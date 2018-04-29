onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib pll3_125m_opt

do {wave.do}

view wave
view structure
view signals

do {pll3_125m.udo}

run -all

quit -force
