set no_lines $1
set res $2

vsim work.control_v4
#do ../sim/control_wave.do
#add wave sim:/control_v4/*
add log -r /*

force rst_n 0 0  $res
force rst_n 1 5  $res

force clk 1 0 -repeat 10  $res
force clk 0 5  $res -repeat 10  $res


force done     	     0 0 $res

force term_rd	               1 503 $res, 1 873 $res 
force term_rd	     0 0 $res, 0 513 $res, 0 883 $res 

force data_in_ram2   11111111 0 $res, 10111110 335 $res, 01100000 345 $res, 00100000 435 $res, 10100000 445 $res
force data_in_ram2   00001111 715 $res, 00011110 725 $res

force fit_eval_rd              1 23 $res, 1 53 $res, 1 83 $res, 1 113 $res, 1 383 $res, 1 483 $res, 1 763 $res, 1 843 $res
force fit_eval_rd    0 0 $res, 0 33 $res, 0 63 $res, 0 93 $res, 0 123 $res, 0 393 $res, 0 493 $res, 0 773 $res, 0 853 $res

force sel_rd           1 163 $res, 1 213 $res, 1 263 $res, 1 313 $res, 1 543 $res, 1 593 $res, 1 643 $res, 1 693 $res 
force sel_rd 0 0 $res, 0 173 $res, 0 223 $res, 0 273 $res, 0 323 $res, 0 553 $res, 0 603 $res, 0 653 $res, 0 703 $res    

force cross_rd           1 363 $res, 1 463 $res, 1 743 $res, 1 823 $res    
force cross_rd 0 0 $res, 0 373 $res, 0 473 $res, 0 753 $res, 0 833 $res  

force mut_rd           1 373 $res, 1 473 $res, 1 753 $res, 1 833 $res    
force mut_rd 0 0 $res, 0 383 $res, 0 483 $res, 0 763 $res, 0 843 $res   

force elite_offs(0)  0 0 $res
force elite_offs(1)  1 0 $res, 2 730 $res
#, 2 380 $res




run [expr ($no_lines-1)*10] $res