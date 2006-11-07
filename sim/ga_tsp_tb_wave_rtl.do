onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {TOP FITNESS EVALUATION}
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u4/clk
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u4/rst_n
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/sreg
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/next_sreg
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u4/decode
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u4/valid
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/in_genes
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u4/elite_null
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/index
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/count_parents
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/gene_score
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/elite_offs
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/fit_sum
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/max_fit
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u4/rd
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/fit_dummy
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/addr_dummy
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u4/ready_out_dummy
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/data_out_rom
add wave -noupdate -divider {FITNESS CALCULATION}
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/sreg
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/next_sreg
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u4/u0/clk
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u4/u0/rst_n
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u4/u0/decode
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u4/u0/valid
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u0/in_genes
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u0/data_in
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u0/gene_score
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u0/fit
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u0/addr_rom
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u4/u0/ready_out
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u0/gene_scr
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u0/gene
add wave -noupdate -format Literal -radix decimal /ga_tsp_tb/u_bench/u4/u0/fit_n
add wave -noupdate -format Literal -radix decimal /ga_tsp_tb/u_bench/u4/u0/temp_fit
add wave -noupdate -format Literal -radix decimal /ga_tsp_tb/u_bench/u4/u0/max_fit
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u0/dist_1
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u0/dist_2
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u0/temp_1
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u0/temp_2
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u0/temp1
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u0/temp2
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u4/u0/done
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u4/u0/done_p
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u0/counter_read_rom
add wave -noupdate -divider {FIX ELITE}
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/sreg
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/next_sreg
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u4/u1/clk
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u4/u1/rst_n
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u4/u1/decode
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u4/u1/valid
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u4/u1/elite_null
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u1/index
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u1/fit
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u1/count_parents
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u4/u1/ready_in
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u1/elite_offs
add wave -noupdate -format Literal -radix unsigned /ga_tsp_tb/u_bench/u4/u1/fit_sum
add wave -noupdate -format Literal -radix unsigned /ga_tsp_tb/u_bench/u4/u1/max_fit
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u4/u1/rd
add wave -noupdate -format Literal -radix decimal /ga_tsp_tb/u_bench/u4/u1/sum
add wave -noupdate -format Literal -radix unsigned /ga_tsp_tb/u_bench/u4/u1/sum_p
add wave -noupdate -format Literal -radix decimal /ga_tsp_tb/u_bench/u4/u1/best_fit
add wave -noupdate -format Literal -radix decimal /ga_tsp_tb/u_bench/u4/u1/best_fit_prev_gen
add wave -noupdate -format Literal -radix decimal /ga_tsp_tb/u_bench/u4/u1/temp1
add wave -noupdate -format Literal -radix decimal /ga_tsp_tb/u_bench/u4/u1/temp2
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u1/elite_indexs
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u1/temp_indexs_1
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u1/temp_indexs_2
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u1/cont
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u1/nparents
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u4/u1/counter
add wave -noupdate -divider {RNG FOR SELECTION}
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u3/clk
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u3/rst_n
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u3/load
add wave -noupdate -format Literal -radix unsigned /ga_tsp_tb/u_bench/u3/seed
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u3/run
add wave -noupdate -format Literal -radix unsigned /ga_tsp_tb/u_bench/u3/parallel_out
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u3/taps
add wave -noupdate -divider SELECTION
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/sreg
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/next_sreg
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u5/clk
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u5/rst_n
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u5/ingene
add wave -noupdate -format Literal -radix unsigned /ga_tsp_tb/u_bench/u5/rng
add wave -noupdate -format Literal -radix unsigned /ga_tsp_tb/u_bench/u5/fitsum
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u5/data_valid
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u5/next_gene
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u5/selparent
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u5/rd
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u5/done
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u5/done_t
add wave -noupdate -format Literal -radix decimal /ga_tsp_tb/u_bench/u5/cumsum_p1
add wave -noupdate -format Literal -radix decimal /ga_tsp_tb/u_bench/u5/scalfitsum
add wave -noupdate -format Literal -radix decimal /ga_tsp_tb/u_bench/u5/scalfitsum_p
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u5/count
add wave -noupdate -divider {RNG FOR CROSSOVER AND MUTATION}
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u2/clk
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u2/rst_n
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u2/load
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u2/seed
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u2/run
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u2/parallel_out
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u2/taps
add wave -noupdate -divider CROSSOVER
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/sreg
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/next_sreg
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u6/clk
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u6/rst_n
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u6/cont
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u6/crosspoints
add wave -noupdate -format Literal -radix binary /ga_tsp_tb/u_bench/u6/ingene1
add wave -noupdate -format Literal -radix binary /ga_tsp_tb/u_bench/u6/ingene2
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u6/rd
add wave -noupdate -format Literal -radix binary /ga_tsp_tb/u_bench/u6/crossoffspr1
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u6/cross_point_int
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u6/ind
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u6/counter
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u6/temp1
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u6/temp2
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u6/crossout1
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u6/done
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u6/cont1
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u6/index
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u6/pool_int
add wave -noupdate -divider {RNG FOR MUTATION}
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u1/clk
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u1/rst_n
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u1/load
add wave -noupdate -format Literal -radix unsigned /ga_tsp_tb/u_bench/u1/seed
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u1/run
add wave -noupdate -format Literal -radix unsigned /ga_tsp_tb/u_bench/u1/parallel_out
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u1/taps
add wave -noupdate -divider MUTATION
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/sreg
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/next_sreg
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u7/clk
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u7/rst_n
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u7/mutpoint
add wave -noupdate -format Literal -radix binary /ga_tsp_tb/u_bench/u7/mutoffspr
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u7/cont
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u7/flag
add wave -noupdate -format Literal -radix unsigned /ga_tsp_tb/u_bench/u7/rng
add wave -noupdate -format Literal -radix binary /ga_tsp_tb/u_bench/u7/ingene
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u7/rd
add wave -noupdate -format Literal -radix binary /ga_tsp_tb/u_bench/u7/mutout
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u7/mutout_p1
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u7/done
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u7/done_p
add wave -noupdate -divider {CONTROL SIGNALS}
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/clk
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/rst_n
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/notify_cnt
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/notify_cnt_p
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/fit_eval_rd
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/sel_rd
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/cross_rd
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/mut_rd
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/run_ga
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/elite_offs
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/data_in_ram2
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/data_out_cross1
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/data_out_cross2
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/addr_1
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/addr_2
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/cnt_parents
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/we1
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/we2
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/data_valid
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/next_gene
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/clear
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/ga_fin
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/cross_out
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/valid
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/elite_null
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/index
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/mut_out
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/flag
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/decode
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/sel_out
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/addr_rom
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/run1
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/run2
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/run3
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/load
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/sreg
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/next_sreg
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/data_out_cross1_p1
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/data_out_cross2_p1
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/incr_p1
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/count_offs
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/count_offs_p1
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/count_gen
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/count_sel_wr_p1
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/count_sel_rd_p1
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/count_parents_p1
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/count_cross_offs_p1
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/count_sel_wr
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/count_sel_rd
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/count_parents
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/count_cross_offs
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/dummy_cnt_adapt
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/cnt_adapted
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/ga_fin_r
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u10/incr
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u10/next_generation
add wave -noupdate -divider {PARENTS RAM}
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u9/clk
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u9/rst_n
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u9/add
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u9/data_in
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u9/data_out
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u9/wr
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u9/clear
add wave -noupdate -format Literal -radix unsigned -expand /ga_tsp_tb/u_bench/u9/data
add wave -noupdate -format Literal /ga_tsp_tb/seed_1_i
add wave -noupdate -format Literal /ga_tsp_tb/seed_2_i
add wave -noupdate -format Literal /ga_tsp_tb/seed_3_i
add wave -noupdate -divider {GENES RAM}
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u8/clk
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u8/rst_n
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u8/add
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u8/data_in
add wave -noupdate -format Literal /ga_tsp_tb/u_bench/u8/data_out
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u8/wr
add wave -noupdate -format Logic /ga_tsp_tb/u_bench/u8/clear
add wave -noupdate -format Literal -expand /ga_tsp_tb/u_bench/u8/data
add wave -noupdate -divider {TESTBENCH SIGNALS}
add wave -noupdate -format Logic /ga_tsp_tb/clk
add wave -noupdate -format Logic /ga_tsp_tb/rst_n
add wave -noupdate -format Literal /ga_tsp_tb/best_gene
add wave -noupdate -format Literal /ga_tsp_tb/best_fit
add wave -noupdate -format Logic /ga_tsp_tb/ga_fin
add wave -noupdate -format Literal /ga_tsp_tb/run_ga_i
add wave -noupdate -format Literal /ga_tsp_tb/seed_1_i
add wave -noupdate -format Literal /ga_tsp_tb/seed_2_i
add wave -noupdate -format Literal /ga_tsp_tb/seed_3_i
add wave -noupdate -format Literal /ga_tsp_tb/elite_offs
add wave -noupdate -format Literal -radix decimal /ga_tsp_tb/max_fit
add wave -noupdate -format Logic /ga_tsp_tb/spy_next_generation
add wave -noupdate -format Literal /ga_tsp_tb/spy_elite
add wave -noupdate -format Literal -radix decimal /ga_tsp_tb/spy_max_fit
add wave -noupdate -format Literal /ga_tsp_tb/period
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {10695000 ps} 0}
configure wave -namecolwidth 247
configure wave -valuecolwidth 64
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
WaveRestoreZoom {2399928273 ps} {2400003776 ps}
