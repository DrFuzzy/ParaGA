restart -f

set no_lines $1
set res $2

vsim work.fit_eval_elite3
add log -r /*
do ../sim/fit_eval3_tb_wave.do

force rst_n 0 0  $res
force rst_n 1 5  $res

force clk 1 0 -repeat 10  $res
force clk 0 5  $res -repeat 10  $res


force decode 0 0 $res
force valid 0 0 $res
force index  10#0 0 $res      	
force count_parents 0 0  $res
force in_genes 00000000  0 $res    
force elite_null 0 0 $res
force fit 000000 0 0 $res
force ready_in 0 0 $res

force valid 1 3 $res
force index  10#1 3 $res     
force count_parents 2 3 $res
force in_genes 00000001 3 $res
force valid 0 40 $res

force valid 1 53 $res
force index  10#2 53 $res
force count_parents 4 53  $res
force in_genes 00000010 53 $res
force valid 0 90 $res


force valid 1 103 $res
force index  10#3 103 $res
force count_parents 6 103  $res
force in_genes 00000011 103 $res
force valid 0 140 $res

force valid 1 153 $res
force index  10#4 153 $res
force count_parents 8 153  $res
force in_genes 00000101 153 $res
force valid 0 190 $res

force valid 1 203 $res
force index  10#5 203 $res
force count_parents 10 203  $res
force in_genes 01000101 203 $res
force valid 0 240 $res

#force valid 1 253 $res
#force index  10#6 253 $res
#force count_parents 12 253  $res
#force in_genes 00010101 253 $res
#force valid 0 290 $res

#force valid 1 303 $res
#force index  10#7 303 $res
#force count_parents 14 303  $res
#force in_genes 00000101 303 $res
#force valid 0 340 $res

run [expr ($no_lines-1)*10] $res