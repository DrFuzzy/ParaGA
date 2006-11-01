--  C:\DOCUMENTS AND SETTINGS\DELK\...\CONTROL2.vhd
--  VHDL code created by Xilinx's StateCAD 7.1i
--  Thu Apr 06 19:11:20 2006

--  This VHDL code (for use with IEEE compliant tools) was generated using: 
--  enumerated state assignment with structured code format.
--  Minimization is enabled,  implied else is disabled, 
--  and outputs are manually optimized.

LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY CONTROL2 IS
	PORT (CLK,cross_in,done,fill_ram,fit_eval,mut_in,ram,rd_in,rst_n,sel,sort_in
		,term_in,wr: IN std_logic;
		clear,cross_out,eval,fill,idl,init,mut_out,sel_out,sort_out,term_out,we : 
			OUT std_logic);
END;

ARCHITECTURE BEHAVIOR OF CONTROL2 IS
	TYPE type_sreg IS (clear_ram_s,cross_s,done_s,fill_ram_s,fit_eval_s,
		fit_scal_sort_s,idle_s,init_s,mut_s,sel_s,write_ram_0_s,write_ram_1_s,
		write_ram_2_s,write_ram_3_s,write_ram_4_s);
	SIGNAL sreg, next_sreg : type_sreg;
