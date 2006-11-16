--------------------------------------------------------------------------------
-- Title      : Genetic Algorithm Package
-- Project    : Genetic Algorithm
--------------------------------------------------------------------------------
-- File       : dhga_pkg.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos (kdelip@mail.ntua.gr)
-- Company    : NTUA/IRAL
-- Created    : 23/03/06
-- Last update: 16/11/06
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
package dhga_pkg is

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
      seed         : in  std_logic_vector(n-1 downto 0);  -- parallel seed input
      run          : in  std_logic;     -- if 1 run else output=high-Z
      parallel_out : out std_logic_vector(n-1 downto 0));  -- parallel data out
  end component rng;

  component rng_128 is
    generic(
      n : positive);                    -- length of pseudo-random sequence
    port (
      clk          : in  std_logic;     -- clock
      rst_n        : in  std_logic;     -- reset (active low)
      load         : in  std_logic;     -- load (active high)
      seed         : in  std_logic_vector(n-1 downto 0);  -- parallel seed input
      run          : in  std_logic;     -- if 1 run else output=high-Z
      parallel_out : out std_logic_vector(n-1 downto 0));  -- parallel data out
  end component rng_128;

  component fit_eval_elite2 is
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
      count_parents : in  integer;
      in_genes      : in  std_logic_vector(2*genom_lngt-1 downto 0);  -- both mutation or rng fill evaluation block 
      gene_score    : out std_logic_vector(genom_lngt+score_sz-1 downto 0);  -- inGene and its fitness value
      elite_offs    : out int_array(1 to elite);  -- addresses of elite children (integer)
      fit_sum       : out std_logic_vector(score_sz+log2(pop_sz)-1 downto 0);  -- sum of fitnesses
      max_fit       : out std_logic_vector(score_sz-1 downto 0);  -- maximum fitness 
      rd            : out std_logic);  
  end component fit_eval_elite2;

  component fit_eval_elite3 is
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
      count_parents : in  integer;
      in_genes      : in  std_logic_vector(2*genom_lngt-1 downto 0);  -- both mutation or rng fill evaluation block 
      gene_score    : out std_logic_vector(genom_lngt+score_sz-1 downto 0);  -- inGene and its fitness value
      elite_offs    : out int_array(1 to elite);  -- addresses of elite children (integer)
      fit_sum       : out std_logic_vector(score_sz+log2(pop_sz)-1 downto 0);  -- sum of fitnesses
      max_fit       : out std_logic_vector(score_sz-1 downto 0);  -- maximum fitness 
      rd            : out std_logic);  
  end component fit_eval_elite3;

  component fit_calc is
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
  end component fit_calc;

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
      decode        : in  std_logic;  -- evaluation after rng_s or after mut_s
      valid         : in  std_logic;  -- if H compute else if L don't                                         -- if H 
      in_genes      : in  std_logic_vector(2*genom_lngt-1 downto 0);  -- both mutation or rng fill evaluation block      
      elite_null    : in  std_logic;
      index         : in  integer;      -- the address of the current gene
      count_parents : in  integer;      -- how many parents have been selected
      gene_score    : out std_logic_vector(genom_lngt+score_sz-1 downto 0);  -- ingene and its fitness value
      elite_offs    : out int_array(0 to elite-1);  -- addresses of elite children (integer)
      fit_sum       : out std_logic_vector(score_sz+log2(pop_sz)-1 downto 0);  -- sum of fitnesses
      max_fit       : out std_logic_vector(score_sz-1 downto 0);  -- maximum fitness
      rd            : out std_logic);
  end component fit_eval_ga;

  component selection is
    generic(
      genom_lngt         : positive;
      pop_sz             : positive;
      elite              : integer;
      score_sz           : integer;
      scaling_factor_res : integer);    -- scaling factor resolution (bits) 
    port (
      clk        : in  std_logic;       -- clock
      rst_n      : in  std_logic;       -- reset (active low)
      inGene     : in  std_logic_vector(genom_lngt+score_sz-1 downto 0);  -- gene and its fitness value concatenated
      rng        : in  std_logic_vector(scaling_factor_res-1 downto 0);  -- random number for scaling down the fitSum 
      fitSum     : in  std_logic_vector(score_sz+log2(pop_sz)-1 downto 0);  -- sum of fitnesses
      data_valid : in  std_logic;
      next_gene  : in  std_logic;
      selParent  : out std_logic_vector(genom_lngt-1 downto 0);
      rd         : out std_logic);  -- ready signal: parent is on pin selparent
  end component selection;

  component mutation_v1 is
    generic(
      genom_lngt : positive;
      mr         : integer;             -- 8bit coding
      mut_res    : integer;
      mut_method : std_logic_vector(1 downto 0));          
    port (
      clk       : in  std_logic;        -- clock
      rst_n     : in  std_logic;        -- reset (active low)
      mutEn     : in  std_logic;
      mutPoint  : in  std_logic_vector(log2(genom_lngt)-1 downto 0);  -- mutation point (for 1point mutation) comes from rng2
      rng       : in  std_logic_vector(genom_lngt+mut_res-1 downto 0);
      inGene    : in  std_logic_vector(genom_lngt-1 downto 0);
      rd        : out std_logic;
      mutOffspr : out std_logic_vector(genom_lngt-1 downto 0));
  end component mutation_v1;

  component mutation_v2 is
    generic(
      genom_lngt : positive;
      mr         : integer;
      mut_res    : integer);            -- mutation resolution          
    port (
      clk       : in  std_logic;        -- clock
      rst_n     : in  std_logic;        -- reset (active low)
      mutPoint  : in  std_logic_vector(log2(genom_lngt)-1 downto 0);  -- mutation point (for 1point mutation) comes from rng2
      mutMethod : in  std_logic_vector(1 downto 0);
      cont      : in  std_logic;
      flag      : in  std_logic;
      rng       : in  std_logic_vector(genom_lngt+mut_res-1 downto 0);  -- XORed with input Gene
      inGene    : in  std_logic_vector(genom_lngt-1 downto 0);
      rd        : out std_logic;        -- mutation ended for current parent
      mutOffspr : out std_logic_vector(genom_lngt-1 downto 0));  -- produced mutation offspring (kid)
  end component mutation_v2;

  component crossover_v2 is
    generic(
      genom_lngt : positive);
    port (
      clk          : in  std_logic;     -- clock
      rst_n        : in  std_logic;     -- reset (active low)
      cont         : in  std_logic;
      crossPoints  : in  std_logic_vector(2*log2(genom_lngt)-1 downto 0);  -- Xover 1st/2nd point from rng2
      crossMethod  : in  std_logic_vector(1 downto 0);
      rng          : in  std_logic_vector(genom_lngt-1 downto 0);  -- used for uniform crossover 
      inGene1      : in  std_logic_vector(genom_lngt-1 downto 0);
      inGene2      : in  std_logic_vector(genom_lngt-1 downto 0);
      rd           : out std_logic;  -- Xover ended for current 2 parents having produced 1 offsping
      crossOffspr1 : out std_logic_vector(genom_lngt-1 downto 0));
  end component crossover_v2;

  component spram1 is
    generic (
      add_width  : integer;
      data_width : integer);
    port (
      clk      : in  std_logic;         -- write clock
      rst_n    : in  std_logic;         -- system reset
      add      : in  std_logic_vector(add_width downto 0);  -- address (integer instead of std_vec)
      data_in  : in  std_logic_vector(data_width -1 downto 0);  -- input data (width ram1: genom_lngt+score_sz, width ram2: genom_lngt)
      data_out : out std_logic_vector(data_width -1 downto 0);  -- output data (width ram1: genom_lngt+score_sz, width ram2: genom_lngt)
      wr       : in  std_logic);        -- read/write enable
  end component spram1;

  component obs is
    generic(
      score_sz  : positive;
      fit_limit : positive);  
    port (clk       : in  std_logic;    -- clock
          rst_n     : in  std_logic;    -- reset (active low)
          max_fit   : in  std_logic_vector(score_sz-1 downto 0);  -- produced by fit_eval block
          fitlim_rd : out std_logic;  -- fitness limit reached (done signal in state machine)
          rd        : out std_logic);
  end component obs;

  component control_v4 is
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
      addr_1          : out integer;
      addr_2          : out integer;
      cnt_parents     : out integer;
      we1             : out std_logic;
      we2             : out std_logic;
      data_valid      : out std_logic;
      next_gene       : out std_logic;
      clear           : out std_logic;  -- clear ram
      ga_fin          : out std_logic;
      cross_out       : out std_logic;
      valid           : out std_logic;
      elite_null      : out std_logic;
      index           : out integer;
      mut_out         : out std_logic;
      flag            : out std_logic;
      decode          : out std_logic;
      sel_out         : out std_logic;
      term_out        : out std_logic;
      --rng             : out std_logic;
      run             : out std_logic;
      run1            : out std_logic;
      run2            : out std_logic;
      run3            : out std_logic;
      load            : out std_logic);
  end component control_v4;

  component control_v5 is
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
  end component control_v5;

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
      crossPoints  : in  std_logic_vector(2*log2(num_towns)-1 downto 0);  -- Xover 1st/2nd point from rng2
      inGene1      : in  std_logic_vector(genom_lngt-1 downto 0);
      inGene2      : in  std_logic_vector(genom_lngt-1 downto 0);
      --pool        : in  int_array(1 to num_towns-1);
      rd           : out std_logic;  -- Xover ended for current 2 parents having produced 1 offsping
      crossOffspr1 : out std_logic_vector(genom_lngt-1 downto 0));
  end component crossover_TSP;

  component mutation_tsp is
    generic(
      genom_lngt : positive;
      mr         : integer;  -- mutation rate coded in mut_res bits --> 25/255 ~= 0,1  
      mut_res    : integer;             -- mutation resolution
      num_towns  : integer);          
    port (
      clk       : in  std_logic;        -- clock
      rst_n     : in  std_logic;        -- reset (active low)
      mutPoint  : in  std_logic_vector(2*log2(num_towns)-1 downto 0);  -- mutation points -- comes from rng2
      cont      : in  std_logic;
      flag      : in  std_logic;
      rng       : in  std_logic_vector(mut_res-1 downto 0);  -- XORed with input Gene
      inGene    : in  std_logic_vector(genom_lngt-1 downto 0);
      rd        : out std_logic;        -- mutation ended for current parent
      mutOffspr : out std_logic_vector(genom_lngt-1 downto 0));  -- produced mutation offspring (kid)
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
      decode     : in  std_logic;  -- evaluation after rng_s or after mut_s
      valid      : in  std_logic;  -- if H compute else if L don't                                         -- if H 
      in_genes   : in  std_logic_vector(2*genom_lngt-1 downto 0);  -- both mutation or rng fill evaluation block  
      data_in    : in  std_logic_vector(2*townres-1 downto 0);  -- importing ROM data
      gene_score : out std_logic_vector(genom_lngt+score_sz-1 downto 0);  -- ingene and its fitness value
      fit        : out std_logic_vector(score_sz-1 downto 0) := (others => '0');  -- fitness of current gene ()
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
      decode        : in  std_logic;  -- evaluation after rng_s or after mut_s
      valid         : in  std_logic;    -- if H compute else if L don't 
      elite_null    : in  std_logic;    -- if H 
      index         : in  integer;      -- the address of the current gene
      fit           : in  std_logic_vector(score_sz-1 downto 0);
      count_parents : in  integer;      -- how many parents have been selected
      ready_in      : in  std_logic;
      elite_offs    : out int_array(0 to elite-1);  -- addresses of elite children (integer)
      fit_sum       : out std_logic_vector(score_sz+log2(pop_sz)-1 downto 0);  -- sum of fitnesses
      max_fit       : out std_logic_vector(score_sz-1 downto 0);  -- maximum fitness
      rd            : out std_logic);
  end component fix_elite_tsp;

  component coordinates_rom_p is
    generic (
      townres : integer;
      pop_sz  : integer);
    port (
      addr     : in  integer;
      data_out : out std_logic_vector(2*townres-1 downto 0));
  end component coordinates_rom_p;

  component init_generation_rom_p is
    generic (
      townres   : integer;
      pop_sz    : integer;
      num_towns : integer);
    port (
      addr     : in  integer;
      data_out : out std_logic_vector((num_towns-1)*townres-1 downto 0)); 
  end component init_generation_rom_p;

  component fit_eval_tsp is
    generic (
      genom_lngt : positive;            -- townres*(num_towns-1)
      score_sz   : integer;
      pop_sz     : integer;
      elite      : integer;
      townres    : integer;
      num_towns  : integer);
    port (
      clk           : in  std_logic;
      rst_n         : in  std_logic;
      decode        : in  std_logic;  -- evaluation after rng_s or after mut_s
      valid         : in  std_logic;  -- if H compute else if L don't compute
      -- both mutation or rng fill evaluation block
      in_genes      : in  std_logic_vector(2*genom_lngt-1 downto 0);
      --
      elite_null    : in  std_logic;
      index         : in  integer;      -- the address of the current gene
      count_parents : in  integer;      -- how many parents have been selected
      gene_score    : out std_logic_vector(genom_lngt+score_sz-1 downto 0);  -- ingene and its fitness value
      elite_offs    : out int_array(0 to elite-1);  -- addresses of elite children (integer)
      fit_sum       : out std_logic_vector(score_sz+log2(pop_sz)-1 downto 0);  -- sum of fitnesses
      max_fit       : out std_logic_vector(score_sz-1 downto 0);  -- maximum fitness
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
      elite_offs      : in  int_array(0 to elite-1);  -- addresses of elite children (integer) 
      data_in_ram2    : in  std_logic_vector(genom_lngt-1 downto 0);  -- Parent from RAM 2
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
      index           : out integer range 0 to pop_sz+1;  -- memory address of the current gene 
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

end package dhga_pkg;

--------------------------------------------------------------------------------
-- PACKAGE BODY DECLARATION
--------------------------------------------------------------------------------
package body dhga_pkg is
-- empty
end package body dhga_pkg;
