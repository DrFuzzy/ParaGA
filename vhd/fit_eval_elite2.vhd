-------------------------------------------------------------------------------
-- Title      : Fitness Evaluation block
-- Project    : genetic Algorithm
-------------------------------------------------------------------------------
-- File       : fit_eval_elite.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 01/06/06
-- Last update: 01/06/06
-- Platform   : Modelsim & Synplify & Xilinx ISE
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This block implements the fitness evaluation block 
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
entity fit_eval_elite2 is
  generic(
           genom_lngt  : positive; 
           score_sz    : integer;
           pop_sz      : positive;
           elite       : positive
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
end entity fit_eval_elite2;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of fit_eval_elite2 is
  subtype score is std_logic_vector( score_sz-1 downto 0 );  
  type fit_array is array (natural range 0 to elite-1) of score;

  signal gene_scr    : std_logic_vector(genom_lngt+score_sz-1 downto 0) := (others=>'0');
  signal gene	     : std_logic_vector(genom_lngt-1 downto 0):= (others=>'0');
  signal fit         : std_logic_vector(score_sz-1 downto 0) := (others=>'0');
  signal sum         : std_logic_vector(score_sz+log2(pop_sz)-1 downto 0) := (others=>'0'); -- accumulated sum of fitnesses
  signal sum_p       : std_logic_vector(score_sz+log2(pop_sz)-1 downto 0):= (others=>'0');  -- previous accumulated sum of fitnesses
  signal best_fit    : fit_array;
  signal elite_indexs: int_array(0 to elite-1):= (others=>0);
  signal cnt         : integer:=0;
  signal cont	     : std_logic:='0';
  signal cont2	     : std_logic:='0';
  signal done_p      : std_logic:='0';
  signal done        : std_logic:='0';
  signal nParents    : integer;
  signal counter     : integer;
 
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
		fit <= sxt(shl(gene,"1"),score_sz); -- simple fitness function (score = 2*gene)
		--fit <= gene*gene;
		gene_scr <= gene & fit;
		sum <= sum_p + fit;
		
	elsif valid='0' then
	 	sum <=(others=>'0');
	 	fit <=(others=>'0');
	        -- do nothing, preserve same outputs
	end if; -- valid

end process fit_eval_elite;


process (clk, rst_n)

begin
	if rst_n = '0' then
		cnt<=0;
		rd<='0';
		cont<='0';
		cont2<='0';
		counter <= 0;
		max_fit <= (others=>'0');
		fit_sum <= (others=>'0');
		sum_p <= (others=>'0');
		for i in elite-1 downto 0 loop
			elite_offs(i) <= 0;
		end loop;		
		for i in elite-1 downto 0 loop
			best_fit(i) <= (others=>'0');
		end loop;
		
	elsif rising_edge(clk) then
		nParents <= 2*(pop_sz-elite);
		if valid='1' then
			-- 1st clock cycle
			if cont='0' then 
				for i in elite-1 downto 0 loop 
					if fit>best_fit(i) then 
						cnt<=elite -i;
					end if;
					if i=0 then 
						cont <= '1';
					else 
						cont <= '0';
					end if;
				end loop;
			end if;
			-- 2nd clock cycle
			if ((cnt/=1) and (cnt/=elite) and (cnt/=0)) and cont='1'  and  cont2='0' then 
				for j in 0 to elite loop
				if j /= cnt-1 then 
					best_fit(elite-1-j) <= best_fit(elite-1-j-1); 
					elite_indexs(elite-1-j) <= elite_indexs(elite-1-j-1);
					if j=cnt-2 then
						best_fit(elite-cnt) <= fit;
						elite_indexs(elite-cnt) <= index;
						cont2<='1';
					else 
						cont2<='0';
					end if;
				elsif j=cnt-1 then 
					exit;
				end if;
				end loop;
					
			elsif cnt=1 and cont='1' and cont2='0' then 
				best_fit(elite-1) <= fit;
				elite_indexs(elite-1) <= index;
				cont2<='1';
			
			elsif cnt=elite and cont='1' and cont2='0' then 
				for j in 0 to elite loop
				if j /= cnt-1 then 	
					best_fit(elite-1-j) <= best_fit(elite-1-j-1); 
					elite_indexs(elite-1-j) <= elite_indexs(elite-1-j-1);
					if j=cnt-2 then
						best_fit(0) <= fit;
						elite_indexs(0) <= index;
						cont2<='1';
					else 
						cont2<='0';
					end if;
				elsif j=cnt-1 then 
					exit;
				end if;
				end loop;
				
			elsif cnt=0 and cont='1' and cont2='0' then -- this gene doesnt affect either 
								    -- the max fitness or elite children
				rd<='1';
				done<='1';
				max_fit <= best_fit(0);
				
				if count_parents < 2*elite+1  and decode = '0' then 
					
					fit_sum <= sum +  best_fit(counter);
					sum_p <= sum +  best_fit(counter);

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
				elsif decode='1' and valid='1' then -- rng offs evaluation
					elite_offs <= elite_indexs;
				end if;				
				
				
				
			end if;	
			
			-- 3rd clock cycle
			if cont2='1' then 
				rd<='1';
				done<='1';
				max_fit <= best_fit(0);
				
				if count_parents < 2*elite+1 and decode = '0' then 
					
					fit_sum <= sum +  best_fit(counter);
					sum_p <= sum +  best_fit(counter);
				
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
				elsif decode='1' and valid='1' then -- rng offs evaluation
					elite_offs <= elite_indexs;
				end if;
			end if;
			
		else
			cnt<=0;
			cont<='0';
			cont2<='0';
			rd<='0';
			done<='0';
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
					elite_indexs(i) <= 0;
				end loop;
			end if;
		end if;
	end if;
end process;

end rtl;
