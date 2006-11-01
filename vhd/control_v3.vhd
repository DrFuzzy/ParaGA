--  c:\documents and settings\delk\...\control2.vhd
--  vhdl code created by xilinx's statecad 7.1i
--  thu apr 06 19:11:20 2006

--  this vhdl code (for use with ieee compliant tools) was generated using: 
--  enumerated state assignment with structured code format.
--  minimization is enabled,  implied else is disabled, 
--  and outputs are manually optimized.

library ieee;
use ieee.std_logic_1164.all;

entity control is
  	generic(
           	max_gen		: positive := 5;
		cross_rate	: integer  := 230;
		mut_rate	: integer  := 25;
		popSz		: integer  := 20;	
		elite		: integer  := 2;
		paral_scale	: integer  := 2
           	); 
	port ( 
	       clk      	: in std_logic;
	       rst_n    	: in std_logic;
	       done     	: in std_logic;
	       fill_ram 	: in std_logic;
	       clear_rd	 	: in std_logic;
	       fit_eval_rd 	: in std_logic;
	       sel_rd   	: in std_logic;
	       cross_rd 	: in std_logic;
	       mut_rd   	: in std_logic;
	       term_rd  	: in std_logic;
	       gen_rd		: in std_logic;
	       offs_rd		: in std_logic;
	       
	       fit_eval_done 	: in std_logic;
	       sel_done   	: in std_logic;
	       
	       clear     	: out std_logic;
	       cross_out 	: out std_logic;
	       eval      	: out std_logic;
	       fill     	: out std_logic;
	       mut_out   	: out std_logic;
	       sel_out   	: out std_logic;
	       term_out  	: out std_logic;
	       we1              : out std_logic;
	       we2              : out std_logic
	       );
end;

architecture behavior of control is
	type type_sreg is (clear_ram_s, cross_s, done_s, fill_ram_s, fit_eval_s, mut_s, sel_s,
	                   write_ram_1_s,read_write_ram_2_s);
	signal sreg, next_sreg  : type_sreg;
	signal fit_eval_done_p1 : std_logic;  
	signal sel_done_p1      : std_logic;
	signal mut_rd_p1        : std_logic;
	signal ram1_rd_p1       : std_logic;
	signal ram1_rd		: std_logic;
	signal count		: integer;
	signal count2		: integer;
	signal count_offs	: integer;
	signal count_gen	: integer;

