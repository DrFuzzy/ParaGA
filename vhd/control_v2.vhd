-------------------------------------------------------------------------------
-- Title      : State Machine Control block
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : control_v2.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 23/03/06
-- Last update: 2006-11-02
-- Platform   : Modelsim & Synplify & Xilinx ISE
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This block implements the state diagram control block 
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
use work.dhga_pkg.all;

entity control is
  port (
    clk         : in  std_logic;
    rst_n       : in  std_logic;
    ready_in    : in  std_logic;
    ram         : in  std_logic;
    fill_ram    : in  std_logic;
    fit_eval    : in  std_logic;
    wr          : in  std_logic;
    sorted      : in  std_logic;
    sel         : in  std_logic;
    mut         : in  std_logic;
    cross       : in  std_logic;
    term        : in  std_logic;
    fin         : in  std_logic;
    clear       : out std_logic;
    fill        : out std_logic;
    init        : out std_logic;
    eval        : out std_logic;
    sort        : out std_logic;
    selection   : out std_logic;
    mutation    : out std_logic;
    crossover   : out std_logic;
    termination : out std_logic;
    we          : out std_logic;
    idl         : out std_logic);        
end entity control;

-------------------------------------------------------------------------------
-- architecture
-------------------------------------------------------------------------------
architecture synth of control is
  
  type   state_values is (idle, clear_ram_state, fill_ram_state, init_state, fit_eval_state, write_ram_state, fit_scal_sort_state, sel_state , mut_state, cross_state, term_ctrl_state);
  signal state, next_state, previous_state, orig_state : state_values;
  attribute syn_state_machine                          : boolean;
  attribute syn_state_machine of state                 : signal is true;
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

  statemachine : process (state, previous_state, ready_in, ram, fill_ram, fit_eval, wr, sorted, sel, mut, cross, term, fin)
  begin

    case state is
      
      when idle =>
        if (ready_in = '0' or fin = '1') then
          next_state  <= state;
          orig_state  <= idle;
          clear       <= '0';
          fill        <= '0';
          init        <= '0';
          eval        <= '0';
          sort        <= '0';
          selection   <= '0';
          mutation    <= '0';
          crossover   <= '0';
          termination <= '0';
          we          <= '0';
          idl         <= '0';
        elsif (ready_in = '1') then
          next_state  <= clear_ram_state;
          orig_state  <= idle;
          clear       <= '1';
          fill        <= '0';
          init        <= '0';
          eval        <= '0';
          sort        <= '0';
          selection   <= '0';
          mutation    <= '0';
          crossover   <= '0';
          termination <= '0';
          we          <= '0';
          idl         <= '0';
        end if;
        
      when clear_ram_state =>
        if (ram = '0') then
          next_state  <= state;
          orig_state  <= clear_ram_state;
          clear       <= '0';
          fill        <= '0';
          init        <= '0';
          eval        <= '0';
          sort        <= '0';
          selection   <= '0';
          mutation    <= '0';
          crossover   <= '0';
          termination <= '0';
          we          <= '0';
          idl         <= '0';
        else
          next_state  <= fill_ram_state;
          orig_state  <= clear_ram_state;
          fill        <= '1';
          clear       <= '0';
          init        <= '0';
          eval        <= '0';
          sort        <= '0';
          selection   <= '0';
          mutation    <= '0';
          crossover   <= '0';
          termination <= '0';
          we          <= '0';
          idl         <= '0';
        end if;

      when fill_ram_state =>
        if (fill_ram = '0') then
          next_state  <= state;
          orig_state  <= fill_ram_state;
          clear       <= '0';
          fill        <= '0';
          init        <= '0';
          eval        <= '0';
          sort        <= '0';
          selection   <= '0';
          mutation    <= '0';
          crossover   <= '0';
          termination <= '0';
          we          <= '0';
          idl         <= '0';
        else
          next_state  <= init_state;
          orig_state  <= fill_ram_state;
          init        <= '1';
          clear       <= '0';
          fill        <= '0';
          eval        <= '0';
          sort        <= '0';
          selection   <= '0';
          mutation    <= '0';
          crossover   <= '0';
          termination <= '0';
          we          <= '0';
          idl         <= '0';
        end if;
        
      when init_state =>
        
        next_state  <= fit_eval_state;
        orig_state  <= init_state;
        clear       <= '0';
        fill        <= '0';
        init        <= '0';
        eval        <= '1';
        sort        <= '0';
        selection   <= '0';
        mutation    <= '0';
        crossover   <= '0';
        termination <= '0';
        we          <= '0';
        idl         <= '0';
        
      when fit_eval_state =>
        if (fit_eval = '0') then
          next_state  <= state;
          orig_state  <= fit_eval_state;
          clear       <= '0';
          fill        <= '0';
          init        <= '0';
          eval        <= '0';
          sort        <= '0';
          selection   <= '0';
          mutation    <= '0';
          crossover   <= '0';
          termination <= '0';
          we          <= '0';
          idl         <= '0';
        else
          next_state  <= write_ram_state;
          orig_state  <= fit_eval_state;
          we          <= '1';           -- write enable
          clear       <= '0';
          fill        <= '0';
          init        <= '0';
          eval        <= '0';
          sort        <= '0';
          selection   <= '0';
          mutation    <= '0';
          crossover   <= '0';
          termination <= '0';
          idl         <= '0';
        end if;
        
      when write_ram_state =>
        if (wr = '0') then
          next_state  <= state;
          orig_state  <= write_ram_state;
          clear       <= '0';
          fill        <= '0';
          init        <= '0';
          eval        <= '0';
          sort        <= '0';
          selection   <= '0';
          mutation    <= '0';
          crossover   <= '0';
          termination <= '0';
          we          <= '0';
          idl         <= '0';
        elsif (previous_state = fit_eval_state) then
          next_state  <= fit_scal_sort_state;
          orig_state  <= write_ram_state;
          we          <= '0';
          sort        <= '1';
          clear       <= '0';
          fill        <= '0';
          init        <= '0';
          eval        <= '0';
          selection   <= '0';
          mutation    <= '0';
          crossover   <= '0';
          termination <= '0';
          idl         <= '0';
        elsif (previous_state = fit_scal_sort_state) then
          next_state  <= sel_state;
          orig_state  <= write_ram_state;
          we          <= '0';
          selection   <= '1';
          clear       <= '0';
          fill        <= '0';
          init        <= '0';
          eval        <= '0';
          sort        <= '0';
          mutation    <= '0';
          crossover   <= '0';
          termination <= '0';
          idl         <= '0';
        elsif (previous_state = sel_state) then
          next_state  <= mut_state;
          orig_state  <= write_ram_state;
          we          <= '0';
          mutation    <= '1';
          clear       <= '0';
          fill        <= '0';
          init        <= '0';
          eval        <= '0';
          sort        <= '0';
          selection   <= '0';
          crossover   <= '0';
          termination <= '0';
          idl         <= '0';
        elsif (previous_state = mut_state) then
          next_state  <= cross_state;
          orig_state  <= write_ram_state;
          we          <= '0';
          crossover   <= '1';
          clear       <= '0';
          fill        <= '0';
          init        <= '0';
          eval        <= '0';
          sort        <= '0';
          selection   <= '0';
          mutation    <= '0';
          termination <= '0';
          idl         <= '0';
        else                            -- previous state was cross_state
          next_state  <= term_ctrl_state;
          orig_state  <= write_ram_state;
          we          <= '0';
          termination <= '1';
          clear       <= '0';
          fill        <= '0';
          init        <= '0';
          eval        <= '0';
          sort        <= '0';
          selection   <= '0';
          mutation    <= '0';
          crossover   <= '0';
          idl         <= '0';
        end if;
        
      when fit_scal_sort_state =>
        if (sorted = '0') then
          next_state  <= state;
          orig_state  <= fit_scal_sort_state;
          clear       <= '0';
          fill        <= '0';
          init        <= '0';
          eval        <= '0';
          sort        <= '0';
          selection   <= '0';
          mutation    <= '0';
          crossover   <= '0';
          termination <= '0';
          we          <= '0';
          idl         <= '0';
        else
          next_state  <= write_ram_state;
          orig_state  <= fit_scal_sort_state;
          we          <= '1';
          clear       <= '0';
          fill        <= '0';
          init        <= '0';
          eval        <= '1';
          sort        <= '0';
          selection   <= '0';
          mutation    <= '0';
          crossover   <= '0';
          termination <= '0';
          idl         <= '0';
        end if;
        
      when sel_state =>
        if (sel = '0') then
          next_state  <= state;
          orig_state  <= sel_state;
          clear       <= '0';
          fill        <= '0';
          init        <= '0';
          eval        <= '0';
          sort        <= '0';
          selection   <= '0';
          mutation    <= '0';
          crossover   <= '0';
          termination <= '0';
          we          <= '0';
          idl         <= '0';
        else
          next_state  <= write_ram_state;
          orig_state  <= sel_state;
          we          <= '1';
          clear       <= '0';
          fill        <= '0';
          init        <= '0';
          eval        <= '1';
          sort        <= '0';
          selection   <= '0';
          mutation    <= '0';
          crossover   <= '0';
          termination <= '0';
          idl         <= '0';
        end if;
        
      when mut_state =>
        if (mut = '0') then
          next_state  <= state;
          orig_state  <= mut_state;
          clear       <= '0';
          fill        <= '0';
          init        <= '0';
          eval        <= '0';
          sort        <= '0';
          selection   <= '0';
          mutation    <= '0';
          crossover   <= '0';
          termination <= '0';
          we          <= '0';
          idl         <= '0';
        else
          next_state  <= write_ram_state;
          orig_state  <= mut_state;
          we          <= '1';
          clear       <= '0';
          fill        <= '0';
          init        <= '0';
          eval        <= '1';
          sort        <= '0';
          selection   <= '0';
          mutation    <= '0';
          crossover   <= '0';
          termination <= '0';
          idl         <= '0';
        end if;
        
      when cross_state =>
        if (cross = '0') then
          next_state  <= state;
          orig_state  <= cross_state;
          clear       <= '0';
          fill        <= '0';
          init        <= '0';
          eval        <= '0';
          sort        <= '0';
          selection   <= '0';
          mutation    <= '0';
          crossover   <= '0';
          termination <= '0';
          we          <= '0';
          idl         <= '0';
        else
          next_state  <= write_ram_state;
          orig_state  <= cross_state;
          we          <= '1';
          clear       <= '0';
          fill        <= '0';
          init        <= '0';
          eval        <= '1';
          sort        <= '0';
          selection   <= '0';
          mutation    <= '0';
          crossover   <= '0';
          termination <= '0';
          idl         <= '0';
        end if;
        
      when term_ctrl_state =>
        if (term = '0') then
          next_state  <= state;
          orig_state  <= term_ctrl_state;
          clear       <= '0';
          fill        <= '0';
          init        <= '0';
          eval        <= '0';
          sort        <= '0';
          selection   <= '0';
          mutation    <= '0';
          crossover   <= '0';
          termination <= '0';
          we          <= '0';
          idl         <= '0';
        elsif (term = '1' and fin = '0') then
          next_state  <= init_state;
          orig_state  <= term_ctrl_state;
          init        <= '1';
          clear       <= '0';
          fill        <= '0';
          eval        <= '1';
          sort        <= '0';
          selection   <= '0';
          mutation    <= '0';
          crossover   <= '0';
          termination <= '0';
          we          <= '0';
          idl         <= '0';
        else
          next_state  <= idle;
          orig_state  <= term_ctrl_state;
          idl         <= '1';
          clear       <= '0';
          fill        <= '0';
          init        <= '0';
          eval        <= '1';
          sort        <= '0';
          selection   <= '0';
          mutation    <= '0';
          crossover   <= '0';
          termination <= '0';
          we          <= '0';
        end if;
        
      when others =>
        next_state  <= idle;
        orig_state  <= idle;
        idl         <= '1';
        clear       <= '0';
        fill        <= '0';
        init        <= '0';
        eval        <= '0';
        sort        <= '0';
        selection   <= '0';
        mutation    <= '0';
        crossover   <= '0';
        termination <= '0';
        we          <= '0';
    end case;
    
  end process statemachine;

end synth;
