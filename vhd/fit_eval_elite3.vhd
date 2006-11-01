-------------------------------------------------------------------------------
-- Title      : Fitness Evaluation block
-- Project    : genetic Algorithm
-------------------------------------------------------------------------------
-- File       : fit_eval_elite3.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 08/08/06
-- Last update: 08/08/06
-- Platform   : Modelsim & Synplify & Xilinx ISE
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This block implements the fitness evaluation block 
-- ATTENTION  : FOR MORE THAN ONE ELITE CHILD 
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
entity fit_eval_elite3 is
  generic(
           genom_lngt  : positive := 4; 
           score_sz    : integer :=  6;
           pop_sz      : positive := 8;
           elite       : positive := 3
           );  
           
  port ( clk         : in  std_logic;  -- clock
         rst_n       : in  std_logic;  -- reset (active low)
         decode      : in  std_logic;					       -- evaluation after rng_s or after mut_s
         valid	     : in  std_logic;					       -- if H compute else if L don't 
	 elite_null  : in  std_logic;					       -- if H 
	 in_genes    : in  std_logic_vector(2*genom_lngt-1 downto 0);          -- both mutation or rng fill evaluation block 
	 index       : in  integer;					       -- the address of the current gene
	 count_parents : in  integer;					       -- how many parents have been selected
 	 gene_score  : out std_logic_vector(genom_lngt+score_sz-1 downto 0);   -- ingene and its fitness value
 	 elite_offs  : out int_array(0 to elite-1);                            -- addresses of elite children (integer)
	 fit_sum     : out std_logic_vector(score_sz+log2(pop_sz)-1 downto 0); -- sum of fitnesses
	 max_fit     : out std_logic_vector(score_sz-1 downto 0);              -- maximum fitness
	 rd 	     : out std_logic
         );
end entity fit_eval_elite3;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of fit_eval_elite3 is
  subtype score is std_logic_vector( score_sz-1 downto 0 );  
  type fit_array is array (natural range 0 to elite-1) of score;

  signal gene_scr      : std_logic_vector(genom_lngt+score_sz-1 downto 0) := (others=>'0');
  signal gene	       : std_logic_vector(genom_lngt-1 downto 0):= (others=>'0');
  signal fit           : std_logic_vector(score_sz-1 downto 0) := (others=>'0');
  signal sum           : std_logic_vector(score_sz+log2(pop_sz)-1 downto 0) := (others=>'0'); -- accumulated sum of fitnesses
  signal sum_p         : std_logic_vector(score_sz+log2(pop_sz)-1 downto 0):= (others=>'0');  -- previous accumulated sum of fitnesses
  signal best_fit      : fit_array:= (others=>(others=>'0'));
  signal best_fit_prev_gen      : fit_array:= (others=>(others=>'0'));
  signal temp1	       : fit_array:= (others=>(others=>'0'));
  signal temp2         : fit_array:= (others=>(others=>'0'));
  signal elite_indexs  : int_array(0 to elite-1):= (others=>0);
  signal temp_indexs_1 : int_array(0 to elite-1):= (others=>0);
  signal temp_indexs_2 : int_array(0 to elite-1):= (others=>0);
  signal cont	       : std_logic:='0';
  signal cont2	       : std_logic;
  signal fin	       : std_logic;
  signal done_p        : std_logic;
  signal done          : std_logic;
  signal equal         : std_logic;
  signal nParents      : integer;
  signal counter       : integer;
 
begin

process (clk, rst_n)

begin
	if rst_n = '0' then
		gene_score <= (others=>'0');
		done_p <= '0';
	elsif rising_edge(clk) then
		gene_score <= gene_scr;
		done_p <= done;
	end if;
end process;

fit_eval_elite: process (in_genes,gene,fit,decode,valid,sum_p)

begin	

	if valid='1' then -- evaluate gene
		if decode = '1' then	 -- pick out the rng offspring
			gene <= in_genes(2*genom_lngt -1 downto genom_lngt);
		elsif decode = '0' then  -- pick out the mutation offspring
			gene <= in_genes(genom_lngt -1 downto 0);
		end if; 
		fit <= shl(ext(gene,score_sz),"1");-- simple fitness function (score = 2*gene)
		--fit <= gene*gene;
		gene_scr <= gene & fit;
		sum <= sum_p + fit;
		
	elsif valid='0' then
	 	sum <=(others=>'0');
	 	fit <=(others=>'0');
		gene <= (others=>'0');
	        -- do nothing, preserve same outputs
	end if; -- valid

end process fit_eval_elite;


process (clk, rst_n)

