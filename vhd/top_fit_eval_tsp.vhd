-------------------------------------------------------------------------------
-- Title      : fit_eval_tsp
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : top_fit_eval_tsp.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 16/05/06
-- Last update: 16/11/06
-- Platform   : Modelsim 6.1c, Synplify 8.1, ISE 8.1
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: Top structural block of the Fitness Evaluation Block connecting
--              all the necessary modules of the F.A. block together.
-------------------------------------------------------------------------------
-- Copyright (c) 2006 NTUA
-- Revisions  :
-- Date        Version  Author  Description
-- 16/05/06    1.1      kdelip  created
-- 16/11/06    1.2      kdelip  updated
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
use work.rom_pkg.all;
use work.arith_pkg.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity fit_eval_tsp is
  generic (
    genom_lngt : positive := 21;        -- townres*(num_towns-1)
    score_sz   : integer  := 16;        -- score size
    pop_sz     : integer  := 8;         -- population size
    elite      : integer  := 3;         -- number of elites
    townres    : integer  := 3;         -- town resolution
    num_towns  : integer  := 8);        -- number of towns
  port (
    clk           : in  std_logic;      -- clock
    rst_n         : in  std_logic;      -- reset (active low)
    decode        : in  std_logic;  -- evaluation after rng_s or after mut_s
    valid         : in  std_logic;      -- if H compute else if L don't
    -- both mutation or rng fill evaluation block
    in_genes      : in  std_logic_vector(2*genom_lngt-1 downto 0);
    --
    elite_null    : in  std_logic;
    index         : in  integer;        -- the address of the current gene
    count_parents : in  integer;        -- how many parents have been selected
    -- ingene and its fitness value
    gene_score    : out std_logic_vector(genom_lngt+score_sz-1 downto 0);
    --
    elite_offs    : out int_array(0 to elite-1);  -- addr's of elite children
    -- sum of fitnesses
    fit_sum       : out std_logic_vector(score_sz+log2(pop_sz)-1 downto 0);
    --
    max_fit       : out std_logic_vector(score_sz-1 downto 0);  -- max. fitness
    rd            : out std_logic);     -- handshake
end entity fit_eval_tsp;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture str of fit_eval_tsp is

-- SIGNAL DECLARATION
-------------------------------------------------------------------------------
  signal fit_dummy       : std_logic_vector(score_sz-1 downto 0);
  signal addr_dummy      : integer;
  signal ready_out_dummy : std_logic;
  signal data_out_rom    : std_logic_vector(2*townres-1 downto 0);

begin

-- COMPONENTS INSTANTIATION

-------------------------------------------------------------------------------
-- Fitness Calculator : Computes the fitness of the input gene 
-------------------------------------------------------------------------------
  U0 : fit_calc_tsp
    generic map (
      genom_lngt => genom_lngt,
      score_sz   => score_sz,
      pop_sz     => pop_sz,
      townres    => townres,
      num_towns  => num_towns)        
    port map (
      clk        => clk,
      rst_n      => rst_n,
      decode     => decode,
      valid      => valid,
      in_genes   => in_genes,
      data_in    => data_out_rom,
      gene_score => gene_score,
      fit        => fit_dummy,          -- to fix_elite
      addr_rom   => addr_dummy,         -- to rom
      ready_out  => ready_out_dummy);   -- to fix_elite            

-------------------------------------------------------------------------------
-- Elite fixation : Fixes the elite indexs and the array of the best fitnesses 
-------------------------------------------------------------------------------
  U1 : fix_elite_tsp
    generic map (
      genom_lngt => genom_lngt,
      score_sz   => score_sz,
      pop_sz     => pop_sz,
      elite      => elite)                 
    port map(
      clk           => clk,
      rst_n         => rst_n,
      decode        => decode,
      valid         => valid,
      elite_null    => elite_null,
      index         => index,
      fit           => fit_dummy,
      count_parents => count_parents,
      ready_in      => ready_out_dummy,
      elite_offs    => elite_offs,
      fit_sum       => fit_sum,
      max_fit       => max_fit,
      rd            => rd);

-------------------------------------------------------------------------------
-- ROM : Contains the coordinates map of the towns (TSP problem)
-------------------------------------------------------------------------------
  U2 : coordinates_rom_p
    generic map(
      townres => townres,
      pop_sz  => pop_sz)
    port map(
      addr     => addr_dummy,
      data_out => data_out_rom);

end architecture str;
