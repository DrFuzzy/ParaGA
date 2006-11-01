-------------------------------------------------------------------------------
-- Title      : Mutation block for tsp 
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : mutation_v2.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 23/03/06
-- Last update: 23/03/06
-- Platform   : Modelsim & Synplify & Xilinx ISE
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This block implements the mutation algorithm block 
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
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.dhga_pkg.all;
use work.arith_pkg.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity mutation_tsp is
  generic(
           genom_lngt : positive := 21;
           mr         : integer := 25;        -- mutation rate coded in mut_res bits --> 25/255 ~= 0,1  
           mut_res    : integer := 8;         -- mutation resolution
           num_towns  : integer := 8
           );          
  port ( clk         : in  std_logic;  -- clock
         rst_n       : in  std_logic;  -- reset (active low)
         mutPoint    : in  std_logic_vector(2*log2(num_towns)-1 downto 0); -- mutation points -- comes from rng2
         cont	     : in  std_logic;
         flag	     : in  std_logic;
         rng	     : in  std_logic_vector(mut_res-1 downto 0);  	 -- XORed with input Gene
         inGene      : in  std_logic_vector(genom_lngt-1 downto 0);      
         rd          : out std_logic;   -- mutation ended for current parent
         mutOffspr   : out std_logic_vector(genom_lngt-1 downto 0) -- produced mutation offspring (kid)
         );
end entity mutation_tsp;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of mutation_tsp is

  signal mutout     : std_logic_vector(genom_lngt-1 downto 0):= (others=>'0');
  signal mutout_p1  : std_logic_vector(genom_lngt-1 downto 0):= (others=>'0');
  signal inGene_mut : std_logic_vector(genom_lngt-1 downto 0):= (others=>'0');
  signal temp1	    : std_logic_vector(log2(num_towns)-1 downto 0):= (others=>'0');
  signal temp2	    : std_logic_vector(log2(num_towns)-1 downto 0):= (others=>'0');
  signal rng1	    : std_logic_vector(mut_res-1 downto 0):= (others=>'0');
  signal done       : std_logic:='0';
  signal done_p     : std_logic:='0';
  signal reduce_1   : integer:= 0; 
  signal reduce_2   : integer:= 0;
begin

process (clk, rst_n)
begin
	if (rst_n = '0') then
		mutOffspr <= (others=>'0');
		mutout_p1 <= (others=>'0');
		rd <= '0';
		done_p <= '0';
		
	elsif clk = '1' and clk'event then
		mutOffspr <= mutout;
		mutout_p1 <= mutout;
		if flag = '1' then 
			rd<='0';
			done_p <= '0';
		else 
			rd <= done;
			done_p <= done;
		end if;
		
	end if;
end process;

mutation_tsp: process (mutPoint,rng1,rng,inGene,inGene_mut,mutout_p1,cont,flag,done,done_p,temp1,temp2,reduce_1,reduce_2)
begin

case cont is 	
 
 when '1' => -- mutation block enabled
	
	rng1 <= rng(mut_res-1 downto 0);
	inGene_mut <= inGene; 
	if conv_integer(mutPoint(2*log2(num_towns)-1 downto log2(num_towns))) = num_towns-1 then -- When num_towns-1 which does not exist mutate the num_towns-2
		
		temp1 <= inGene((conv_integer(mutPoint(2*log2(num_towns)-1 downto log2(num_towns)))+1-1)*log2(num_towns)-1 downto (conv_integer(mutPoint(2*log2(num_towns)-1 downto log2(num_towns)))-1)*log2(num_towns));
		inGene_mut((conv_integer(mutPoint(2*log2(num_towns)-1 downto log2(num_towns)))+1-1)*log2(num_towns)-1 downto (conv_integer(mutPoint(2*log2(num_towns)-1 downto log2(num_towns)))-1)*log2(num_towns)) <= temp2;
	else 
		temp1 <= inGene((conv_integer(mutPoint(2*log2(num_towns)-1 downto log2(num_towns)))+1)*log2(num_towns)-1 downto conv_integer(mutPoint(2*log2(num_towns)-1 downto log2(num_towns)))*log2(num_towns));
		inGene_mut((conv_integer(mutPoint(2*log2(num_towns)-1 downto log2(num_towns)))+1)*log2(num_towns)-1 downto conv_integer(mutPoint(2*log2(num_towns)-1 downto log2(num_towns)))*log2(num_towns)) <= temp2;
	end if;
	
	
	if conv_integer(mutPoint(log2(num_towns)-1 downto 0)) = num_towns-1 then 
                         										
		temp2 <= inGene((conv_integer(mutPoint(log2(num_towns)-1 downto 0))+1-1)*log2(num_towns)-1 downto (conv_integer(mutPoint(log2(num_towns)-1 downto 0))-1)*log2(num_towns));
		inGene_mut((conv_integer(mutPoint(log2(num_towns)-1 downto 0))+1-1)*log2(num_towns)-1 downto (conv_integer(mutPoint(log2(num_towns)-1 downto 0))-1)*log2(num_towns)) <= temp1;
	else 
		temp2 <= inGene((conv_integer(mutPoint(log2(num_towns)-1 downto 0))+1)*log2(num_towns)-1 downto conv_integer(mutPoint(log2(num_towns)-1 downto 0))*log2(num_towns));
		inGene_mut((conv_integer(mutPoint(log2(num_towns)-1 downto 0))+1)*log2(num_towns)-1 downto conv_integer(mutPoint(log2(num_towns)-1 downto 0))*log2(num_towns)) <= temp1;
	end if; 
	
	if rng1>conv_std_logic_vector(mr,mut_res) then 
	  mutout <= inGene;  
	else
          mutout <= inGene_mut;
	end if;
	done<='1';

when '0' => -- mutation block disabled

	rng1 <= (others=>'0');
	inGene_mut  <= (others=>'0');
	temp1 <= (others=>'0');
	temp2 <= (others=>'0');
	mutout <= mutout_p1;
	if flag='1' then
		done<='0';
	else
		done<=done_p;
	end if;

when others =>
	
end case;

end process mutation_tsp;

end rtl;