-------------------------------------------------------------------------------
-- Title      : GA top
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : top.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 16/5/06
-- Last update: 16/11/06
-- Platform   : Modelsim 6.1c, Synplify 8.1, ISE 8.1
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This is the top structural block of the GA chip connecting
--              all the necessary components of the Genetic Algorithm together.
-------------------------------------------------------------------------------
-- Copyright (c) 2006 NTUA
-- Revisions  :
-- Date        Version  Author  Description
-- 16/05/06    1.1      kdelip  created
-- 16/11/06    1.2      kdelip  replace clocked process with delay_regs block 
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- LIBRARIES
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.dhga_pkg.all;
use work.arith_pkg.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity ga is
  generic (
    genom_lngt         : positive := 8;
    score_sz           : integer  := 9;
    scaling_factor_res : integer  := 4;
    pop_sz             : integer  := 8;
    elite              : integer  := 2;
    mr                 : integer  := 150;
    mut_res            : integer  := 8;
    fit_limit          : positive := 510;  -- (max. value is 2^score_sz -1)
    max_gen            : positive := 100);
  port (
    clk             : in  std_logic;
    rst_n           : in  std_logic;
    run_ga          : in  std_logic;
    seed            : in  std_logic_vector(genom_lngt -1 downto 0);  -- parallel seed input for rng 
    seed_1          : in  std_logic_vector(genom_lngt+mut_res-1 downto 0);  -- parallel seed input for rng1
    seed_2          : in  std_logic_vector(2*log2(genom_lngt)-1 downto 0);  -- parallel seed input for rng2
    seed_3          : in  std_logic_vector(scaling_factor_res-1 downto 0);  -- parallel seed input for rng3
    crossMethod     : in  std_logic_vector(1 downto 0);
    mutMethod       : in  std_logic_vector(1 downto 0);
    best_gene       : out std_logic_vector(genom_lngt -1 downto 0);
    best_fit        : out std_logic_vector(score_sz-1 downto 0);
    fit_limit_reach : out std_logic;
    ga_fin          : out std_logic);                     
end entity ga;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture str of ga is

-- SIGNAL DECLARATION
-------------------------------------------------------------------------------
  signal load_dummy           : std_logic;
  signal run                  : std_logic;
  signal run1                 : std_logic;
  signal run2                 : std_logic;
  signal run3                 : std_logic;
  signal out_rng_1_dummy      : std_logic_vector(genom_lngt+mut_res-1 downto 0);
  signal out_rng_2_dummy      : std_logic_vector(2*log2(genom_lngt)-1 downto 0);
  signal out_rng_3_dummy      : std_logic_vector(scaling_factor_res-1 downto 0);
  signal valid1               : std_logic;
  signal elite_null_dummy     : std_logic;
  signal index                : integer range 0 to pop_sz+1;
  signal elite_offs_dummy     : int_array(0 to elite-1);
  signal fit_eval_rd_dummy    : std_logic;
  signal inGene_fiteval_dummy : std_logic_vector(2*genom_lngt-1 downto 0);
  signal fit_sum_dummy        : std_logic_vector(score_sz+log2(pop_sz)-1 downto 0);
  signal max_fit_dummy        : std_logic_vector(score_sz-1 downto 0);
  signal decode_dummy         : std_logic;
  signal selection_rd_dummy   : std_logic;
  signal sel_out              : std_logic;
  signal data_valid_dummy     : std_logic;
  signal next_gene_dummy      : std_logic;
  signal cross_out            : std_logic;
  signal inGene1_cross_dummy  : std_logic_vector(genom_lngt-1 downto 0);
  signal inGene2_cross_dummy  : std_logic_vector(genom_lngt-1 downto 0);
  signal cross_rd_dummy       : std_logic;
  signal crossOffspr_dummy    : std_logic_vector(genom_lngt-1 downto 0);
  signal mut_out              : std_logic;
  signal mutation_rd_dummy    : std_logic;
  signal term_out             : std_logic;
  signal fitlim_rd_dummy      : std_logic_vector(0 downto 0);
  signal obs_rd_dummy         : std_logic;
  signal data_in_1_dummy      : std_logic_vector(genom_lngt+score_sz-1 downto 0);
  signal data_out_1_dummy     : std_logic_vector(genom_lngt+score_sz-1 downto 0);
  signal addr_1_dummy         : integer;
  signal addr_1_vec           : std_logic_vector(log2(pop_sz) downto 0);
  signal we1_dummy            : std_logic;
  signal data_in_2_dummy      : std_logic_vector(genom_lngt-1 downto 0);
  signal data_out_2_dummy     : std_logic_vector(genom_lngt-1 downto 0);
  signal addr_2_dummy         : integer;
  signal addr_2_vec           : std_logic_vector(log2(2*(pop_sz-elite)) downto 0);
  signal we2_dummy            : std_logic;
  signal flag_dummy           : std_logic;
  signal count_parents_dummy  : integer;
  signal best_gene_i          : std_logic_vector(genom_lngt -1 downto 0);
  signal best_fit_i           : std_logic_vector(score_sz-1 downto 0);
  signal ga_fin_i             : std_logic_vector(0 downto 0);
  signal ga_fin_i_vec         : std_logic_vector(0 downto 0);
  signal run_ga_i             : std_logic_vector(0 downto 0);
  signal run_ga_vec           : std_logic_vector(0 downto 0);
  signal seed_i               : std_logic_vector(genom_lngt -1 downto 0);
  signal seed_1_i             : std_logic_vector(genom_lngt+mut_res-1 downto 0);
  signal seed_2_i             : std_logic_vector(2*log2(genom_lngt)-1 downto 0);
  signal seed_3_i             : std_logic_vector(scaling_factor_res-1 downto 0);
  signal crossMethod_i        : std_logic_vector(1 downto 0);
  signal mutMethod_i          : std_logic_vector(1 downto 0);
  signal fit_limit_reach_vec  : std_logic_vector(0 downto 0);
  
