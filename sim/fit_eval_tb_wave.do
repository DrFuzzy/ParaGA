onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /fit_eval_elite2/clk
add wave -noupdate -format Logic /fit_eval_elite2/rst_n
add wave -noupdate -format Logic /fit_eval_elite2/decode
add wave -noupdate -format Logic /fit_eval_elite2/valid
add wave -noupdate -format Literal /fit_eval_elite2/ingenes
add wave -noupdate -format Literal /fit_eval_elite2/index
add wave -noupdate -format Literal /fit_eval_elite2/gene_score
add wave -noupdate -format Literal /fit_eval_elite2/elite_offs
add wave -noupdate -format Literal -radix unsigned /fit_eval_elite2/fitsum
add wave -noupdate -format Literal -radix unsigned /fit_eval_elite2/max_fit
add wave -noupdate -format Logic /fit_eval_elite2/rd
add wave -noupdate -format Literal /fit_eval_elite2/gene_scr
add wave -noupdate -format Literal /fit_eval_elite2/gene
add wave -noupdate -format Literal /fit_eval_elite2/fit
add wave -noupdate -format Literal /fit_eval_elite2/sum
add wave -noupdate -format Literal /fit_eval_elite2/sum_p
add wave -noupdate -format Literal -radix unsigned /fit_eval_elite2/best_fit
add wave -noupdate -format Literal /fit_eval_elite2/elite_indexs
add wave -noupdate -format Literal /fit_eval_elite2/cnt
add wave -noupdate -format Logic /fit_eval_elite2/cont
add wave -noupdate -format Logic /fit_eval_elite2/cont2
add wave -noupdate -format Logic /fit_eval_elite2/done_p
add wave -noupdate -format Logic /fit_eval_elite2/done
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {11 ns} 0}
configure wave -namecolwidth 191
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
WaveRestoreZoom {0 ns} {31 ns}
