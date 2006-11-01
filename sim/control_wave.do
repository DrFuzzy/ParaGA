onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /control_v4/clk
add wave -noupdate -format Logic /control_v4/rst_n
add wave -noupdate -format Logic /control_v4/done
add wave -noupdate -format Logic /control_v4/fit_eval_rd
add wave -noupdate -format Logic /control_v4/sel_rd
add wave -noupdate -format Logic /control_v4/cross_rd
add wave -noupdate -format Logic /control_v4/mut_rd
add wave -noupdate -format Logic /control_v4/term_rd
add wave -noupdate -format Literal /control_v4/elite_offs
add wave -noupdate -format Literal /control_v4/data_in_ram2
add wave -noupdate -format Literal /control_v4/data_out_cross1
add wave -noupdate -format Literal /control_v4/out_cross2
add wave -noupdate -format Literal /control_v4/addr_1
add wave -noupdate -format Literal /control_v4/addr_2
add wave -noupdate -format Logic /control_v4/we1
add wave -noupdate -format Logic /control_v4/we2
add wave -noupdate -format Logic /control_v4/data_valid
add wave -noupdate -format Logic /control_v4/clear
add wave -noupdate -format Logic /control_v4/cross_out
add wave -noupdate -format Logic /control_v4/valid
add wave -noupdate -format Literal /control_v4/index
add wave -noupdate -format Logic /control_v4/mut_out
add wave -noupdate -format Logic /control_v4/decode
add wave -noupdate -format Logic /control_v4/sel_out
add wave -noupdate -format Logic /control_v4/term_out
add wave -noupdate -format Logic /control_v4/rng
add wave -noupdate -format Logic /control_v4/run
add wave -noupdate -format Logic /control_v4/run1
add wave -noupdate -format Logic /control_v4/run2
add wave -noupdate -format Logic /control_v4/run3
add wave -noupdate -format Logic /control_v4/load
add wave -noupdate -format Literal /control_v4/sreg
add wave -noupdate -format Literal /control_v4/next_sreg
add wave -noupdate -format Logic /control_v4/mut_rd_p1
add wave -noupdate -format Logic /control_v4/rng_rd_p1
add wave -noupdate -format Logic /control_v4/rng_rd
add wave -noupdate -format Logic /control_v4/term_rd_p1
add wave -noupdate -format Literal /control_v4/data_out_cross1_p1
add wave -noupdate -format Literal /control_v4/out_cross2_p1
add wave -noupdate -format Literal /control_v4/incr_p1
add wave -noupdate -format Literal /control_v4/count_offs
add wave -noupdate -format Literal /control_v4/count2
add wave -noupdate -format Literal /control_v4/count_offs_p1
add wave -noupdate -format Literal /control_v4/count_gen
add wave -noupdate -format Literal /control_v4/count_sel_wr_p1
add wave -noupdate -format Literal /control_v4/count_sel_rd_p1
add wave -noupdate -format Literal /control_v4/count_parents_p1
add wave -noupdate -format Literal /control_v4/count_cross_offs_p1
add wave -noupdate -format Literal /control_v4/count_sel_wr
add wave -noupdate -format Literal /control_v4/count_sel_rd
add wave -noupdate -format Literal /control_v4/count_parents
add wave -noupdate -format Literal /control_v4/count_cross_offs
add wave -noupdate -format Logic /control_v4/dummy_eval1_p1
add wave -noupdate -format Logic /control_v4/dummy_eval2_p1
add wave -noupdate -format Logic /control_v4/dummy_eval3_p1
add wave -noupdate -format Logic /control_v4/dummy_sel_p1
add wave -noupdate -format Logic /control_v4/dummy_ram1_p1
add wave -noupdate -format Logic /control_v4/dummy_ram2_p1
add wave -noupdate -format Logic /control_v4/dummy_eval1
add wave -noupdate -format Logic /control_v4/dummy_eval2
add wave -noupdate -format Logic /control_v4/dummy_eval3
add wave -noupdate -format Logic /control_v4/dummy_sel
add wave -noupdate -format Logic /control_v4/dummy_ram1
add wave -noupdate -format Logic /control_v4/dummy_ram2
add wave -noupdate -format Logic /control_v4/cnt_adapted
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {340 ns} 0}
configure wave -namecolwidth 223
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
WaveRestoreZoom {340 ns} {401 ns}