begin
	if rst_n = '0' then
		rd<='0';
		equal <= '0';
		cont<='0';
		cont2<='0';
		fin <= '0';
		counter <= 0;
		max_fit <= (others=>'0');
		fit_sum <= (others=>'0');
		sum_p <= (others=>'0');
		for i in elite-1 downto 0 loop
			elite_offs(i) <= 0;
			elite_indexs(i) <= 0;
			temp_indexs_1(i) <= 0;
			temp_indexs_2(i) <= 0;
		end loop;		
		for i in elite-1 downto 0 loop
			best_fit(i) <= (others=>'0');
			best_fit_prev_gen(i) <= (others=>'0');
			temp1(i) <= (others=>'0');
			temp2(i) <= (others=>'0');
		end loop;
		
	elsif rising_edge(clk) then
		nParents <= 2*(pop_sz-elite);
		if valid='1' then
			
			-- 1st clock cycle	
			if cont='0' and fin ='0' then 
				for i in elite-1 downto 1 loop 
					if fit = best_fit(i) or fit = best_fit(i-1)then 
						equal <= '1';
					end if;
					temp1(i) <= best_fit(i-1);
					temp2(i) <= best_fit(i);
					temp_indexs_1(i) <= elite_indexs(i-1);
					temp_indexs_2(i) <= elite_indexs(i);
					if i=1 then 
						temp1(0) <= (others=>'0');
						temp2(0) <= best_fit(0); 
						temp_indexs_1(0) <= 0;
						temp_indexs_2(0) <= elite_indexs(0);
						cont <= '1';
					else 
						cont <= '0';
					end if;
				end loop;
			end if;
			
			-- 2nd clock cycle
			if cont='1' and  cont2='0' and fin ='0' then --  and equal = '0'
				for i in elite-1 downto 1 loop -- for more than one elite child !!!!!!!!!

					if temp1(i) < fit and temp2(i) < fit and temp1(i)/=temp2(i) then 
						best_fit(i) <= temp1(i);
						elite_indexs(i) <= temp_indexs_1(i); 
					elsif temp1(i) > fit and temp2(i) > fit and temp1(i)/=temp2(i) then 
						best_fit(i) <= temp2(i);
						elite_indexs(i) <= temp_indexs_2(i);
					elsif temp1(i) = temp2(i) and fit > temp1(i) then
						best_fit(i) <= temp1(i);
						elite_indexs(i) <= temp_indexs_1(i);
					elsif temp1(i) = temp2(i) and fit < temp1(i) then
						best_fit(i) <= temp2(i);
						elite_indexs(i) <= temp_indexs_2(i);
						
					elsif temp1(i) >= fit and temp2(i) < fit then 
						best_fit(i) <= fit;
						elite_indexs(i) <= index;
					end if; 
					
					if i=1  then 
						
						if fit > temp2(0) then 
							best_fit(0) <= fit;
							elite_indexs(0) <= index;						
						else 				
							best_fit(0) <= temp2(0);
							elite_indexs(0) <= temp_indexs_2(0);
						end if;	
						cont2 <= '1';
						cont<='0';
					else 
						cont2 <= '0';
					end if;
				end loop;
				
			-- elsif cont='1' and  cont2='0'  and equal = '1' then 
				-- nothing -- this gene doesnot affect
			--	cont2 <= '1';
			end if;			
				
			-- 3rd clock cycle
			if cont2='1' then 
				rd<='1';
				done<='1';
				max_fit <= best_fit(0);
				
				if count_parents < 2*elite+1 and decode = '0' then 
					
					fit_sum <= sum +  best_fit_prev_gen(counter);
					sum_p <= sum +  best_fit_prev_gen(counter);
				
				else 
					fit_sum <= sum;
					sum_p <= sum;
				end if;

				if counter < elite-1 then 
					counter <= counter + 1;
				else 
					counter <= 0;
				end if;					
				
				if decode='0' and valid='1' and count_parents = nParents then --  produce new elite indexes only at the last mut offs
					elite_offs <= elite_indexs;
					best_fit_prev_gen <= best_fit;
				elsif decode='1' and valid='1' then -- rng offs evaluation
					elite_offs <= elite_indexs;
					best_fit_prev_gen <= best_fit;
				end if;
				cont2<='0';
				fin <='1';
			end if;
			
		else
			cont<='0';
			fin <= '0';
			cont2<='0';
			rd<='0';
			done<='0';
			equal <= '0';
			if (count_parents = 0 and decode = '0')  or (decode = '1' and index = pop_sz - 1) then
				sum_p <= (others=>'0');
			end if;
			
			if elite_null = '1' then
				sum_p <= (others=>'0');
				max_fit <= (others=>'0');
				fit_sum <= (others=>'0');
				for i in elite-1 downto 0 loop
					elite_offs(i) <= 0;
					best_fit(i) <= (others=>'0');
					best_fit_prev_gen(i) <= (others=>'0');
					elite_indexs(i) <= 0;
				end loop;
			end if;
		end if;
	end if;
end process;

end rtl;
