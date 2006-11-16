library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

library modelsim_lib;
use modelsim_lib.util.all;

use std.textio.all;
use work.dhga_pkg.all;
use work.arith_pkg.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity fit_eval_tb is
  generic(
    genomLngt : positive := 16;
    scoreSz   : integer  := 17;
    popSz     : positive := 16);  
end entity fit_eval_tb;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture bench of fit_eval_tb is

  component fit_eval
    generic(
      genomLngt : positive;
      scoreSz   : integer;
      popSz     : positive);  
    port (
      clk        : in  std_logic;       -- clock
      rst_n      : in  std_logic;       -- reset (active low)
      inGene     : in  std_logic_vector(genomLngt-1 downto 0);
      score      : out std_logic_vector(scoreSz-1 downto 0);  -- fitness value of inGene
      fitSum     : out std_logic_vector(scoreSz+log2(popSz)-1 downto 0);  -- sum of fitnesses
      fitEvalFin : out std_logic);  -- fitness evaluation finished after selecting nParents genes
  end component;


  signal period     : time      := 13.333 ns;                -- 75 MHz
  signal clk        : std_logic := '0';  -- clock
  signal rst_n      : std_logic := '0';  -- reset (active low)
  signal inGene     : std_logic_vector(genomLngt-1 downto 0);
  signal score      : std_logic_vector(scoreSz-1 downto 0);  -- fitness value of inGene
  signal fitSum     : std_logic_vector(scoreSz+log2(popSz)-1 downto 0);  -- sum of fitnesses 
  signal fitEvalFin : std_logic;  -- fitness evaluation finished after selecting nParents genes    
  
  
begin  -- ARCHITECTURE bench
  
  u_bench : fit_eval                    -- component instantiation
    generic map (
      genomLngt => genomLngt,
      popSz     => popSz,
      scoreSz   => scoreSz)        

    port map (
      clk        => clk,
      rst_n      => rst_n,
      inGene     => inGene,
      score      => score,
      fitSum     => fitSum,
      fitEvalFin => fitEvalFin);

  -- clock and reset generator
  clk   <= not clk after period/2;
  rst_n <= '1'     after 6*period/2;

  stimuli_gen : process
  begin
    
    inGene <= (others => '0');

    wait for 30 ns;

    for i in 0 to 5 loop
      
      inGene <= sxt(X"0001", inGene'length);

      for j in 0 to 3 loop
        wait for period*7.5;
      end loop;  -- j

    end loop;  -- i

    wait;

  end process stimuli_gen;

  -- simulation time check
  check : process(clk)
  begin
    assert now < 1000000*period
      report "End of simulation"
      severity failure;
  end process;

end bench;


configuration cfg_fit_eval_tb of fit_eval_tb is
  for bench
    for u_bench : fit_eval
      -- Default configuration
    end for;
  end for;
end cfg_fit_eval_tb;

configuration cfg_fit_eval_tb_rtl of fit_eval_tb is
  for bench
    for u_bench : fit_eval
      use entity work.fit_eval(rtl);
    end for;
  end for;
end cfg_fit_eval_tb_rtl;

configuration cfg_fit_eval_tb_gat of fit_eval_tb is
  for bench
    for u_bench : fit_eval
      use entity work.fit_eval(gat);
    end for;
  end for;
end cfg_fit_eval_tb_gat;
