generate_target {synthesis implementation} [get_files bd_name.bd]
launch_runs synth_1 -jobs 4
wait_on_run -verbose synth_1
#opt_design
#place_design
#phys_opt_design
#route_design
launch_runs impl_1 -to_step route_design -jobs 4
wait_on_run -verbose impl_1
open_run impl_1

update_design -cells par0pm -black_box 
update_design -cells par1pm -black_box 
update_design -cells par2pm -black_box 
update_design -cells par3pm -black_box 
update_design -cells par4pm -black_box 
update_design -cells par5pm -black_box 
update_design -cells par6pm -black_box 
update_design -cells par7pm -black_box 

update_design -cells par0pm -buffer_ports
update_design -cells par1pm -buffer_ports
update_design -cells par2pm -buffer_ports
update_design -cells par3pm -buffer_ports
update_design -cells par4pm -buffer_ports
update_design -cells par5pm -buffer_ports
update_design -cells par6pm -buffer_ports
update_design -cells par7pm -buffer_ports

opt_design
place_design
phys_opt_design
route_design
write_checkpoint ./oproduct/static.dcp
close_project
exit

