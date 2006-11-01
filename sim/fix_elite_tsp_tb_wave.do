onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /fix_elite_tsp/clk
add wave -noupdate -format Logic /fix_elite_tsp/rst_n
add wave -noupdate -format Logic /fix_elite_tsp/decode
add wave -noupdate -format Logic /fix_elite_tsp/valid
add wave -noupdate -format Logic /fix_elite_tsp/ready_in
add wave -noupdate -format Logic /fix_elite_tsp/elite_null
add wave -noupdate -format Literal /fix_elite_tsp/index
add wave -noupdate -format Literal -radix unsigned /fix_elite_tsp/fit
add wave -noupdate -format Literal /fix_elite_tsp/count_parents
add wave -noupdate -format Literal /fix_elite_tsp/elite_offs
add wave -noupdate -format Literal -radix unsigned /fix_elite_tsp/fit_sum
add wave -noupdate -format Literal /fix_elite_tsp/max_fit
add wave -noupdate -format Logic /fix_elite_tsp/rd
add wave -noupdate -format Literal -radix unsigned /fix_elite_tsp/sum
add wave -noupdate -format Literal -radix unsigned /fix_elite_tsp/sum_p
add wave -noupdate -format Literal -radix unsigned /fix_elite_tsp/best_fit
add wave -noupdate -format Literal -radix unsigned /fix_elite_tsp/best_fit_prev_gen
add wave -noupdate -format Literal /fix_elite_tsp/temp1
add wave -noupdate -format Literal /fix_elite_tsp/temp2
add wave -noupdate -format Literal /fix_elite_tsp/elite_indexs
add wave -noupdate -format Literal /fix_elite_tsp/temp_indexs_1
add wave -noupdate -format Literal /fix_elite_tsp/temp_indexs_2
add wave -noupdate -format Logic /fix_elite_tsp/cont
add wave -noupdate -format Logic /fix_elite_tsp/cont2
add wave -noupdate -format Logic /fix_elite_tsp/fin
add wave -noupdate -format Logic /fix_elite_tsp/done_p
add wave -noupdate -format Logic /fix_elite_tsp/done
add wave -noupdate -format Logic /fix_elite_tsp/equal
add wave -noupdate -format Literal /fix_elite_tsp/nparents
add wave -noupdate -format Literal /fix_elite_tsp/counter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {230 ns} 0}
configure wave -namecolwidth 217
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
WaveRestoreZoom {170 ns} {291 ns}
