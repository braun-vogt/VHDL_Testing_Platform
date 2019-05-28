create_project -in_memory -part xc7z020clg400-1
add_files ./Dokumente/git/VHDL_Testing_Platform/proj/static.dcp
add_files ./Dokumente/git/VHDL_Testing_Platform/src/constraints/final.xdc
set_property USED_IN {implementation} [get_files ./Dokumente/git/VHDL_Testing_Platform/src/constraints/final.xdc]
add_files ./Dokumente/git/VHDL_Testing_Platform/proj/part.dcp
set_property SCOPED_TO_CELLS {par} [get_files ./Dokumente/git/VHDL_Testing_Platform/proj/part.dcp]
link_design -mode default -reconfig_partitions {part1} -part xc7z020clg400-1 -top top
update_design -cells par6pm -black_box
update_design -cells par6pm -from_file ./Dokumente/git/VHDL_Testing_Platform/proj/part.edif
opt_design
place_design
route_design
write_bitstream -cell par 
set_property HD.RECONFIGURABLE 1 [get_cells par]
write_checkpoint –force ./Dokumente/git/VHDL_Testing_Platform/proj/part_routed.dcp
close_project
exit
#lock_design -level routing -cell MUX0
#lock_design -level routing -cell bd_name_wrapper_port_map
