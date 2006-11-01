restart -f

set no_lines $1
set res $2

vsim work.rng
add log -r /*
do ../sim/rng_wave.do






force rst_n 0 0 ns
force rst_n 1 5 ns

force clk 1 0 -repeat 10 ns
force clk 0 5 ns -repeat 10 ns

force load 1 0 ns
force load 0 40 ns

force seed 10#0 0 ns
force seed 1101 0 ns

force run 0 0 ns
force run 1 40 ns

run [expr ($no_lines-1)*10] ns