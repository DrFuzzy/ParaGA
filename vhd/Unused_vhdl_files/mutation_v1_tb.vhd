library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

library modelsim_lib;
use modelsim_lib.util.all;

use std.textio.all;
use work.ga_pkg.all;
use work.arith_pkg.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity mutation_v1_tb is
  generic(
    genomLngt : positive                     := 16;
    mutRes    : integer                      := 8;
    nParents  : integer                      := 50;
    upRange   : positive                     := 1;
    dnRange   : positive                     := 1;
    mutMethod : std_logic_vector(1 downto 0) := "10"
    );          
end;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture bench of mutation_v1_tb is

  component mutation_v1
    generic (
      genomLngt : positive;
      mutRes    : integer;
      nParents  : integer;
      upRange   : positive;
      dnRange   : positive;
      mutMethod : std_logic_vector(1 downto 0));

    port (
      clk       : in  std_logic;        -- clock
      rst_n     : in  std_logic;        -- reset (active low)
      mutEn     : in  std_logic;
      mutPoint  : in  std_logic_vector(log2(genomLngt)-1 downto 0);
      mutrate   : in  std_logic_vector(mutRes-1 downto 0);
      rng1      : in  std_logic_vector(mutRes-1 downto 0);
      rng       : in  std_logic_vector(genomLngt-1 downto 0);
      inGene    : in  std_logic_vector(genomLngt-1 downto 0);
      -- we         : out  std_logic;
      mutDone   : out std_logic;
      mutOffspr : out std_logic_vector(genomLngt-1 downto 0));
  end component;

  signal period    : time      := 13.333 ns;  -- 75 MHz
  signal clk       : std_logic := '0';
  signal rst_n     : std_logic := '0';
  signal mutEn     : std_logic;
  signal mutPoint  : std_logic_vector(log2(genomLngt)-1 downto 0);
  signal mutrate   : std_logic_vector(mutRes-1 downto 0);
  signal rng1      : std_logic_vector(mutRes-1 downto 0);
  signal rng       : std_logic_vector(genomLngt-1 downto 0);
  signal inGene    : std_logic_vector(genomLngt-1 downto 0);
  signal mutDone   : std_logic;
  signal mutOffspr : std_logic_vector(genomLngt-1 downto 0);
  
begin  -- ARCHITECTURE bench
  
  u_bench : mutation_v1                 -- component instantiation
    generic map (
      genomLngt => genomLngt,
      mutRes    => mutRes,
      nParents  => nParents,
      upRange   => upRange,
      dnRange   => dnRange,
      mutMethod => mutMethod)
    port map (
      clk       => clk,
      rst_n     => rst_n,
      mutEn     => mutEn,
      mutPoint  => mutPoint,
      mutrate   => mutrate,
      rng1      => rng1,
      rng       => rng,
      inGene    => inGene,
      mutDone   => mutDone,
      mutOffspr => mutOffspr);

  -- clock and reset generator
  clk   <= not clk after period/2;
  rst_n <= '1'     after 6*period/2;

  -- testing all possible values
  stimuli_gen : process
  begin
    
    mutEn    <= '0';
    mutPoint <= (others => '0');
    mutrate  <= (others => '0');        -- 0.1 approx
    rng1     <= (others => '0');        -- X"0000";
    rng      <= (others => '0');
    inGene   <= (others => '0');


    wait for 30 ns;

    for i in 0 to 400 loop
      mutEn    <= '0';
      mutPoint <= (others => '0');
      mutrate  <= "00011001";           -- 0.1 approx
      rng1     <= (others => '0');      -- X"0000";
      rng      <= (others => '0');
      inGene   <= "0101010101010101";

      rng1     <= "00001001";           -- less than mutrate   
      rng      <= "0000000000000100";  -- will be XORed with inGene if Method = "01"
      mutPoint <= "0001";               -- bit 1 will be mutated

      for j in 0 to 7 loop
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


configuration cfg_mutation_v1_tb of mutation_v1_tb is
  for bench
    for u_bench : mutation_v1
      -- Default configuration
    end for;
  end for;
end cfg_mutation_v1_tb;

configuration cfg_mutation_v1_tb_rtl of mutation_v1_tb is
  for bench
    for u_bench : mutation_v1
      use entity work.mutation_v1(rtl);
    end for;
  end for;
end cfg_mutation_v1_tb_rtl;

configuration cfg_mutation_v1_tb_gat of mutation_v1_tb is
  for bench
    for u_bench : mutation_v1
      use entity work.mutation_v1(gat);
    end for;
  end for;
end cfg_mutation_v1_tb_gat;
