# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
set_param tcl.collectionResultDisplayLimit 0
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a35tfgg484-2

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir F:/DDR3_HDMI/project_1/project_1.cache/wt [current_project]
set_property parent.project_path F:/DDR3_HDMI/project_1/project_1.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo f:/DDR3_HDMI/project_1/project_1.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/GBET_TX/add_checksum.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/contrl_clk.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/GBET_TX/crc32_d8_send_02.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/ddr3/ddr3_ctrl.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/ddr3/ddr3_p1_write.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/ddr3/ddr3_p5_read.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/ddr3/ddr3_p6_read.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/hdmi/encode.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/ddr3/fifo_arbit.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/GBET_RX/iddr_ctrl.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/GBET_RX/image_ctrl.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/hdmi/par2ser.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/ddr3/rd_ctrl.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/ddr3/rd_fifo_path.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/ddr3/rd_path_ctrl.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/GBET_TX/rgmii_tx..v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/GBET_RX/run_clk_ctrl.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/GBET_RX/top_GBET.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/GBET_TX/top_GBET_tx.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/hdmi/top_hdmi_out.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/GBET_TX/tx_gen_frame.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/hdmi/vga.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/ddr3/wr_ctrl.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/ddr3/wr_fifo_path.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/ddr3/wr_path_ctrl.v
  F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/new/top_ddr3_GEBT_HDMI.v
}
read_ip -quiet F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/fifo_ddr3_rd_p6/fifo_ddr3_rd_p6.xci
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/fifo_ddr3_rd_p6/fifo_ddr3_rd_p6.xdc]
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/fifo_ddr3_rd_p6/fifo_ddr3_rd_p6_clocks.xdc]
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/fifo_ddr3_rd_p6/fifo_ddr3_rd_p6_ooc.xdc]

read_ip -quiet F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/mult_gen_0/mult_gen_0.xci
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/mult_gen_0/mult_gen_0_ooc.xdc]

read_ip -quiet F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/ram_64x8/ram_64x8.xci
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/ram_64x8/ram_64x8_ooc.xdc]

read_ip -quiet F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/fifo_in128_o32_2048/fifo_in128_o32_2048.xci
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/fifo_in128_o32_2048/fifo_in128_o32_2048.xdc]
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/fifo_in128_o32_2048/fifo_in128_o32_2048_clocks.xdc]
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/fifo_in128_o32_2048/fifo_in128_o32_2048_ooc.xdc]

read_ip -quiet F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/fifo_in32_o128/fifo_in32_o128.xci
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/fifo_in32_o128/fifo_in32_o128.xdc]
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/fifo_in32_o128/fifo_in32_o128_clocks.xdc]
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/fifo_in32_o128/fifo_in32_o128_ooc.xdc]

read_ip -quiet F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/clk_ddr3/clk_ddr3.xci
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/clk_ddr3/clk_ddr3_board.xdc]
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/clk_ddr3/clk_ddr3.xdc]
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/clk_ddr3/clk_ddr3_ooc.xdc]

read_ip -quiet F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/pll3_125m/pll3_125m.xci
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/pll3_125m/pll3_125m_board.xdc]
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/pll3_125m/pll3_125m.xdc]
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/pll3_125m/pll3_125m_ooc.xdc]

read_ip -quiet F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/pll2_50M/pll2_50M.xci
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/pll2_50M/pll2_50M_board.xdc]
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/pll2_50M/pll2_50M.xdc]
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/pll2_50M/pll2_50M_ooc.xdc]

read_ip -quiet F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/pll1_50M/pll1_50M.xci
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/pll1_50M/pll1_50M_board.xdc]
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/pll1_50M/pll1_50M.xdc]
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/pll1_50M/pll1_50M_ooc.xdc]

read_ip -quiet F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/rd_data/rd_data.xci
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/rd_data/rd_data.xdc]
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/rd_data/rd_data_clocks.xdc]

read_ip -quiet F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/cmd_fifo/cmd_fifo.xci
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/cmd_fifo/cmd_fifo.xdc]
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/cmd_fifo/cmd_fifo_clocks.xdc]
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/cmd_fifo/cmd_fifo_ooc.xdc]

read_ip -quiet F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/wr_data/wr_data.xci
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/wr_data/wr_data.xdc]
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/wr_data/wr_data_clocks.xdc]
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/wr_data/wr_data_ooc.xdc]

read_ip -quiet F:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig.xci
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/constraints/A7_ddr3_mig.xdc]
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/A7_ddr3_mig/A7_ddr3_mig/user_design/constraints/A7_ddr3_mig_ooc.xdc]

read_ip -quiet f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/ram_2048x8/ram_2048x8.xci
set_property used_in_implementation false [get_files -all f:/DDR3_HDMI/project_1/project_1.srcs/sources_1/ip/ram_2048x8/ram_2048x8_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc F:/DDR3_HDMI/project_1/project_1.srcs/constrs_1/new/abc.xdc
set_property used_in_implementation false [get_files F:/DDR3_HDMI/project_1/project_1.srcs/constrs_1/new/abc.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top top_ddr3_GEBT_HDMI -part xc7a35tfgg484-2


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef top_ddr3_GEBT_HDMI.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file top_ddr3_GEBT_HDMI_utilization_synth.rpt -pb top_ddr3_GEBT_HDMI_utilization_synth.pb"