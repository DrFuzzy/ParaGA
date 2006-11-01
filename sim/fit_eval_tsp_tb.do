restart -f

set no_lines $1
set res $2

vsim work.fit_eval_tsp
add log -r /*
do ../sim/fit_eval_tsp_wave.do

force rst_n 0 0  $res
force rst_n 1 5  $res

force clk 1 0 -repeat 10  $res
force clk 0 5  $res -repeat 10  $res


force decode 0 0 $res
force valid 0 0 $res
force index  10#0 0 $res      	
force count_parents 0 0  $res
force elite_null 0 0 $res
force in_genes 000000000000000000000000000000000000000000  0 $res


force valid 1 7 $res
force index  10#1 7 $res     
force count_parents 2 7 $res
force valid 0 200 $res
force in_genes 001010111100011101110001010111100011101110  7 $res


force valid 1 253 $res
force index  10#2 253 $res
force count_parents 4 253  $res
force valid 0 400 $res
force in_genes 010001111101110011100010001111101110011100  250 $res


force valid 1 420 $res
force index  10#3 420 $res
force count_parents 6 420  $res
force valid 0 570 $res
force in_genes 100011110001010111101100011110001010111101  420 $res


force valid 1 600 $res
force index  10#4 600 $res
force count_parents 8 600  $res
force valid 0 750 $res
force in_genes 010111100001101110011010111100001101110011  600 $res


force valid 1 770 $res
force index  10#5 770 $res
force count_parents 10 770  $res
force valid 0 920 $res
force in_genes 001111100110011101010001111100110011101010  770 $res

force elite_null 1 950 $res

#force valid 1 253 $res
#force index  10#6 253 $res
#force count_parents 12 253  $res
#force valid 0 290 $res

#force valid 1 303 $res
#force index  10#7 303 $res
#force count_parents 14 303  $res
#force valid 0 340 $res

run [expr ($no_lines-1)*10] $res