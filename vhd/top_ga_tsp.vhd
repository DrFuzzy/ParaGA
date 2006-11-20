-------------------------------------------------------------------------------
-- Title      : GA for TSP
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : ga_tsp.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 16/05/06
-- Last update: 20/11/06
-- Platform   : Modelsim 6.1c, Synplify 8.1, ISE 8.1
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This is the top structural block of the GA chip connecting
--              all the necessary components of the Genetic Algorithm together.
-------------------------------------------------------------------------------
-- Copyright (c) 2006 NTUA/IRAL
-------------------------------------------------------------------------------
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
use work.ga_pkg.all;
use work.rom_pkg.all;
use work.arith_pkg.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity ga_tsp is
  generic (
    genom_lngt         : positive := 21;
    score_sz           : integer  := 10;
    scaling_factor_res : integer  := 4;
    pop_sz             : integer  := 8;
    elite              : integer  := 2;
    num_towns          : integer  := 8;
    townres            : integer  := 3;
    mr                 : integer  := 150;
    mut_res            : integer  := 8;  -- max for mutation rate is 255
    max_gen            : positive := 300);
  port (
    clk       : in  std_logic;
    rst_n     : in  std_logic;
    run_ga_i  : in  std_logic;
    seed_1_i  : in  std_logic_vector(mut_res-1 downto 0);
    seed_2_i  : in  std_logic_vector(2*log2(num_towns)-1 downto 0);
    seed_3_i  : in  std_logic_vector(scaling_factor_res-1 downto 0);
    best_gene : out std_logic_vector(genom_lngt-1 downto 0);
    best_fit  : out std_logic_vector(score_sz-1 downto 0);
    ga_fin    : out std_logic);                     
end entity ga_tsp;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture str of ga_tsp is

-- SIGNAL DECLARATION
-------------------------------------------------------------------------------
  signal load_dummy           : std_logic;
  signal run1                 : std_logic;
  signal run2                 : std_logic;
  signal run3                 : std_logic;
  signal out_rng_1_dummy      : std_logic_vector(mut_res-1 downto 0);
  signal out_rng_2_dummy      : std_logic_vector(2*log2(num_towns)-1 downto 0);
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
  signal run_ga               : std_logic_vector(0 downto 0);
  signal run_ga_i_vec         : std_logic_vector(0 downto 0);
  signal seed_1               : std_logic_vector(mut_res-1 downto 0);
  signal seed_2               : std_logic_vector(2*log2(num_towns)-1 downto 0);
  signal seed_3               : std_logic_vector(scaling_factor_res-1 downto 0);
  signal addr_rom_dummy       : integer;

begin

-- COMPONENTS INSTANTIATION
-------------------------------------------------------------------------------
-- ROM : Stores initial generation for the TSP algorithm
-------------------------------------------------------------------------------
  U0 : init_generation_rom
    generic map(
      townres   => townres,
      pop_sz    => pop_sz,
      num_towns => num_towns)
    port map(
      addr     => addr_rom_dummy,
      data_out => inGene_fiteval_dummy(2*genom_lngt-1 downto genom_lngt));  -- to fitness evaluation

-------------------------------------------------------------------------------
-- RNG1 : feeds mutation with a random mask and a random number of mut_res bits 
-------------------------------------------------------------------------------
  U1 : rng_128
    generic map (n => mut_res)          -- length of pseudo-random sequence

    port map (
      clk          => clk,
      rst_n        => rst_n,
      load         => load_dummy,
      seed         => seed_1,
      run          => run1,
      parallel_out => out_rng_1_dummy);  

-------------------------------------------------------------------------------
-- RNG2 : feeds crossover with crossover points and mutation with mutation 
--        points
-------------------------------------------------------------------------------   
  U2 : rng_128
    generic map (n => 2*log2(num_towns))  -- length of pseudo-random sequence

    port map (
      clk          => clk,
      rst_n        => rst_n,
      load         => load_dummy,
      seed         => seed_2,
      run          => run2,
      parallel_out => out_rng_2_dummy);  

