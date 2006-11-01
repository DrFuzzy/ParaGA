-------------------------------------------------------------------------------
-- Title      : ROM
-- Project    : GA
-------------------------------------------------------------------------------
-- File       : init_generation_rom_p.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos (kdelip@mail.ntua.gr)
-- Company    : NTUA/IRAL
-- Created    : 14/09/2006
-- Last update: 14/09/2006
-- Platform   : Modelsim, Synplify, ISE
-------------------------------------------------------------------------------
-- Description: This block implements a parameterized wrapper for the 
-- 		initial generation ROM	
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
use work.rom_pkg.all;
use work.dhga_pkg.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity init_generation_rom_p is
  generic (
    townres   : integer;
    pop_sz    : integer;
    num_towns : integer);
  port (
    addr     : in  integer;
    data_out : out std_logic_vector((num_towns-1)*townres-1 downto 0)); -- Length = genomlngt
end entity init_generation_rom_p;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of init_generation_rom_p is

begin

  -- get data
  	data_out <= init_generation_rom(addr) when addr<pop_sz+1 and addr>0 else
  		    (others=>'Z');
end architecture rtl;