-------------------------------------------------------------------------------
-- Title      : Crossover Algorithm Block
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : crossover.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 23/03/06
-- Last update: 2006-11-02
-- Platform   : Modelsim & Synplify & Xilinx ISE
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This block implements the crossover block algorithm
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
use work.ga_pkg.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity cross is
  generic(
    genomLngt : positive;
    crossRate : positive
    );             
  port (
    clk         : in  std_logic;        -- clock
    rst_n       : in  std_logic;        -- reset (active low)
    parents     : in  integer;
    crossOffspr : out std_logic_vector(genomLngt-1 downto 0)
    );
end entity cross;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of cross is
begin

-- empty
-- empty
-- empty

end rtl;
