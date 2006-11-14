onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -format Logic /ga_tb/clk
add wave -noupdate -format Logic /ga_tb/rst_n
add wave -noupdate -format Literal /ga_tb/best_gene
add wave -noupdate -format Literal /ga_tb/best_fit
add wave -noupdate -format Logic /ga_tb/fit_limit_reach
add wave -noupdate -format Logic /ga_tb/ga_fin
add wave -noupdate -format Literal /ga_tb/run_ga_i
add wave -noupdate -format Literal /ga_tb/seed_i
add wave -noupdate -format Literal /ga_tb/seed_1_i
add wave -noupdate -format Literal /ga_tb/seed_2_i
add wave -noupdate -format Literal /ga_tb/seed_3_i
add wave -noupdate -format Literal /ga_tb/crossmethod_i
add wave -noupdate -format Literal /ga_tb/mutmethod_i
add wave -noupdate -format Literal /ga_tb/elite_offs
add wave -noupdate -format Literal /ga_tb/max_fit
add wave -noupdate -format Logic /ga_tb/spy_next_generation
add wave -noupdate -format Literal /ga_tb/spy_elite
add wave -noupdate -format Literal /ga_tb/spy_max_fit
add wave -noupdate -format Literal /ga_tb/period
add wave -noupdate -divider {CONTROL BLOCK}
add wave -noupdate -format Logic /ga_tb/u_bench/u11/clk
add wave -noupdate -format Logic /ga_tb/u_bench/u11/rst_n
add wave -noupdate -format Logic /ga_tb/u_bench/u11/done
add wave -noupdate -format Logic /ga_tb/u_bench/u11/fit_eval_rd
add wave -noupdate -format Logic /ga_tb/u_bench/u11/sel_rd
add wave -noupdate -format Logic /ga_tb/u_bench/u11/cross_rd
add wave -noupdate -format Logic /ga_tb/u_bench/u11/mut_rd
add wave -noupdate -format Logic /ga_tb/u_bench/u11/term_rd
add wave -noupdate -format Logic /ga_tb/u_bench/u11/run_ga
add wave -noupdate -format Literal /ga_tb/u_bench/u11/elite_offs
add wave -noupdate -format Literal /ga_tb/u_bench/u11/data_in_ram2
add wave -noupdate -format Literal /ga_tb/u_bench/u11/mut_method
add wave -noupdate -format Literal /ga_tb/u_bench/u11/data_out_cross1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/data_out_cross2
add wave -noupdate -format Literal /ga_tb/u_bench/u11/cnt_parents
add wave -noupdate -format Logic /ga_tb/u_bench/u11/data_valid
add wave -noupdate -format Logic /ga_tb/u_bench/u11/next_gene
add wave -noupdate -format Logic /ga_tb/u_bench/u11/ga_fin
add wave -noupdate -format Logic /ga_tb/u_bench/u11/cross_out
add wave -noupdate -format Logic /ga_tb/u_bench/u11/valid
add wave -noupdate -format Logic /ga_tb/u_bench/u11/elite_null
add wave -noupdate -format Literal /ga_tb/u_bench/u11/index
add wave -noupdate -format Logic /ga_tb/u_bench/u11/mut_out
add wave -noupdate -format Logic /ga_tb/u_bench/u11/flag
add wave -noupdate -format Logic /ga_tb/u_bench/u11/decode
add wave -noupdate -format Logic /ga_tb/u_bench/u11/sel_out
add wave -noupdate -format Logic /ga_tb/u_bench/u11/term_out
add wave -noupdate -format Logic /ga_tb/u_bench/u11/run
add wave -noupdate -format Logic /ga_tb/u_bench/u11/run1
add wave -noupdate -format Logic /ga_tb/u_bench/u11/run2
add wave -noupdate -format Logic /ga_tb/u_bench/u11/run3
add wave -noupdate -format Logic /ga_tb/u_bench/u11/load
add wave -noupdate -format Literal /ga_tb/u_bench/u11/sreg
add wave -noupdate -format Literal /ga_tb/u_bench/u11/next_sreg
add wave -noupdate -format Logic /ga_tb/u_bench/u11/term_rd_p1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/data_out_cross1_p1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/data_out_cross2_p1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/temp1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/temp2
add wave -noupdate -format Literal /ga_tb/u_bench/u11/incr_p1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_offs
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_gen_p1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_offs_p1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_gen
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_sel_wr_p1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_sel_rd_p1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_parents_p1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_cross_offs_p1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_sel_wr
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_sel_rd
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_parents
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_cross_offs
add wave -noupdate -format Logic /ga_tb/u_bench/u11/dummy_cnt_adapt
add wave -noupdate -format Literal /ga_tb/u_bench/u11/notify_cnt
add wave -noupdate -format Literal /ga_tb/u_bench/u11/notify_cnt_p
add wave -noupdate -format Logic /ga_tb/u_bench/u11/cnt_adapted
add wave -noupdate -format Logic /ga_tb/u_bench/u11/ga_fin_r
add wave -noupdate -format Literal /ga_tb/u_bench/u11/incr
add wave -noupdate -format Logic /ga_tb/u_bench/u11/next_generation
add wave -noupdate -divider {FITNESS CALCULATION}
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u0/clk
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u0/rst_n
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u0/decode
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u0/valid
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u0/in_genes
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u0/gene_score
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u4/u0/fit
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u0/ready_out
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u0/gene_scr
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u4/u0/gene
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u0/max_fit
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u0/done
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u0/done_p
add wave -noupdate -divider {FIX ELITE}
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u1/clk
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u1/rst_n
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u1/decode
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u1/valid
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u1/elite_null
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u1/index
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u4/u1/fit
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u1/count_parents
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u1/ready_in
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u1/elite_offs
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u4/u1/fit_sum
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u1/max_fit
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u1/rd
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u4/u1/sum
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u4/u1/sum_p
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u4/u1/best_fit
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u4/u1/best_fit_prev_gen
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u1/temp1
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u1/temp2
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u1/elite_indexs
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u1/temp_indexs_1
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u1/temp_indexs_2
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u1/fin
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u1/count_cycle
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u1/counter
add wave -noupdate -divider {POPULATION RAM}
add wave -noupdate -format Literal /ga_tb/u_bench/u11/sreg
add wave -noupdate -format Literal /ga_tb/u_bench/u11/next_sreg
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u9/add
add wave -noupdate -format Logic /ga_tb/u_bench/u9/clk
add wave -noupdate -format Logic /ga_tb/u_bench/u9/rst_n
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u9/add
add wave -noupdate -format Literal /ga_tb/u_bench/u9/data_in
add wave -noupdate -format Literal /ga_tb/u_bench/u9/data_out
add wave -noupdate -format Logic /ga_tb/u_bench/u9/wr
add wave -noupdate -format Literal /ga_tb/u_bench/u9/data
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u9/data(0)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u9/data(1)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u9/data(2)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u9/data(3)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u9/data(4)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u9/data(5)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u9/data(6)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u9/data(7)
add wave -noupdate -divider {RNG SELECTION}
add wave -noupdate -format Logic /ga_tb/u_bench/u3/clk
add wave -noupdate -format Logic /ga_tb/u_bench/u3/rst_n
add wave -noupdate -format Logic /ga_tb/u_bench/u3/load
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u3/seed
add wave -noupdate -format Logic /ga_tb/u_bench/u3/run
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u3/parallel_out
add wave -noupdate -format Literal /ga_tb/u_bench/u3/taps
add wave -noupdate -divider SELECTION
add wave -noupdate -format Literal /ga_tb/u_bench/u11/sreg
add wave -noupdate -format Literal /ga_tb/u_bench/u11/next_sreg
add wave -noupdate -format Logic /ga_tb/u_bench/u5/clk
add wave -noupdate -format Logic /ga_tb/u_bench/u5/rst_n
add wave -noupdate -format Literal /ga_tb/u_bench/u5/ingene
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u5/rng
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u5/fitsum
add wave -noupdate -format Logic /ga_tb/u_bench/u5/data_valid
add wave -noupdate -format Logic /ga_tb/u_bench/u5/next_gene
add wave -noupdate -format Literal /ga_tb/u_bench/u5/sel_gene
add wave -noupdate -format Literal -radix binary /ga_tb/u_bench/u5/selparent
add wave -noupdate -format Logic /ga_tb/u_bench/u5/rd
add wave -noupdate -format Logic /ga_tb/u_bench/u5/rd_p1
add wave -noupdate -format Logic /ga_tb/u_bench/u5/temp_rd
add wave -noupdate -format Logic /ga_tb/u_bench/u5/done
add wave -noupdate -format Logic /ga_tb/u_bench/u5/done_t
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u5/cumsum_p1
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u5/scalfitsum
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u5/scalfitsum_p
add wave -noupdate -format Logic /ga_tb/u_bench/u5/count
add wave -noupdate -divider {PARENTS RAM}
add wave -noupdate -format Logic /ga_tb/u_bench/u10/clk
add wave -noupdate -format Logic /ga_tb/u_bench/u10/rst_n
add wave -noupdate -format Literal /ga_tb/u_bench/u10/add
add wave -noupdate -format Literal /ga_tb/u_bench/u10/data_in
add wave -noupdate -format Literal /ga_tb/u_bench/u10/data_out
add wave -noupdate -format Logic /ga_tb/u_bench/u10/wr
add wave -noupdate -format Literal /ga_tb/u_bench/u10/data
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(0)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(1)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(2)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(3)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(4)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(5)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(6)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(7)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(8)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(9)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(10)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(11)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(12)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(13)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(14)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(15)
add wave -noupdate -divider CROSSOVER
add wave -noupdate -format Logic /ga_tb/u_bench/u6/clk
add wave -noupdate -format Logic /ga_tb/u_bench/u6/rst_n
add wave -noupdate -format Logic /ga_tb/u_bench/u6/cont
add wave -noupdate -format Literal /ga_tb/u_bench/u6/crosspoints
add wave -noupdate -format Literal /ga_tb/u_bench/u6/crossmethod
add wave -noupdate -format Literal -radix binary /ga_tb/u_bench/u6/rng
add wave -noupdate -format Literal /ga_tb/u_bench/u6/ingene1
add wave -noupdate -format Literal /ga_tb/u_bench/u6/ingene2
add wave -noupdate -format Logic /ga_tb/u_bench/u6/rd
add wave -noupdate -format Literal /ga_tb/u_bench/u6/crossoffspr1
add wave -noupdate -format Literal /ga_tb/u_bench/u6/mask
add wave -noupdate -format Literal /ga_tb/u_bench/u6/mask1
add wave -noupdate -format Literal /ga_tb/u_bench/u6/mask2
add wave -noupdate -format Literal /ga_tb/u_bench/u6/temp
add wave -noupdate -format Literal /ga_tb/u_bench/u6/temp_int
add wave -noupdate -format Literal /ga_tb/u_bench/u6/temp1
add wave -noupdate -format Literal /ga_tb/u_bench/u6/temp2
add wave -noupdate -format Literal /ga_tb/u_bench/u6/crossout1
add wave -noupdate -format Logic /ga_tb/u_bench/u6/done
add wave -noupdate -divider MUTATION
add wave -noupdate -format Literal /ga_tb/u_bench/u11/sreg
add wave -noupdate -format Literal /ga_tb/u_bench/u11/next_sreg
add wave -noupdate -format Logic /ga_tb/u_bench/u7/clk
add wave -noupdate -format Logic /ga_tb/u_bench/u7/rst_n
add wave -noupdate -format Literal /ga_tb/u_bench/u7/mutpoint
add wave -noupdate -format Literal /ga_tb/u_bench/u7/mutmethod
add wave -noupdate -format Logic /ga_tb/u_bench/u7/cont
add wave -noupdate -format Logic /ga_tb/u_bench/u7/flag
add wave -noupdate -format Literal /ga_tb/u_bench/u7/rng
add wave -noupdate -format Literal /ga_tb/u_bench/u7/ingene
add wave -noupdate -format Logic /ga_tb/u_bench/u7/rd
add wave -noupdate -format Literal /ga_tb/u_bench/u7/mutoffspr
add wave -noupdate -format Literal /ga_tb/u_bench/u7/mutout
add wave -noupdate -format Literal /ga_tb/u_bench/u7/mutout_p1
add wave -noupdate -format Literal /ga_tb/u_bench/u7/count
add wave -noupdate -format Logic /ga_tb/u_bench/u7/done
add wave -noupdate -format Logic /ga_tb/u_bench/u7/done_p
add wave -noupdate -divider {MASK + MUT RNG}
add wave -noupdate -format Logic /ga_tb/u_bench/u1/clk
add wave -noupdate -format Logic /ga_tb/u_bench/u1/rst_n
add wave -noupdate -format Logic /ga_tb/u_bench/u1/load
add wave -noupdate -format Literal /ga_tb/u_bench/u1/seed
add wave -noupdate -format Logic /ga_tb/u_bench/u1/run
add wave -noupdate -format Literal /ga_tb/u_bench/u1/parallel_out
add wave -noupdate -format Literal /ga_tb/u_bench/u1/taps
add wave -noupdate -format Logic /ga_tb/clk
add wave -noupdate -format Logic /ga_tb/rst_n
add wave -noupdate -format Literal /ga_tb/best_gene
add wave -noupdate -format Literal /ga_tb/best_fit
add wave -noupdate -format Logic /ga_tb/fit_limit_reach
add wave -noupdate -format Logic /ga_tb/ga_fin
add wave -noupdate -format Literal /ga_tb/run_ga_i
add wave -noupdate -format Literal /ga_tb/seed_i
add wave -noupdate -format Literal /ga_tb/seed_1_i
add wave -noupdate -format Literal /ga_tb/seed_2_i
add wave -noupdate -format Literal /ga_tb/seed_3_i
add wave -noupdate -format Literal /ga_tb/crossmethod_i
add wave -noupdate -format Literal /ga_tb/mutmethod_i
add wave -noupdate -format Literal /ga_tb/elite_offs
add wave -noupdate -format Literal /ga_tb/max_fit
add wave -noupdate -format Logic /ga_tb/spy_next_generation
add wave -noupdate -format Literal /ga_tb/spy_elite
add wave -noupdate -format Literal /ga_tb/spy_max_fit
add wave -noupdate -format Literal /ga_tb/period
add wave -noupdate -divider {CONTROL BLOCK}
add wave -noupdate -format Logic /ga_tb/u_bench/u11/clk
add wave -noupdate -format Logic /ga_tb/u_bench/u11/rst_n
add wave -noupdate -format Logic /ga_tb/u_bench/u11/done
add wave -noupdate -format Logic /ga_tb/u_bench/u11/fit_eval_rd
add wave -noupdate -format Logic /ga_tb/u_bench/u11/sel_rd
add wave -noupdate -format Logic /ga_tb/u_bench/u11/cross_rd
add wave -noupdate -format Logic /ga_tb/u_bench/u11/mut_rd
add wave -noupdate -format Logic /ga_tb/u_bench/u11/term_rd
add wave -noupdate -format Logic /ga_tb/u_bench/u11/run_ga
add wave -noupdate -format Literal /ga_tb/u_bench/u11/elite_offs
add wave -noupdate -format Literal /ga_tb/u_bench/u11/data_in_ram2
add wave -noupdate -format Literal /ga_tb/u_bench/u11/mut_method
add wave -noupdate -format Literal /ga_tb/u_bench/u11/data_out_cross1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/data_out_cross2
add wave -noupdate -format Literal /ga_tb/u_bench/u11/cnt_parents
add wave -noupdate -format Logic /ga_tb/u_bench/u11/data_valid
add wave -noupdate -format Logic /ga_tb/u_bench/u11/next_gene
add wave -noupdate -format Logic /ga_tb/u_bench/u11/ga_fin
add wave -noupdate -format Logic /ga_tb/u_bench/u11/cross_out
add wave -noupdate -format Logic /ga_tb/u_bench/u11/valid
add wave -noupdate -format Logic /ga_tb/u_bench/u11/elite_null
add wave -noupdate -format Literal /ga_tb/u_bench/u11/index
add wave -noupdate -format Logic /ga_tb/u_bench/u11/mut_out
add wave -noupdate -format Logic /ga_tb/u_bench/u11/flag
add wave -noupdate -format Logic /ga_tb/u_bench/u11/decode
add wave -noupdate -format Logic /ga_tb/u_bench/u11/sel_out
add wave -noupdate -format Logic /ga_tb/u_bench/u11/term_out
add wave -noupdate -format Logic /ga_tb/u_bench/u11/run
add wave -noupdate -format Logic /ga_tb/u_bench/u11/run1
add wave -noupdate -format Logic /ga_tb/u_bench/u11/run2
add wave -noupdate -format Logic /ga_tb/u_bench/u11/run3
add wave -noupdate -format Logic /ga_tb/u_bench/u11/load
add wave -noupdate -format Literal /ga_tb/u_bench/u11/sreg
add wave -noupdate -format Literal /ga_tb/u_bench/u11/next_sreg
add wave -noupdate -format Logic /ga_tb/u_bench/u11/term_rd_p1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/data_out_cross1_p1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/data_out_cross2_p1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/temp1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/temp2
add wave -noupdate -format Literal /ga_tb/u_bench/u11/incr_p1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_offs
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_gen_p1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_offs_p1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_gen
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_sel_wr_p1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_sel_rd_p1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_parents_p1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_cross_offs_p1
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_sel_wr
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_sel_rd
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_parents
add wave -noupdate -format Literal /ga_tb/u_bench/u11/count_cross_offs
add wave -noupdate -format Logic /ga_tb/u_bench/u11/dummy_cnt_adapt
add wave -noupdate -format Literal /ga_tb/u_bench/u11/notify_cnt
add wave -noupdate -format Literal /ga_tb/u_bench/u11/notify_cnt_p
add wave -noupdate -format Logic /ga_tb/u_bench/u11/cnt_adapted
add wave -noupdate -format Logic /ga_tb/u_bench/u11/ga_fin_r
add wave -noupdate -format Literal /ga_tb/u_bench/u11/incr
add wave -noupdate -format Logic /ga_tb/u_bench/u11/next_generation
add wave -noupdate -divider {FITNESS CALCULATION}
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u0/clk
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u0/rst_n
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u0/decode
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u0/valid
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u0/in_genes
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u0/gene_score
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u4/u0/fit
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u0/ready_out
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u0/gene_scr
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u4/u0/gene
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u0/max_fit
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u0/done
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u0/done_p
add wave -noupdate -divider {FIX ELITE}
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u1/clk
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u1/rst_n
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u1/decode
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u1/valid
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u1/elite_null
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u1/index
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u4/u1/fit
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u1/count_parents
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u1/ready_in
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u1/elite_offs
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u4/u1/fit_sum
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u1/max_fit
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u1/rd
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u4/u1/sum
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u4/u1/sum_p
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u4/u1/best_fit
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u4/u1/best_fit_prev_gen
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u1/temp1
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u1/temp2
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u1/elite_indexs
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u1/temp_indexs_1
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u1/temp_indexs_2
add wave -noupdate -format Logic /ga_tb/u_bench/u4/u1/fin
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u1/count_cycle
add wave -noupdate -format Literal /ga_tb/u_bench/u4/u1/counter
add wave -noupdate -divider {POPULATION RAM}
add wave -noupdate -format Literal /ga_tb/u_bench/u11/sreg
add wave -noupdate -format Literal /ga_tb/u_bench/u11/next_sreg
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u9/add
add wave -noupdate -format Logic /ga_tb/u_bench/u9/clk
add wave -noupdate -format Logic /ga_tb/u_bench/u9/rst_n
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u9/add
add wave -noupdate -format Literal /ga_tb/u_bench/u9/data_in
add wave -noupdate -format Literal /ga_tb/u_bench/u9/data_out
add wave -noupdate -format Logic /ga_tb/u_bench/u9/wr
add wave -noupdate -format Literal /ga_tb/u_bench/u9/data
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u9/data(0)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u9/data(1)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u9/data(2)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u9/data(3)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u9/data(4)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u9/data(5)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u9/data(6)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u9/data(7)
add wave -noupdate -divider {RNG SELECTION}
add wave -noupdate -format Logic /ga_tb/u_bench/u3/clk
add wave -noupdate -format Logic /ga_tb/u_bench/u3/rst_n
add wave -noupdate -format Logic /ga_tb/u_bench/u3/load
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u3/seed
add wave -noupdate -format Logic /ga_tb/u_bench/u3/run
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u3/parallel_out
add wave -noupdate -format Literal /ga_tb/u_bench/u3/taps
add wave -noupdate -divider SELECTION
add wave -noupdate -format Literal /ga_tb/u_bench/u11/sreg
add wave -noupdate -format Literal /ga_tb/u_bench/u11/next_sreg
add wave -noupdate -format Logic /ga_tb/u_bench/u5/clk
add wave -noupdate -format Logic /ga_tb/u_bench/u5/rst_n
add wave -noupdate -format Literal /ga_tb/u_bench/u5/ingene
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u5/rng
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u5/fitsum
add wave -noupdate -format Logic /ga_tb/u_bench/u5/data_valid
add wave -noupdate -format Logic /ga_tb/u_bench/u5/next_gene
add wave -noupdate -format Literal /ga_tb/u_bench/u5/sel_gene
add wave -noupdate -format Literal -radix binary /ga_tb/u_bench/u5/selparent
add wave -noupdate -format Logic /ga_tb/u_bench/u5/rd
add wave -noupdate -format Logic /ga_tb/u_bench/u5/rd_p1
add wave -noupdate -format Logic /ga_tb/u_bench/u5/temp_rd
add wave -noupdate -format Logic /ga_tb/u_bench/u5/done
add wave -noupdate -format Logic /ga_tb/u_bench/u5/done_t
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u5/cumsum_p1
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u5/scalfitsum
add wave -noupdate -format Literal -radix unsigned /ga_tb/u_bench/u5/scalfitsum_p
add wave -noupdate -format Logic /ga_tb/u_bench/u5/count
add wave -noupdate -divider {PARENTS RAM}
add wave -noupdate -format Logic /ga_tb/u_bench/u10/clk
add wave -noupdate -format Logic /ga_tb/u_bench/u10/rst_n
add wave -noupdate -format Literal /ga_tb/u_bench/u10/add
add wave -noupdate -format Literal /ga_tb/u_bench/u10/data_in
add wave -noupdate -format Literal /ga_tb/u_bench/u10/data_out
add wave -noupdate -format Logic /ga_tb/u_bench/u10/wr
add wave -noupdate -format Literal /ga_tb/u_bench/u10/data
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(0)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(1)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(2)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(3)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(4)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(5)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(6)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(7)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(8)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(9)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(10)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(11)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(12)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(13)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(14)
add wave -noupdate -format Literal -height 15 /ga_tb/u_bench/u10/data(15)
add wave -noupdate -divider CROSSOVER
add wave -noupdate -format Logic /ga_tb/u_bench/u6/clk
add wave -noupdate -format Logic /ga_tb/u_bench/u6/rst_n
add wave -noupdate -format Logic /ga_tb/u_bench/u6/cont
add wave -noupdate -format Literal /ga_tb/u_bench/u6/crosspoints
add wave -noupdate -format Literal /ga_tb/u_bench/u6/crossmethod
add wave -noupdate -format Literal -radix binary /ga_tb/u_bench/u6/rng
add wave -noupdate -format Literal /ga_tb/u_bench/u6/ingene1
add wave -noupdate -format Literal /ga_tb/u_bench/u6/ingene2
add wave -noupdate -format Logic /ga_tb/u_bench/u6/rd
add wave -noupdate -format Literal /ga_tb/u_bench/u6/crossoffspr1
add wave -noupdate -format Literal /ga_tb/u_bench/u6/mask
add wave -noupdate -format Literal /ga_tb/u_bench/u6/mask1
add wave -noupdate -format Literal /ga_tb/u_bench/u6/mask2
add wave -noupdate -format Literal /ga_tb/u_bench/u6/temp
add wave -noupdate -format Literal /ga_tb/u_bench/u6/temp_int
add wave -noupdate -format Literal /ga_tb/u_bench/u6/temp1
add wave -noupdate -format Literal /ga_tb/u_bench/u6/temp2
add wave -noupdate -format Literal /ga_tb/u_bench/u6/crossout1
add wave -noupdate -format Logic /ga_tb/u_bench/u6/done
add wave -noupdate -divider MUTATION
add wave -noupdate -format Literal /ga_tb/u_bench/u11/sreg
add wave -noupdate -format Literal /ga_tb/u_bench/u11/next_sreg
add wave -noupdate -format Logic /ga_tb/u_bench/u7/clk
add wave -noupdate -format Logic /ga_tb/u_bench/u7/rst_n
add wave -noupdate -format Literal /ga_tb/u_bench/u7/mutpoint
add wave -noupdate -format Literal /ga_tb/u_bench/u7/mutmethod
add wave -noupdate -format Logic /ga_tb/u_bench/u7/cont
add wave -noupdate -format Logic /ga_tb/u_bench/u7/flag
add wave -noupdate -format Literal /ga_tb/u_bench/u7/rng
add wave -noupdate -format Literal /ga_tb/u_bench/u7/ingene
add wave -noupdate -format Logic /ga_tb/u_bench/u7/rd
add wave -noupdate -format Literal /ga_tb/u_bench/u7/mutoffspr
add wave -noupdate -format Literal /ga_tb/u_bench/u7/mutout
add wave -noupdate -format Literal /ga_tb/u_bench/u7/mutout_p1
add wave -noupdate -format Literal /ga_tb/u_bench/u7/count
add wave -noupdate -format Logic /ga_tb/u_bench/u7/done
add wave -noupdate -format Logic /ga_tb/u_bench/u7/done_p
add wave -noupdate -divider {MASK + MUT RNG}
add wave -noupdate -format Logic /ga_tb/u_bench/u1/clk
add wave -noupdate -format Logic /ga_tb/u_bench/u1/rst_n
add wave -noupdate -format Logic /ga_tb/u_bench/u1/load
add wave -noupdate -format Literal /ga_tb/u_bench/u1/seed
add wave -noupdate -format Logic /ga_tb/u_bench/u1/run
add wave -noupdate -format Literal /ga_tb/u_bench/u1/parallel_out
add wave -noupdate -format Literal /ga_tb/u_bench/u1/taps
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {17195000 ps} 0}
configure wave -namecolwidth 271
configure wave -valuecolwidth 40
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
WaveRestoreZoom {17143730 ps} {17246270 ps}
