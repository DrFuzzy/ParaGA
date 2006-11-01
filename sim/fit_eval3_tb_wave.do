onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /fit_eval_elite3/clk
add wave -noupdate -format Logic /fit_eval_elite3/rst_n
add wave -noupdate -format Logic /fit_eval_elite3/decode
add wave -noupdate -format Logic /fit_eval_elite3/valid
add wave -noupdate -format Logic /fit_eval_elite3/elite_null
add wave -noupdate -format Literal /fit_eval_elite3/in_genes
add wave -noupdate -format Literal /fit_eval_elite3/index
add wave -noupdate -format Literal /fit_eval_elite3/count_parents
add wave -noupdate -format Literal /fit_eval_elite3/gene_score
add wave -noupdate -format Literal /fit_eval_elite3/elite_offs
add wave -noupdate -format Literal -radix unsigned /fit_eval_elite3/fit_sum
add wave -noupdate -format Literal -radix unsigned /fit_eval_elite3/max_fit
add wave -noupdate -format Logic /fit_eval_elite3/rd
add wave -noupdate -format Literal /fit_eval_elite3/gene_scr
add wave -noupdate -format Literal /fit_eval_elite3/gene
add wave -noupdate -format Literal -radix unsigned /fit_eval_elite3/fit
add wave -noupdate -format Literal -radix unsigned /fit_eval_elite3/sum
add wave -noupdate -format Literal -radix unsigned /fit_eval_elite3/sum_p
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal -radix unsigned /fit_eval_elite3/best_fit
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal -radix unsigned /fit_eval_elite3/temp1
add wave -noupdate -format Literal -radix unsigned /fit_eval_elite3/temp2
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal /fit_eval_elite3/elite_indexs
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal -radix unsigned /fit_eval_elite3/best_fit_prev_gen
add wave -noupdate -format Literal /fit_eval_elite3/temp_indexs_1
add wave -noupdate -format Literal /fit_eval_elite3/temp_indexs_2
add wave -noupdate -format Logic /fit_eval_elite3/cont
add wave -noupdate -format Logic /fit_eval_elite3/cont2
add wave -noupdate -format Logic /fit_eval_elite3/done_p
add wave -noupdate -format Logic /fit_eval_elite3/done
add wave -noupdate -format Literal /fit_eval_elite3/nparents
add wave -noupdate -format Literal /fit_eval_elite3/counter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {248 ns} 0}
configure wave -namecolwidth 213
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
WaveRestoreZoom {180 ns} {280 ns}
