-------------------------------------------------------------------------------
-- Title      : GA
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : ga_tb.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos (kdelip@mail.ntua.gr)
-- Company    : NTUA/IRAL
-- Created    : 03/10/06
-- Last update: 2006-11-02
-- Platform   : Modelsim, Synplicity, ISE
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This is the testbench for the parametric GA top design 
-------------------------------------------------------------------------------
-- Copyright (c) 2006 NTUA
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description

-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- LIBRARIES
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library modelsim_lib;
use modelsim_lib.util.all;

use std.textio.all;
use work.dhga_pkg.all;
use work.arith_pkg.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity ga_tb is
-- empty
end;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture bench of ga_tb is

  component ga is
    generic (
      genom_lngt         : positive;
      score_sz           : integer;
      scaling_factor_res : integer;
      pop_sz             : integer;
      elite              : integer;
      mr                 : integer;
      mut_res            : integer;
      fit_limit          : positive;    -- (max. value is 2^score_sz -1)
      max_gen            : positive);
    port (
      clk             : in  std_logic;
      rst_n           : in  std_logic;
      run_ga_i        : in  std_logic;
      seed_i          : in  std_logic_vector(genom_lngt -1 downto 0);  -- parallel seed input for rng 
      seed_1_i        : in  std_logic_vector(genom_lngt+mut_res-1 downto 0);  -- parallel seed input for rng1
      seed_2_i        : in  std_logic_vector(2*log2(genom_lngt)-1 downto 0);  -- parallel seed input for rng2
      seed_3_i        : in  std_logic_vector(scaling_factor_res-1 downto 0);  -- parallel seed input for rng3
      crossMethod_i   : in  std_logic_vector(1 downto 0);
      mutMethod_i     : in  std_logic_vector(1 downto 0);
      best_gene       : out std_logic_vector(genom_lngt -1 downto 0);
      best_fit        : out std_logic_vector(score_sz-1 downto 0);
      fit_limit_reach : out std_logic;
      ga_fin          : out std_logic);                     
  end component ga;


  signal clk   : std_logic := '0';      -- system clock
  signal rst_n : std_logic := '0';      -- reset (active low)

  -- output signals
  signal best_gene       : std_logic_vector(8-1 downto 0);
  signal best_fit        : std_logic_vector(9-1 downto 0);
  signal fit_limit_reach : std_logic;
  signal ga_fin          : std_logic;

  -- test vector signals
  signal run_ga_i      : std_logic_vector(1 downto 0);
  signal seed_i        : std_logic_vector(8-1 downto 0);
  signal seed_1_i      : std_logic_vector(16-1 downto 0);
  signal seed_2_i      : std_logic_vector(2*log2(8)-1 downto 0);
  signal seed_3_i      : std_logic_vector(4-1 downto 0);
  signal crossMethod_i : std_logic_vector(1 downto 0);
  signal mutMethod_i   : std_logic_vector(1 downto 0);

  -- true internal signals 
  signal elite_offs : int_array(0 to 2-1);
  signal max_fit    : std_logic_vector(9-1 downto 0);

  -- spy signals
  signal spy_next_generation : std_logic;
  signal spy_elite           : int_array(0 to 2-1);
  signal spy_max_fit         : std_logic_vector(9-1 downto 0);

  -- simulation period
  signal period : time := 10 ns;        -- 100 MHz
  
  
