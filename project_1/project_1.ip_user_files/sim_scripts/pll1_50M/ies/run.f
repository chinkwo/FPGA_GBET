-makelib ies_lib/xil_defaultlib -sv \
  "D:/Xilinx/vivado1704/Vivado/2017.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
-endlib
-makelib ies_lib/xpm \
  "D:/Xilinx/vivado1704/Vivado/2017.4/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies_lib/xil_defaultlib \
  "../../../../project_1.srcs/sources_1/ip/pll1_50M/pll1_50M_clk_wiz.v" \
  "../../../../project_1.srcs/sources_1/ip/pll1_50M/pll1_50M.v" \
-endlib
-makelib ies_lib/xil_defaultlib \
  glbl.v
-endlib

