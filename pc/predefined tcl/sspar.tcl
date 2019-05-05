create_project -in_memory -part xc7z020clg400-1
add_files /home/pfirsichgnom/Dokumente/git/VHDL_Testing_Platform/src/hdl/files/Par2_RGB2.vhd
add_files ./Dokumente/git/VHDL_Testing_Platform/src/constraints/final.xdc
set_property top /home/pfirsichgnom/Dokumente/git/VHDL_Testing_Platform/src/hdl/files/Par2_RGB2.vhd
set_property source_mgmt_mode None [current_project]
update_compile_order -force_gui
synth_design
write_checkpoint /home/pfirsichgnom/Dokumente/git/VHDL_Testing_Platform/proj/oproduct/Par2_RGB2.dcp
report_utilization -file /home/pfirsichgnom/Dokumente/git/VHDL_Testing_Platform/proj/oproduct/report.txt
close_project
exit