begin  -- ARCHITECTURE bench

  u_bench : ga
    generic map (
      genom_lngt         => 8,
      score_sz           => 9,
      scaling_factor_res => 4,
      pop_sz             => 8,
      elite              => 2,
      mr                 => 150,
      mut_res            => 8,
      fit_limit          => 511,
      max_gen            => 100)          

    
    
    port map (
      clk             => clk,
      rst_n           => rst_n,
      run_ga_i        => run_ga_i(0),
      seed_i          => seed_i,
      seed_1_i        => seed_1_i,
      seed_2_i        => seed_2_i,
      seed_3_i        => seed_3_i,
      crossMethod_i   => crossMethod_i,
      mutMethod_i     => mutMethod_i,
      best_gene       => best_gene,
      best_fit        => best_fit,
      fit_limit_reach => fit_limit_reach,
      ga_fin          => ga_fin);       



  -- clock and reset generator
  clk   <= not clk after period/2;
  rst_n <= '1'     after 6*period/2;

  -- !!! assign spy signals !!!
  init_signal_spy("/ga_tb/u_bench/u11/next_generation", "/spy_next_generation", 0);
  init_signal_spy("/ga_tb/u_bench/u4/elite_offs", "/spy_elite", 0);
  init_signal_spy("/ga_tb/u_bench/u4/max_fit", "/spy_max_fit", 0);


  -- testing all possible values
  stimuli_gen : process
    
    variable text_line       : line;
    variable run_ga          : integer;
    variable seed            : integer;
    variable seed1           : integer;
    variable seed2           : integer;
    variable seed3           : integer;
    variable Xover_method    : integer;
    variable Mutation_method : integer;

    -- file where the input stimuli are stored
    file ip_vec_ga : text is "..\sim\ip_vec_ga.vec";
    
  begin
    
    while not endfile(ip_vec_ga) loop
      -- read one line from file input_data.vec into text_line
      readline(ip_vec_ga, text_line);

      -- read the first value into seed
      read(text_line, seed);
      seed_i <= conv_std_logic_vector(seed, seed_i'length);

      -- read the second value into seed3
      read(text_line, seed3);
      seed_3_i <= conv_std_logic_vector(seed3, seed_3_i'length);

      -- read the third value into seed2
      read(text_line, seed2);
      seed_2_i <= conv_std_logic_vector(seed2, seed_2_i'length);

      -- read the fourth value into seed1
      read(text_line, seed1);
      seed_1_i <= conv_std_logic_vector(seed1, seed_1_i'length);

      -- read the fifth value into run_ga
      read(text_line, run_ga);
      run_ga_i <= conv_std_logic_vector(run_ga, run_ga_i'length);

      -- read the sixth value into Xover_method
      read(text_line, Xover_method);
      crossMethod_i <= conv_std_logic_vector(Xover_method, crossMethod_i'length);

      -- read the sixth value into Mutation_method
      read(text_line, Mutation_method);
      mutMethod_i <= conv_std_logic_vector(Mutation_method, mutMethod_i'length);

      -- prevent memory leaks
      deallocate(text_line);

      wait until spy_next_generation = '1';  -- spy signal which informs when the current generation's evaluation ended

    end loop;

    wait;

  end process;  -- stimuli_gen

  -- comparison
  comp_vectors : process
    
    variable text_line   : line;
    variable elite1      : integer;     -- elite offs 1st (MatLab)
    variable elite2      : integer;     -- elite offs 2nd (MatLab)
    variable max_fitness : integer;     -- max fitness

    variable good_number : boolean;

    -- file where the output stimuli are stored
    file op_vec_ga : text is "..\sim\op_vec_ga.vec";
    
  begin

    while not endfile(op_vec_ga) loop

      readline(op_vec_ga, text_line);

      read(text_line, elite1, good => good_number);
      next when not good_number;
      elite_offs(0) <= elite1;

      read(text_line, elite2, good => good_number);
      next when not good_number;
      elite_offs(1) <= elite2;

      read(text_line, max_fitness, good => good_number);
      next when not good_number;
      max_fit <= conv_std_logic_vector(max_fitness, max_fit'length);


      -- prevent memory leaks
      deallocate(text_line);


      -- compare vectors
      if elite_offs(0)-1 /= spy_elite(0) then
        report "Vector mismatch." & "(MatLab)elite_offs(1)=" & integer'image(elite_offs(0)) & "  while, true_elite(1)=" & integer'image(spy_elite(0));
      end if;

      if elite_offs(1)-1 /= spy_elite(1) then
        report "Vector mismatch." & "(MatLab)elite_offs(2)=" & integer'image(elite_offs(1)) & "  while, true_elite(2)=" & integer'image(spy_elite(1));
      end if;

      if max_fit /= spy_max_fit then
        report "Vector mismatch." & "max_fit=" & integer'image(conv_integer(max_fit)) & "  while, true_max_fit=" & integer'image(conv_integer(spy_max_fit));
      end if;

      wait until spy_next_generation = '1';

    end loop;

    wait;
    
  end process;  -- comp_vectors


end bench;


configuration cfg_ga_tb of ga_tb is
  for bench
    for u_bench : ga
      -- Default configuration
    end for;
  end for;
end cfg_ga_tb;

configuration cfg_ga_tb_rtl of ga_tb is
  for bench
    for u_bench : ga
      use entity work.ga(str);
    end for;
  end for;
end cfg_ga_tb_rtl;

configuration cfg_ga_tb_gat of ga_tb is
  for bench
    for u_bench : ga
      use entity work.ga(gat);
    end for;
  end for;
end cfg_ga_tb_gat;
