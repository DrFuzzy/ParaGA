-------------------------------------------------------------------------------
-- Title      : Observer block
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : obs.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 23/03/06
-- Last update: 23/03/06
-- Platform   : Modelsim & Synplify & Xilinx ISE
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This block implements the fitness evaluation block 
-------------------------------------------------------------------------------
-- Copyright (c) 2006 NTUA
-------------------------------------------------------------------------------
-- revisions  :
-- date        version  author  description
-------------------------------------------------------------------------------
-- NOT USED IN TSP 
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
entity obs_tsp is
  generic(
           score_sz	: positive);  
           
  port ( clk        : in  std_logic;  -- clock
         rst_n      : in  std_logic;  -- reset (active low)
         max_fit    : in  std_logic_vector(score_sz-1 downto 0); -- produced by fit_eval block
	 fitlim_rd  : out std_logic;  -- fitness limit reached (done signal in state machine)
	 rd 	    : out std_logic   -- obs block ready signal
         );
end entity obs_tsp;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of obs_tsp is

  signal done  : std_logic:= '0';
  signal done2 : std_logic:= '0';
  signal temp  : std_logic_vector(score_sz-1 downto 0);
begin

process (clk, rst_n)
begin
	if (rst_n = '0') then
		rd <= '0';        
		fitlim_rd <= '0';
	elsif clk = '1' and clk'event then
		rd <= done;
		fitlim_rd <= done2;	
	end if;
end process;


process (max_fit,temp)
begin
	
	temp<= conv_std_logic_vector(fit_limit, score_sz);
	if max_fit < conv_std_logic_vector(fit_limit, score_sz) then 
		done2 <= '0';
	elsif max_fit = conv_std_logic_vector(fit_limit, score_sz) or max_fit > conv_std_logic_vector(fit_limit, score_sz) then 
		done2 <= '1';
	end if ;
	done <= '1';
	
end process;

end rtl;