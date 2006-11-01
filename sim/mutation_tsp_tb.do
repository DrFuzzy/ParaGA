restart -f

set no_lines $1
set res $2

vsim work.mutation_tsp
add log -r /*
do ../sim/mutation_tsp_wave.do
#add wave sim:/ga/*


force rst_n 0 0  $res
force rst_n 1 5  $res

force clk 1 0 -repeat 10  $res
force clk 0 5  $res -repeat 10  $res


force mutPoint 000000 0  $res, 111111 5 $res   
force cont 0 0  $res, 1 5 $res	  
force flag 0 0  $res, 1 55 $res	  
force rng 00000000 0  $res, 00000111 5 $res	  
force inGene 000000000000000000000 0  $res, 010001111101110011100 5 $res     


run [expr ($no_lines-1)*10] $res