begin

-- COMPONENTS INSTANTIATION

-------------------------------------------------------------------------------
-- RNG : feeds fitness evaluation with random genes in order to be evaluated 
--       and afterwards to be writen (together with their scores in RAM 1)
-------------------------------------------------------------------------------
  U0 : rng
    generic map (
      n => genom_lngt)                  -- length of pseudo-random sequence
    port map (
      clk          => clk,
      rst_n        => rst_n,            -- from control v4
      load         => load_dummy,       -- from control v4
      seed         => seed_i,           -- from chip port
      run          => run,              -- from control v4
      parallel_out => inGene_fiteval_dummy(2*genom_lngt-1 downto genom_lngt));  -- to fitness evaluation

-------------------------------------------------------------------------------
-- RNG1 : feeds mutation with a random mask and a random number of mut_res bits 
--        and crossover with a random mask 
-------------------------------------------------------------------------------
  U1 : rng
    generic map (
      n => genom_lngt+mut_res)           -- length of pseudo-random sequence
    port map (
      clk          => clk,
      rst_n        => rst_n,
      load         => load_dummy,        -- from control v4
      seed         => seed_1_i,          -- from chip port
      run          => run1,              -- from control v4
      parallel_out => out_rng_1_dummy);  -- to mutation and crossover

-------------------------------------------------------------------------------
-- RNG2 : feeds crossover with crossover points and mutation with mutation 
--        points
-------------------------------------------------------------------------------   
  U2 : rng
    generic map (
      n => 2*log2(genom_lngt))           -- length of pseudo-random sequence
    port map (
      clk          => clk,
      rst_n        => rst_n,
      load         => load_dummy,        -- from control v4
      seed         => seed_2_i,          -- from chip port
      run          => run2,              -- from control v4
      parallel_out => out_rng_2_dummy);  -- to crossover and mutation

-------------------------------------------------------------------------------
-- RNG3 : feeds selection block with random numbers
-------------------------------------------------------------------------------   
  
  U3 : rng
    generic map (
      n => scaling_factor_res)           -- length of pseudo-random sequence
    port map (
      clk          => clk,
      rst_n        => rst_n,
      load         => load_dummy,        -- from control v4
      seed         => seed_3_i,          -- from chip port
      run          => run3,              -- from control v4
      parallel_out => out_rng_3_dummy);  -- to selection

-------------------------------------------------------------------------------
-- Fitness Evaluation : evaluates genes and produces the gene's score, the sum 
--                      of fitnesses, the maximum fitness, the elite children'
--                      indexes and ready signals 
------------------------------------------------------------------------------- 
  U4 : fit_eval_ga
    generic map(
      genom_lngt => genom_lngt,
      score_sz   => score_sz,
      pop_sz     => pop_sz,
      elite      => elite)
    port map(
      clk           => clk,
      rst_n         => rst_n,
      decode        => decode_dummy,
      valid         => valid1,
      elite_null    => elite_null_dummy,
      in_genes      => inGene_fiteval_dummy,  -- from mutation and rng
      index         => index,                 -- from control
      count_parents => count_parents_dummy,
      gene_score    => data_in_1_dummy,       -- to RAM 1
      elite_offs    => elite_offs_dummy,      -- to control
      fit_sum       => fit_sum_dummy,         -- to selection 
      max_fit       => max_fit_dummy,         -- to observer 
      rd            => fit_eval_rd_dummy);    -- to control_v4

