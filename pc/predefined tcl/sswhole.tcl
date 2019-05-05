create_project -in_memory -part xc7z020clg400-1
add_files /home/pfirsichgnom/Dokumente/git/VHDL_Testing_Platform/proj/oproduct/static.dcp
add_files ./Dokumente/git/VHDL_Testing_Platform/src/constraints/final.xdc
set_property USED_IN {implementation} [get_files ./Dokumente/git/VHDL_Testing_Platform/src/constraints/final.xdc]
add_files /home/pfirsichgnom/Dokumente/git/VHDL_Testing_Platform/proj/oproduct/Par2_RGB2.dcp
set_property SCOPED_TO_CELLS {par0pm} [get_fil/home/pfirsichgnom/Dokumente/git/VHDL_Testing_Platform/proj/oproduct/Par2_RGB2.dcp]
link_design -mode default -reconfig_partitions {par0pm}-part xc7z020clg400-1 -top top
set_property HD.RECONFIGURABLE 1 [get_cells par0pm]
write_checkpoint –force /home/pfirsichgnom/Dokumente/git/VHDL_Testing_Platform/proj/oproduct/Par2_RGB2.dcp
opt_design
place_design
route_design
write_bitstream par0pm
close_project
exit