-------------------------------------------------------------------------------
-- Title      : Observer block
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : obs.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 23/03/06
-- Last update: 20/11/06
-- Platform   : Modelsim 6.1c, Synplify 8.1, Xilinx ISE
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This block implements the observer 
-------------------------------------------------------------------------------
-- Copyright (c) 2006 NTUA
-------------------------------------------------------------------------------
-- revisions  :
-- date        version  author  description
-- 23/03/06    1.1      kdelip  created
-- 16/06/06    1.2      kdelip  updated
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
use work.ga_pkg.all;
use work.arith_pkg.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity obs is
  generic(
    score_sz  : positive;               -- score size
    fit_limit : positive);              -- fitness limit
  port(
    clk       : in  std_logic;          -- clock
    rst_n     : in  std_logic;          -- reset (active low)
    max_fit   : in  std_logic_vector(score_sz-1 downto 0);
    --
    -- fitness limit reached (done signal in state machine)
    fitlim_rd : out std_logic;
    rd        : out std_logic);
end entity obs;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of obs is

  signal done : std_logic;

begin

  -- purpose: reg'd outputs 
  -- type   : sequential
  -- inputs : clk, rst_n, high, done
  -- outputs: rd, fitlim_rd
  reg_op : process (clk, rst_n)
  begin  -- process reg_op
    if (rst_n = '0') then
      rd        <= '0';
      fitlim_rd <= '0';
    elsif rising_edge(clk) then
      rd        <= '1';
      fitlim_rd <= done;
    end if;
  end process reg_op;

  -- purpose: handshake generation
  -- type   : combinational
  -- inputs : fit_limit
  -- outputs: done  
  handshake : process (max_fit)
  begin  -- process handshake
    if max_fit < conv_std_logic_vector(fit_limit, score_sz) then
      done <= '0';
    elsif max_fit = conv_std_logic_vector(fit_limit, score_sz) or
      max_fit > conv_std_logic_vector(fit_limit, score_sz) then
      done <= '1';
    end if;
  end process handshake;

end rtl;
