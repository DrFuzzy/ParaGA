onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /ga/clk
add wave -noupdate -format Logic /ga/rst_n
add wave -noupdate -format Logic /ga/run_ga_i
add wave -noupdate -format Literal /ga/seed_i
add wave -noupdate -format Literal /ga/seed_1_i
add wave -noupdate -format Literal /ga/seed_2_i
add wave -noupdate -format Literal /ga/seed_3_i
add wave -noupdate -format Literal /ga/crossmethod_i
add wave -noupdate -format Literal /ga/mutmethod_i
add wave -noupdate -format Literal /ga/best_gene
add wave -noupdate -format Literal -radix unsigned /ga/best_fit
add wave -noupdate -format Logic /ga/fit_limit_reach
add wave -noupdate -format Logic /ga/ga_fin
add wave -noupdate -format Logic /ga/load_dummy
add wave -noupdate -format Logic /ga/run
add wave -noupdate -format Logic /ga/run1
add wave -noupdate -format Logic /ga/run2
add wave -noupdate -format Logic /ga/run3
add wave -noupdate -format Literal /ga/out_rng_1_dummy
add wave -noupdate -format Literal /ga/out_rng_2_dummy
add wave -noupdate -format Literal /ga/out_rng_3_dummy
add wave -noupdate -format Logic /ga/valid1
add wave -noupdate -format Logic /ga/elite_null_dummy
add wave -noupdate -format Literal /ga/index
add wave -noupdate -format Literal /ga/elite_offs_dummy
add wave -noupdate -format Logic /ga/fit_eval_rd_dummy
add wave -noupdate -format Literal /ga/ingene_fiteval_dummy
add wave -noupdate -format Literal /ga/fit_sum_dummy
add wave -noupdate -format Literal /ga/max_fit_dummy
add wave -noupdate -format Logic /ga/decode_dummy
add wave -noupdate -format Logic /ga/selection_rd_dummy
add wave -noupdate -format Logic /ga/sel_out
add wave -noupdate -format Logic /ga/data_valid_dummy
add wave -noupdate -format Logic /ga/next_gene_dummy
add wave -noupdate -format Logic /ga/cross_out
add wave -noupdate -format Literal /ga/ingene1_cross_dummy
add wave -noupdate -format Literal /ga/ingene2_cross_dummy
add wave -noupdate -format Logic /ga/cross_rd_dummy
add wave -noupdate -format Literal /ga/crossoffspr_dummy
add wave -noupdate -format Logic /ga/mut_out
add wave -noupdate -format Logic /ga/mutation_rd_dummy
add wave -noupdate -format Logic /ga/term_out
add wave -noupdate -format Logic /ga/fitlim_rd_dummy
add wave -noupdate -format Logic /ga/obs_rd_dummy
add wave -noupdate -format Logic /ga/clear_dummy
add wave -noupdate -format Literal /ga/data_in_1_dummy
add wave -noupdate -format Literal /ga/data_out_1_dummy
add wave -noupdate -format Literal /ga/addr_1_dummy
add wave -noupdate -format Logic /ga/we1_dummy
add wave -noupdate -format Literal /ga/data_in_2_dummy
add wave -noupdate -format Literal /ga/data_out_2_dummy
add wave -noupdate -format Literal /ga/addr_2_dummy
add wave -noupdate -format Logic /ga/we2_dummy
add wave -noupdate -format Logic /ga/flag_dummy
add wave -noupdate -format Literal /ga/count_parents_dummy
add wave -noupdate -format Literal -radix unsigned /ga/best_gene_i
add wave -noupdate -format Literal -radix unsigned /ga/best_fit_i
add wave -noupdate -format Logic /ga/fit_limit_reach_i
add wave -noupdate -format Logic /ga/ga_fin_i
add wave -noupdate -format Logic /ga/run_ga
add wave -noupdate -format Literal /ga/seed
add wave -noupdate -format Literal /ga/seed_1
add wave -noupdate -format Literal /ga/seed_2
add wave -noupdate -format Literal /ga/seed_3
add wave -noupdate -format Literal /ga/crossmethod
add wave -noupdate -format Literal /ga/mutmethod
add wave -noupdate -divider RNG0
add wave -noupdate -format Logic /ga/u0/clk
add wave -noupdate -format Logic /ga/u0/rst_n
add wave -noupdate -format Logic /ga/u0/load
add wave -noupdate -format Literal /ga/u0/seed
add wave -noupdate -format Logic /ga/u0/run
add wave -noupdate -format Literal /ga/u0/parallel_out
add wave -noupdate -divider RNG1
add wave -noupdate -format Logic /ga/u1/load
add wave -noupdate -format Literal /ga/u1/seed
add wave -noupdate -format Logic /ga/u1/run
add wave -noupdate -format Literal -radix binary /ga/u1/parallel_out
add wave -noupdate -divider RNG2
add wave -noupdate -format Logic /ga/u2/clk
add wave -noupdate -format Logic /ga/u2/rst_n
add wave -noupdate -format Logic /ga/u2/load
add wave -noupdate -format Literal /ga/u2/seed
add wave -noupdate -format Logic /ga/u2/run
add wave -noupdate -format Literal /ga/u2/parallel_out
add wave -noupdate -divider RNG3
add wave -noupdate -format Logic /ga/u3/load
add wave -noupdate -format Literal /ga/u3/seed
add wave -noupdate -format Logic /ga/u3/run
add wave -noupdate -format Literal /ga/u3/parallel_out
add wave -noupdate -divider {FIT EVALUATION}
add wave -noupdate -format Logic /ga/u4/clk
add wave -noupdate -format Logic /ga/u4/rst_n
add wave -noupdate -format Literal /ga/u11/sreg
add wave -noupdate -format Literal /ga/u11/next_sreg
add wave -noupdate -format Logic /ga/u4/decode
add wave -noupdate -format Logic /ga/u4/valid
add wave -noupdate -format Logic /ga/u4/elite_null
add wave -noupdate -format Literal /ga/u4/in_genes
add wave -noupdate -format Literal /ga/u4/index
add wave -noupdate -format Literal /ga/u4/count_parents
add wave -noupdate -format Literal /ga/u4/gene_score
add wave -noupdate -format Literal /ga/u4/elite_offs
add wave -noupdate -format Literal -radix unsigned /ga/u4/fit_sum
add wave -noupdate -format Literal -radix unsigned /ga/u4/max_fit
add wave -noupdate -format Logic /ga/u4/rd
add wave -noupdate -format Literal /ga/u4/gene_scr
add wave -noupdate -format Literal -radix unsigned /ga/u4/gene
add wave -noupdate -format Literal -radix unsigned /ga/u4/fit
add wave -noupdate -format Literal -radix unsigned /ga/u4/sum
add wave -noupdate -format Literal -radix unsigned /ga/u4/sum_p
add wave -noupdate -format Literal -radix unsigned /ga/u4/best_fit
add wave -noupdate -format Literal -radix unsigned /ga/u4/best_fit_prev_gen
add wave -noupdate -format Literal -radix unsigned /ga/u4/temp1
add wave -noupdate -format Literal -radix unsigned /ga/u4/temp2
add wave -noupdate -format Literal /ga/u4/elite_indexs
add wave -noupdate -format Literal /ga/u4/temp_indexs_1
add wave -noupdate -format Literal /ga/u4/temp_indexs_2
add wave -noupdate -format Logic /ga/u4/cont
add wave -noupdate -format Logic /ga/u4/cont2
add wave -noupdate -format Logic /ga/u4/done_p
add wave -noupdate -format Logic /ga/u4/done
add wave -noupdate -format Logic /ga/u4/equal
add wave -noupdate -format Literal /ga/u4/nparents
add wave -noupdate -format Literal /ga/u4/counter
add wave -noupdate -divider SELECTION
add wave -noupdate -format Logic /ga/u5/clk
add wave -noupdate -format Logic /ga/u5/rst_n
add wave -noupdate -format Literal /ga/u11/sreg
add wave -noupdate -format Literal /ga/u11/next_sreg
add wave -noupdate -format Literal /ga/u5/ingene
add wave -noupdate -format Literal -radix unsigned /ga/u5/rng
add wave -noupdate -format Literal -radix unsigned /ga/u5/fitsum
add wave -noupdate -format Logic /ga/u5/data_valid
add wave -noupdate -format Logic /ga/u5/next_gene
add wave -noupdate -format Literal /ga/u5/selparent
add wave -noupdate -format Logic /ga/u5/rd
add wave -noupdate -format Logic /ga/u5/done
add wave -noupdate -format Logic /ga/u5/done_t
add wave -noupdate -format Literal -radix unsigned /ga/u5/cumsum_p1
add wave -noupdate -format Literal -radix unsigned /ga/u5/scalfitsum
add wave -noupdate -format Literal -radix unsigned /ga/u5/scalfitsum_p
add wave -noupdate -format Literal /ga/u5/count
add wave -noupdate -divider CROSSOVER
add wave -noupdate -format Logic /ga/u6/clk
add wave -noupdate -format Logic /ga/u6/rst_n
add wave -noupdate -format Literal /ga/u11/sreg
add wave -noupdate -format Literal /ga/u11/next_sreg
add wave -noupdate -format Logic /ga/u6/cont
add wave -noupdate -format Literal /ga/u6/crosspoints
add wave -noupdate -format Literal /ga/u6/rng
add wave -noupdate -format Literal /ga/u6/crossmethod
add wave -noupdate -format Literal /ga/u6/ingene1
add wave -noupdate -format Literal /ga/u6/ingene2
add wave -noupdate -format Logic /ga/u6/rd
add wave -noupdate -format Literal /ga/u6/crossoffspr1
add wave -noupdate -format Literal /ga/u6/mask
add wave -noupdate -format Literal /ga/u6/mask1
add wave -noupdate -format Literal /ga/u6/mask2
add wave -noupdate -format Literal /ga/u6/temp
add wave -noupdate -format Literal /ga/u6/temp_int
add wave -noupdate -format Literal /ga/u6/temp1
add wave -noupdate -format Literal /ga/u6/temp2
add wave -noupdate -format Literal /ga/u6/crossout1
add wave -noupdate -format Logic /ga/u6/done
add wave -noupdate -divider MUTATION
add wave -noupdate -format Logic /ga/u7/clk
add wave -noupdate -format Logic /ga/u7/rst_n
add wave -noupdate -format Literal /ga/u11/sreg
add wave -noupdate -format Literal /ga/u11/next_sreg
add wave -noupdate -format Literal /ga/u7/mutpoint
add wave -noupdate -format Literal /ga/u7/mutmethod
add wave -noupdate -format Logic /ga/u7/cont
add wave -noupdate -format Logic /ga/u7/flag
add wave -noupdate -format Literal /ga/u7/rng
add wave -noupdate -format Literal -radix unsigned /ga/u7/ingene
add wave -noupdate -format Literal -radix binary /ga/u7/ingene
add wave -noupdate -format Logic /ga/u7/rd
add wave -noupdate -format Literal -radix unsigned /ga/u7/mutoffspr
add wave -noupdate -format Literal -radix binary /ga/u7/mutoffspr
add wave -noupdate -format Literal /ga/u7/mask
add wave -noupdate -format Literal /ga/u7/maskunif
add wave -noupdate -format Literal /ga/u7/mutout
add wave -noupdate -format Literal /ga/u7/mutout_p1
add wave -noupdate -format Literal /ga/u7/ingene_mut
add wave -noupdate -format Literal -radix unsigned /ga/u7/rng1
add wave -noupdate -format Literal -radix binary /ga/u7/rng1
add wave -noupdate -format Literal /ga/u7/count
add wave -noupdate -format Logic /ga/u7/done
add wave -noupdate -format Logic /ga/u7/done_p
add wave -noupdate -divider OBSERVER
add wave -noupdate -format Logic /ga/u8/clk
add wave -noupdate -format Logic /ga/u8/rst_n
add wave -noupdate -format Literal /ga/u8/max_fit
add wave -noupdate -format Logic /ga/u8/fitlim_rd
add wave -noupdate -format Logic /ga/u8/rd
add wave -noupdate -format Logic /ga/u8/done
add wave -noupdate -format Logic /ga/u8/done2
add wave -noupdate -format Literal /ga/u8/temp
add wave -noupdate -divider {RAM 1 - GENES}
add wave -noupdate -format Logic /ga/u9/clk
add wave -noupdate -format Logic /ga/u9/rst_n
add wave -noupdate -format Literal /ga/u11/sreg
add wave -noupdate -format Literal /ga/u11/next_sreg
add wave -noupdate -format Literal /ga/u9/add
add wave -noupdate -format Literal /ga/u9/data_in
add wave -noupdate -format Literal /ga/u9/data_out
add wave -noupdate -format Logic /ga/u9/wr
add wave -noupdate -format Logic /ga/u9/clear
add wave -noupdate -format Literal -expand /ga/u9/data
add wave -noupdate -divider {RAM 2 - PARENTS}
add wave -noupdate -format Logic /ga/u10/clk
add wave -noupdate -format Logic /ga/u10/rst_n
add wave -noupdate -format Literal /ga/u10/add
add wave -noupdate -format Literal /ga/u10/data_in
add wave -noupdate -format Literal /ga/u10/data_out
add wave -noupdate -format Logic /ga/u10/wr
add wave -noupdate -format Logic /ga/u10/clear
add wave -noupdate -format Literal -expand /ga/u10/data
add wave -noupdate -divider {CONTROL BLOCK}
add wave -noupdate -format Logic /ga/u11/clk
add wave -noupdate -format Logic /ga/u11/rst_n
add wave -noupdate -format Logic /ga/u11/done
add wave -noupdate -format Logic /ga/u11/fit_eval_rd
add wave -noupdate -format Logic /ga/u11/sel_rd
add wave -noupdate -format Logic /ga/u11/cross_rd
add wave -noupdate -format Logic /ga/u11/mut_rd
add wave -noupdate -format Logic /ga/u11/term_rd
add wave -noupdate -format Logic /ga/u11/run_ga
add wave -noupdate -format Literal /ga/u11/elite_offs
add wave -noupdate -format Literal /ga/u11/data_in_ram2
add wave -noupdate -format Literal /ga/u11/data_out_cross1
add wave -noupdate -format Literal /ga/u11/data_out_cross2
add wave -noupdate -format Literal /ga/u11/addr_1
add wave -noupdate -format Literal /ga/u11/addr_2
add wave -noupdate -format Literal /ga/u11/cnt_parents
add wave -noupdate -format Logic /ga/u11/we1
add wave -noupdate -format Logic /ga/u11/we2
add wave -noupdate -format Logic /ga/u11/data_valid
add wave -noupdate -format Logic /ga/u11/next_gene
add wave -noupdate -format Logic /ga/u11/clear
add wave -noupdate -format Logic /ga/u11/ga_fin
add wave -noupdate -format Logic /ga/u11/cross_out
add wave -noupdate -format Logic /ga/u11/valid
add wave -noupdate -format Logic /ga/u11/elite_null
add wave -noupdate -format Literal /ga/u11/index
add wave -noupdate -format Logic /ga/u11/mut_out
add wave -noupdate -format Logic /ga/u11/flag
add wave -noupdate -format Logic /ga/u11/decode
add wave -noupdate -format Logic /ga/u11/sel_out
add wave -noupdate -format Logic /ga/u11/term_out
add wave -noupdate -format Logic /ga/u11/run
add wave -noupdate -format Logic /ga/u11/run1
add wave -noupdate -format Logic /ga/u11/run2
add wave -noupdate -format Logic /ga/u11/run3
add wave -noupdate -format Logic /ga/u11/load
add wave -noupdate -format Literal /ga/u11/sreg
add wave -noupdate -format Literal /ga/u11/next_sreg
add wave -noupdate -format Logic /ga/u11/mut_rd_p1
add wave -noupdate -format Logic /ga/u11/rng_rd_p1
add wave -noupdate -format Logic /ga/u11/rng_rd
add wave -noupdate -format Logic /ga/u11/term_rd_p1
add wave -noupdate -format Literal /ga/u11/data_out_cross1_p1
add wave -noupdate -format Literal /ga/u11/data_out_cross2_p1
add wave -noupdate -format Literal /ga/u11/incr_p1
add wave -noupdate -format Literal /ga/u11/count_offs
add wave -noupdate -format Literal /ga/u11/count2
add wave -noupdate -format Literal /ga/u11/count_offs_p1
add wave -noupdate -format Literal /ga/u11/count_gen
add wave -noupdate -format Literal /ga/u11/count_sel_wr_p1
add wave -noupdate -format Literal /ga/u11/count_sel_rd_p1
add wave -noupdate -format Literal /ga/u11/count_parents_p1
add wave -noupdate -format Literal /ga/u11/count_cross_offs_p1
add wave -noupdate -format Literal /ga/u11/count_sel_wr
add wave -noupdate -format Literal /ga/u11/count_sel_rd
add wave -noupdate -format Literal /ga/u11/count_parents
add wave -noupdate -format Literal /ga/u11/count_cross_offs
add wave -noupdate -format Logic /ga/u11/dummy_eval1_p1
add wave -noupdate -format Logic /ga/u11/dummy_eval2_p1
add wave -noupdate -format Logic /ga/u11/dummy_eval3_p1
add wave -noupdate -format Logic /ga/u11/dummy_sel_p1
add wave -noupdate -format Logic /ga/u11/dummy_ram1_p1
add wave -noupdate -format Logic /ga/u11/dummy_ram2_p1
add wave -noupdate -format Logic /ga/u11/dummy_mut_p1
add wave -noupdate -format Logic /ga/u11/dummy_eval1
add wave -noupdate -format Logic /ga/u11/dummy_eval2
add wave -noupdate -format Logic /ga/u11/dummy_eval3
add wave -noupdate -format Logic /ga/u11/dummy_sel
add wave -noupdate -format Logic /ga/u11/dummy_ram1
add wave -noupdate -format Logic /ga/u11/dummy_ram2
add wave -noupdate -format Logic /ga/u11/dummy_cnt_adapt
add wave -noupdate -format Logic /ga/u11/dummy_mut
add wave -noupdate -format Logic /ga/u11/cnt_adapted
add wave -noupdate -format Logic /ga/u11/ga_fin_r
add wave -noupdate -format Literal /ga/u11/incr
add wave -noupdate -format Literal /ga/u11/nparents
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {18161 ns} 0}
configure wave -namecolwidth 203
configure wave -valuecolwidth 112
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
WaveRestoreZoom {18111 ns} {18173 ns}
