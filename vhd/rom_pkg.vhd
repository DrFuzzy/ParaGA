-------------------------------------------------------------------------------
-- Title      : ROM Package
-- Project    : GA
-------------------------------------------------------------------------------
-- File       : rom_pkg.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos (kdelip@mail.ntua.gr)
-- Company    : NTUA/IRAL
-- Created    : 14/09/2006
-- Last update: 14/09/2006
-- Platform   : Modelsim, Synplify, ISE
-------------------------------------------------------------------------------
-- Description: This package holds the rom data of the numerous ROM's in the
--              design. Of course it cannot be parametrized
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
use work.dhga_pkg.all;
 
--------------------------------------------------------------------------------
-- PACKAGE DECLARATION
--------------------------------------------------------------------------------
package rom_pkg is    
 
  ------------------------
  -- Coordinates Map 
  ------------------------
  constant resol  : positive := 3;  -- townres
  constant towns  : positive := 8; -- num_towns

  subtype town_x_y is std_logic_vector(2*resol-1 downto 0);
  type    towns_x_y is array(0 to towns) of town_x_y;
  --                                         
  constant coordinates_rom : towns_x_y := towns_x_y'(

"ZZZZZZ",
"001001",
"001010",
"010100",
"011101",
"010000",
"011011",
"100001",
"101011"



--"ZZZZZZZZZZZZZZZZ",
--"0000000100000001",
--"0000000100000010",
--"0000001000000100",
--"0000001100000101",
--"0000001000000000",
--"0000001100000011",
--"0000010000000001",
--"0000010100000011"


--"0000001100000110",
--"0000010000000111",
--"0000011000000111",
--"0000011100000110",
--"0000010100000101",
--"0000010100000100",
--"0000011000000010",
--"0000011100000001"

);

  ------------------------
  -- Initial generation
  ------------------------
  constant pop_sz  : positive := 16;
  subtype init_gene is std_logic_vector(resol*(towns-1)-1 downto 0);
  type    init_genes is array(0 to pop_sz) of init_gene;
  --                                         
  constant init_generation_rom : init_genes := init_genes'(
	  
--"ZZZZZZZZZZZZZZZZZZZZZ",
--"001010111100011101110",
--"010001111101110011100",
--"100011110001010111101",
--"010111100001101110011",
--"001111100110011101010",
--"011101001110111010100",
--"001100101011110111001",
--"111011001010100101110"

"ZZZZZZZZZZZZZZZZZZZZZ",
"111011001101010100110",
"111011110010101100001",
"110001011101100010111",
"110001111010100101011",
"100111110101001010011",
"001011101111010100110",
"011111010110101001100",
"111100101001010011110",
"001111011010100110101",
"110011100111001101010",
"110101100111011010001",
"101001011111110100010",
"010100111011101110001",
"101001100011111110010",
"101010111110100011001",
"100111001101011110010"
);



  --------------------------------------------------------------------------------
  -- Seeds for RNG 1 - mutres bits
  --------------------------------------------------------------------------------
  
--  constant mutres  : positive := 8;  
---  constant max_gen  : positive := 10;
--  constant scaling_factor_res : positive := 4;
  
--  subtype seed1 is std_logic_vector(mutres-1 downto 0);
--  type    seeds1 is array(0 to max_gen) of seed1;
  --                                         
--  constant seed1_rom : seeds1 := seeds1'(
	  
--"ZZZZZZZZ",
--"00100110",
--"00101001",
--"01010000",
--"01110101",
--"01000011",
--"01101100",
--"10000100",
--"10101111",
--"10000100",
--"10101111"	  
	  
--  );  
  --------------------------------------------------------------------------------
  -- Seeds for RNG 2 - 2*townres bits
  --------------------------------------------------------------------------------
--  subtype seed2 is std_logic_vector(2*resol-1 downto 0);
--  type    seeds2 is array(0 to max_gen) of seed2;
  --                                         
--  constant seed2_rom : seeds2 := seeds2'(  

--"ZZZZZZ",
--"001001",
--"001010",
--"010100",
--"011101",
--"010000",
--"011011",
--"100001",
--"101011",
--"100001",
--"101011"		  
	  
--  );  
  --------------------------------------------------------------------------------
    -- Seeds for RNG 3 - scaling_factor_res bits
  --------------------------------------------------------------------------------
--  subtype seed3 is std_logic_vector(scaling_factor_res-1 downto 0);
--  type    seeds3 is array(0 to max_gen) of seed3;
  --                                         
--  constant seed3_rom : seeds3 := seeds3'(
	  
--"ZZZZ",
--"0010",
--"0010",
--"0101",
--"0111",
--"0100",
--"0110",
--"1000",
--"1010",
--"1000",
--"1010"	  
	  	  
--  );
  
end package rom_pkg;


--------------------------------------------------------------------------------
-- PACKAGE BODY DECLARATION
--------------------------------------------------------------------------------


package body rom_pkg is
-- empty
end package body rom_pkg;