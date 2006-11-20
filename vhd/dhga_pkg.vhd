--------------------------------------------------------------------------------
-- Title      : Genetic Algorithm Package
-- Project    : Genetic Algorithm
--------------------------------------------------------------------------------
-- File       : ga_pkg.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos (kdelip@mail.ntua.gr)
-- Company    : NTUA/IRAL
-- Created    : 23/03/06
-- Last update: 20/11/06
-- Platform   : Modelsim 6.1c, Synplicity 8.1, ISE 8.1
-- Standard   : VHDL'93
--------------------------------------------------------------------------------
-- Description: The package contains all constant declarations that are mapped
--              on the generics.
--              Moreover it contains all the component declarations. This is
--              is to avoid component declaration in the architecture when a
--              component need to be instantiated.
--------------------------------------------------------------------------------
-- Copyright (c) 2006 NTUA
--------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 23/03/06    1.1      kdelip  Created
-- 16/11/06    1.2      kdelip  Update delay_regs (width-1 -> width) and all
--                              necessary signals. Add rng_128 component
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- LIBRARIES
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
library work;
use work.arith_pkg.all;

--------------------------------------------------------------------------------
-- PACKAGE DECLARATION
--------------------------------------------------------------------------------
package ga_pkg is

-- CONSTANTS DECLARATION
--------------------------------------------------------------------------------
  type int_array is array (integer range <>) of integer;

  constant pool : int_array(1 to 7) := (1, 2, 3, 4, 5, 6, 7);


-- COMPONENTS DECLARATION
--------------------------------------------------------------------------------

  -- Random Number Generator
  component rng is
    generic(
      n : positive);                    -- length of pseudo-random sequence
    port (
      clk          : in  std_logic;     -- clock
      rst_n        : in  std_logic;     -- reset (active low)
      load         : in  std_logic;     -- load (active high)
      seed         : in  std_logic_vector(n-1 downto 0);
      run          : in  std_logic;
      parallel_out : out std_logic_vector(n-1 downto 0));  -- parallel data out
  end component rng;

  component rng_128 is
    generic(
      n : positive);                    -- length of pseudo-random sequence
    port (
      clk          : in  std_logic;     -- clock
      rst_n        : in  std_logic;     -- reset (active low)
      load         : in  std_logic;     -- load (active high)
      seed         : in  std_logic_vector(n-1 downto 0);
      run          : in  std_logic;
      parallel_out : out std_logic_vector(n-1 downto 0));  -- parallel data out
  end component rng_128;

  component fitness_calc is
    generic(
      genom_lngt : positive;
      score_sz   : integer;
      pop_sz     : positive);  
    port (
      clk        : in  std_logic;       -- clock
      rst_n      : in  std_logic;       -- reset (active low)
      decode     : in  std_logic;
      valid      : in  std_logic;
      in_genes   : in  std_logic_vector(2*genom_lngt-1 downto 0);
      gene_score : out std_logic_vector(genom_lngt+score_sz-1 downto 0);
      fit        : out std_logic_vector(score_sz-1 downto 0) := (others => '0');
      ready_out  : out std_logic);
  end component fitness_calc;

  component fix_elite is
    generic(
      genom_lngt : positive;
      score_sz   : integer;
      pop_sz     : positive;
      elite      : positive);  
    port (
      clk           : in  std_logic;    -- clock
      rst_n         : in  std_logic;    -- reset (active low)
      decode        : in  std_logic;
      valid         : in  std_logic;
      elite_null    : in  std_logic;
      index         : in  integer;
      fit           : in  std_logic_vector(score_sz-1 downto 0);
      count_parents : in  integer;
      ready_in      : in  std_logic;
      elite_offs    : out int_array(0 to elite-1);
      fit_sum       : out std_logic_vector(score_sz+log2(pop_sz)-1 downto 0);
      max_fit       : out std_logic_vector(score_sz-1 downto 0);
      rd            : out std_logic);
  end component fix_elite;

  component fit_eval_ga is
    generic (
      genom_lngt : positive;            -- townres*(num_towns-1)
      score_sz   : integer;
      pop_sz     : integer;
      elite      : integer);
    port (
      clk           : in  std_logic;
      rst_n         : in  std_logic;
      decode        : in  std_logic;
      valid         : in  std_logic;
      in_genes      : in  std_logic_vector(2*genom_lngt-1 downto 0);
      elite_null    : in  std_logic;
      index         : in  integer;
      count_parents : in  integer;
      gene_score    : out std_logic_vector(genom_lngt+score_sz-1 downto 0);
      elite_offs    : out int_array(0 to elite-1);
      fit_sum       : out std_logic_vector(score_sz+log2(pop_sz)-1 downto 0);
      max_fit       : out std_logic_vector(score_sz-1 downto 0);
      rd            : out std_logic);
  end component fit_eval_ga;

  component selection is
    generic(
      genom_lngt         : positive;
      pop_sz             : positive;
      elite              : integer;
      score_sz           : integer;
      scaling_factor_res : integer);   
    port (
      clk        : in  std_logic;       -- clock
      rst_n      : in  std_logic;       -- reset (active low)
      inGene     : in  std_logic_vector(genom_lngt+score_sz-1 downto 0);
      rng        : in  std_logic_vector(scaling_factor_res-1 downto 0);
      fitSum     : in  std_logic_vector(score_sz+log2(pop_sz)-1 downto 0);
      data_valid : in  std_logic;
      next_gene  : in  std_logic;
      selParent  : out std_logic_vector(genom_lngt-1 downto 0);
      rd         : out std_logic); 
  end component selection;

  component mutation is
    generic(
      genom_lngt : positive;
      mr         : integer;
      mut_res    : integer);                
    port (
      clk       : in  std_logic;        -- clock
      rst_n     : in  std_logic;        -- reset (active low)
      mutPoint  : in  std_logic_vector(log2(genom_lngt)-1 downto 0);
      mutMethod : in  std_logic_vector(1 downto 0);
      cont      : in  std_logic;
      flag      : in  std_logic;
      rng       : in  std_logic_vector(genom_lngt+mut_res-1 downto 0);
      inGene    : in  std_logic_vector(genom_lngt-1 downto 0);
      rd        : out std_logic;
      mutOffspr : out std_logic_vector(genom_lngt-1 downto 0));  
  end component mutation;

  component crossover is
    generic(
      genom_lngt : positive);
    port (
      clk          : in  std_logic;     -- clock
      rst_n        : in  std_logic;     -- reset (active low)
      cont         : in  std_logic;
      crossPoints  : in  std_logic_vector(2*log2(genom_lngt)-1 downto 0);
      crossMethod  : in  std_logic_vector(1 downto 0);
      rng          : in  std_logic_vector(genom_lngt-1 downto 0);
      inGene1      : in  std_logic_vector(genom_lngt-1 downto 0);
      inGene2      : in  std_logic_vector(genom_lngt-1 downto 0);
      rd           : out std_logic;
      crossOffspr1 : out std_logic_vector(genom_lngt-1 downto 0));
  end component crossover;

  component spram is
    generic (
      add_width  : integer;
      data_width : integer);
    port (
      clk      : in  std_logic;         -- write clock
      rst_n    : in  std_logic;         -- system reset
      add      : in  std_logic_vector(add_width downto 0);
      data_in  : in  std_logic_vector(data_width -1 downto 0);
      data_out : out std_logic_vector(data_width -1 downto 0);
      wr       : in  std_logic);        -- read/write enable
  end component spram;

  component obs is
    generic(
      score_sz  : positive;
      fit_limit : positive);  
    port (clk       : in  std_logic;    -- clock
          rst_n     : in  std_logic;    -- reset (active low)
          max_fit   : in  std_logic_vector(score_sz-1 downto 0);
          fitlim_rd : out std_logic;
          rd        : out std_logic);
  end component obs;

  component control is
    generic(
      genom_lngt : integer;
      max_gen    : positive;
      pop_sz     : integer;
      score_sz   : integer;
      elite      : integer); 
    port (
      clk             : in  std_logic;
      rst_n           : in  std_logic;
      done            : in  std_logic;
      fit_eval_rd     : in  std_logic;
      sel_rd          : in  std_logic;
      cross_rd        : in  std_logic;
      mut_rd          : in  std_logic;
      term_rd         : in  std_logic;
      run_ga          : in  std_logic;
      elite_offs      : in  int_array(0 to elite-1);
      data_in_ram2    : in  std_logic_vector(genom_lngt-1 downto 0);
      mut_method      : in  std_logic_vector(1 downto 0);
      data_out_cross1 : out std_logic_vector(genom_lngt-1 downto 0);
      data_out_cross2 : out std_logic_vector(genom_lngt-1 downto 0);
      addr_1_c        : out integer;
      addr_2_c        : out integer;
      cnt_parents     : out integer;
      we1_c           : out std_logic;
      we2_c           : out std_logic;
      data_valid      : out std_logic;
      next_gene       : out std_logic;
      ga_fin          : out std_logic;
      cross_out       : out std_logic;
      valid           : out std_logic;
      elite_null      : out std_logic;
      index           : out integer range 0 to pop_sz+1;
      mut_out         : out std_logic;
      flag            : out std_logic;
      decode          : out std_logic;
      sel_out         : out std_logic;
      term_out        : out std_logic;
      run             : out std_logic;
      run1            : out std_logic;
      run2            : out std_logic;
      run3            : out std_logic;
      load            : out std_logic);
  end component control;

  component delay_regs is
    generic (
      width   : integer;                -- data width
      latency : integer);               -- number of delay elements
    port (
      clk      : in  std_logic;         -- clock
      rst_n    : in  std_logic;         -- reset (active low)
      in_data  : in  std_logic_vector(width downto 0);   -- input data
      out_data : out std_logic_vector(width downto 0));  -- ouput data
  end component delay_regs;

--------------------------------------------------------------------------------
-- Components for TSP problem evaluation
--------------------------------------------------------------------------------

  component crossover_TSP is
    generic(
      genom_lngt : positive;
      num_towns  : positive);
    port (
      clk          : in  std_logic;     -- clock
      rst_n        : in  std_logic;     -- reset (active low)
      cont         : in  std_logic;
      crossPoints  : in  std_logic_vector(2*log2(num_towns)-1 downto 0);
      inGene1      : in  std_logic_vector(genom_lngt-1 downto 0);
      inGene2      : in  std_logic_vector(genom_lngt-1 downto 0);
      rd           : out std_logic;
      crossOffspr1 : out std_logic_vector(genom_lngt-1 downto 0));
  end component crossover_TSP;

  component mutation_tsp is
    generic(
      genom_lngt : positive;
      mr         : integer;
      mut_res    : integer;
      num_towns  : integer);          
    port (
      clk       : in  std_logic;        -- clock
      rst_n     : in  std_logic;        -- reset (active low)
      mutPoint  : in  std_logic_vector(2*log2(num_towns)-1 downto 0);
      cont      : in  std_logic;
      flag      : in  std_logic;
      rng       : in  std_logic_vector(mut_res-1 downto 0);
      inGene    : in  std_logic_vector(genom_lngt-1 downto 0);
      rd        : out std_logic;
      mutOffspr : out std_logic_vector(genom_lngt-1 downto 0));  
  end component mutation_tsp;

  component fit_calc_tsp is
    generic(
      genom_lngt : positive;
      score_sz   : integer;
      pop_sz     : positive;
      townres    : positive;
      num_towns  : positive);  
    port (
      clk        : in  std_logic;       -- clock
      rst_n      : in  std_logic;       -- reset (active low)
      decode     : in  std_logic;
      valid      : in  std_logic;
      in_genes   : in  std_logic_vector(2*genom_lngt-1 downto 0);
      data_in    : in  std_logic_vector(2*townres-1 downto 0);
      gene_score : out std_logic_vector(genom_lngt+score_sz-1 downto 0);
      fit        : out std_logic_vector(score_sz-1 downto 0) := (others => '0');
      addr_rom   : out integer;
      ready_out  : out std_logic);
  end component fit_calc_tsp;

  component fix_elite_tsp is
    generic(
      genom_lngt : positive;
      score_sz   : integer;
      pop_sz     : positive;
      elite      : positive);  
    port (
      clk           : in  std_logic;    -- clock
      rst_n         : in  std_logic;    -- reset (active low)
      decode        : in  std_logic;
      valid         : in  std_logic;
      elite_null    : in  std_logic;
      index         : in  integer;
      fit           : in  std_logic_vector(score_sz-1 downto 0);
      count_parents : in  integer;
      ready_in      : in  std_logic;
      elite_offs    : out int_array(0 to elite-1);
      fit_sum       : out std_logic_vector(score_sz+log2(pop_sz)-1 downto 0);
      max_fit       : out std_logic_vector(score_sz-1 downto 0);
      rd            : out std_logic);
  end component fix_elite_tsp;

  component coordinates_rom is
    generic (
      townres : integer;
      pop_sz  : integer);
    port (
      addr     : in  integer;
      data_out : out std_logic_vector(2*townres-1 downto 0));
  end component coordinates_rom;

  component init_generation_rom is
    generic (
      townres   : integer;
      pop_sz    : integer;
      num_towns : integer);
    port (
      addr     : in  integer;
      data_out : out std_logic_vector((num_towns-1)*townres-1 downto 0)); 
  end component init_generation_rom;

  component fit_eval_tsp is
    generic (
      genom_lngt : positive;
      score_sz   : integer;
      pop_sz     : integer;
      elite      : integer;
      townres    : integer;
      num_towns  : integer);
    port (
      clk           : in  std_logic;
      rst_n         : in  std_logic;
      decode        : in  std_logic;
      valid         : in  std_logic;
      in_genes      : in  std_logic_vector(2*genom_lngt-1 downto 0);
      elite_null    : in  std_logic;
      index         : in  integer;
      count_parents : in  integer;
      gene_score    : out std_logic_vector(genom_lngt+score_sz-1 downto 0);
      elite_offs    : out int_array(0 to elite-1);
      fit_sum       : out std_logic_vector(score_sz+log2(pop_sz)-1 downto 0);
      max_fit       : out std_logic_vector(score_sz-1 downto 0);
      rd            : out std_logic);
  end component fit_eval_tsp;

  component control_tsp is
    generic(
      genom_lngt : integer;
      max_gen    : positive;
      pop_sz     : integer;
      score_sz   : integer;
      elite      : integer); 
    port (
      clk             : in  std_logic;
      rst_n           : in  std_logic;
      fit_eval_rd     : in  std_logic;
      sel_rd          : in  std_logic;
      cross_rd        : in  std_logic;
      mut_rd          : in  std_logic;
      run_ga          : in  std_logic;
      elite_offs      : in  int_array(0 to elite-1);
      data_in_ram2    : in  std_logic_vector(genom_lngt-1 downto 0);
      data_out_cross1 : out std_logic_vector(genom_lngt-1 downto 0);
      data_out_cross2 : out std_logic_vector(genom_lngt-1 downto 0);
      addr_1_c        : out integer;
      addr_2_c        : out integer;
      cnt_parents     : out integer;
      we1_c           : out std_logic;
      we2_c           : out std_logic;
      data_valid      : out std_logic;
      next_gene       : out std_logic;
      ga_fin          : out std_logic;
      cross_out       : out std_logic;
      valid           : out std_logic;
      elite_null      : out std_logic;
      index           : out integer range 0 to pop_sz+1;
      mut_out         : out std_logic;
      flag            : out std_logic;
      decode          : out std_logic;
      sel_out         : out std_logic;
      addr_rom        : out integer;
      run1            : out std_logic;
      run2            : out std_logic;
      run3            : out std_logic;
      load            : out std_logic);
  end component control_tsp;

end package ga_pkg;

--------------------------------------------------------------------------------
-- PACKAGE BODY DECLARATION
--------------------------------------------------------------------------------
package body ga_pkg is
-- empty
end package body ga_pkg;
