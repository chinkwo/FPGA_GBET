-makelib ies_lib/xil_defaultlib -sv \
  "D:/Xilinx/vivado1704/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/Xilinx/vivado1704/Vivado/2017.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/Xilinx/vivado1704/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_1 \
  "../../../ipstatic/simulation/fifo_generator_vlog_beh.v" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_1 \
  "../../../ipstatic/hdl/fifo_generator_v13_2_rfs.vhd" \
-endlib
-makelib ies_lib/fifo_generator_v13_2_1 \
  "../../../ipstatic/hdl/fifo_generator_v13_2_rfs.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/fifo_in128_o32_2048/sim/fifo_in128_o32_2048.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib
