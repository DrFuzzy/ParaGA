restart -f

set no_lines $1
set res $2

vsim work.selection_v2
add log -r /*
do ../sim/selection_v2_wave.do
#add wave sim:/selection_v2/*


force rst_n 0 0  $res
force rst_n 1 5  $res, 0 80 $res

force clk 1 0 -repeat 10  $res
force clk 0 5  $res -repeat 10  $res


force inGene   10#0 0 $res, 16#1F 10 $res, 16#2F 20 $res, 16#3F 30 $res, 16#4F 40 $res, 16#5F 50 $res, 16#6F 60 $res  
force rng      10#0 0 $res, 10111 10 $res , 10001 20 $res
force fitSum   10#120 0 $res
force data_valid 0 0 $res, 1 10 $res, 0 70 $res


run [expr ($no_lines-1)*10] $res