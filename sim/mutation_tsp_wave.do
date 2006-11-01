onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /mutation_tsp/clk
add wave -noupdate -format Logic /mutation_tsp/rst_n
add wave -noupdate -format Literal /mutation_tsp/mutpoint
add wave -noupdate -format Logic /mutation_tsp/cont
add wave -noupdate -format Logic /mutation_tsp/flag
add wave -noupdate -format Literal /mutation_tsp/rng
add wave -noupdate -format Literal /mutation_tsp/ingene
add wave -noupdate -format Logic /mutation_tsp/rd
add wave -noupdate -format Literal /mutation_tsp/mutoffspr
add wave -noupdate -format Literal /mutation_tsp/mutout
add wave -noupdate -format Literal /mutation_tsp/mutout_p1
add wave -noupdate -format Literal /mutation_tsp/ingene_mut
add wave -noupdate -format Literal /mutation_tsp/temp1
add wave -noupdate -format Literal /mutation_tsp/temp2
add wave -noupdate -format Literal -radix unsigned /mutation_tsp/rng1
add wave -noupdate -format Logic /mutation_tsp/done
add wave -noupdate -format Logic /mutation_tsp/done_p
add wave -noupdate -format Literal /mutation_tsp/reduce_1
add wave -noupdate -format Literal /mutation_tsp/reduce_2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5 ns} 0}
configure wave -namecolwidth 190
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
WaveRestoreZoom {0 ns} {46 ns}
