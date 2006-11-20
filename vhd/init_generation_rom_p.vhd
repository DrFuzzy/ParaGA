-------------------------------------------------------------------------------
-- Title      : Initial generation ROM
-- Project    : GA
-------------------------------------------------------------------------------
-- File       : init_generation_rom.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos (gdoyamis@ieee.org kdelip@mail.ntua.gr)
-- Company    : NTUA/IRAL
-- Created    : 14/09/06
-- Last update: 20/11/06
-- Platform   : Modelsim 6.1c, Synplify 8.1, Xilinx ISE 8.1
-------------------------------------------------------------------------------
-- Description: This block implements a parameterized wrapper for the 
--              initial generation ROM 
-------------------------------------------------------------------------------
-- Copyright (c) 2006 NTUA
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 14/09/06    1.1      kdelip  created
-- 20/11/06    1.2      kdelip  updated
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
use work.ga_pkg.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity init_generation_rom is
  generic (
    townres   : integer;
    pop_sz    : integer;
    num_towns : integer);
  port (
    addr     : in  integer;
    data_out : out std_logic_vector((num_towns-1)*townres-1 downto 0)); 
end entity init_generation_rom;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of init_generation_rom is

begin

  -- get data
  data_out <= init_gen_rom(addr) when addr < pop_sz+1 and addr > 0 else
              (others => 'Z');

end architecture rtl;
