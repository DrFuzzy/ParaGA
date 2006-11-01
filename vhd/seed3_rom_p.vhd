-------------------------------------------------------------------------------
-- Title      : ROM
-- Project    : GA
-------------------------------------------------------------------------------
-- File       : seed3_rom_p.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos (kdelip@mail.ntua.gr)
-- Company    : NTUA/IRAL
-- Created    : 19/09/2006
-- Platform   : Modelsim, Synplify, ISE
-------------------------------------------------------------------------------
-- Description: This block implements a parameterized wrapper for the seed3_rom 
-------------------------------------------------------------------------------
-- Copyright (c) 2006 NTUA
-------------------------------------------------------------------------------
-- Revisions  :
-- date        version  author  description
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- LIBRARIES
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.arith_pkg.all;
use work.dhga_pkg.all;
use work.rom_pkg.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity seed3_rom_p is
  generic (scaling_factor_res   : integer);
  port (
    addr     : in  integer;
    data_out : out std_logic_vector(scaling_factor_res-1 downto 0));
end entity seed3_rom_p;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of seed3_rom_p is

begin

  -- get data
  	data_out <= seed3_rom(addr) when addr>=0 else
  		    (others=>'0');
end architecture rtl;