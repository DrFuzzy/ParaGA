-------------------------------------------------------------------------------
-- Title      : Fitness Evaluation block
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : fit_calc_TSP.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 08/08/06
-- Last update: 08/11/06
-- Platform   : Modelsim & Synplify & Xilinx ISE
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This block implements the fitness calculation block for TSP
-- 
-------------------------------------------------------------------------------
-- Copyright (c) 2006 NTUA
-------------------------------------------------------------------------------
-- revisions  :
-- date        version  author  description
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- LIBRARIES
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.dhga_pkg.all;
use work.arith_pkg.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity fit_calc is
  generic(
    genom_lngt : positive;
    score_sz   : integer;
    pop_sz     : positive);           
  port (
    clk        : in  std_logic;         -- clock
    rst_n      : in  std_logic;         -- reset (active low)
    decode     : in  std_logic;  -- evaluation after rng_s or after mut_s
    valid      : in  std_logic;  -- if H compute else if L don't                                         -- if H 
    in_genes   : in  std_logic_vector(2*genom_lngt-1 downto 0);  -- both mutation or rng fill evaluation block
    gene_score : out std_logic_vector(genom_lngt+score_sz-1 downto 0);  -- ingene and its fitness value
    fit        : out std_logic_vector(score_sz-1 downto 0) := (others => '0');  -- fitness of current gene ()
    ready_out  : out std_logic);
end entity fit_calc;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of fit_calc is

  signal gene_scr : std_logic_vector(genom_lngt+score_sz-1 downto 0) := (others => '0');
  signal temp     : std_logic_vector(genom_lngt+score_sz-1 downto 0) := (others => '0');
  signal gene     : std_logic_vector(genom_lngt-1 downto 0)          := (others => '0');
  signal max_fit  : std_logic_vector(score_sz-1 downto 0)            := (others => '1');
  --signal temp_fit          : std_logic_vector(score_sz-1 downto 0) ;
  signal fit_p    : std_logic_vector(score_sz-1 downto 0);
  signal done     : std_logic;
  signal done_p   : std_logic;

begin

  process (clk, rst_n)

  begin
    if rst_n = '0' then
      temp   <= (others => '0');
      done_p <= '0';
    elsif rising_edge(clk) then
      temp   <= gene_scr;
      done_p <= done;
    end if;
  end process;
-- Outputs
  fit        <= temp(score_sz-1 downto 0);  -- maybe temp_fit
  gene_score <= temp;                       -- maybe temp
  ready_out  <= done_p;

  fit_calculation : process (in_genes, gene, decode, valid, done, done_p, temp)

  begin

    if valid = '1' and done_p /= '1' then  -- evaluate gene - calculate fitness
      if decode = '1' then                 -- pick out the rng offspring
        gene <= in_genes(2*genom_lngt -1 downto genom_lngt);
      elsif decode = '0' then              -- pick out the mutation offspring
        gene <= in_genes(genom_lngt -1 downto 0);
      end if;

      max_fit  <= (others => '1');
      done     <= '1';
      fit_p    <= shl(ext(gene, score_sz), "1");  -- simple fitness function (score = 2*gene)
      --fit_p <= gene*gene;
      gene_scr <= gene & shl(ext(gene, score_sz), "1");  -- change if u change the fit function          

    elsif valid = '1' and done_p = '1' then
      
      gene     <= (others => '0');
      fit_p    <= temp(score_sz-1 downto 0);
      gene_scr <= temp;
      done     <= '1';
      -- do nothing, preserve same outputs
      
    elsif valid = '0' then
      fit_p    <= temp(score_sz-1 downto 0);
      gene     <= (others => '0');
      gene_scr <= temp;
      max_fit  <= (others => '1');
      done     <= '0';
    else
      fit_p    <= temp(score_sz-1 downto 0);
      gene     <= (others => '0');
      gene_scr <= (others => '0');
      max_fit  <= (others => '1');
      done     <= '0';
      
    end if;  -- valid

  end process fit_calculation;

end rtl;