-------------------------------------------------------------------------------
-- RNG3 : feeds selection block with random numbers
-------------------------------------------------------------------------------   
  U3 : rng_128
    generic map (n => scaling_factor_res)  -- length of pseudo-random sequence

    port map (
      clk          => clk,
      rst_n        => rst_n,
      load         => load_dummy,
      seed         => seed_3,
      run          => run3,
      parallel_out => out_rng_3_dummy); 

-------------------------------------------------------------------------------
-- Fitness Evaluation : evaluates genes and produces the gene's score, the sum 
--                      of fitnesses, the maximum fitness, the elite children'
--                      indexes and ready signals 
------------------------------------------------------------------------------- 
  U4 : fitness_eval_tsp
    generic map(
      genom_lngt => genom_lngt,
      score_sz   => score_sz,
      pop_sz     => pop_sz,
      elite      => elite,
      townres    => townres,
      num_towns  => num_towns)  
    port map(
      clk           => clk,
      rst_n         => rst_n,
      decode        => decode_dummy,
      valid         => valid1,
      in_genes      => inGene_fiteval_dummy,
      elite_null    => elite_null_dummy,
      index         => index,
      count_parents => count_parents_dummy,
      gene_score    => data_in_1_dummy,
      elite_offs    => elite_offs_dummy,
      fit_sum       => fit_sum_dummy,
      max_fit       => max_fit_dummy,
      rd            => fit_eval_rd_dummy);   

-------------------------------------------------------------------------------
-- Selection : selects new parents for the next generation 
------------------------------------------------------------------------------- 
  U5 : selection
    generic map(
      genom_lngt         => genom_lngt,
      pop_sz             => pop_sz,
      elite              => elite,
      score_sz           => score_sz,
      scaling_factor_res => scaling_factor_res) 
    port map(
      clk        => clk,
      rst_n      => sel_out,
      inGene     => data_out_1_dummy,
      rng        => out_rng_3_dummy,
      fitSum     => fit_sum_dummy,
      data_valid => data_valid_dummy,
      next_gene  => next_gene_dummy,
      selParent  => data_in_2_dummy,
      rd         => selection_rd_dummy);

-------------------------------------------------------------------------------
-- Crossover : performs crossover algorithm on two selected parents
-------------------------------------------------------------------------------           
  U6 : crossover_tsp
    generic map(
      genom_lngt => genom_lngt,
      num_towns  => num_towns)  
    port map(
      clk          => clk,
      rst_n        => rst_n,
      cont         => cross_out,
      crossPoints  => out_rng_2_dummy,
      inGene1      => inGene1_cross_dummy,
      inGene2      => inGene2_cross_dummy,
      rd           => cross_rd_dummy,
      crossOffspr1 => crossOffspr_dummy);  

-------------------------------------------------------------------------------
-- Mutation : performs mutation algorithm on the "crossovered" offspring 
--            according to mutrate (mr) (mutation probability)
-------------------------------------------------------------------------------          
  U7 : mutation_tsp
    generic map(
      genom_lngt => genom_lngt,
      mr         => mr,
      mut_res    => mut_res,
      num_towns  => num_towns)
    port map(
      clk       => clk,
      rst_n     => rst_n,
      mutPoint  => out_rng_2_dummy,
      cont      => mut_out,
      flag      => flag_dummy,
      rng       => out_rng_1_dummy,
      inGene    => crossOffspr_dummy,
      rd        => mutation_rd_dummy,
      mutOffspr => inGene_fiteval_dummy(genom_lngt-1 downto 0));

-------------------------------------------------------------------------------
-- RAM 1 : write/reads genes and their scores (concatenated)
-------------------------------------------------------------------------------          
  U8 : spram
    generic map(
      add_width  => log2(pop_sz),
      data_width => genom_lngt+score_sz)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      add      => addr_1_vec,
      data_in  => data_in_1_dummy,
      data_out => data_out_1_dummy,
      wr       => we1_dummy);

