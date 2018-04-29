onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc" -t 1ps -L blk_mem_gen_v8_4_1 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -L xpm -lib xil_defaultlib xil_defaultlib.ram_2048x8 xil_defaultlib.glbl

do {wave.do}

view wave
view structure
view signals

do {ram_2048x8.udo}

run -all

quit -force
