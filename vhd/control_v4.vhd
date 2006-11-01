--  c:\documents and settings\delk\...\control2.vhd
--  vhdl code created by xilinx's statecad 7.1i
--  thu apr 06 19:11:20 2006

--  this vhdl code (for use with ieee compliant tools) was generated using: 
--  enumerated state assignment with structured code format.
--  minimization is enabled,  implied else is disabled, 
--  and outputs are manually optimized.


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.dhga_pkg.all;
use work.arith_pkg.all;

entity control_v4 is
  	generic(
           	genom_lngt	: integer;
           	max_gen		: positive;
		pop_sz		: integer;
		score_sz	: integer;
		elite		: integer
           	); 
	port ( 
	       clk      	: in std_logic;
	       rst_n    	: in std_logic;
	       done     	: in std_logic;
	       fit_eval_rd 	: in std_logic;
	       sel_rd   	: in std_logic;
	       cross_rd 	: in std_logic;
	       mut_rd   	: in std_logic;
	       term_rd  	: in std_logic;
	       run_ga		: in std_logic;
	       
	       elite_offs	: in int_array(0 to elite-1);    -- addresses of elite children (integer) 
	       data_in_ram2	: in  std_logic_vector(genom_lngt-1 downto 0); -- Parent from RAM 2
	       mut_method	: in  std_logic_vector(1 downto 0);
	       data_out_cross1	: out std_logic_vector(genom_lngt-1 downto 0);
	       data_out_cross2	: out std_logic_vector(genom_lngt-1 downto 0);
	       addr_1		: out integer;
	       addr_2		: out integer;
	       cnt_parents      : out integer;
	       we1              : out std_logic;
	       we2              : out std_logic;
	       
	       data_valid   	: out std_logic; 
	       next_gene   	: out std_logic; 
	       clear     	: out std_logic;
	       ga_fin     	: out std_logic;
	       cross_out 	: out std_logic;
	       valid            : out std_logic;
	       elite_null       : out  std_logic;
	       index		: out integer;    -- memory address of the current gene 
	       mut_out   	: out std_logic;
	       flag	        : out  std_logic;
	       decode		: out std_logic;
	       sel_out   	: out std_logic;
	       term_out  	: out std_logic;
	       --rng	     	: out std_logic;
	       run		: out std_logic;
	       run1		: out std_logic;
	       run2		: out std_logic;
	       run3		: out std_logic;
	       load		: out std_logic
	       );
end control_v4;

architecture rtl of control_v4 is
	type type_sreg is (clear_ram_s, cross_s, done_s, fill_ram_s, fit_eval_s, mut_s, sel_s,
	                   read_write_ram_1_s,read_write_ram_2_s);
	                   
	signal sreg, next_sreg     : type_sreg;  
	signal mut_rd_p1           : std_logic;
	signal rng_rd_p1           : std_logic;
	signal rng_rd              : std_logic;
	signal term_rd_p1          : std_logic;
	signal data_out_cross1_p1  : std_logic_vector(genom_lngt-1 downto 0);
	signal data_out_cross2_p1  : std_logic_vector(genom_lngt-1 downto 0);
	--signal temp_cross1	   : std_logic_vector(genom_lngt-1 downto 0);
	signal incr_p1		   : integer;
	signal count_offs	   : integer;
	signal count2		   : integer;
	signal count_offs_p1	   : integer;
	signal count_gen	   : integer;
	signal count_sel_wr_p1	   : integer;
	signal count_sel_rd_p1 	   : integer;
	signal count_parents_p1    : integer;
	signal count_cross_offs_p1 : integer;
	signal count_sel_wr	   : integer;
	signal count_sel_rd 	   : integer;
	signal count_parents       : integer;
	signal count_cross_offs    : integer;
	signal dummy_eval1_p1	   : std_logic;
	signal dummy_eval2_p1      : std_logic;
	signal dummy_eval3_p1      : std_logic;
	signal dummy_sel_p1        : std_logic;
	signal dummy_ram1_p1 	   : std_logic;
	signal dummy_ram2_p1       : std_logic;
	signal dummy_mut_p1        : std_logic;
	signal dummy_eval1	   : std_logic;
	signal dummy_eval2         : std_logic;
	signal dummy_eval3         : std_logic;
	signal dummy_sel	   : std_logic;
	signal dummy_ram1          : std_logic;
	signal dummy_ram2	   : std_logic;
	signal dummy_cnt_adapt	   : std_logic;
	signal dummy_mut	   : std_logic;
	signal cnt_adapted	   : std_logic;
	signal ga_fin_r		   : std_logic;
	signal incr		   : integer;
	signal nParents		   : integer;
	signal next_generation     : std_logic;
