-------------------------------------------------------------------------------
-- Title      : ROM
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : rom.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos
-- Company    : NTUA/IRAL
-- Created    : 23/03/06
-- Last update: 20/11/06
-- Platform   : Modelsim 6.1c, Synplify 8.1, ISE 8.1
-------------------------------------------------------------------------------
-- Description: Implements a ROM.
-------------------------------------------------------------------------------
-- Copyright (c) 2006 NTUA
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
use ieee.std_logic_arith.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity rom is
  generic (
    townres : integer := 8);
  port (
    addr     : in  integer;
    data_out : out std_logic_vector(2*townres-1 downto 0));
end entity rom;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of rom is

begin

  -- consequents
  data_out <=
    (others => 'Z')                   when addr = 0  else  -- high Z
    conv_std_logic_vector(1, townres)&
    conv_std_logic_vector(1, townres) when addr = 1  else
    conv_std_logic_vector(1, townres)&
    conv_std_logic_vector(2, townres) when addr = 2  else
    conv_std_logic_vector(2, townres)&
    conv_std_logic_vector(4, townres) when addr = 3  else
    conv_std_logic_vector(3, townres)&
    conv_std_logic_vector(5, townres) when addr = 4  else
    conv_std_logic_vector(2, townres)&
    conv_std_logic_vector(0, townres) when addr = 5  else
    conv_std_logic_vector(3, townres)&
    conv_std_logic_vector(3, townres) when addr = 6  else
    conv_std_logic_vector(4, townres)&
    conv_std_logic_vector(1, townres) when addr = 7  else
    conv_std_logic_vector(5, townres)&
    conv_std_logic_vector(3, townres) when addr = 8  else
    conv_std_logic_vector(3, townres)&
    conv_std_logic_vector(6, townres) when addr = 9  else
    conv_std_logic_vector(4, townres)&
    conv_std_logic_vector(7, townres) when addr = 10 else
    conv_std_logic_vector(6, townres)&
    conv_std_logic_vector(7, townres) when addr = 11 else
    conv_std_logic_vector(7, townres)&
    conv_std_logic_vector(6, townres) when addr = 12 else
    conv_std_logic_vector(5, townres)&
    conv_std_logic_vector(5, townres) when addr = 13 else
    conv_std_logic_vector(5, townres)&
    conv_std_logic_vector(4, townres) when addr = 14 else
    conv_std_logic_vector(6, townres)&
    conv_std_logic_vector(2, townres) when addr = 15 else
    conv_std_logic_vector(7, townres)&
    conv_std_logic_vector(1, townres) when addr = 16 else
    (others => 'Z');
  
end architecture rtl;
