#############################
#  SETUP PARAMETERS   
#############################
set sim_type $1  
set sim_time $2  
set time_unit $3  

#############################
#  SIM TYPE (rtl , gat)  
#############################
if [string match $sim_type gat] {
  set rtl false; 
  set gat true
} else {
  set rtl true; 
  set gat false
}

#############################
#  VSIM INVOCATION
#############################
if [ string match $sim_type rtl ] { 
  #vsim -t ps -vopt -voptargs=+acc work.cfg_ga_tb_rtl -wlf ga_tb_rtl.wlf
  vsim -t ps work.cfg_ga_tb_rtl -wlf D:\Designs\GA_eval\vhd\ga_tb_rtl.wlf
  add log -r /*
  do ../sim/ga_tb_wave_rtl.do

} else {
  vsim -sdftyp /u_bench=../../par/fc_4ip1op_v1_0/fc_4ip1op_v1_0_timesim.sdf -t ps work.cfg_fpga_fc_tb_gat -wlf fpga_fc_tb_gat.wlf
  add log -r /*
  #do ../sim/ga_tb_wave_gat.do
}

#############################
#  RUN SIMULATION    
#############################
run $sim_time $time_unit