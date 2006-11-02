-------------------------------------------------------------------------------
-- Title      : ROM
-- Project    : Hardware GA
-------------------------------------------------------------------------------
-- File       : srom.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos
-- Company    : NTUA/IRAL
-- Created    : 05/06/2004
-- Platform   : Modelsim 6.1d & FPGA Compiler-II 3.5
-------------------------------------------------------------------------------
-- Description: Το αρχείο αυτό περιγράφει μία μνήμη  ROM.
-------------------------------------------------------------------------------
-- Copyright (c) 2006 NTUA
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
entity ROM is
  generic (
    townres : integer := 8);
  port (
    addr     : in  integer;
    data_out : out std_logic_vector(2*townres-1 downto 0));
end entity ROM;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of ROM is

begin

-- consequents
  data_out <=
    (others => 'Z')                                                     when addr = 0  else  -- high Z
    conv_std_logic_vector(1, townres)&conv_std_logic_vector(1, townres) when addr = 1  else
    conv_std_logic_vector(1, townres)&conv_std_logic_vector(2, townres) when addr = 2  else
    conv_std_logic_vector(2, townres)&conv_std_logic_vector(4, townres) when addr = 3  else
    conv_std_logic_vector(3, townres)&conv_std_logic_vector(5, townres) when addr = 4  else
    conv_std_logic_vector(2, townres)&conv_std_logic_vector(0, townres) when addr = 5  else
    conv_std_logic_vector(3, townres)&conv_std_logic_vector(3, townres) when addr = 6  else
    conv_std_logic_vector(4, townres)&conv_std_logic_vector(1, townres) when addr = 7  else
    conv_std_logic_vector(5, townres)&conv_std_logic_vector(3, townres) when addr = 8  else
    conv_std_logic_vector(3, townres)&conv_std_logic_vector(6, townres) when addr = 9  else
    conv_std_logic_vector(4, townres)&conv_std_logic_vector(7, townres) when addr = 10 else
    conv_std_logic_vector(6, townres)&conv_std_logic_vector(7, townres) when addr = 11 else
    conv_std_logic_vector(7, townres)&conv_std_logic_vector(6, townres) when addr = 12 else
    conv_std_logic_vector(5, townres)&conv_std_logic_vector(5, townres) when addr = 13 else
    conv_std_logic_vector(5, townres)&conv_std_logic_vector(4, townres) when addr = 14 else
    conv_std_logic_vector(6, townres)&conv_std_logic_vector(2, townres) when addr = 15 else
    conv_std_logic_vector(7, townres)&conv_std_logic_vector(1, townres) when addr = 16 else
    (others => 'Z');
  
end architecture rtl;