begin
	process (clk, rst_n)
	begin
		if (rst_n = '0') then
			sreg <= clear_ram_s;
			mut_rd_p1 <= '0';
			term_rd_p1 <= '0';
			rng_rd_p1 <= '0';
			data_out_cross1 <= (others=>'0');
			data_out_cross2 <= (others=>'0');
			dummy_eval1_p1 <= '0';
			dummy_eval2_p1 <= '0';
			dummy_eval3_p1 <= '0';
			dummy_sel_p1 <= '0';
			dummy_ram1_p1 <= '0';
			dummy_ram2_p1 <= '0';
			dummy_mut_p1 <= '0';
			count_offs_p1 <= 0;
			count_gen <= 0;
			count_sel_wr_p1 <= 0;
			count_sel_rd_p1 <= 0;
			count_parents_p1 <= 0;
			count_cross_offs_p1 <= 0;
			cnt_parents <= 0;
			ga_fin <= '0';
			
		elsif clk = '1' and clk'event then
			sreg <= next_sreg;
			
			mut_rd_p1 <= mut_rd;
			term_rd_p1 <= term_rd;
			rng_rd_p1 <= rng_rd;
			data_out_cross1 <= data_out_cross1_p1;
			data_out_cross2 <= data_out_cross2_p1;
			dummy_eval1_p1 <= dummy_eval1;
			dummy_eval2_p1 <= dummy_eval2;
			dummy_eval3_p1 <= dummy_eval3;
			dummy_sel_p1 <= dummy_sel;
			dummy_ram1_p1 <= dummy_ram1;
			dummy_ram2_p1 <= dummy_ram2;
			dummy_mut_p1 <= dummy_mut;
			count_offs_p1 <= count_offs;
			--index <= count_offs;
			count_gen <= count2;
			count_sel_wr_p1 <= count_sel_wr;
			count_sel_rd_p1 <= count_sel_rd;
			count_parents_p1 <= count_parents;
			count_cross_offs_p1 <= count_cross_offs;			
			cnt_parents <= count_parents;
			ga_fin <= ga_fin_r;
			--addr_ram1 <= addr_1;
			--addr_ram2 <= addr_2;

		end if;
	end process;
	
	
process (clk, rst_n)

begin
	if rst_n = '0' then
		cnt_adapted <= '0';
		--equal <= '0';
		incr <= 0;
		incr_p1 <= 0;
	elsif rising_edge(clk) then
		incr_p1 <= incr;
		--((fit_eval_rd = '1') and (mut_rd_p1 = '1')) or
		if  (dummy_cnt_adapt = '1') then 
						
			for i in 0 to elite-1 loop 
				if count_offs_p1+incr = elite_offs(i) then -- mpike to incr 
					incr <= incr_p1 + 1;
					--equal <= '0';
					cnt_adapted <= '0';
					exit;
				elsif count_offs_p1+incr /= elite_offs(i) and i=elite-1 then
					--incr <= incr_p1;
					--equal <= '1';
					cnt_adapted <= '1';
				end if;
			end loop;
		else 
			--cnt_adapted <= '0'; 
		end if;
		
		if dummy_eval2 = '1' then 
			incr <= 0;
			cnt_adapted <= '0';
		end if;
	
	end if;
end process;
	

	
	-- sensitivity list needs update -- 