-------------------------------------------------------------------------------
-- Selection : selects new parents for the next generation 
------------------------------------------------------------------------------- 
  U5 : selection
    generic map(
      genom_lngt         => genom_lngt,
      pop_sz             => pop_sz,
      elite              => elite,
      score_sz           => score_sz,
      scaling_factor_res => scaling_factor_res)  --scaling factor resolution (bits)
    port map(
      clk        => clk,
      rst_n      => sel_out,
      inGene     => data_out_1_dummy,   -- comes from ram1
      rng        => out_rng_3_dummy,    -- comes from rng3
      fitSum     => fit_sum_dummy,      -- from fitness evaluation 
      data_valid => data_valid_dummy,   -- from control_v4 
      next_gene  => next_gene_dummy,
      selParent  => data_in_2_dummy,    -- will be written in RAM 2
      rd         => selection_rd_dummy);         -- to control_v4 

-------------------------------------------------------------------------------
-- Crossover : performs crossover algorithm on two selected parents
-------------------------------------------------------------------------------           
  U6 : crossover_v2
    generic map(
      genom_lngt => genom_lngt)
    port map(
      clk          => clk,
      rst_n        => rst_n,
      cont         => cross_out,
      crossPoints  => out_rng_2_dummy,  -- from rng 2
      crossMethod  => crossMethod_i,    -- from chip port
      rng          => out_rng_1_dummy(genom_lngt+mut_res-1 downto mut_res),  -- from rng 1
      inGene1      => inGene1_cross_dummy,  -- from control  
      inGene2      => inGene2_cross_dummy,  -- from control 
      rd           => cross_rd_dummy,   -- to control_v4 
      crossOffspr1 => crossOffspr_dummy);   -- to mutation

-------------------------------------------------------------------------------
-- Mutation : performs mutation algorithm on the "crossovered" offspring 
--            according to mutrate (mr) (mutation probability)
-------------------------------------------------------------------------------          
  U7 : mutation_v2
    generic map(
      genom_lngt => genom_lngt,
      mr         => mr,
      mut_res    => mut_res)
    port map(
      clk       => clk,
      rst_n     => rst_n,
      mutPoint  => out_rng_2_dummy(log2(genom_lngt)-1 downto 0),  -- from rng 2
      mutMethod => mutMethod_i,         -- from chip port
      cont      => mut_out,
      flag      => flag_dummy,
      rng       => out_rng_1_dummy,     -- from rng 1
      inGene    => crossOffspr_dummy,   -- from crossover   
      rd        => mutation_rd_dummy,   -- to control_v4
      mutOffspr => inGene_fiteval_dummy(genom_lngt-1 downto 0));  -- to fitness evaluation

-------------------------------------------------------------------------------
-- Observer : Observes if the algorithm has met one of the desired specs
-------------------------------------------------------------------------------   
  U8 : obs
    generic map(
      score_sz  => score_sz,
      fit_limit => fit_limit)
    port map(
      clk       => clk,
      rst_n     => term_out,
      max_fit   => max_fit_dummy,       -- from fitness evaluation
      fitlim_rd => fitlim_rd_dummy(0),  -- to control_v4
      rd        => obs_rd_dummy);  -- done signal in state machine (control_v4)    

-------------------------------------------------------------------------------
-- RAM 1 : write/reads genes and their scores (concatenated)
-------------------------------------------------------------------------------          
  U9 : spram
    generic map(
      add_width  => log2(pop_sz),
      data_width => genom_lngt+score_sz)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      add      => addr_1_vec,
      data_in  => data_in_1_dummy,      -- from fitness evaluation
      data_out => data_out_1_dummy,     -- to selection block
      wr       => we1_dummy);

-------------------------------------------------------------------------------
-- RAM 2 : writes/reads selected Parents
------------------------------------------------------------------------------- 
  U10 : spram
    generic map(
      add_width  => log2(2*(pop_sz-elite)),
      data_width => genom_lngt)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      add      => addr_2_vec,
      data_in  => data_in_2_dummy,      -- from selection
      data_out => data_out_2_dummy,     -- to control_v4  
      wr       => we2_dummy);

