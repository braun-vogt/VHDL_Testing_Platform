create_pblock pblock_par
add_cells_to_pblock [get_pblocks pblock_par] [get_cells -quiet [list pardes/par]]
resize_pblock [get_pblocks pblock_par] -add {SLICE_X36Y101:SLICE_X49Y148}
resize_pblock [get_pblocks pblock_par] -add {DSP48_X2Y42:DSP48_X2Y57}
set_property SNAPPING_MODE ON [get_pblocks pblock_par]


set_property IOSTANDARD LVCMOS33 [get_ports {BUTTONS_tri_i[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {BUTTONS_tri_i[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {BUTTONS_tri_i[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {BUTTONS_tri_i[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports hdmi_ddc_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports hdmi_ddc_sda_io]







set_property PACKAGE_PIN K17 [get_ports clk_i]
set_property IOSTANDARD LVCMOS33 [get_ports clk_i]
set_property PACKAGE_PIN Y11 [get_ports {RGB_LED[2]}]
set_property PACKAGE_PIN T5 [get_ports {RGB_LED[1]}]
set_property PACKAGE_PIN Y12 [get_ports {RGB_LED[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RGB_LED[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RGB_LED[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RGB_LED[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {HDMI_OEN[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_tri_o[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_tri_o[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_tri_o[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {LED_tri_o[0]}]
set_property PACKAGE_PIN M14 [get_ports {LED_tri_o[0]}]
set_property PACKAGE_PIN M15 [get_ports {LED_tri_o[1]}]
set_property PACKAGE_PIN G14 [get_ports {LED_tri_o[2]}]
set_property PACKAGE_PIN D18 [get_ports {LED_tri_o[3]}]
set_property PACKAGE_PIN B19 [get_ports {TMDS_data_p[2]}]
set_property PACKAGE_PIN C20 [get_ports {TMDS_data_p[1]}]
set_property PACKAGE_PIN D19 [get_ports {TMDS_data_p[0]}]
set_property PACKAGE_PIN H16 [get_ports TMDS_clk_p]
set_property PACKAGE_PIN E18 [get_ports hdmi_in_hpd_led_tri_io]
set_property IOSTANDARD LVCMOS33 [get_ports hdmi_in_hpd_led_tri_io]
set_property PACKAGE_PIN Y16 [get_ports {BUTTONS_tri_i[3]}]
set_property PACKAGE_PIN K19 [get_ports {BUTTONS_tri_i[2]}]
set_property PACKAGE_PIN P16 [get_ports {BUTTONS_tri_i[1]}]
set_property PACKAGE_PIN K18 [get_ports {BUTTONS_tri_i[0]}]
set_property PACKAGE_PIN G17 [get_ports hdmi_ddc_scl_io]
set_property PACKAGE_PIN G18 [get_ports hdmi_ddc_sda_io]
set_property PACKAGE_PIN F17 [get_ports {HDMI_OEN[0]}]
