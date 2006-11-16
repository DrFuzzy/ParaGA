-------------------------------------------------------------------------------
-- Title      : Fitness Scaling & Ranking block
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : fit_scal_rank.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 23/03/06
-- Last update: 2006-11-02
-- Platform   : Modelsim & Synplify & Xilinx ISE
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This block implements the fitness caling and ranking block 
-------------------------------------------------------------------------------
-- Copyright (c) 2006 NTUA
-------------------------------------------------------------------------------
-- revisions  :
-- date        version  author  description
-- 23/03/06    1.1      kdelip  created
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- LIBRARIES
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
library work;
use work.dhga_pkg.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity fit_scal_rank is
  generic(
    RamSize  : positive;
    nParents : integer);          
  port (
    clk          : in  std_logic;       -- clock
    rst_n        : in  std_logic;       -- reset (active low)
    scores       : in  intarray;
    ranks        : out intarray;
    scaledScores : out intarray);
end entity fit_scal_rank;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of fit_scal_rank is
begin

-- empty

end rtl;
