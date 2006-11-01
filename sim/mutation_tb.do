set no_lines $1
set res $2

vsim work.mutation_v2
#do ../sim/mutation_v2_wave.do
#add wave sim:/control/*
add log -r /*

force rst_n 0 0  $res
force rst_n 1 5  $res

force clk 1 0 -repeat 10  $res
force clk 0 5  $res -repeat 10  $res

force mutMethod 00 0 $res
force mutPoint 000 0 $res
force cont 0 0 $res
force flag 0 0 $res
force rng  0000000000000000 0 $res
force inGene 01010101 0 $res
force inGene 01010000 20 $res

force mutPoint 001 10 $res
force cont 1 10 $res
force cont 0 20 $res
force flag 1 40 $res
force rng  0000000000000011 10 $res
force rng  0000000000001111 10 $res

run [expr ($no_lines-1)*10] $res
