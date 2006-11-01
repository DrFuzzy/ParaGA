set no_lines $1
set res $2

vsim work.control
#do ../sim/control_v3_wave.do
#add wave sim:/control/*
add log -r /*

force rst_n 0 0  $res
force rst_n 1 5  $res

force clk 1 0 -repeat 10  $res
force clk 0 5  $res -repeat 10  $res


force done 0 0 $res
force fill_ram 0 0 $res      	
force clear_rd 0 0 $res
force fit_eval_rd 0 0 $res
force sel_rd 0 0 $res
force cross_rd 0 0 $res
force mut_rd 0 0 $res
force term_rd 0 0 $res
force gen_rd 0 0 $res
force offs_rd 0 0 $res
force fit_eval_done 0 0 $res
force sel_done 0 0 $res

force clear_rd 1 8 $res
force fill_ram 1 15 $res      	
force fit_eval_rd 1 27 $res
force fit_eval_done 1 57 $res
force clear_rd 0 57 $res

force fill_ram 0 77 $res
force fit_eval_done 0 77 $res
force fit_eval_rd 0 77 $res

force sel_rd 1 87 $res
force sel_done 1 107 $res

force sel_rd 0 117 $res
force sel_done 0 117 $res

force cross_rd 1 127 $res
force mut_rd 1 137 $res

force term_rd 1 145 $res

force fit_eval_rd 1 804 $res
force fit_eval_done 1 904 $res

force sel_rd 1 934 $res
force sel_done 1 967 $res

force mut_rd 0 1564 $res

run [expr ($no_lines-1)*10] $res