onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /fit_calc_tsp/clk
add wave -noupdate -format Logic /fit_calc_tsp/rst_n
add wave -noupdate -format Logic /fit_calc_tsp/decode
add wave -noupdate -format Logic /fit_calc_tsp/valid
add wave -noupdate -format Literal /fit_calc_tsp/in_genes
add wave -noupdate -format Literal /fit_calc_tsp/data_in
add wave -noupdate -format Literal /fit_calc_tsp/gene_score
add wave -noupdate -format Literal -radix decimal /fit_calc_tsp/fit
add wave -noupdate -format Logic /fit_calc_tsp/ready_out
add wave -noupdate -format Literal /fit_calc_tsp/gene_scr
add wave -noupdate -format Literal /fit_calc_tsp/gene
add wave -noupdate -format Literal -radix decimal /fit_calc_tsp/fit_n
add wave -noupdate -format Literal -radix unsigned /fit_calc_tsp/temp_fit
add wave -noupdate -format Literal /fit_calc_tsp/dist_1
add wave -noupdate -format Literal /fit_calc_tsp/dist_2
add wave -noupdate -format Literal /fit_calc_tsp/temp1
add wave -noupdate -format Literal /fit_calc_tsp/temp2
add wave -noupdate -format Literal /fit_calc_tsp/temp_1
add wave -noupdate -format Literal /fit_calc_tsp/temp_2
add wave -noupdate -format Literal /fit_calc_tsp/counter_read_rom
add wave -noupdate -format Logic /fit_calc_tsp/done
add wave -noupdate -format Literal /fit_calc_tsp/counter
add wave -noupdate -format Literal /fit_calc_tsp/addr_rom
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {70 ns} 0}
configure wave -namecolwidth 193
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
WaveRestoreZoom {273 ns} {397 ns}
