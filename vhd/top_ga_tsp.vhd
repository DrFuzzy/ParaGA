-------------------------------------------------------------------------------
-- Title      : GA
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : top.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 16/05/06
-- Last update: 08/11/06
-- Platform   : Modelsim, Synplicity, ISE
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This is the top structural block of the GA chip connecting
--              all the necessary components of the Genetic Algorithm together.
-------------------------------------------------------------------------------
-- Copyright (c) 2006 NTUA
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- LIBRARIES
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.dhga_pkg.all;
use work.rom_pkg.all;
use work.arith_pkg.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity ga_tsp is
  generic (
    genom_lngt         : positive := 21;
    score_sz           : integer  := 16;
    scaling_factor_res : integer  := 4;
    pop_sz             : integer  := 32;
    elite              : integer  := 2;
    num_towns          : integer  := 8;
    townres            : integer  := 3;
    mr                 : integer  := 100;
    mut_res            : integer  := 8;  -- max for mutation rate is 255
    max_gen            : positive := 50);
  port (
    clk       : in  std_logic;
    rst_n     : in  std_logic;
    --pool          : in  int_array(1 to num_towns-1); egine constant sto dhga_pkg
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
  signal index                : integer;
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
  --signal clear_dummy          : std_logic;
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
  signal ga_fin_i             : std_logic;
  signal run_ga               : std_logic;
  signal seed_1               : std_logic_vector(mut_res-1 downto 0);
  signal seed_2               : std_logic_vector(2*log2(num_towns)-1 downto 0);
  signal seed_3               : std_logic_vector(scaling_factor_res-1 downto 0);
  signal addr_rom_dummy       : integer;
  --signal addr_seed_dummy        : integer;
  

begin

-- COMPONENTS INSTANTIATION
-------------------------------------------------------------------------------
-- ROM : Stores initial generation for the TSP algorithm
-------------------------------------------------------------------------------

  U0 : init_generation_rom_p

    generic map(
      townres   => townres,
      pop_sz    => pop_sz,
      num_towns => num_towns)

    port map(
      addr     => addr_rom_dummy,
      data_out => inGene_fiteval_dummy(2*genom_lngt-1 downto genom_lngt)  -- to fitness evaluation
      ); 


-------------------------------------------------------------------------------
-- RNG1 : feeds mutation with a random mask and a random number of mut_res bits 
-------------------------------------------------------------------------------
  U1 : rng
    generic map (n => mut_res)          -- length of pseudo-random sequence

    port map (
      clk          => clk,
      rst_n        => rst_n,
      load         => load_dummy,         -- from control v4
      seed         => seed_1,             -- from chip port
      run          => run1,               -- from control v4
      parallel_out => out_rng_1_dummy     -- to mutation and crossover
      );
-------------------------------------------------------------------------------
-- RNG2 : feeds crossover with crossover points and mutation with mutation 
--        points
-------------------------------------------------------------------------------   
  U2 : rng
    generic map (n => 2*log2(num_towns))  -- length of pseudo-random sequence

    port map (
      clk          => clk,
      rst_n        => rst_n,
      load         => load_dummy,          -- from control v4
      seed         => seed_2,              -- from chip port
      run          => run2,                -- from control v4
      parallel_out => out_rng_2_dummy      -- to crossover and mutation
      );       
-------------------------------------------------------------------------------
-- RNG3 : feeds selection block with random numbers
-------------------------------------------------------------------------------   
  U3 : rng
    generic map (n => scaling_factor_res)  -- length of pseudo-random sequence

    port map (
      clk          => clk,
      rst_n        => rst_n,
      load         => load_dummy,       -- from control v4
      seed         => seed_3,           -- from chip port
      run          => run3,             -- from control v4
      parallel_out => out_rng_3_dummy   -- to selection
      );      
-------------------------------------------------------------------------------
-- Fitness Evaluation : evaluates genes and produces the gene's score, the sum 
--                      of fitnesses, the maximum fitness, the elite children'
--                      indexes and ready signals 
------------------------------------------------------------------------------- 
  U4 : fit_eval_tsp
    
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
      in_genes      => inGene_fiteval_dummy,  -- from mutation and rng
      elite_null    => elite_null_dummy,
      index         => index,                 -- from control
      count_parents => count_parents_dummy,
      gene_score    => data_in_1_dummy,       -- to RAM 1
      elite_offs    => elite_offs_dummy,      -- to control
      fit_sum       => fit_sum_dummy,         -- to selection 
      max_fit       => max_fit_dummy,         -- to observer 
      rd            => fit_eval_rd_dummy      -- to control_v4 
      );           
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
      rd         => selection_rd_dummy  -- to control_v4 
      );
-------------------------------------------------------------------------------
-- Crossover : performs crossover algorithm on two selected parents
-------------------------------------------------------------------------------           
  U6 : crossover_tsp
    generic map(genom_lngt => genom_lngt,
                num_towns  => num_towns)  

    
    port map(
      clk          => clk,
      rst_n        => rst_n,
      cont         => cross_out,
      crossPoints  => out_rng_2_dummy,      -- from rng 2
      inGene1      => inGene1_cross_dummy,  -- from control_v4  
      inGene2      => inGene2_cross_dummy,  -- from control_v4 
      --pool         => pool,                   -- from package
      rd           => cross_rd_dummy,       -- to control_v4 
      crossOffspr1 => crossOffspr_dummy     -- to mutation
      );

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
      mutPoint  => out_rng_2_dummy,     -- from rng 2
      cont      => mut_out,
      flag      => flag_dummy,
      rng       => out_rng_1_dummy,     -- from rng 1
      inGene    => crossOffspr_dummy,   -- from crossover   
      rd        => mutation_rd_dummy,   -- to control_v4
      mutOffspr => inGene_fiteval_dummy(genom_lngt-1 downto 0)  -- to fitness evaluation
      );

