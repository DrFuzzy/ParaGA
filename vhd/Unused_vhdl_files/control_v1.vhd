-------------------------------------------------------------------------------
-- Title      : State Machine Control block
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : control.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 23/03/06
-- Last update: 2006-11-02
-- Platform   : Modelsim & Synplify & Xilinx ISE
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This block implements the state machine control block 
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
library work;
use work.ga_pkg.all;

entity control is
  port (
    clk      : in  std_logic;
    rst_n    : in  std_logic;
    ready_in : in  std_logic;
    input    : in  std_logic_vector(9 downto 0);  -- ram,fill_ram, fit_eval, wr,sorted, sel,      mut,      cross, term, fin       
    output   : out std_logic_vector(10 downto 0));  -- clear, fill, init, eval, sort, selection, mutation, crossover, termination, we, idl
end entity control;

-------------------------------------------------------------------------------
-- architecture
-------------------------------------------------------------------------------
architecture synth of control is
  
  type   state_values is (idle, clear_ram_state, fill_ram_state, init_state, fit_eval_state, write_ram_state, fit_scal_sort_state, sel_state , mut_state, cross_state, term_ctrl_state);
  signal state, next_state, previous_state, orig_state : state_values;
  attribute syn_encoding                               : string;
  attribute syn_encoding of state                      : signal is "onehot";

begin
  
  clock : process (clk, rst_n)
  begin
    
    if rst_n = '0' then
      state          <= idle;
      previous_state <= idle;
    elsif rising_edge(clk) then
      state          <= next_state;
      previous_state <= orig_state;
    end if;
    
  end process clock;

  statemachine : process (state, previous_state, ready_in, input)
  begin

    case state is
      
      when idle =>
        if (ready_in = '0' or (input(0) = '1' and ready_in = '1')) then
          next_state <= state;
          orig_state <= idle;
        elsif (input(0) = '0' and ready_in = '1') then
          next_state <= clear_ram_state;
          orig_state <= idle;
          output     <= "10000000000";
        end if;
        
      when clear_ram_state =>
        if (input(9) = '0') then
          next_state <= state;
          orig_state <= idle;
        else
          next_state <= fill_ram_state;
          orig_state <= idle;
          output     <= "01000000000";
        end if;

      when fill_ram_state =>
        if (input(8) = '0') then
          next_state <= state;
          orig_state <= clear_ram_state;
        else
          next_state <= init_state;
          orig_state <= clear_ram_state;
          output     <= "00100000000";
        end if;
        
      when init_state =>
        
        next_state <= fit_eval_state;
        orig_state <= fill_ram_state;
        output     <= "00010000000";
        
      when fit_eval_state =>
        if (input(7) = '0') then
          next_state <= state;
          orig_state <= init_state;
        else
          next_state <= write_ram_state;
          orig_state <= init_state;
          output     <= "00000000010";  -- write enable
        end if;
        
      when write_ram_state =>
        if (input(6) = '0') then
          next_state <= state;
        elsif (previous_state = fit_eval_state) then
          next_state <= fit_scal_sort_state;
          orig_state <= fit_eval_state;
          output     <= "00001000000";
        elsif (previous_state = fit_scal_sort_state) then
          next_state <= sel_state;
          orig_state <= fit_scal_sort_state;
          output     <= "00000100000";
        elsif (previous_state = sel_state) then
          next_state <= mut_state;
          orig_state <= sel_state;
          output     <= "00000010000";
        elsif (previous_state = mut_state) then
          next_state <= cross_state;
          orig_state <= mut_state;
          output     <= "00000001000";
        else                            -- previous state was cross_state
          next_state <= term_ctrl_state;
          orig_state <= cross_state;
          output     <= "00000000100";
        end if;
        
      when fit_scal_sort_state =>
        if (input(5) = '0') then
          next_state <= state;
          orig_state <= write_ram_state;
        else
          next_state <= write_ram_state;
          orig_state <= fit_eval_state;
          output     <= "00000000010";
        end if;
        
      when sel_state =>
        if (input(4) = '0') then
          next_state <= state;
          orig_state <= write_ram_state;
        else
          next_state <= write_ram_state;
          orig_state <= fit_scal_sort_state;
          output     <= "00000000010";
        end if;
        
      when mut_state =>
        if (input(3) = '0') then
          next_state <= state;
        else
          next_state <= write_ram_state;
          orig_state <= sel_state;
          output     <= "00000000010";
        end if;
        
      when cross_state =>
        if (input(2) = '0') then
          next_state <= state;
        else
          next_state <= write_ram_state;
          orig_state <= mut_state;
          output     <= "00000000010";
        end if;
        
      when term_ctrl_state =>
        if (input(1) = '0') then
          next_state <= state;
          orig_state <= write_ram_state;
        elsif (input(1) = '1' and input(0) = '0') then
          next_state <= init_state;
          orig_state <= write_ram_state;
          output     <= "00100000000";
        else
          next_state <= idle;
          orig_state <= write_ram_state;
          output     <= "00000000001";
        end if;
        
      when others =>
        next_state <= idle;
        orig_state <= idle;
        
    end case;
    
  end process statemachine;

end synth;
