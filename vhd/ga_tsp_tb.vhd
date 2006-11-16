-------------------------------------------------------------------------------
-- Title      : GA
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : ga_tsp_tb.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos (kdelip@mail.ntua.gr)
-- Company    : NTUA/IRAL
-- Created    : 25/09/06
-- Last update: 2006-11-02
-- Platform   : Modelsim, Synplicity, ISE
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This is the testbench for the GA top design for the dolution
--              of the TSP problem
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
use ieee.std_logic_signed.all;

library modelsim_lib;
use modelsim_lib.util.all;

use std.textio.all;
use work.dhga_pkg.all;
use work.rom_pkg.all;
use work.arith_pkg.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity ga_tsp_tb is
-- empty
end;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture bench of ga_tsp_tb is

  component ga_tsp
    generic (
      genom_lngt         : positive;
      score_sz           : integer;
      scaling_factor_res : integer;
      pop_sz             : integer;
      elite              : integer;
      num_towns          : integer;
      townres            : integer;
      mr                 : integer;
      mut_res            : integer;  -- max for mutation rate is 2^mut_res -1 = 255
      max_gen            : positive);
    port (
      clk       : in  std_logic;
      rst_n     : in  std_logic;
      --pool        : in  int_array(1 to num_towns-1); 
      run_ga_i  : in  std_logic;
      seed_1_i  : in  std_logic_vector(mut_res-1 downto 0);
      seed_2_i  : in  std_logic_vector(2*log2(num_towns)-1 downto 0);
      seed_3_i  : in  std_logic_vector(scaling_factor_res-1 downto 0);
      best_gene : out std_logic_vector(genom_lngt-1 downto 0);
      best_fit  : out std_logic_vector(score_sz-1 downto 0);
      ga_fin    : out std_logic);                     
  end component ga_tsp;


  signal clk   : std_logic := '0';      -- system clock
  signal rst_n : std_logic := '0';      -- reset (active low)

  -- output signals
  signal best_gene : std_logic_vector(21-1 downto 0);
  signal best_fit  : std_logic_vector(16-1 downto 0);
  signal ga_fin    : std_logic;

  -- test vector signals
  signal run_ga_i : std_logic_vector(1 downto 0);
  signal seed_1_i : std_logic_vector(8-1 downto 0);
  signal seed_2_i : std_logic_vector(2*log2(8)-1 downto 0);
  signal seed_3_i : std_logic_vector(4-1 downto 0);

  -- true internal signals 
  signal elite_offs : int_array(0 to 2-1);
  signal max_fit    : std_logic_vector(16-1 downto 0);

  -- spy signals
  signal spy_next_generation : std_logic;
  signal spy_elite           : int_array(0 to 2-1);
  signal spy_max_fit         : std_logic_vector(16-1 downto 0);

  -- simulation period
  signal period : time := 13 ns;        -- 100 MHz
  
  
begin  -- ARCHITECTURE bench

  u_bench : ga_tsp
    generic map (
      genom_lngt         => 21,
      score_sz           => 16,
      scaling_factor_res => 4,
      pop_sz             => 16,
      elite              => 2,
      num_towns          => 8,
      townres            => 3,
      mr                 => 150,
      mut_res            => 8,
      max_gen            => 100)          

    
    
    port map (
      clk       => clk,
      rst_n     => rst_n,
      run_ga_i  => run_ga_i(0),
      seed_1_i  => seed_1_i,
      seed_2_i  => seed_2_i,
      seed_3_i  => seed_3_i,
      best_gene => best_gene,
      best_fit  => best_fit,
      ga_fin    => ga_fin);     



  -- clock and reset generator
  clk   <= not clk after period/2;
  rst_n <= '1'     after 6*period/2;

  -- !!! assign spy signals !!!
  init_signal_spy("/ga_tsp_tb/u_bench/u10/next_generation", "/spy_next_generation", 0);
  init_signal_spy("/ga_tsp_tb/u_bench/u4/elite_offs", "/spy_elite", 0);
  init_signal_spy("/ga_tsp_tb/u_bench/u4/max_fit", "/spy_max_fit", 0);


  -- testing all possible values
  stimuli_gen : process
    
    variable text_line : line;
    variable run_ga    : integer;
    variable seed1     : integer;
    variable seed2     : integer;
    variable seed3     : integer;

    -- file where the input stimuli are stored
    file ip_vec_ga_tsp : text is "..\sim\ip_vec_ga_tsp.vec";  -- Change Matlab file name too....(3/10/2006)
    
  begin
    
    while not endfile(ip_vec_ga_tsp) loop
      -- read one line from file input_data.vec into text_line
      readline(ip_vec_ga_tsp, text_line);
      -- read the first value into seed1
      read(text_line, seed3);
      seed_3_i <= conv_std_logic_vector(seed3, seed_3_i'length);

      -- read the second value into seed2
      read(text_line, seed2);
      seed_2_i <= conv_std_logic_vector(seed2, seed_2_i'length);

      -- read the third value into seed3
      read(text_line, seed1);
      seed_1_i <= conv_std_logic_vector(seed1, seed_1_i'length);

      -- read the fourth value into run_ga
      read(text_line, run_ga);
      run_ga_i <= conv_std_logic_vector(run_ga, run_ga_i'length);

      -- prevent memory leaks
      deallocate(text_line);

      wait until spy_next_generation = '1';  -- spy signal which informs when the current generation's evaluation ended

    end loop;

    wait;

  end process;  -- stimuli_gen

  -- comparison
  comp_vectors : process
    
    variable text_line   : line;
    variable elite1      : integer;     -- elite offs 1st
    variable elite2      : integer;     -- elite offs 2nd
    variable max_fitness : integer;     -- max fitness

    variable good_number : boolean;

    -- file where the output stimuli are stored
    file op_vec_ga_tsp : text is "..\sim\op_vec_ga_tsp.vec";  -- Change Matlab file name too....(3/10/2006)
    
  begin

    while not endfile(op_vec_ga_tsp) loop

      readline(op_vec_ga_tsp, text_line);

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


configuration cfg_ga_tsp_tb of ga_tsp_tb is
  for bench
    for u_bench : ga_tsp
      -- Default configuration
    end for;
  end for;
end cfg_ga_tsp_tb;

configuration cfg_ga_tsp_tb_rtl of ga_tsp_tb is
  for bench
    for u_bench : ga_tsp
      use entity work.ga_tsp(str);
    end for;
  end for;
end cfg_ga_tsp_tb_rtl;

configuration cfg_ga_tsp_tb_gat of ga_tsp_tb is
  for bench
    for u_bench : ga_tsp
      use entity work.ga_tsp(gat);
    end for;
  end for;
end cfg_ga_tsp_tb_gat;
