-------------------------------------------------------------------------------
-- Title      : Crossover block
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : crossover_v1.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 23/03/06
-- Last update: 2006-11-02
-- Platform   : Modelsim & Synplify & Xilinx ISE
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This block implements the mutation algorithm block 
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
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.dhga_pkg.all;
use work.arith_pkg.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity crossover_v1 is
  generic(
    genomLngt   : positive                     := 16;
    crossRes    : integer                      := 8;
    nParents    : integer                      := 50;
    upRange     : positive                     := 1;
    dnRange     : positive                     := 1;
    crossMethod : std_logic_vector(1 downto 0) := "00");          
  port (
    clk          : in  std_logic;       -- clock
    rst_n        : in  std_logic;       -- reset (active low)
    crossEn      : in  std_logic;
    crossPoints  : in  std_logic_vector(2*log2(genomLngt)-1 downto 0);
    --crossPoint2 : in  std_logic_vector(log2(genomLngt)-1 downto 0);
    crossrate    : in  std_logic_vector(crossRes-1 downto 0);
    --rng1           : in  std_logic_vector(crossRes-1 downto 0);
    rng          : in  std_logic_vector(genomLngt+crossRes-1 downto 0);
    inGene1      : in  std_logic_vector(genomLngt-1 downto 0);
    inGene2      : in  std_logic_vector(genomLngt-1 downto 0);
    -- we         : out  std_logic;
    --crossDone   : out std_logic;
    crossOffspr1 : out std_logic_vector(genomLngt-1 downto 0));
end entity crossover_v1;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of crossover_v1 is

  
  signal mask          : std_logic_vector(genomLngt-1 downto 0);
  signal mask1         : std_logic_vector(genomLngt-1 downto 0);
  signal mask2         : std_logic_vector(genomLngt-1 downto 0);
  signal temp1         : std_logic_vector(genomLngt-1 downto 0);
  signal temp2         : std_logic_vector(genomLngt-1 downto 0);
  signal temp3         : std_logic_vector(genomLngt-1 downto 0);
  signal temp4         : std_logic_vector(genomLngt-1 downto 0);
  signal crossout1     : std_logic_vector(genomLngt-1 downto 0) := (others => '0');
  signal inGene_cross1 : std_logic_vector(genomLngt-1 downto 0);
  signal done          : std_logic                              := '0';
begin

  process (clk, rst_n)
  begin
    if (rst_n = '0') then
      crossOffspr1 <= (others => '0');
    elsif clk = '1' and clk'event then
      crossOffspr1 <= crossout1;
    end if;
  end process;



-- PENDING --


end rtl;
