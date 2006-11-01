onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /ga/clk
add wave -noupdate -format Logic /ga/rst_n
add wave -noupdate -format Logic /ga/run_ga
add wave -noupdate -format Literal -radix unsigned /ga/best_gene
add wave -noupdate -format Literal -radix unsigned /ga/best_fit
add wave -noupdate -format Logic /ga/fit_limit_reach
add wave -noupdate -format Logic /ga/ga_fin
add wave -noupdate -format Literal /ga/seed
add wave -noupdate -format Literal /ga/seed_1
add wave -noupdate -format Literal /ga/seed_2
add wave -noupdate -format Literal /ga/seed_3
add wave -noupdate -format Literal /ga/crossmethod
add wave -noupdate -format Literal /ga/mutmethod
add wave -noupdate -format Logic /ga/load_dummy
add wave -noupdate -format Logic /ga/run
add wave -noupdate -format Logic /ga/run1
add wave -noupdate -format Logic /ga/run2
add wave -noupdate -format Logic /ga/run3
add wave -noupdate -format Literal /ga/out_rng_1_dummy
add wave -noupdate -format Literal /ga/out_rng_2_dummy
add wave -noupdate -format Literal /ga/out_rng_3_dummy
add wave -noupdate -format Logic /ga/valid1
add wave -noupdate -format Logic /ga/clear_dummy
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
add wave -noupdate -format Literal /ga/data_in_1_dummy
add wave -noupdate -format Literal /ga/data_out_1_dummy
add wave -noupdate -format Literal /ga/addr_1_dummy
add wave -noupdate -format Logic /ga/we1_dummy
add wave -noupdate -format Literal /ga/data_in_2_dummy
add wave -noupdate -format Literal /ga/data_out_2_dummy
add wave -noupdate -format Literal /ga/addr_2_dummy
add wave -noupdate -format Logic /ga/we2_dummy
add wave -noupdate -divider {CONTROL BLOCK}
add wave -noupdate -format Logic /ga/u9/clk
add wave -noupdate -format Logic /ga/u9/rst_n
add wave -noupdate -format Logic /ga/u9/done
add wave -noupdate -format Logic /ga/u9/fit_eval_rd
add wave -noupdate -format Logic /ga/u9/sel_rd
add wave -noupdate -format Logic /ga/u9/cross_rd
add wave -noupdate -format Logic /ga/u9/mut_rd
add wave -noupdate -format Logic /ga/u9/term_rd
add wave -noupdate -format Literal /ga/u9/elite_offs
add wave -noupdate -format Literal /ga/u9/data_in_ram2
add wave -noupdate -format Literal /ga/u9/data_out_cross1
add wave -noupdate -format Literal /ga/u9/data_out_cross2
add wave -noupdate -format Literal /ga/u9/addr_1
add wave -noupdate -format Literal /ga/u9/addr_2
add wave -noupdate -format Logic /ga/u9/we1
add wave -noupdate -format Logic /ga/u9/we2
add wave -noupdate -format Logic /ga/u9/data_valid
add wave -noupdate -format Logic /ga/u9/clear
add wave -noupdate -format Logic /ga/u9/cross_out
add wave -noupdate -format Logic /ga/u9/valid
add wave -noupdate -format Literal /ga/u9/index
add wave -noupdate -format Logic /ga/u9/mut_out
add wave -noupdate -format Logic /ga/u9/decode
add wave -noupdate -format Logic /ga/u9/sel_out
add wave -noupdate -format Logic /ga/u9/term_out
add wave -noupdate -format Logic /ga/u9/run
add wave -noupdate -format Logic /ga/u9/run1
add wave -noupdate -format Logic /ga/u9/run2
add wave -noupdate -format Logic /ga/u9/run3
add wave -noupdate -format Logic /ga/u9/load
add wave -noupdate -format Literal /ga/u9/sreg
add wave -noupdate -format Literal /ga/u9/next_sreg
add wave -noupdate -format Logic /ga/u9/mut_rd_p1
add wave -noupdate -format Logic /ga/u9/rng_rd_p1
add wave -noupdate -format Logic /ga/u9/rng_rd
add wave -noupdate -format Logic /ga/u9/term_rd_p1
add wave -noupdate -format Literal /ga/u9/data_out_cross1_p1
add wave -noupdate -format Literal /ga/u9/data_out_cross2_p1
add wave -noupdate -format Literal /ga/u9/incr_p1
add wave -noupdate -format Literal /ga/u9/count_offs
add wave -noupdate -format Literal /ga/u9/count2
add wave -noupdate -format Literal /ga/u9/count_offs_p1
add wave -noupdate -format Literal /ga/u9/count_sel_wr_p1
add wave -noupdate -format Literal /ga/u9/count_sel_rd_p1
add wave -noupdate -format Literal /ga/u9/count_parents_p1
add wave -noupdate -format Literal /ga/u9/count_cross_offs_p1
add wave -noupdate -format Literal /ga/u9/count_sel_wr
add wave -noupdate -format Literal /ga/u9/count_sel_rd
add wave -noupdate -format Literal /ga/u9/count_parents
add wave -noupdate -format Literal /ga/u9/count_gen
add wave -noupdate -format Literal /ga/u9/count_cross_offs
add wave -noupdate -format Logic /ga/u9/dummy_eval1_p1
add wave -noupdate -format Logic /ga/u9/dummy_eval2_p1
add wave -noupdate -format Logic /ga/u9/dummy_eval3_p1
add wave -noupdate -format Logic /ga/u9/dummy_sel_p1
add wave -noupdate -format Logic /ga/u9/dummy_ram1_p1
add wave -noupdate -format Logic /ga/u9/dummy_ram2_p1
add wave -noupdate -format Logic /ga/u9/dummy_eval1
add wave -noupdate -format Logic /ga/u9/dummy_eval2
add wave -noupdate -format Logic /ga/u9/dummy_eval3
add wave -noupdate -format Logic /ga/u9/dummy_sel
add wave -noupdate -format Logic /ga/u9/dummy_ram1
add wave -noupdate -format Logic /ga/u9/dummy_ram2
add wave -noupdate -format Logic /ga/u9/dummy_cnt_adapt
add wave -noupdate -format Logic /ga/u9/cnt_adapted
add wave -noupdate -format Literal /ga/u9/incr
add wave -noupdate -format Literal /ga/u9/nparents
add wave -noupdate -divider {RAM 1}
add wave -noupdate -format Logic /ga/r1/clk
add wave -noupdate -format Logic /ga/r1/rst_n
add wave -noupdate -format Literal /ga/r1/add
add wave -noupdate -format Literal /ga/r1/data_in
add wave -noupdate -format Literal /ga/r1/data_out
add wave -noupdate -format Logic /ga/r1/wr
add wave -noupdate -format Literal -expand /ga/r1/data
add wave -noupdate -divider {FITNESS EVALUATION}
add wave -noupdate -format Logic /ga/u4/clk
add wave -noupdate -format Logic /ga/u4/rst_n
add wave -noupdate -format Logic /ga/u4/decode
add wave -noupdate -format Logic /ga/u4/valid
add wave -noupdate -format Literal /ga/u4/in_genes
add wave -noupdate -format Literal /ga/u4/index
add wave -noupdate -format Literal /ga/u4/gene_score
add wave -noupdate -format Literal /ga/u4/elite_offs
add wave -noupdate -format Logic /ga/u9/elite_null
add wave -noupdate -format Literal -radix unsigned /ga/u4/fit_sum
add wave -noupdate -format Literal -radix unsigned /ga/u4/max_fit
add wave -noupdate -format Logic /ga/u4/rd
add wave -noupdate -format Literal /ga/u4/gene_scr
add wave -noupdate -format Literal /ga/u4/gene
add wave -noupdate -format Literal -radix unsigned /ga/u4/fit
add wave -noupdate -format Literal -radix unsigned /ga/u4/sum
add wave -noupdate -format Literal -radix unsigned /ga/u4/sum_p
add wave -noupdate -format Logic /ga/u4/elite_null
add wave -noupdate -format Literal -radix unsigned /ga/u4/best_fit
add wave -noupdate -format Literal /ga/u4/elite_indexs
add wave -noupdate -format Logic /ga/u4/cont
add wave -noupdate -format Logic /ga/u4/cont2
add wave -noupdate -format Logic /ga/u4/done_p
add wave -noupdate -format Literal -radix unsigned /ga/u4/best_fit_prev_gen
add wave -noupdate -format Literal /ga/u4/counter
add wave -noupdate -format Logic /ga/u4/done
add wave -noupdate -divider {SELECTION BLOCK}
add wave -noupdate -format Logic /ga/u5/clk
add wave -noupdate -format Logic /ga/u5/rst_n
add wave -noupdate -format Literal /ga/u9/sreg
add wave -noupdate -format Literal /ga/u9/next_sreg
add wave -noupdate -format Literal /ga/u5/ingene
add wave -noupdate -format Literal -radix unsigned /ga/u5/rng
add wave -noupdate -format Logic /ga/u5/next_gene
add wave -noupdate -format Literal -radix unsigned /ga/u5/fitsum
add wave -noupdate -format Literal -radix unsigned /ga/u5/cumsum_p1
add wave -noupdate -format Logic /ga/u5/data_valid
add wave -noupdate -format Literal /ga/u5/selparent
add wave -noupdate -format Logic /ga/u5/rd
add wave -noupdate -format Logic /ga/u5/done
add wave -noupdate -format Logic /ga/u5/done_t
add wave -noupdate -format Literal -radix unsigned /ga/u5/scalfitsum
add wave -noupdate -format Literal -radix unsigned /ga/u5/scalfitsum_p
add wave -noupdate -format Literal /ga/u5/count
add wave -noupdate -divider {RAM 2}
add wave -noupdate -format Logic /ga/r2/clk
add wave -noupdate -format Logic /ga/r2/rst_n
add wave -noupdate -format Literal /ga/r2/add
add wave -noupdate -format Literal /ga/r2/data_in
add wave -noupdate -format Literal /ga/r2/data_out
add wave -noupdate -format Logic /ga/r2/wr
add wave -noupdate -format Literal -expand /ga/r2/data
add wave -noupdate -divider {RNG 3}
add wave -noupdate -format Logic /ga/u3/clk
add wave -noupdate -format Logic /ga/u3/rst_n
add wave -noupdate -format Logic /ga/u3/load
add wave -noupdate -format Literal /ga/u3/seed
add wave -noupdate -format Logic /ga/u3/run
add wave -noupdate -format Literal /ga/u3/parallel_out
add wave -noupdate -divider CROSSOVER
add wave -noupdate -format Literal /ga/u9/sreg
add wave -noupdate -format Literal /ga/u9/next_sreg
add wave -noupdate -format Logic /ga/u6/clk
add wave -noupdate -format Logic /ga/u6/rst_n
add wave -noupdate -divider space
add wave -noupdate -format Logic /ga/u6/cont
add wave -noupdate -divider space
add wave -noupdate -format Literal /ga/u6/crosspoints
add wave -noupdate -format Literal /ga/u6/crossmethod
add wave -noupdate -format Literal /ga/u6/rng
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
add wave -noupdate -divider {RNG 1}
add wave -noupdate -format Logic /ga/u1/clk
add wave -noupdate -format Logic /ga/u1/rst_n
add wave -noupdate -format Logic /ga/u1/load
add wave -noupdate -format Literal /ga/u1/seed
add wave -noupdate -format Logic /ga/u1/run
add wave -noupdate -format Literal /ga/u1/parallel_out
add wave -noupdate -divider {RNG 2}
add wave -noupdate -format Logic /ga/u2/clk
add wave -noupdate -format Logic /ga/u2/rst_n
add wave -noupdate -format Logic /ga/u2/load
add wave -noupdate -format Literal /ga/u2/seed
add wave -noupdate -format Logic /ga/u2/run
add wave -noupdate -format Literal /ga/u2/parallel_out
add wave -noupdate -divider MUTATION
add wave -noupdate -format Literal /ga/u9/sreg
add wave -noupdate -format Literal /ga/u9/next_sreg
add wave -noupdate -format Logic /ga/u7/clk
add wave -noupdate -format Logic /ga/u7/rst_n
add wave -noupdate -format Logic /ga/u7/cont
add wave -noupdate -format Logic /ga/u7/flag
add wave -noupdate -format Literal /ga/u7/mutpoint
add wave -noupdate -format Literal /ga/u7/mutmethod
add wave -noupdate -format Literal -radix binary /ga/u7/rng
add wave -noupdate -format Literal /ga/u7/ingene
add wave -noupdate -format Logic /ga/u7/rd
add wave -noupdate -format Literal /ga/u7/mutoffspr
add wave -noupdate -format Literal /ga/u7/weirdtrue
add wave -noupdate -format Literal /ga/u7/mask
add wave -noupdate -format Literal /ga/u7/maskunif
add wave -noupdate -format Literal /ga/u7/mutout
add wave -noupdate -format Literal /ga/u7/mutout_p1
add wave -noupdate -format Literal /ga/u7/ingene_mut
add wave -noupdate -format Literal /ga/u7/rng1
add wave -noupdate -format Literal -radix unsigned /ga/u7/count
add wave -noupdate -format Logic /ga/u7/done
add wave -noupdate -divider OBSERVER
add wave -noupdate -format Logic /ga/u8/clk
add wave -noupdate -format Logic /ga/u8/rst_n
add wave -noupdate -format Literal /ga/u8/max_fit
add wave -noupdate -format Logic /ga/u8/fitlim_rd
add wave -noupdate -format Logic /ga/u8/rd
add wave -noupdate -format Logic /ga/u8/done
add wave -noupdate -format Logic /ga/u8/done2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {14010 ns} 0}
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
WaveRestoreZoom {13928 ns} {14092 ns}