-------------------------------------------------------------------------------
-- RAM 2 : writes/reads selected Parents
------------------------------------------------------------------------------- 
  U9 : spram
    generic map(
      add_width  => log2(2*(pop_sz-elite)),
      data_width => genom_lngt)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      add      => addr_2_vec,
      data_in  => data_in_2_dummy,
      data_out => data_out_2_dummy,
      wr       => we2_dummy);

-------------------------------------------------------------------------------
-- control_tsp : controls all the signals of the design
------------------------------------------------------------------------------- 
  U10 : control_tsp
    generic map(
      genom_lngt => genom_lngt,
      max_gen    => max_gen,
      pop_sz     => pop_sz,
      score_sz   => score_sz,
      elite      => elite)               
    port map(
      clk             => clk,
      rst_n           => rst_n,
      fit_eval_rd     => fit_eval_rd_dummy,
      sel_rd          => selection_rd_dummy,
      cross_rd        => cross_rd_dummy,
      mut_rd          => mutation_rd_dummy,
      run_ga          => run_ga(0),
      elite_offs      => elite_offs_dummy,
      data_in_ram2    => data_out_2_dummy,
      data_out_cross1 => inGene1_cross_dummy,
      data_out_cross2 => inGene2_cross_dummy,
      addr_1_c        => addr_1_dummy,
      addr_2_c        => addr_2_dummy,
      cnt_parents     => count_parents_dummy,
      we1_c           => we1_dummy,
      we2_c           => we2_dummy,
      data_valid      => data_valid_dummy,
      next_gene       => next_gene_dummy,
      ga_fin          => ga_fin_i(0),
      cross_out       => cross_out,
      valid           => valid1,
      elite_null      => elite_null_dummy,
      index           => index,
      mut_out         => mut_out,
      flag            => flag_dummy,
      decode          => decode_dummy,
      sel_out         => sel_out,
      addr_rom        => addr_rom_dummy,
      run1            => run1,
      run2            => run2,
      run3            => run3,
      load            => load_dummy);

-------------------------------------------------------------------------------
-- Delay Registers
-------------------------------------------------------------------------------
  -- Registered outputs
  U11 : delay_regs
    generic map(
      width   => best_gene'length-1,
      latency => 1)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      in_data  => best_gene_i,
      out_data => best_gene);

  U12 : delay_regs
    generic map(
      width   => best_fit'length-1,
      latency => 1)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      in_data  => best_fit_i,
      out_data => best_fit);

  -- Registered inputs
  U13 : delay_regs
    generic map(
      width   => seed_1_i'length-1,
      latency => 1)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      in_data  => seed_1_i,
      out_data => seed_1);

  U14 : delay_regs
    generic map(
      width   => seed_2_i'length-1,
      latency => 1)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      in_data  => seed_2_i,
      out_data => seed_2);

  U15 : delay_regs
    generic map(
      width   => seed_3_i'length-1,
      latency => 1)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      in_data  => seed_3_i,
      out_data => seed_3);

  U16 : delay_regs
    generic map(
      width   => 0,
      latency => 1)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      in_data  => ga_fin_i,
      out_data => ga_fin_i_vec);

  U17 : delay_regs
    generic map(
      width   => 0,
      latency => 1)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      in_data  => run_ga_i_vec,
      out_data => run_ga);

  addr_2_vec      <= conv_std_logic_vector(addr_2_dummy, addr_2_vec'length);
  addr_1_vec      <= conv_std_logic_vector(addr_1_dummy, addr_1_vec'length);
  best_gene_i     <= data_out_1_dummy(genom_lngt+score_sz -1 downto score_sz);
  best_fit_i      <= max_fit_dummy;
  -- std_logic to std_logic_vector
  run_ga_i_vec(0) <= run_ga_i;
  ga_fin          <= ga_fin_i_vec(0);

end architecture str;
