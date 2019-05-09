create_project -in_memory -part xc7z020clg400-1
add_files ./Dokumente/git/VHDL_Testing_Platform/src/hdl/PART1.vhd
add_files ./Dokumente/git/VHDL_Testing_Platform/src/constraints/final.xdc
set_property top PART1.vhd [current_fileset]
set_property source_mgmt_mode None [current_project]
update_compile_order -force_gui
synth_design
write_checkpoint ./Dokumente/git/VHDL_Testing_Platform/proj/part.dcp
report_utilization -file ./Dokumente/git/VHDL_Testing_Platform/proj/part.dcp
close_project
exit