process (sreg, sel_rd, cross_rd, mut_rd, mut_rd_p1, done, term_rd, term_rd_p1, rng_rd_p1, fit_eval_rd,
	 dummy_eval1_p1, dummy_eval2_p1, dummy_eval3_p1, dummy_sel_p1, dummy_ram1_p1, dummy_ram2_p1,nParents,
	 count_offs_p1, count_gen, count_sel_wr_p1, count_sel_rd_p1, count_parents_p1, count_cross_offs_p1,
	 data_in_ram2, incr_p1, cnt_adapted, dummy_cnt_adapt,incr,dummy_mut_p1,elite_offs,run_ga,mut_method,next_generation )

	begin       
		--clear <= '0'; 
		--cross_out <= '0';  
		--mut_out <= '0';   
		--sel_out <= '0';   
		--term_out <= '0'; 
		--we1 <= '0'; 
		--we2 <= '0';
		--run <= '0';
		--run1 <= '0';
		--run2 <= '0';
		--run3 <= '0';
		--data_out_cross1 <= (others=>'0');
		--data_out_cross2 <= (others=>'0');
		--addr_1 <= 0;		
		--addr_2 <= 0;            
		next_sreg <= fill_ram_s;
		nParents <= 2*(pop_sz-elite);
		
		case sreg is   
		
			when clear_ram_s =>
				
				if run_ga = '1' then 
					next_generation <= '0';
					clear <= '1';
					ga_fin_r <= '0';
					load <= '1';
					flag <= '0';
					cross_out <= '0';
					valid <= '0'; -- to fitness evaluation
					dummy_cnt_adapt <= '0';
					index <= 0;
					mut_out <= '0';
					sel_out <= '0';
					term_out <= '0';
					we1 <= '0'; 
					we2 <= '0';
					run1 <= '0';
					run2 <= '0';
					run3 <= '0';
					elite_null <= '1';
					
					dummy_eval1 <= '0';
					dummy_eval2 <= '0';
					dummy_eval3 <= '0';
					dummy_sel  <= '0';
					dummy_ram1 <= '0';
					dummy_ram2 <= '0';
					dummy_mut <= '0';
					
					data_out_cross1_p1 <= (others=>'0');
					data_out_cross2_p1 <= (others=>'0');
					
					count2 <= 0;           -- generation counter (count_gen)
					count_offs <= 0;       -- offspring counter
					count_sel_wr <= 0;     -- counts the addresses where the selected offs. must written (so it simultaneously counts how many parents I have selected and written)
					count_sel_rd <= 0;     -- counts the addresses from where the offs. for selection must be read
					count_parents <= 0;    -- counter of the selected parents
					count_cross_offs <= 0; -- counter which notifies that I have selected 2 offs. in order to proceed to crossover
					run <= '1';	       -- produce new random number
					rng_rd <= '0';
					next_sreg <= fill_ram_s;
					
					decode <= '0';
					data_valid <= '0';
					next_gene <= '0';
					addr_1 <= 0; 
					addr_2 <= 0; 
				else 
					next_generation <= '0';
					clear <= '0';
					load <= '0';
					flag <= '0';
					cross_out <= '0';
					valid <= '0'; -- to fitness evaluation
					dummy_cnt_adapt <= '0';
					index <= 0;
					mut_out <= '0';
					sel_out <= '0';
					term_out <= '1';
					we1 <= '0'; 
					we2 <= '0';
					run1 <= '0';
					run2 <= '0';
					run3 <= '0';
					elite_null <= '0';
					
					dummy_eval1 <= '0';
					dummy_eval2 <= '0';
					dummy_eval3 <= '0';
					dummy_sel  <= '0';
					dummy_ram1 <= '0';
					dummy_ram2 <= '0';
					dummy_mut <= '0';
					
					data_out_cross1_p1 <= (others=>'0');
					data_out_cross2_p1 <= (others=>'0');
					
					count2 <= 0;           -- generation counter (count_gen)
					count_offs <= 0;       -- offspring counter
					count_sel_wr <= 0;     -- counts the addresses where the selected offs. must written (so it simultaneously counts how many parents I have selected and written)
					count_sel_rd <= 0;     -- counts the addresses from where the offs. for selection must be read
					count_parents <= 0;    -- counter of the selected parents
					count_cross_offs <= 0; -- counter which notifies that I have selected 2 offs. in order to proceed to crossover
					run <= '0';	       -- produce new random number
					rng_rd <= '0';
					
					next_sreg <= clear_ram_s;
					
					decode <= '0';
					data_valid <= '0';
					next_gene <= '0'; 
					addr_2 <= 0;
					addr_1 <= elite_offs(0);
					
				end if;
				
			when fill_ram_s =>
				next_generation <= '0';
				clear <= '0';
				ga_fin_r <= '0';
				cross_out <= '0';
				elite_null <= '0';
				load <= '0';
				run  <= '0';
				run1 <= '0'; -- prepei na kratithei toul 3 clocks
				run2 <= '0';
				run3 <= '0';
				mut_out <= '0';
				sel_out <= '0';
				term_out <= '0';
				we1 <= '0'; 
				we2 <= '0';
				rng_rd <= '1'; -- notify --
				next_sreg <= fit_eval_s;
				--eval <= '1';
				decode <= '1';
				valid <= '1';
				index <= count_offs_p1;
				
			when fit_eval_s =>
				next_generation <= '0';
				clear <= '0';
				ga_fin_r <= '0';
				cross_out <= '0';
				--eval <= '1';
				run  <= '0';
				run1 <= '0';
				run2 <= '0';
				run3 <= '0';
				mut_out <= '0'; -- to mutation de tha ypologisei alla tha kratisei previous results
				sel_out <= '0';
				term_out <= '0';
				we2 <= '0';
				dummy_sel <= '0';
				dummy_ram1 <= '0';
				dummy_ram2 <= '0';
				elite_null <= '0';
				--rng_rd <= '0';

				if (fit_eval_rd = '1') and (rng_rd_p1 = '1') then -- 1st generation's evaluation     ok
					next_sreg <= read_write_ram_1_s;  -- write to ram1 
					we1 <= '1';
					addr_1 <= count_offs_p1; 
					dummy_eval1 <= '1'; -- notify 
					dummy_eval2 <= '0';
					valid<= '0';
					flag <= '0';
				end if;
								
				if (fit_eval_rd = '1') and (mut_rd_p1 = '1') then -- evaluate new offspring 
					rng_rd <= '0';
					flag <= '1';
					if cnt_adapted = '1' then 
						next_sreg <= read_write_ram_1_s;
						if (count_offs_p1 + incr_p1)< pop_sz then 
							addr_1 <= count_offs_p1 + incr;
							count_offs <= count_offs_p1 + incr_p1 + 1; -- increment of produced offsprings
							we1 <= '1';
							--valid <= '0';
							dummy_eval2 <= '1';
							dummy_eval1 <= '0';
							dummy_eval3<= '0';
							dummy_cnt_adapt <= '0';
							--mut_out <= '0';
						else
							addr_1 <= 0;
							we1 <= '0';
							valid <= '0';
							count_offs <= pop_sz;
							dummy_eval2 <= '1';
							dummy_eval1 <= '0';
							dummy_eval3<= '0';
							--mut_out <= '0';
						end if;

					else
						next_sreg <= fit_eval_s;
						we1 <= '0';
						dummy_eval2 <= '0';
						dummy_eval1 <= '0';
						dummy_eval3 <= '1'; -- notify
						valid<= '1';
						--mut_out <= '0';
						
					end if;					
				end if;	
				
				if (dummy_eval3_p1='1') and (cnt_adapted = '0') then
						next_sreg <= fit_eval_s;
						we1 <= '0';
						rng_rd <= '0';
						dummy_eval2 <= '0';
						dummy_eval1 <= '0';
						dummy_eval3 <= '1'; -- notify
						valid<= '1';
						--mut_out <= '0';
						
				elsif (dummy_eval3_p1='1') and (cnt_adapted = '1') then
						next_sreg <= read_write_ram_1_s;
						
						if (count_offs_p1 + incr_p1)< pop_sz then 
							addr_1 <= count_offs_p1 + incr;
							count_offs <= count_offs_p1 + incr_p1 + 1; -- increment of produced offsprings
							we1 <= '1';
							rng_rd <= '0';
							valid <= '0';
							dummy_eval2 <= '1';
							dummy_eval1 <= '0';	
							dummy_eval3 <= '0';
							dummy_cnt_adapt <= '0';
						else 
							addr_1 <= 0;
							we1 <= '0';
							rng_rd <= '0';
							valid <= '0';
							count_offs <= pop_sz;
							dummy_eval2 <= '1';
							dummy_eval1 <= '0';
							dummy_eval3 <= '0';
						end if;
							
				end if;
				
				
				
				if (fit_eval_rd = '0') and (dummy_eval3_p1='0') then  -- fitness evaluation not ready yet
					next_sreg <= fit_eval_s;
					--rng_rd <= '0';
					we1 <= '0';
					dummy_eval2 <= '0';
					dummy_eval1 <= '0';
					dummy_eval3 <= '0';
					valid<= '1';
				end if;
				
			when read_write_ram_1_s =>
				clear <= '0';
				ga_fin_r <= '0';
				cross_out <= '0';
				--eval <= '1';
				valid <= '0';
				mut_out <= '0';
				term_out <= '0';
				flag <= '0';
				we2 <= '0';
				we1 <= '0';
				run1 <= '0';
				run2 <= '0';
				dummy_eval1 <= '0';
				dummy_eval2 <= '0';
				dummy_eval3 <= '0';
				dummy_sel <= '0';
				dummy_ram2 <= '0';
				rng_rd <= '0';
				if ( dummy_eval1_p1='1' ) and (count_offs_p1 /= pop_sz-1) then
									                      
					next_sreg <= fill_ram_s; -- produce and evaluate new gene of first generation
					addr_1 <= count_offs_p1;
					run  <= '1';
					run3 <= '0';
					count_offs <= count_offs_p1 + 1;
					sel_out <= '0';
					term_out <= '0';
					dummy_ram1 <= '0';
					next_generation <= '0';
				end if;
				if (dummy_eval1_p1='1') and (count_offs_p1 = pop_sz-1) then
								                             -- ok
					next_sreg <= read_write_ram_1_s; -- read first gene for selection block (Parents selection)
					addr_1 <= count_sel_rd_p1; -- address of the gene needed for selection
					count_offs <= 0; -- initialize counter_offs for evaluation of this generation has ended 
					run  <= '0';
					run3 <= '1'; -- alaksa
					sel_out <= '0';
					term_out <= '0';
					dummy_ram1 <= '1'; -- notify state that I was here
					next_generation <= '0';
				end if;	
				
				if (dummy_ram1_p1 = '1') then 
				   
					next_sreg <= sel_s; -- I already have read one gene from ram 1 and go to selection   -- ok
					count_sel_rd <= count_sel_rd_p1 + 1; -- next gene for reading if needed
					sel_out <= '1';
					data_valid <= '1';
					run  <= '0';
					run3 <= '0'; -- allaksa
					term_out <= '0';
					dummy_ram1 <= '0';
					next_gene <= '0';
					next_generation <= '0';
				end if;					
				
				
				if (dummy_sel_p1 = '1') then
				   			
					next_sreg <= sel_s; -- have read next gene needed for selection  -- ok
					if count_sel_rd_p1 /= pop_sz - 1 then
						count_sel_rd <= count_sel_rd_p1 + 1; -- next gene for reading if needed
					else 
						count_sel_rd <= 0;
					end if;
					sel_out <= '1';
					data_valid <= '1';
					run  <= '0';
					run3 <= '0'; -- changed to 0
					term_out <= '0';
					dummy_ram1 <= '0';
					next_gene <= '1';
					next_generation <= '0';
				end if;				
				
				if (dummy_ram2_p1='1') then 
				   
					next_sreg <= sel_s; -- have read next gene from ram1 in order to be fed in selection block
					count_sel_rd <= count_sel_rd_p1 + 1;
					data_valid <= '1';
					sel_out <= '1';
					run  <= '0';
					run3 <= '0';
					term_out <= '0';
					dummy_ram1 <= '0';
					next_generation <= '0';
				end if;					
				
				if (dummy_ram2_p1='0') and (term_rd_p1='1') and (dummy_eval2_p1='0') and (dummy_eval1_p1='0') then
				   
					next_sreg <= sel_s; -- came here from done_s because max num of generations and fitness limit have   
					                    -- not been reached and so we continue with selection of the new generation
					count_sel_rd <= count_sel_rd_p1 + 1;
					sel_out <= '1';
					data_valid <= '1';
					run  <= '0';
					run3 <= '0'; -- allaksa
					term_out <= '0';
					dummy_ram1 <= '0';
					load <= '0';
					next_generation <= '0';
				end if;					
				
				if  (dummy_eval2_p1='1') and (count_parents_p1 /= nParents) then -- from fitness evaluation 
				
					next_sreg <= read_write_ram_2_s; -- read next parent from ram2
					addr_2 <= count_parents_p1;
					we2 <= '0';
					count_parents <= count_parents_p1 +1;
					--count_offs <= count_offs_p1 + incr_p1 + 1; -- increment of produced offsprings
					run  <= '0';
					run3 <= '0';
					sel_out <= '0';
					term_out <= '0';
					dummy_ram2 <= '1'; -- notify -- was dummy ram 1
					count_cross_offs <= count_cross_offs_p1 +1; --- TORA MPIKE
					next_generation <= '0';
				end if;				
				
				if (dummy_eval2_p1='1') and (count_parents_p1 = nParents) then
				
					next_sreg <= done_s;
					run  <= '0';
					run3 <= '0';
					addr_1 <= elite_offs(0);
					--count_offs <= 0;  -- counter initialized
					--count_parents <= 0; -- counter initialized
					sel_out <= '0';
					term_out <= '1';
					dummy_ram1 <= '0'; 
					next_generation <= '1';
				end if;					
				
				
							
				
			when sel_s =>
				next_generation <= '0';
				clear <= '0';
				ga_fin_r <= '0';
				cross_out <= '0';
				--eval <= '0';
				valid  <= '0';
				run  <= '0';
				run1 <= '0';
				run2 <= '0';
				--run3 <= '0'; -- alakse
				mut_out <= '0';
				term_out <= '0';
				we1 <= '0';
				dummy_eval1 <= '0';
				dummy_eval2 <= '0';
				dummy_eval3 <= '0';
				dummy_ram1 <= '0';				
				dummy_ram2 <= '0';
				rng_rd <= '0';
				
				if (sel_rd = '1')  then             -- the parent is ready to be written in ram 2   ok
					next_sreg <= read_write_ram_2_s;
					addr_2 <= count_sel_wr_p1; -- where to write the parent in ram2   
					count_sel_rd <= 0;         -- initialize counter of reading genes for selection
					--run3 <= '0';
					we2 <= '1';                -- write enable 
					dummy_sel <= '0';
					--next_gene <= '0';
					sel_out <= '1'; --changed
				
				elsif (sel_rd = '0') then  -- new gene is needed to be read from ram1 
					next_sreg <= read_write_ram_1_s;
					we2 <= '0';
					--run3 <= '1';
					addr_1 <= count_sel_rd_p1;
					dummy_sel <= '1'; -- notify write_ram1 state that I was here
					sel_out <= '1';	  -- selection block remains enabled
					next_gene <= '0';
					--data_valid <= '0';-- but does affect any of its previous outputs/signals
				end if;
				
			when read_write_ram_2_s =>
				next_generation <= '0';
				clear <= '0';
				ga_fin_r <= '0';
				mut_out <= '0';
				--eval <= '0';
				valid <= '0';
				term_out <= '0';
				--sel_out <= '0'; 
				data_valid <= '0';
				we1 <= '0';
				run  <= '0';				
				--run3 <= '0'; changed
				
				dummy_eval1 <= '0';
				dummy_eval2 <= '0';
				dummy_eval3 <= '0';
				dummy_sel <= '0';				
				dummy_ram1 <= '0';				
				rng_rd <= '0';				
				
				if count_sel_wr_p1/=nParents-1 and (dummy_ram1_p1 = '0') and (dummy_ram2_p1='0') then   -- nParents not selected yet    ok
					next_sreg <= read_write_ram_1_s; -- read again from the beginning genes for next selection
					addr_1 <= count_sel_rd_p1; -- counter has been already initialized
					count_sel_wr <= count_sel_wr_p1 + 1; -- where the new selected parent must be written in ram2 
					cross_out <= '0';
					next_gene <= '0';
					run1 <= '0';
					run2 <= '0';
					run3 <= '1';
					we2 <= '0';
					dummy_ram2 <= '1'; -- notify write_ram1 state that I was here
				end if;
				
				if count_sel_wr_p1=nParents-1 and (count_cross_offs_p1/=2) and (dummy_ram2_p1='0') then  -- nParents selected 
					next_sreg <= read_write_ram_2_s; -- must read 1st parent for crossover
					addr_2 <= count_parents_p1;      -- must be zero
					count_parents <= count_parents_p1 +1; -- increment of counter for 2nd (next) parent
					cross_out <= '0';
					run1 <= '0';
					run2 <= '0';
					run3 <= '0'; -- changed 6/10
					we2 <= '0';
					dummy_ram2 <= '1'; -- notify I was here and have selected the 1st parent
					count_cross_offs <= count_cross_offs_p1 +1; -- increment of counter that counts the parents been driven to crossover
				end if;
				
				if (dummy_ram2_p1='1') and (count_cross_offs_p1=1) then 
					next_sreg <= read_write_ram_2_s; -- read ram 2 (parents) again because you have to pick 2 parents for crossover
					addr_2 <= count_parents_p1; -- here lies the next parent
					data_out_cross1_p1 <= data_in_ram2;
					count_parents <= count_parents_p1 +1;	-- increment of counter for next parent	
					cross_out <= '0';
					run1 <= '0';
					run2 <= '0';
					run3 <= '0';
					we2 <= '0';
					dummy_ram2 <= '1'; -- notify I was here and have picked a parent from ram2 
					count_cross_offs <= count_cross_offs_p1 +1; -- increment of counter that counts the parents been driven to crossover
				end if;				

				if (dummy_ram2_p1='1') and (count_cross_offs_p1=2) then 
					next_sreg <= read_write_ram_2_s; -- read ram 2 (parents) again because you have to pick 2 parents for crossover
					--addr_2 <= count_parents_p1; -- here lies the next parent
					data_out_cross2_p1 <= data_in_ram2;
					--count_parents <= count_parents_p1 +1;	-- increment of counter for next parent	
					cross_out <= '0';
					run1 <= '1'; -- changed
					run2 <= '1'; -- changed
					run3 <= '0';
					we2 <= '0';
					dummy_ram2 <= '1'; -- notify I was here and have picked a parent from ram2 
					count_cross_offs <= count_cross_offs_p1 +1; -- increment of counter that counts the parents been driven to crossover
				end if;					
				
				
				if (dummy_ram2_p1='1') and (count_cross_offs_p1=3) then
					next_sreg <= cross_s; -- already picked 2 parents and ready to continue to crossover
					count_sel_wr <= 0;  -- initialize counter where selected genes are written (selection has already ended)
					cross_out <= '1';
					--data_out_cross1 <= data_out_cross1_p1;
					--data_out_cross2 <= data_in_ram2(genom_lngt+score_sz-1 downto score_sz);
					--if mut_method = "10" then 
						run1 <= '1';
					--else 
					--	run1 <= '0';
					--end if;
					run2 <= '0'; -- changed
					run3 <= '0';
					we2 <= '0';
					dummy_ram2 <= '0';
				end if;					
				
				--if (dummy_ram1_p1='1') then
				--	next_sreg <= read_write_ram_2_s;        -- read ram 2 (parents) again because you have to pick 2 parents for crossover
				--	addr_2 <= count_parents_p1;             -- where lies the next parent
				--	count_parents <= count_parents_p1+1;    -- increment of counter for next parent	
				--	cross_out <= '0';
				--	run1 <= '0';
				--	run2 <= '0';
				--	we2 <= '0';
				--	dummy_ram2 <= '1'; -- notify I was here and have picked a parent from ram2 
				--	count_cross_offs <= count_cross_offs_p1 + 1; -- increment of counter that counts the parents been driven to crossover
				--end if;
							
			when cross_s =>
				next_generation <= '0';
				clear <= '0';
				ga_fin_r <= '0';
				--eval <= '0';
				valid <= '0';
				sel_out <= '0';
				term_out <= '0';
				we1 <= '0';
				we2 <= '0';
				run  <= '0';
				
				run2 <= '0'; -- changed
				run3 <= '0';
				count_cross_offs <= 0; -- initialize counter which counts how many parents have picked for crossover & mutation....
				
				dummy_eval1 <= '0';
				dummy_eval2 <= '0';
				dummy_eval3 <= '0';
				dummy_sel <= '0';
				dummy_ram1 <= '0';
				dummy_ram2 <= '0';
				rng_rd <= '0';
				
				if (cross_rd = '1') then -- crossover ready
					next_sreg <= mut_s;
					mut_out <= '1';
					cross_out <= '0';
					if mut_method = "10" then 
						run1 <= '1';
					else 
						run1 <= '0';
					end if;
					--run1 <= '0'; -- changed for mut = 0
				end if;
				
				if (cross_rd = '0') then
					next_sreg <= cross_s;
					mut_out <= '0';
					cross_out <= '1';
					run1 <= '0';
				end if;
				
			when mut_s =>
				next_generation <= '0';
				clear <= '0';
				ga_fin_r <= '0';
				cross_out <= '0';
				sel_out <= '0';
				term_out <= '0';
				we2 <= '0';
				we1 <= '0';
				run  <= '0';
				run2 <= '0';
				
				run3 <= '0';
				
				dummy_eval1 <= '0';
				dummy_eval2 <= '0';
				dummy_eval3 <= '0';
				dummy_sel <= '0';				
				dummy_ram1 <= '0';				
				dummy_ram2 <= '0';
				rng_rd <= '0';
				
				if (mut_rd = '1') or (dummy_mut_p1 = '1') then -- mutation ready
					if cnt_adapted = '1' then 
					next_sreg <= fit_eval_s;
					index <= count_offs_p1 + incr;
					dummy_cnt_adapt <= '0';
					valid <= '1';
					decode <= '0';
					mut_out <= '0';
					dummy_mut <= '0';
					run1 <= '0';
					else 
					next_sreg <= mut_s;
					index <= count_offs_p1;
					dummy_cnt_adapt <= '1';
					valid <= '0';
					decode <= '0';
					mut_out <= '0';
					dummy_mut <= '1';
					run1 <= '0';
					end if;
				end if;
				if (mut_rd = '0') and (dummy_mut_p1 = '0') then
					next_sreg <= mut_s;
					dummy_cnt_adapt <= '0';
					mut_out <= '1';
					valid <= '0';
					decode <= '0';
					run1 <= '1';
				end if;
			
			when done_s =>
				next_generation <= '0';
				cross_out <= '0';
				mut_out <= '0';
				sel_out <= '0';
				--eval <= '0';
				valid <= '0';
				we1 <= '0';
				we2 <= '0';
				run  <= '0';
				run1 <= '0';
				run2 <= '0';
				
				dummy_eval1 <= '0';
				dummy_eval2 <= '0';
				dummy_eval3 <= '0';
				dummy_sel <= '0';				
				dummy_ram1 <= '0';				
				dummy_ram2 <= '0';
				rng_rd <= '0';
				
				if (count_gen = max_gen-1 and term_rd = '1') then -- max gen reached
					next_sreg <= clear_ram_s; 
					ga_fin_r <= '1';
					if run_ga = '1' then 
						clear <= '1';
					else 
						clear <= '0';
					end if;
					load <= '1';
					run3 <= '0';
				end if;
				
				if (count_gen /= max_gen-1 and done = '1' and term_rd = '1') then -- fit limit reached 
					next_sreg <= clear_ram_s;
					ga_fin_r <= '1';
					if run_ga = '1' then 
						clear <= '1';
					else 
						clear <= '0';
					end if;
					load <= '1';
					run3 <= '0';
					--term_out <= '0';
				end if; 				
				
				if (count_gen /= max_gen-1 and done = '0' and term_rd = '1') then
					next_sreg <= read_write_ram_1_s;
					ga_fin_r <= '0';
					addr_1 <= count_sel_rd_p1;
					count_offs <= 0;  -- counter initialized
					count_parents <= 0; -- counter initialized
					clear <= '0';
					--term_out <= '0';
					load <= '1';
					run3 <= '1';
					count2 <= count_gen + 1;
				end if;
				
				if (term_rd = '0') then
					next_sreg <= done_s;
					ga_fin_r <= '0';
					clear <= '0';
					load <= '0';
					run3 <= '0';
					term_out <= '1';
				end if;

			when others =>
				-- empty
		end case;
	end process;	
	
end rtl;