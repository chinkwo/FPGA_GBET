onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+pll3_125m -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.pll3_125m xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {pll3_125m.udo}

run -all

endsim

quit -force
