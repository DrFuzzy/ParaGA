onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /mutation_v2_tb/u_bench/clk
add wave -noupdate -format Literal /mutation_v2_tb/u_bench/mutpoint
add wave -noupdate -format Literal /mutation_v2_tb/u_bench/mutrate
add wave -noupdate -format Literal /mutation_v2_tb/u_bench/mutmethod
add wave -noupdate -format Literal /mutation_v2_tb/u_bench/rng1
add wave -noupdate -format Literal /mutation_v2_tb/u_bench/rng
add wave -noupdate -format Literal /mutation_v2_tb/u_bench/ingene
add wave -noupdate -format Logic /mutation_v2_tb/u_bench/mutdone
add wave -noupdate -format Literal /mutation_v2_tb/u_bench/mutoffspr
add wave -noupdate -format Literal /mutation_v2_tb/u_bench/weirdtrue
add wave -noupdate -format Literal /mutation_v2_tb/u_bench/mask
add wave -noupdate -format Literal /mutation_v2_tb/u_bench/maskunif
add wave -noupdate -format Literal /mutation_v2_tb/u_bench/mutout
add wave -noupdate -format Literal /mutation_v2_tb/u_bench/mutout_p1
add wave -noupdate -format Literal /mutation_v2_tb/u_bench/ingene_mut
add wave -noupdate -format Literal /mutation_v2_tb/u_bench/count
add wave -noupdate -format Logic /mutation_v2_tb/u_bench/done
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4829904 ps} 0}
configure wave -namecolwidth 231
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
update
WaveRestoreZoom {5001319 ps} {5075159 ps}
