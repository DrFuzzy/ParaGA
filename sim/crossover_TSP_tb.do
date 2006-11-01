#restart -f

set no_lines $1
set res $2

vsim work.crossover_tsp
add log -r /*
do ../sim/cross_tsp.do
#add wave sim:/ga/*


force rst_n 0 0  $res
force rst_n 1 5  $res

force clk 1 0 -repeat 10  $res
force clk 0 5  $res -repeat 10  $res

force cont 1 0 $res, 0 120 $res
force crosspoints 000000 0 $res, 110011 5 $res
force inGene1 000000000000000000000 0 $res, 001010111100011101110 5 $res
force inGene2 000000000000000000000 0 $res, 010001111101110011100 5 $res
force pool(1) 0 0 $res, 1 5 $res
force pool(2) 0 0 $res, 2 5 $res
force pool(3) 0 0 $res, 3 5 $res
force pool(4) 0 0 $res, 4 5 $res
force pool(5) 0 0 $res, 5 5 $res
force pool(6) 0 0 $res, 6 5 $res
force pool(7) 0 0 $res, 7 5 $res



run [expr ($no_lines-1)*10] $res