BEGIN
	PROCESS (CLK, rst_n)
	BEGIN
		IF ( rst_n='0' ) THEN
			sreg <= idle_s;
		ELSIF CLK='1' AND CLK'event THEN
			sreg <= next_sreg;
		END IF;
	END PROCESS;

	PROCESS (sreg,cross_in,done,fill_ram,fit_eval,mut_in,ram,rd_in,sel,sort_in,
		term_in,wr)
	BEGIN
		clear <= '0'; cross_out <= '0'; eval <= '0'; fill <= '0'; idl <= '0'; init 
			<= '0'; mut_out <= '0'; sel_out <= '0'; sort_out <= '0'; term_out <= '0'; we 
			<= '0'; 

		next_sreg<=clear_ram_s;

		CASE sreg IS
			WHEN clear_ram_s =>
				clear<='0';
				cross_out<='0';
				eval<='0';
				idl<='0';
				init<='0';
				mut_out<='0';
				sel_out<='0';
				sort_out<='0';
				term_out<='0';
				we<='0';
				IF ( ram='0' ) THEN
					next_sreg<=clear_ram_s;
					fill<='0';
				END IF;
				IF ( ram='1' ) THEN
					next_sreg<=fill_ram_s;
					fill<='1';
				END IF;
			WHEN cross_s =>
				clear<='0';
				cross_out<='0';
				eval<='0';
				fill<='0';
				idl<='0';
				init<='0';
				mut_out<='0';
				sel_out<='0';
				sort_out<='0';
				term_out<='0';
				IF ( cross_in='1' ) THEN
					next_sreg<=write_ram_4_s;
					we<='1';
				END IF;
				IF ( cross_in='0' ) THEN
					next_sreg<=cross_s;
					we<='0';
				END IF;
			WHEN done_s =>
				clear<='0';
				cross_out<='0';
				eval<='0';
				fill<='0';
				mut_out<='0';
				sel_out<='0';
				sort_out<='0';
				term_out<='0';
				we<='0';
				IF ( done='1' AND term_in='1' ) THEN
					next_sreg<=idle_s;
					init<='0';
					idl<='1';
				END IF;
				IF ( done='0' AND term_in='1' ) THEN
					next_sreg<=init_s;
					idl<='0';
					init<='1';
				END IF;
				IF ( term_in='0' ) THEN
					next_sreg<=done_s;
					idl<='0';
					init<='0';
				END IF;
			WHEN fill_ram_s =>
				clear<='0';
				cross_out<='0';
				eval<='0';
				fill<='0';
				idl<='0';
				mut_out<='0';
				sel_out<='0';
				sort_out<='0';
				term_out<='0';
				we<='0';
				IF ( fill_ram='0' ) THEN
					next_sreg<=fill_ram_s;
					init<='0';
				END IF;
				IF ( fill_ram='1' ) THEN
					next_sreg<=init_s;
					init<='1';
				END IF;
			WHEN fit_eval_s =>
				clear<='0';
				cross_out<='0';
				eval<='0';
				fill<='0';
				idl<='0';
				init<='0';
				mut_out<='0';
				sel_out<='0';
				sort_out<='0';
				term_out<='0';
				IF ( fit_eval='1' ) THEN
					next_sreg<=write_ram_0_s;
					we<='1';
				END IF;
				IF ( fit_eval='0' ) THEN
					next_sreg<=fit_eval_s;
					we<='0';
				END IF;
			WHEN fit_scal_sort_s =>
				clear<='0';
				cross_out<='0';
				eval<='0';
				fill<='0';
				idl<='0';
				init<='0';
				mut_out<='0';
				sel_out<='0';
				sort_out<='0';
				term_out<='0';
				IF ( sort_in='1' ) THEN
					next_sreg<=write_ram_1_s;
					we<='1';
				END IF;
				IF ( sort_in='0' ) THEN
					next_sreg<=fit_scal_sort_s;
					we<='0';
				END IF;
			WHEN idle_s =>
				cross_out<='0';
				eval<='0';
				fill<='0';
				idl<='0';
				init<='0';
				mut_out<='0';
				sel_out<='0';
				sort_out<='0';
				term_out<='0';
				we<='0';
				IF ( rd_in='1' ) THEN
					next_sreg<=clear_ram_s;
					clear<='1';
				END IF;
				IF ( rd_in='0' ) THEN
					next_sreg<=idle_s;
					clear<='0';
				END IF;
			WHEN init_s =>
				clear<='0';
				cross_out<='0';
				fill<='0';
				idl<='0';
				init<='0';
				mut_out<='0';
				sel_out<='0';
				sort_out<='0';
				term_out<='0';
				we<='0';
				next_sreg<=fit_eval_s;
				eval<='1';
			WHEN mut_s =>
				clear<='0';
				cross_out<='0';
				eval<='0';
				fill<='0';
				idl<='0';
				init<='0';
				mut_out<='0';
				sel_out<='0';
				sort_out<='0';
				term_out<='0';
				IF ( mut_in='1' ) THEN
					next_sreg<=write_ram_3_s;
					we<='1';
				END IF;
				IF ( mut_in='0' ) THEN
					next_sreg<=mut_s;
					we<='0';
				END IF;
			WHEN sel_s =>
				clear<='0';
				cross_out<='0';
				eval<='0';
				fill<='0';
				idl<='0';
				init<='0';
				mut_out<='0';
				sel_out<='0';
				sort_out<='0';
				term_out<='0';
				IF ( sel='1' ) THEN
					next_sreg<=write_ram_2_s;
					we<='1';
				END IF;
				IF ( sel='0' ) THEN
					next_sreg<=sel_s;
					we<='0';
				END IF;
			WHEN write_ram_0_s =>
				clear<='0';
				cross_out<='0';
				eval<='0';
				fill<='0';
				idl<='0';
				init<='0';
				mut_out<='0';
				sel_out<='0';
				term_out<='0';
				IF ( wr='1' ) THEN
					next_sreg<=fit_scal_sort_s;
					we<='0';
					sort_out<='1';
				END IF;
				IF ( wr='0' ) THEN
					next_sreg<=write_ram_0_s;
					sort_out<='0';
					we<='0';
				END IF;
			WHEN write_ram_1_s =>
				clear<='0';
				cross_out<='0';
				eval<='0';
				fill<='0';
				idl<='0';
				init<='0';
				mut_out<='0';
				sort_out<='0';
				term_out<='0';
				IF ( wr='0' ) THEN
					next_sreg<=write_ram_1_s;
					sel_out<='0';
					we<='0';
				END IF;
				IF ( wr='1' ) THEN
					next_sreg<=sel_s;
					we<='0';
					sel_out<='1';
				END IF;
			WHEN write_ram_2_s =>
				clear<='0';
				cross_out<='0';
				eval<='0';
				fill<='0';
				idl<='0';
				init<='0';
				sel_out<='0';
				sort_out<='0';
				term_out<='0';
				IF ( wr='0' ) THEN
					next_sreg<=write_ram_2_s;
					mut_out<='0';
					we<='0';
				END IF;
				IF ( wr='1' ) THEN
					next_sreg<=mut_s;
					we<='0';
					mut_out<='1';
				END IF;
			WHEN write_ram_3_s =>
				clear<='0';
				eval<='0';
				fill<='0';
				idl<='0';
				init<='0';
				mut_out<='0';
				sel_out<='0';
				sort_out<='0';
				term_out<='0';
				IF ( wr='0' ) THEN
					next_sreg<=write_ram_3_s;
					cross_out<='0';
					we<='0';
				END IF;
				IF ( wr='1' ) THEN
					next_sreg<=cross_s;
					we<='0';
					cross_out<='1';
				END IF;
			WHEN write_ram_4_s =>
				clear<='0';
				cross_out<='0';
				eval<='0';
				fill<='0';
				idl<='0';
				init<='0';
				mut_out<='0';
				sel_out<='0';
				sort_out<='0';
				IF ( wr='0' ) THEN
					next_sreg<=write_ram_4_s;
					term_out<='0';
					we<='0';
				END IF;
				IF ( wr='1' ) THEN
					next_sreg<=done_s;
					we<='0';
					term_out<='1';
				END IF;
			WHEN OTHERS =>
		END CASE;
	END PROCESS;
END BEHAVIOR;