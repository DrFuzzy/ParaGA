restart -f

set no_lines $1
set res $2

vsim work.ga
add log -r /*
do ../sim/debug_wave_out2.do
#add wave sim:/ga/*


force rst_n 0 0  $res
force rst_n 1 5  $res

force clk 1 0 -repeat 10  $res
force clk 0 5  $res -repeat 10  $res

force run_ga_i 1 0 $res, 0 100 $res


force seed_i	  00000000 0  $res,  01010000  5 $res

# FOR MUTMETHOD = 10

#force seed_3_i	  0000 0  $res, 1010 5 $res, 1001 2650 $res, 1110 4900 $res, 1110 7200 $res 
#force seed_3_i	  1011 9300 $res, 0110 11400 $res, 0011 13400 $res, 0100 15500 $res, 0111 17800 $res,  0001 20100 $res

#force seed_2_i	  000000 0  $res, 011000 5 $res, 001011 2650 $res, 010000 4900 $res, 111101 7200 $res 
#force seed_2_i	  101100 9300 $res, 010100 11400 $res, 001100 13400 $res, 110110 15500 $res, 101111 17800 $res, 110010 20100 $res 
  
#force seed_1_i	  0000000000000000 0  $res, 1011001100110101 5 $res, 0101111101100010 2650 $res, 1001001111011110 4900 $res, 1010110011001110 7200 $res 
#force seed_1_i	  0110111111011000 9300 $res, 1010110100010001 11400 $res, 0001001110010100 13400 $res, 0000111000110110 15500 $res, 0000101101000110 17800 $res, 1011000111011110 20100 $res 

# FOR CROSSMETHOD /= 10

force seed_3_i	  0000 0  $res, 1010 5 $res, 1001 2250 $res, 1110 3940 $res, 1110 5480 $res 
force seed_3_i	  1011 7400 $res, 0110 9300 $res, 0011 11200 $res, 0100 13100 $res, 0111 15000 $res,  0001 16900 $res

force seed_2_i	  000000 0  $res, 011000 5 $res, 001011 2250 $res, 010000 3940 $res, 111101 5480 $res 
force seed_2_i	  101100 7400 $res, 010100 9300 $res, 001100 11200 $res, 110110 13100 $res, 101111 15000 $res, 110010 16900 $res 
  
force seed_1_i	  0000000000000000 0  $res, 1011001100110101 5 $res, 0101111101100010 2250 $res, 1001001111011110 3940 $res, 1010110011001110 5480 $res 
force seed_1_i	  0110111111011000 7400 $res, 1010110100010001 9300 $res, 0001001110010100 11200 $res, 0000111000110110 13100 $res, 0000101101000110 15000 $res, 1011000111011110 16900 $res 


# FOR CROSSMETHOD = 10 AND MUTMETHOD /= 10

#force seed_3_i	  0000 0  $res, 1010 5 $res, 1001 2250 $res, 1110 3740 $res, 1110 5430 $res 
#force seed_3_i	  1011 7250 $res, 0110 9050 $res, 0011 10900 $res, 0100 12850 $res, 0111 14700 $res,  0001 16600 $res

#force seed_2_i	  000000 0  $res, 011000 5 $res, 001011 2250 $res, 010000 3740 $res, 111101 5430 $res 
#force seed_2_i	  101100 7250 $res, 010100 9050 $res, 001100 10900 $res, 110110 12850 $res, 101111 14700 $res, 110010 16600 $res 
  
#force seed_1_i	  0000000000000000 0  $res, 1011001100110101 5 $res, 0101111101100010 2250 $res, 1001001111011110 3740 $res, 1010110011001110 5430 $res 
#force seed_1_i	  0110111111011000 7250 $res, 1010110100010001 9050 $res, 0001001110010100 10900 $res, 0000111000110110 12850 $res, 0000101101000110 14700 $res, 1011000111011110 16600 $res 



# One point crossover
force crossMethod_i 00 0  $res,  10 5 $res 
# One point mutation
force mutMethod_i   00 0  $res,  10 5 $res



run [expr ($no_lines-1)*10] $res