-------------------------------------------------------------------------------
-- control_v5 : controls all the signals of the design
------------------------------------------------------------------------------- 
  U11 : control_v5
    generic map(
      genom_lngt => genom_lngt,
      max_gen    => max_gen,
      pop_sz     => pop_sz,
      score_sz   => score_sz,
      elite      => elite)               
    port map(
      clk             => clk,
      rst_n           => rst_n,
      done            => fitlim_rd_dummy(0),
      fit_eval_rd     => fit_eval_rd_dummy,
      sel_rd          => selection_rd_dummy,
      cross_rd        => cross_rd_dummy,
      mut_rd          => mutation_rd_dummy,
      term_rd         => obs_rd_dummy,
      run_ga          => run_ga_i(0),
      elite_offs      => elite_offs_dummy,
      data_in_ram2    => data_out_2_dummy,
      mut_method      => mutMethod,
      data_out_cross1 => inGene1_cross_dummy,
      data_out_cross2 => inGene2_cross_dummy,
      addr_1_c        => addr_1_dummy,
      addr_2_c        => addr_2_dummy,
      cnt_parents     => count_parents_dummy,
      we1_c           => we1_dummy,
      we2_c           => we2_dummy,
      data_valid      => data_valid_dummy,
      next_gene       => next_gene_dummy,
      --clear           => clear_dummy,
      ga_fin          => ga_fin_i(0),
      cross_out       => cross_out,
      --eval              => eval,
      valid           => valid1,
      elite_null      => elite_null_dummy,
      index           => index,
      mut_out         => mut_out,
      flag            => flag_dummy,
      decode          => decode_dummy,
      sel_out         => sel_out,
      term_out        => term_out,
      --rng               => rng1,
      run             => run,
      run1            => run1,
      run2            => run2,
      run3            => run3,
      load            => load_dummy);
-------------------------------------------------------------------------------
-- Delay Registers
-------------------------------------------------------------------------------
  -- Registered outputs
  U12 : delay_regs
    generic map(
      width   => best_gene'length-1,
      latency => 1)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      in_data  => best_gene_i,
      out_data => best_gene);

  U13 : delay_regs
    generic map(
      width   => best_fit'length-1,
      latency => 1)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      in_data  => best_fit_i,
      out_data => best_fit);

  -- Registered inputs
  U14 : delay_regs
    generic map(
      width   => seed'length-1,
      latency => 1)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      in_data  => seed,
      out_data => seed_i);

  U15 : delay_regs
    generic map(
      width   => seed_1'length-1,
      latency => 1)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      in_data  => seed_1,
      out_data => seed_1_i);

  U16 : delay_regs
    generic map(
      width   => seed_2'length-1,
      latency => 1)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      in_data  => seed_2,
      out_data => seed_2_i);

  U17 : delay_regs
    generic map(
      width   => seed_3'length-1,
      latency => 1)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      in_data  => seed_3,
      out_data => seed_3_i);

  U18 : delay_regs
    generic map(
      width   => crossMethod'length-1,
      latency => 1)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      in_data  => crossMethod,
      out_data => crossMethod_i);

  U19 : delay_regs
    generic map(
      width   => mutMethod'length-1,
      latency => 1)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      in_data  => mutMethod,
      out_data => mutMethod_i);

  U20 : delay_regs
    generic map(
      width   => 0,
      latency => 1)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      in_data  => fitlim_rd_dummy,
      out_data => fit_limit_reach_vec);

  U21 : delay_regs
    generic map(
      width   => 0,
      latency => 1)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      in_data  => ga_fin_i,
      out_data => ga_fin_i_vec);

  U22 : delay_regs
    generic map(
      width   => 0,
      latency => 1)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      in_data  => run_ga_vec,
      out_data => run_ga_i);

  addr_2_vec      <= conv_std_logic_vector(addr_2_dummy, addr_2_vec'length);
  addr_1_vec      <= conv_std_logic_vector(addr_1_dummy, addr_1_vec'length);
  best_gene_i     <= data_out_1_dummy(genom_lngt+score_sz -1 downto score_sz);
  best_fit_i      <= max_fit_dummy;
  -- std_logic to std_logic_vector
  run_ga_vec(0)   <= run_ga;
  ga_fin          <= ga_fin_i_vec(0);
  fit_limit_reach <= fit_limit_reach_vec(0);

end architecture str;
