vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xilinx_vip
vlib modelsim_lib/msim/xil_defaultlib
vlib modelsim_lib/msim/xpm

vmap xilinx_vip modelsim_lib/msim/xilinx_vip
vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib
vmap xpm modelsim_lib/msim/xpm

vlog -work xilinx_vip -64 -incr -sv -L xil_defaultlib "+incdir+D:/Xilinx/Vivado/2018.1/data/xilinx_vip/include" "+incdir+D:/Xilinx/Vivado/2018.1/data/xilinx_vip/include" \
"D:/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
"D:/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
"D:/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
"D:/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
"D:/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
"D:/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
"D:/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/axi_vip_if.sv" \
"D:/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/clk_vip_if.sv" \
"D:/Xilinx/Vivado/2018.1/data/xilinx_vip/hdl/rst_vip_if.sv" \

vlog -work xil_defaultlib -64 -incr -sv -L xil_defaultlib "+incdir+D:/Xilinx/Vivado/2018.1/data/xilinx_vip/include" "+incdir+D:/Xilinx/Vivado/2018.1/data/xilinx_vip/include" \
"D:/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"D:/Xilinx/Vivado/2018.1/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib -64 -incr "+incdir+D:/Xilinx/Vivado/2018.1/data/xilinx_vip/include" "+incdir+D:/Xilinx/Vivado/2018.1/data/xilinx_vip/include" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/clocking/mig_7series_v4_1_clk_ibuf.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/clocking/mig_7series_v4_1_infrastructure.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/clocking/mig_7series_v4_1_iodelay_ctrl.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/clocking/mig_7series_v4_1_tempmon.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/controller/mig_7series_v4_1_arb_mux.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/controller/mig_7series_v4_1_arb_row_col.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/controller/mig_7series_v4_1_arb_select.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/controller/mig_7series_v4_1_bank_cntrl.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/controller/mig_7series_v4_1_bank_common.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/controller/mig_7series_v4_1_bank_compare.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/controller/mig_7series_v4_1_bank_mach.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/controller/mig_7series_v4_1_bank_queue.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/controller/mig_7series_v4_1_bank_state.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/controller/mig_7series_v4_1_col_mach.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/controller/mig_7series_v4_1_mc.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/controller/mig_7series_v4_1_rank_cntrl.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/controller/mig_7series_v4_1_rank_common.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/controller/mig_7series_v4_1_rank_mach.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/controller/mig_7series_v4_1_round_robin_arb.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/ecc/mig_7series_v4_1_ecc_buf.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/ecc/mig_7series_v4_1_ecc_dec_fix.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/ecc/mig_7series_v4_1_ecc_gen.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/ecc/mig_7series_v4_1_ecc_merge_enc.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/ecc/mig_7series_v4_1_fi_xor.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/ip_top/mig_7series_v4_1_memc_ui_top_std.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/ip_top/mig_7series_v4_1_mem_intfc.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_byte_group_io.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_byte_lane.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_calib_top.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_if_post_fifo.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_mc_phy.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_mc_phy_wrapper.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_of_pre_fifo.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_4lanes.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ck_addr_cmd_delay.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_dqs_found_cal.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_dqs_found_cal_hr.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_init.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_cntlr.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_data.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_edge.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_lim.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_mux.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_po_cntlr.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_samp.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_oclkdelay_cal.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_prbs_rdlvl.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_rdlvl.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_tempmon.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_top.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_wrcal.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_wrlvl.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_wrlvl_off_delay.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_prbs_gen.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_ddr_skip_calib_tap.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_poc_cc.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_poc_edge_store.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_poc_meta.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_poc_pd.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_poc_tap_base.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/phy/mig_7series_v4_1_poc_top.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/ui/mig_7series_v4_1_ui_cmd.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/ui/mig_7series_v4_1_ui_rd_data.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/ui/mig_7series_v4_1_ui_top.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/ui/mig_7series_v4_1_ui_wr_data.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/A7_ddr3_mig_mig_sim.v" \
"../../../../project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/rtl/A7_ddr3_mig.v" \

vlog -work xil_defaultlib \
"glbl.v"

