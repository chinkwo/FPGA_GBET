-makelib ies_lib/xil_defaultlib -sv \
  "D:/Xilinx/vivado1704/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/Xilinx/vivado1704/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/blk_mem_gen_v8_4_1 \
  "../../../ipstatic/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/ram_64x8/sim/ram_64x8.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib
