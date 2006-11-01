restart -f

set no_lines $1
set res $2

vsim work.ga_tsp
add log -r /*
#do ../sim/debug_wave_tsp.do
#add wave sim:/ga/*


force rst_n 0 0  $res
force rst_n 1 5  $res

force clk 1 0 -repeat 10  $res
force clk 0 5  $res -repeat 10  $res

force run_ga_i 1 0 $res, 0 100 $res

force pool()

run [expr ($no_lines-1)*10] $res