begin
	process (clk, rst_n)
	begin
		if (rst_n = '0') then
			sreg <= clear_ram_s;
			fit_eval_done_p1 <= '0';
			sel_done_p1 <= '0';
			mut_rd_p1 <= '0';
			ram1_rd_p1 <= '0';
			count_offs <= 0;
			count_gen <= 0;
		elsif clk = '1' and clk'event then
			sreg <= next_sreg;
			fit_eval_done_p1 <= fit_eval_done;
			sel_done_p1 <= sel_done;
			mut_rd_p1 <= mut_rd;
			ram1_rd_p1 <= ram1_rd;
			count_offs <= count;
			count_gen <= count2;
		end if;
	end process;

	process (sreg, clear_rd, fill_ram, fit_eval_rd, fit_eval_done_p1, mut_rd_p1, sel_rd, sel_done_p1, cross_rd,
		 mut_rd, done, term_rd, gen_rd, offs_rd, count_offs, count_gen)
	begin
		clear <= '0'; 
		cross_out <= '0'; 
		eval <= '0'; 
		fill <= '0';  
		mut_out <= '0';   
		sel_out <= '0';   
		term_out <= '0'; 
		we1 <= '0'; 
		we2 <= '0';
		ram1_rd <= '0';
		next_sreg <= fill_ram_s;

		case sreg is
		
			when clear_ram_s =>
				clear <= '0';
				cross_out <= '0';
				eval <= '0';
				mut_out <= '0';
				sel_out <= '0';
				term_out <= '0';
				we1 <= '0'; 
				we2 <= '0';
				count2 <= 0;
				count <= 0;
				ram1_rd <= '0';
				if (clear_rd = '0') then
					next_sreg <= clear_ram_s;
					fill <= '0';
				end if;
				if (clear_rd = '1') then
					next_sreg <= fill_ram_s;
					fill <= '1';
				end if;
				
			when fill_ram_s =>
				clear <= '0';
				cross_out <= '0';
				fill <= '0';
				mut_out <= '0';
				sel_out <= '0';
				term_out <= '0';
				we1 <= '0'; 
				we2 <= '0';
				ram1_rd <= '0';
				if (fill_ram = '0') then
					next_sreg <= fill_ram_s;
					eval <= '0';
				end if;
				if (fill_ram = '1') then
					next_sreg <= fit_eval_s;
					eval <= '1';
				end if;
				
			when fit_eval_s =>
				clear <= '0';
				cross_out <= '0';
				eval <= '0';
				fill <= '0';
				mut_out <= '0';
				sel_out <= '0';
				term_out <= '0';
				we2 <= '0';
				count <= 0;
				ram1_rd <= '0';
				if (fit_eval_rd = '1') then
					next_sreg <= write_ram_1_s;
					we1 <= '1';
				end if;
				if (fit_eval_rd = '0') then
					next_sreg <= fit_eval_s;
					we1 <= '0';
				end if;
				
			when write_ram_1_s =>
				clear <= '0';
				cross_out <= '0';
				fill <= '0';
				mut_out <= '0';
				we2 <= '0';
				we1 <= '0';
				if ( fit_eval_done_p1='0' ) and (mut_rd_p1 = '0')then
					next_sreg <= fit_eval_s;
					sel_out <= '0';
					eval <= '1';
					term_out <= '0';
					ram1_rd <= '0';
				end if;
				if (fit_eval_done_p1 = '1') and (mut_rd_p1 = '0')then
					next_sreg <= sel_s;
					eval <= '0';
					sel_out <= '1';
					term_out <= '0';
					ram1_rd <= '0';
				end if;
				
				if (mut_rd_p1 = '1') and (count_offs=popSz-elite) then -- eixa kai fitevaldoen elegxo
					next_sreg <= done_s;
					sel_out <= '0';
					eval <= '0';
					term_out <= '1';
					ram1_rd <= '0';
				end if;
				if (mut_rd_p1 = '1') and (count_offs/=popSz-elite) then
					next_sreg <= read_write_ram_2_s;
					ram1_rd <= '1';
					eval <= '0';
					sel_out <= '0';
					term_out <= '0';
				end if;				
				
			when sel_s =>
				clear <= '0';
				cross_out <= '0';
				eval <= '0';
				fill <= '0';
				mut_out <= '0';
				sel_out <= '0';
				term_out <= '0';
				we1 <= '0';
				ram1_rd <= '0';
				if (sel_rd = '1') then
					next_sreg <= read_write_ram_2_s;
					we2 <= '1';
				end if;
				if (sel_rd = '0') then
					next_sreg <= sel_s;
					we2 <= '0';
				end if;
							
			when read_write_ram_2_s =>
				clear <= '0';
				mut_out <= '0';
				eval <= '0';
				fill <= '0';
				term_out <= '0';
				we1 <= '0';
				ram1_rd <= '0';
				if (sel_done_p1 = '0') and (ram1_rd_p1 = '0') then
					next_sreg <= sel_s;
					cross_out <= '0';
					sel_out <= '1';
					we2 <= '0';
				end if;
				if (sel_done_p1 = '1') and (ram1_rd_p1 = '0') then
					next_sreg <= cross_s;
					we2 <= '0';
					cross_out <= '1';
					sel_out <= '0';
				end if;
				if (ram1_rd_p1 = '1') then
					next_sreg <= cross_s;
					we2 <= '0';
					cross_out <= '1';
					sel_out <= '0';
				end if;					

				
			when cross_s =>
				clear <= '0';
				eval <= '0';
				fill <= '0';
				sel_out <= '0';
				term_out <= '0';
				we1 <= '0';
				we2 <= '0';
				ram1_rd <= '0';
				if (cross_rd = '1') then
					next_sreg <= mut_s;
					mut_out <= '1';
					cross_out <= '0';
				end if;
				if (cross_rd = '0') then
					next_sreg <= cross_s;
					mut_out <= '0';
					cross_out <= '1';
				end if;
				
			when mut_s =>
				clear <= '0';
				cross_out <= '0';
				eval <= '0';
				fill <= '0';
				sel_out <= '0';
				term_out <= '0';
				we2 <= '0';
				
				ram1_rd <= '0';
				if (mut_rd = '1') then
					next_sreg <= write_ram_1_s;
					we1 <= '1';
					mut_out <= '0';
					count <= count_offs + 1;
				end if;
				if (mut_rd = '0') then
					next_sreg <= mut_s;
					we1 <= '0';
					mut_out <= '1';					
				end if;
			
			when done_s =>
				cross_out <= '0';
				fill <= '0';
				mut_out <= '0';
				sel_out <= '0';
				we1 <= '0';
				we2 <= '0';
				ram1_rd <= '0';
				if (count_gen = max_gen and term_rd = '1') then
					next_sreg <= clear_ram_s;
					clear <= '1';
					eval <= '0';
					term_out <= '0';
				end if;
				
				if (count_gen /= max_gen and done = '1' and term_rd = '1') then
					next_sreg <= clear_ram_s;
					clear <= '1';
					eval <= '0';
					term_out <= '0';
				end if; 				
				
				if (count_gen /= max_gen and done = '0' and term_rd = '1') then
					next_sreg <= fit_eval_s;
					clear <= '0';
					eval <= '1';
					term_out <= '0';
					count2 <= count_gen + 1;
				end if;
				
				if (term_rd = '0') then
					next_sreg <= done_s;
					clear <= '0';
					eval <= '0';
					term_out <= '1';
				end if;

			when others =>
				-- empty
		end case;
	end process;
end behavior;