onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /fit_eval_tsp/clk
add wave -noupdate -format Logic /fit_eval_tsp/rst_n
add wave -noupdate -format Logic /fit_eval_tsp/decode
add wave -noupdate -format Logic /fit_eval_tsp/valid
add wave -noupdate -format Literal /fit_eval_tsp/in_genes
add wave -noupdate -format Logic /fit_eval_tsp/elite_null
add wave -noupdate -format Literal /fit_eval_tsp/index
add wave -noupdate -format Literal /fit_eval_tsp/count_parents
add wave -noupdate -format Literal /fit_eval_tsp/gene_score
add wave -noupdate -format Literal /fit_eval_tsp/elite_offs
add wave -noupdate -format Literal -radix unsigned /fit_eval_tsp/fit_sum
add wave -noupdate -format Literal -radix unsigned /fit_eval_tsp/max_fit
add wave -noupdate -format Logic /fit_eval_tsp/rd
add wave -noupdate -format Literal /fit_eval_tsp/fit_dummy
add wave -noupdate -format Literal /fit_eval_tsp/addr_dummy
add wave -noupdate -format Logic /fit_eval_tsp/ready_out_dummy
add wave -noupdate -format Literal /fit_eval_tsp/data_out_rom
add wave -noupdate -divider {FITNESS CALCULATION}
add wave -noupdate -format Logic /fit_eval_tsp/u0/clk
add wave -noupdate -format Logic /fit_eval_tsp/u0/rst_n
add wave -noupdate -format Logic /fit_eval_tsp/u0/decode
add wave -noupdate -format Logic /fit_eval_tsp/u0/valid
add wave -noupdate -format Literal /fit_eval_tsp/u0/in_genes
add wave -noupdate -format Literal /fit_eval_tsp/u0/data_in
add wave -noupdate -format Literal /fit_eval_tsp/u0/gene_score
add wave -noupdate -format Literal -radix unsigned /fit_eval_tsp/u0/fit
add wave -noupdate -format Literal /fit_eval_tsp/u0/addr_rom
add wave -noupdate -format Logic /fit_eval_tsp/u0/ready_out
add wave -noupdate -format Literal /fit_eval_tsp/u0/gene_scr
add wave -noupdate -format Literal /fit_eval_tsp/u0/gene
add wave -noupdate -format Literal -radix unsigned /fit_eval_tsp/u0/fit_n
add wave -noupdate -format Literal -radix unsigned /fit_eval_tsp/u0/temp_fit
add wave -noupdate -format Literal /fit_eval_tsp/u0/dist_1
add wave -noupdate -format Literal /fit_eval_tsp/u0/dist_2
add wave -noupdate -format Literal /fit_eval_tsp/u0/temp_1
add wave -noupdate -format Literal /fit_eval_tsp/u0/temp_2
add wave -noupdate -format Literal /fit_eval_tsp/u0/temp1
add wave -noupdate -format Literal /fit_eval_tsp/u0/temp2
add wave -noupdate -format Logic /fit_eval_tsp/u0/done
add wave -noupdate -format Literal /fit_eval_tsp/u0/counter
add wave -noupdate -format Literal /fit_eval_tsp/u0/counter_read_rom
add wave -noupdate -divider {FIX ELITE}
add wave -noupdate -format Logic /fit_eval_tsp/u1/clk
add wave -noupdate -format Logic /fit_eval_tsp/u1/rst_n
add wave -noupdate -format Logic /fit_eval_tsp/u1/decode
add wave -noupdate -format Logic /fit_eval_tsp/u1/valid
add wave -noupdate -format Logic /fit_eval_tsp/u1/elite_null
add wave -noupdate -format Literal /fit_eval_tsp/u1/index
add wave -noupdate -format Literal /fit_eval_tsp/u1/fit
add wave -noupdate -format Literal /fit_eval_tsp/u1/count_parents
add wave -noupdate -format Logic /fit_eval_tsp/u1/ready_in
add wave -noupdate -format Literal /fit_eval_tsp/u1/elite_offs
add wave -noupdate -format Literal -radix decimal /fit_eval_tsp/u1/fit_sum
add wave -noupdate -format Literal -radix unsigned /fit_eval_tsp/u1/max_fit
add wave -noupdate -format Logic /fit_eval_tsp/u1/rd
add wave -noupdate -format Literal -radix unsigned /fit_eval_tsp/u1/sum
add wave -noupdate -format Literal -radix unsigned /fit_eval_tsp/u1/sum_p
add wave -noupdate -format Literal -radix unsigned /fit_eval_tsp/u1/best_fit
add wave -noupdate -format Literal -radix unsigned /fit_eval_tsp/u1/best_fit_prev_gen
add wave -noupdate -format Literal -radix unsigned /fit_eval_tsp/u1/temp1
add wave -noupdate -format Literal -radix unsigned /fit_eval_tsp/u1/temp2
add wave -noupdate -format Literal /fit_eval_tsp/u1/elite_indexs
add wave -noupdate -format Literal /fit_eval_tsp/u1/temp_indexs_1
add wave -noupdate -format Literal /fit_eval_tsp/u1/temp_indexs_2
add wave -noupdate -format Logic /fit_eval_tsp/u1/cont
add wave -noupdate -format Logic /fit_eval_tsp/u1/cont2
add wave -noupdate -format Logic /fit_eval_tsp/u1/fin
add wave -noupdate -format Logic /fit_eval_tsp/u1/done_p
add wave -noupdate -format Logic /fit_eval_tsp/u1/done
add wave -noupdate -format Logic /fit_eval_tsp/u1/equal
add wave -noupdate -format Literal /fit_eval_tsp/u1/nparents
add wave -noupdate -format Literal /fit_eval_tsp/u1/counter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {110 ns} 0}
configure wave -namecolwidth 221
configure wave -valuecolwidth 90
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
WaveRestoreZoom {0 ns} {130 ns}
