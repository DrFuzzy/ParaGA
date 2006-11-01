onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /crossover_tsp/clk
add wave -noupdate -format Logic /crossover_tsp/rst_n
add wave -noupdate -format Logic /crossover_tsp/cont
add wave -noupdate -format Literal /crossover_tsp/crosspoints
add wave -noupdate -format Literal /crossover_tsp/ingene1
add wave -noupdate -format Literal /crossover_tsp/ingene2
add wave -noupdate -format Literal /crossover_tsp/pool
add wave -noupdate -format Logic /crossover_tsp/rd
add wave -noupdate -format Literal /crossover_tsp/crossoffspr1
add wave -noupdate -format Literal /crossover_tsp/cross_point_int
add wave -noupdate -format Literal /crossover_tsp/ind
add wave -noupdate -format Literal /crossover_tsp/temp1
add wave -noupdate -format Literal /crossover_tsp/temp2
add wave -noupdate -format Literal /crossover_tsp/town
add wave -noupdate -format Literal /crossover_tsp/crossout1
add wave -noupdate -format Logic /crossover_tsp/done
add wave -noupdate -format Literal /crossover_tsp/cont1
add wave -noupdate -format Literal /crossover_tsp/index
add wave -noupdate -format Literal /crossover_tsp/pool_int
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10 ns} 0}
configure wave -namecolwidth 208
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
WaveRestoreZoom {932 ns} {994 ns}
