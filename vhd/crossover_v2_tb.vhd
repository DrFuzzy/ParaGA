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
entity crossover_v2_tb is
  generic(
    genomLngt : positive := 8);          
end;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture bench of crossover_v2_tb is

  component crossover_v2
    generic(
      genomLngt : positive);          
    port (
      clk          : in  std_logic;     -- clock
      rst_n        : in  std_logic;     -- reset (active low)
      crossPoints  : in  std_logic_vector(2*log2(genomLngt)-1 downto 0);
      crossMethod  : in  std_logic_vector(1 downto 0);
      rng          : in  std_logic_vector(genomLngt-1 downto 0);
      inGene1      : in  std_logic_vector(genomLngt-1 downto 0);
      inGene2      : in  std_logic_vector(genomLngt-1 downto 0);
      rd           : out std_logic;
      crossOffspr1 : out std_logic_vector(genomLngt-1 downto 0));
  end component;

  signal period       : time      := 13.333 ns;  -- 75 MHz
  signal clk          : std_logic := '0';
  signal rst_n        : std_logic := '0';
  signal crossPoints  : std_logic_vector(2*log2(genomLngt)-1 downto 0);
  signal crossMethod  : std_logic_vector(1 downto 0);
  signal rng          : std_logic_vector(genomLngt-1 downto 0);
  signal inGene1      : std_logic_vector(genomLngt-1 downto 0);
  signal inGene2      : std_logic_vector(genomLngt-1 downto 0);
  signal rd           : std_logic;
  signal crossOffspr1 : std_logic_vector(genomLngt-1 downto 0);
  
  
begin  -- ARCHITECTURE bench
  
  u_bench : crossover_v2                -- component instantiation
    generic map (
      genomLngt => genomLngt)

    port map (
      clk          => clk,
      rst_n        => rst_n,
      crossPoints  => crossPoints,
      crossMethod  => crossMethod,
      rng          => rng,
      inGene1      => inGene1,
      inGene2      => inGene2,
      rd           => rd,
      crossOffspr1 => crossOffspr1);         

  -- clock and reset generator
  clk   <= not clk after period/2;
  rst_n <= '1'     after 6*period/2;

  -- testing all possible values
  stimuli_gen : process
  begin

    -- Initialization 
    crossPoints <= (others => '0');
    rng         <= (others => '0');
    inGene1     <= (others => '0');
    inGene2     <= (others => '0');
    crossMethod <= "11";

    wait for 30 ns;

    for i in 0 to 5 loop
      
      crossPoints <= "100010";          -- bit 2 is the first  Xover point
      rng         <= sxt(X"F0", rng'length);  -- will be the crossover mask for the uniform crossover 
      inGene1     <= sxt(X"E1", inGene1'length);  -- this is the first parent 
      inGene2     <= sxt(X"B0", inGene1'length);  -- this is the second parent 
      crossMethod <= "10";      -- One point crossover, "01" : uniform cossover

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


configuration cfg_crossover_v2_tb of crossover_v2_tb is
  for bench
    for u_bench : crossover_v2
      -- Default configuration
    end for;
  end for;
end cfg_crossover_v2_tb;

configuration cfg_crossover_v2_tb_rtl of crossover_v2_tb is
  for bench
    for u_bench : crossover_v2
      use entity work.crossover_v2(rtl);
    end for;
  end for;
end cfg_crossover_v2_tb_rtl;

configuration cfg_crossover_v2_tb_gat of crossover_v2_tb is
  for bench
    for u_bench : crossover_v2
      use entity work.crossover_v2(gat);
    end for;
  end for;
end cfg_crossover_v2_tb_gat;