-------------------------------------------------------------------------------
-- RAM 1 : write/reads genes and their scores (concatenated)
-------------------------------------------------------------------------------          
  U8 : spram1

    generic map(
      add_width  => log2(pop_sz),
      data_width => genom_lngt+score_sz)

    port map(
      clk      => clk,
      rst_n    => rst_n,
      add      => addr_1_vec,         -- address (integer instead of std_vec)
      data_in  => data_in_1_dummy,      -- from fitness evaluation
      data_out => data_out_1_dummy,     -- to selection block
      wr       => we1_dummy
      );
-------------------------------------------------------------------------------
-- RAM 2 : writes/reads selected Parents
------------------------------------------------------------------------------- 
  U9 : spram1

    generic map(
      add_width  => log2(2*(pop_sz-elite)),
      data_width => genom_lngt)

    port map(
      clk      => clk,
      rst_n    => rst_n,
      add      => addr_2_vec,         -- address (integer instead of std_vec)
      data_in  => data_in_2_dummy,      -- from selection
      data_out => data_out_2_dummy,     -- to control_v4  
      wr       => we2_dummy
      );

-------------------------------------------------------------------------------
-- CONTROL (version 4) : controls all the signals of the design
------------------------------------------------------------------------------- 

  U10 : control_tsp

    generic map(
      genom_lngt => genom_lngt,
      max_gen    => max_gen,
      pop_sz     => pop_sz,
      score_sz   => score_sz,
      elite      => elite)               

    port map(
      clk         => clk,
      rst_n       => rst_n,
      fit_eval_rd => fit_eval_rd_dummy,
      sel_rd      => selection_rd_dummy,
      cross_rd    => cross_rd_dummy,
      mut_rd      => mutation_rd_dummy,
      run_ga      => run_ga,

      elite_offs      => elite_offs_dummy,
      data_in_ram2    => data_out_2_dummy,
      data_out_cross1 => inGene1_cross_dummy,
      data_out_cross2 => inGene2_cross_dummy,
      addr_1_c          => addr_1_dummy,
      addr_2_c          => addr_2_dummy,
      cnt_parents     => count_parents_dummy,
      we1_c             => we1_dummy,
      we2_c             => we2_dummy,
      data_valid      => data_valid_dummy,
      next_gene       => next_gene_dummy,
      --clear           => clear_dummy,
      ga_fin          => ga_fin_i,
      cross_out       => cross_out,
      --eval              => eval,
      valid           => valid1,
      elite_null      => elite_null_dummy,
      index           => index,
      mut_out         => mut_out,
      flag            => flag_dummy,
      decode          => decode_dummy,
      sel_out         => sel_out,
      --rng               => rng1,
      addr_rom        => addr_rom_dummy,  -- To ROM input (initial generation)
      --addr_seed         => addr_seed_dummy, -- To ROMs input (seeds)
      run1            => run1,
      run2            => run2,
      run3            => run3,
      load            => load_dummy

      );
----- ROMs for seeds store -------

-------------------------------------------------------------------------------
-- ROM : stores all the seeds for RNG 1
------------------------------------------------------------------------------- 
--U12 : seed1_rom_p

--  generic map (mutres  => mutres)
--  port map(
--        addr     => addr_seed_dummy,
--      data_out => seed_1_i);

-------------------------------------------------------------------------------
-- ROM : stores all the seeds for RNG 2
-------------------------------------------------------------------------------    
--U13 : seed2_rom_p

--  generic map(townres  => townres)
--  port map(
--      addr     => addr_seed_dummy,
--      data_out => seed_2_i);

-------------------------------------------------------------------------------
-- ROM : stores all the seeds for RNG 3
-------------------------------------------------------------------------------         
--U14 : seed3_rom_p

--  generic map(scaling_factor_res => scaling_factor_res)
--  port map(
--      addr     => addr_seed_dummy,
--      data_out => seed_3_i);

-------------------------------------------------------------------------------
-- Delay Registers : Delay for one clock every input and output (seeds included)
-------------------------------------------------------------------------------
----- Registered outputs -------

  U11 : delay_regs
    generic map(
      width   => best_gene'length,
      latency => 1)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      in_data  => best_gene_i,
      out_data => best_gene
      );

  U12 : delay_regs
    generic map(
      width   => best_fit'length,
      latency => 1)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      in_data  => best_fit_i,
      out_data => best_fit
      );

---- Registered inputs -------

  U13 : delay_regs
    generic map(
      width   => seed_1_i'length,
      latency => 1)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      in_data  => seed_1_i,
      out_data => seed_1
      );

  U14 : delay_regs
    generic map(
      width   => seed_2_i'length,
      latency => 1)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      in_data  => seed_2_i,
      out_data => seed_2
      );

  U15 : delay_regs
    generic map(
      width   => seed_3_i'length,
      latency => 1)
    port map(
      clk      => clk,
      rst_n    => rst_n,
      in_data  => seed_3_i,
      out_data => seed_3
      );

  process (clk, rst_n)
  begin
    if (rst_n = '0') then
      ga_fin <= '0';
      run_ga <= '0';
    elsif clk = '1' and clk'event then
      ga_fin <= ga_fin_i;
      run_ga <= run_ga_i;
    end if;
  end process;
  
  addr_2_vec        <= conv_std_logic_vector(addr_2_dummy, addr_2_vec'length);
  addr_1_vec        <= conv_std_logic_vector(addr_1_dummy, addr_1_vec'length);
  best_gene_i <= data_out_1_dummy(genom_lngt+score_sz -1 downto score_sz);
  best_fit_i  <= max_fit_dummy;

end architecture str;
