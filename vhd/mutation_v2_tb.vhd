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
entity mutation_v2_tb is
  generic(
           genomLngt : positive := 8;
           mr	     : integer  := 25;
           mutRes    : integer  := 8
           );          
end;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture bench of mutation_v2_tb is

  component mutation_v2
    generic (
           genomLngt : positive;
           mr	     : integer;
           mutRes    : integer
           );

    port ( clk         : in  std_logic;  -- clock
           rst_n       : in  std_logic;  -- reset (active low)
           mutPoint    : in  std_logic_vector(log2(genomLngt)-1 downto 0);
           mutMethod   : in  std_logic_vector(1 downto 0);
           rng	       : in  std_logic_vector(genomLngt + mutRes-1 downto 0);  
           inGene      : in  std_logic_vector(genomLngt-1 downto 0);  
           rd          : out std_logic;
           mutOffspr   : out std_logic_vector(genomLngt-1 downto 0)
           );

  end component;
  
  signal period : time := 13.333 ns; -- 75 MHz
  signal clk           : std_logic := '0';
  signal rst_n         : std_logic := '0';  
  signal mutPoint      : std_logic_vector(log2(genomLngt)-1 downto 0);
  signal mutMethod     : std_logic_vector(1 downto 0);
  signal rng	       : std_logic_vector(genomLngt + mutRes -1 downto 0);  
  signal inGene        : std_logic_vector(genomLngt-1 downto 0);  
  signal rd            : std_logic;
  signal mutOffspr     : std_logic_vector(genomLngt-1 downto 0);
  
  begin -- ARCHITECTURE bench
  
    u_bench : mutation_v2 -- component instantiation
      generic map (
           genomLngt => genomLngt,
           mr	     => mr,
           mutRes    => mutRes)
      port map (
           clk           => clk,
           rst_n         => rst_n,
           mutPoint      => mutPoint,
 	   mutMethod     => mutMethod,
           rng           => rng,
           inGene        => inGene,
           rd	         => rd,
           mutOffspr     => mutOffspr);
      
 -- clock and reset generator
      clk   <= not clk after period/2;
      rst_n <= '1'     after 6*period/2;
      
 -- testing all possible values
  stimuli_gen : process
  begin 
  
    mutPoint  <= (others=>'0');
    rng       <= (others=>'0');
    inGene    <= (others=>'0');
    mutMethod <= "11";

 wait for 30 ns;

 for i in 0 to 5 loop
     mutMethod <= "00";
     inGene    <= "01010101";
     rng      <= "1000000000001001"; -- [mask | rng1] rng1 is here less than mutrate -- mask will be XORed with inGene if Method = "01"
     mutPoint  <= "001";            -- bit 1 will be mutated

      for j in 0 to 3 loop
        wait for period*7.5;
      end loop;  -- j

    end loop;  -- i
 
  wait for 30 ns;

    
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


configuration cfg_mutation_v2_tb of mutation_v2_tb is
  for bench
    for u_bench: mutation_v2
      -- Default configuration
    end for;
  end for;
end cfg_mutation_v2_tb;

configuration cfg_mutation_v2_tb_rtl of mutation_v2_tb is
  for bench
    for u_bench: mutation_v2
      use entity work.mutation_v2(rtl);
    end for;
  end for;
end cfg_mutation_v2_tb_rtl;

configuration cfg_mutation_v2_tb_gat of mutation_v2_tb is
  for bench
    for u_bench: mutation_v2
      use entity work.mutation_v2(gat);
    end for;
  end for;
end cfg_mutation_v2_tb_gat;