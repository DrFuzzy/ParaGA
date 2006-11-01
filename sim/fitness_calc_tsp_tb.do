#restart -f

set no_lines $1
set res $2

vsim work.fit_calc_tsp
add log -r /*
do ../sim/fit_calc_tsp_wave.do

force rst_n 0 0  $res
force rst_n 1 5  $res

force clk 1 0 -repeat 10  $res
force clk 0 5  $res -repeat 10  $res


force decode 0 0 $res
force valid 0 0 $res
force in_genes 000000000000000000000000000000000000000000  0 $res   
force data_in 0000000000000000 0 $res

force valid 1 10 $res     
force in_genes 001010111100011101110001010111100011101110 10 $res
force data_in  0000000100000001  10 $res
force data_in  0000000100000010	 20 $res
force data_in  0000001000000100	 30 $res
force data_in  0000001100000101	 40 $res
force data_in  0000001000000000	 50 $res
force data_in  0000001100000011	 60 $res
force data_in  0000010000000001	 70 $res
force data_in  0000010100000011	 80 $res
force data_in  0000000100000001	 90 $res
force data_in  0000000000000000	 100 $res
	       
force valid 0 210 $res 


run [expr ($no_lines-1)*10] $res