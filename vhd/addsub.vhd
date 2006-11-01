-------------------------------------------------------------------------------
-- Title      : Delay Register
-- Project    : Public
-------------------------------------------------------------------------------
-- File       : addsub.vhd
-- Author     : Kyriakos Deliparaschos (kdelip@mail.ntua.gr)
-- Company    : NTUA/IRAL
-- Created    : 01/11/06
-- Last update: 01/11/06
-- Platform   : Modelsim, Synplify, ISE
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description:
-------------------------------------------------------------------------------
-- Copyright (c) 2004 NTUA
-------------------------------------------------------------------------------
-- revisions  :
-- date        version  author  description
-- 01/11/06    1.1      kdelip  created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.dhga_pkg.all;
use work.arith_pkg.all;

entity addsub is
  generic(
           genom_lngt  : positive; 
           score_sz    : integer;
           pop_sz      : positive;
           elite       : positive
           );          
  
  port(
  in_array  : in  array (natural range 0 to elite-1) of std_logic_vector( score_sz-1 downto 0 );
  result    : out std_logic_vector( score_sz + log2(elite)-1 downto 0 )  
  );
end entity addsub;

ARCHITECTURE rtl OF addsub IS


BEGIN
  PROCESS (in_array)
  BEGIN
    
      
    
  END PROCESS;
END rtl;
