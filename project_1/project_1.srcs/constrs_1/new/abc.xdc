########################################################
set_property PACKAGE_PIN W19 [get_ports sclk]
set_property IOSTANDARD LVCMOS33 [get_ports sclk]

set_property PACKAGE_PIN Y18 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]


########################################################
set_property IOSTANDARD LVCMOS33 [get_ports rx_clk]
set_property PACKAGE_PIN J19 [get_ports rx_clk]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets rx_clk_IBUF]

set_property PACKAGE_PIN N22 [get_ports phy_rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports phy_rst_n]

set_property PACKAGE_PIN J22 [get_ports rx_ctrl]
set_property IOSTANDARD LVCMOS33 [get_ports rx_ctrl]

set_property PACKAGE_PIN K22 [get_ports {rx_dat[0]}]
set_property PACKAGE_PIN K21 [get_ports {rx_dat[1]}]
set_property PACKAGE_PIN J20 [get_ports {rx_dat[2]}]
set_property PACKAGE_PIN H22 [get_ports {rx_dat[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rx_dat[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rx_dat[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rx_dat[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {rx_dat[0]}]

set_property PACKAGE_PIN L18 [get_ports tx_ctrl]
set_property IOSTANDARD LVCMOS33 [get_ports tx_ctrl]

set_property IOSTANDARD LVCMOS33 [get_ports tx_clk]
set_property PACKAGE_PIN K18 [get_ports tx_clk]

set_property PACKAGE_PIN M22 [get_ports {tx_dat[0]}]
set_property PACKAGE_PIN M18 [get_ports {tx_dat[1]}]
set_property PACKAGE_PIN L19 [get_ports {tx_dat[2]}]
set_property PACKAGE_PIN L20 [get_ports {tx_dat[3]}]

set_property IOSTANDARD LVCMOS33 [get_ports {tx_dat[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tx_dat[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tx_dat[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tx_dat[3]}]


########################################################
set_property PACKAGE_PIN C18 [get_ports tmds_clk_p]
set_property PACKAGE_PIN B21 [get_ports tmds_r_p]
set_property PACKAGE_PIN C22 [get_ports tmds_g_p]
set_property PACKAGE_PIN D20 [get_ports tmds_b_p]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports sclk]
set_property IOSTANDARD TMDS_33 [get_ports tmds_b_p]
set_property IOSTANDARD TMDS_33 [get_ports tmds_clk_p]
set_property IOSTANDARD TMDS_33 [get_ports tmds_g_p]
set_property IOSTANDARD TMDS_33 [get_ports tmds_r_p]

set_property PACKAGE_PIN B13 [get_ports hdmi_en]
set_property IOSTANDARD LVCMOS33 [get_ports hdmi_en]

