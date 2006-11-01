set no_lines $1
set res $2

vsim work.control2 
do ../sim/CONTROL2_wave.do
#add wave sim:/control/*
add log -r /*

force rst_n 0 0  $res
force rst_n 1 5  $res

force clk 1 0 -repeat 10  $res
force clk 0 5  $res -repeat 10  $res

force rd_in 0 0  $res


force done 0 0 $res
force ram 0 0 $res
force fill_ram 0 0 $res
force fit_eval 0 0 $res
force wr 0 0 $res
force sort_in 0 0 $res
force sel 0 0 $res
force mut_in 0 0 $res
force cross_in 0 0 $res
force term_in 0 0 $res

force rd_in 1 25  $res

force ram 1 40 $res
force fill_ram 1 50 $res
force fit_eval 1 65 $res
force wr 1 90 $res
force sort_in 1 100 $res
force sel 1 140 $res
force mut_in 1 180 $res
force cross_in 1 220 $res
force term_in 1 255 $res
force done 1 255 $res

force fit_eval 1 290 $res

force rd_in 0 250  $res


run [expr ($no_lines-1)*10] $res