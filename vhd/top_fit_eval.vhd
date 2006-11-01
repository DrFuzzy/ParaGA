-------------------------------------------------------------------------------
-- Title      : GA
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : top_fit_eval.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 12/10/2006
-- Platform   : Modelsim, Synplicity, ISE
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This is the top structural block of the Fitness Evaluation Block
--              connecting all the necessary moduless of the F.A. block together.
-------------------------------------------------------------------------------
-- Copyright (c) 2006 NTUA
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- LIBRARIES
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.dhga_pkg.all;
use work.arith_pkg.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity fit_eval_ga is
  generic (
        genom_lngt	   : positive; -- townres*(num_towns-1)
  	score_sz	   : integer; 
  	pop_sz		   : integer;
  	elite		   : integer
  	);
  
  port (
    	clk         : in  std_logic;
        rst_n       : in  std_logic;
        decode      : in  std_logic;					       -- evaluation after rng_s or after mut_s
        valid	    : in  std_logic;					       -- if H compute else if L don't 					       -- if H 
	in_genes    : in  std_logic_vector(2*genom_lngt-1 downto 0);           -- both mutation or rng fill evaluation block 	
	elite_null  : in  std_logic;					       
	index       : in  integer;					       -- the address of the current gene
	count_parents : in  integer;					       -- how many parents have been selected
 	gene_score  : out std_logic_vector(genom_lngt+score_sz-1 downto 0);   -- ingene and its fitness value
	elite_offs  : out int_array(0 to elite-1);                            -- addresses of elite children (integer)
	fit_sum     : out std_logic_vector(score_sz+log2(pop_sz)-1 downto 0); -- sum of fitnesses
	max_fit     : out std_logic_vector(score_sz-1 downto 0);              -- maximum fitness
	rd 	    : out std_logic 
 	);
 	
end entity fit_eval_ga;


-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture str of fit_eval_ga is

-- SIGNAL DECLARATION
-------------------------------------------------------------------------------

signal fit_dummy         : std_logic_vector(score_sz-1 downto 0) := (others=>'0');
signal ready_out_dummy	 : std_logic;

begin

-- COMPONENTS INSTANTIATION

-------------------------------------------------------------------------------
-- Fitness Calculator : Computes the fitness of the input gene 
-------------------------------------------------------------------------------
U0 : fit_calc
  generic map (
           genom_lngt  =>  genom_lngt,
           score_sz    =>  score_sz,  
           pop_sz      =>  pop_sz
           )	       
           
  port map ( 
	 clk         => clk,          
         rst_n       => rst_n,     
         decode      => decode,    
         valid	     => valid,	   		       
	 in_genes    => in_genes,  	   
 	 gene_score  => gene_score,
 	 fit 	     => fit_dummy,   -- to fix_elite
	 ready_out   => ready_out_dummy -- to fix_elite
         );	    

-------------------------------------------------------------------------------
-- Elite fixation : Fixes the elite indexs and the array of the best fitnesses 
-------------------------------------------------------------------------------
U1 : fix_elite
  generic map (
           genom_lngt  => genom_lngt, 
           score_sz    => score_sz,  
           pop_sz      => pop_sz,    
           elite       => elite     
           )  	        
           
  port map( 
	 clk           => clk,       
         rst_n         => rst_n,     
         decode        => decode,    
         valid	       => valid,	   
	 elite_null    => elite_null,
	 index         => index,     	
	 fit           => fit_dummy,
	 count_parents => count_parents,
 	 ready_in      => ready_out_dummy,
 	 elite_offs    => elite_offs,
	 fit_sum       => fit_sum,
	 max_fit       => max_fit,
	 rd 	       => rd
         );
  
end architecture str;