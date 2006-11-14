-------------------------------------------------------------------------------
-- Title      : ROM
-- Project    : GA
-------------------------------------------------------------------------------
-- File       : coordinates_rom_p.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos (gdoyamis@ieee.org, kdelip@mail.ntua.gr)
-- Company    : NTUA/IRAL
-- Created    : 14/09/06
-- Last update: 08/11/06
-- Platform   : Modelsim, Synplify, ISE
-------------------------------------------------------------------------------
-- Description: This block implements a parameterized wrapper for the coordinates_rom 
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
entity coordinates_rom_p is
  generic (
    townres : integer;
    pop_sz  : integer);
  port (
    addr     : in  integer;
    data_out : out std_logic_vector(2*townres-1 downto 0));
end entity coordinates_rom_p;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of coordinates_rom_p is

begin

  -- get data
  data_out <= coordinates_rom(addr) when addr < pop_sz+1 and addr >= 0 else
              (others => '0');
end architecture rtl;
