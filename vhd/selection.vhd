-------------------------------------------------------------------------------
-- Title      : Selection block
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : selection.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 23/03/06
-- Last update: 07/11/06
-- Platform   : Modelsim 6.1c, Synplify 8.1, ISE 8.1
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This block implements the selection algorithm block 
-------------------------------------------------------------------------------
-- Copyright (c) 2006 NTUA
-------------------------------------------------------------------------------
-- revisions  :
-- date        version  author  description
-- 07/11/06    1.0      kdelip  Created
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- LIBRARIES
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.dhga_pkg.all;
use work.arith_pkg.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity selection is
  generic(
    genom_lngt         : positive := 4;
    pop_sz             : positive := 8;
    elite              : integer  := 2;
    score_sz           : integer  := 4;
    scaling_factor_res : integer  := 5);  -- scaling factor resolution (bits)  
  port (
    clk        : in  std_logic;         -- clock
    rst_n      : in  std_logic;         -- reset (active low)
    inGene     : in  std_logic_vector(genom_lngt+score_sz-1 downto 0);  -- gene and its fitness value concatenated
    rng        : in  std_logic_vector(scaling_factor_res-1 downto 0);  -- random number for scaling down the fitSum 
    fitSum     : in  std_logic_vector(score_sz+log2(pop_sz)-1 downto 0);  -- sum of fitnesses
    data_valid : in  std_logic;
    next_gene  : in  std_logic;
    selParent  : out std_logic_vector(genom_lngt-1 downto 0);
    rd         : out std_logic);  -- ready signal: parent is on pin selparent
end entity selection;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of selection is
  signal done         : std_logic;
  signal done_t       : std_logic;
  signal rd_p1        : std_logic;
  signal temp_rd      : std_logic;
  signal cumSum_p1    : std_logic_vector(score_sz+log2(pop_sz)-1 downto 0);
  signal scalFitSum   : std_logic_vector(score_sz+log2(pop_sz)+scaling_factor_res-1 downto 0);
  signal scalFitSum_p : std_logic_vector(score_sz+log2(pop_sz)+scaling_factor_res-1 downto 0);
  signal selParent_p  : std_logic_vector(genom_lngt-1 downto 0);
  signal sel_gene     : std_logic_vector(genom_lngt-1 downto 0);
  signal count        : std_logic;

begin

  process (clk, rst_n)
  begin
    if (rst_n = '0') then
      count       <= '0';               -- 1st cycle of selection..??
      cumSum_p1   <= (others => '0');  -- Previous accumulated sum of fitnesses
      done_t      <= '0';  -- Notifies if selection block needs to continue with another gene from ram 1
      --scalFitSum_p <= (others => '0');
      temp_rd     <= '0';
      selParent_p <= (others => '0');
    elsif clk = '1' and clk'event then
      temp_rd <= rd_p1;
      if data_valid = '1' then
        count <= '1';
      else
        count <= '0';
      end if;
      if data_valid = '1' and next_gene = '0' and count = '1' then
        --cumSum_p1 <= cumSum_p1;
      elsif (data_valid = '1' and next_gene = '1') or (data_valid = '1' and next_gene = '0' and count = '0')then
        cumSum_p1 <= cumSum_p1 + inGene(score_sz-1 downto 0);
      else
        cumSum_p1 <= (others => '0');
      end if;
      done_t      <= done;
      --scalFitSum_p <= scalFitSum;
      selParent_p <= sel_gene;
    end if;
  end process;

  rd        <= temp_rd;
  selParent <= selParent_p;

  selection : process (fitSum, rng, cumSum_p1, scalFitSum, scalFitSum_p, inGene, done_t, data_valid, count, temp_rd, selParent_p)
  begin


    if data_valid = '1' and temp_rd = '0' then

      --score <= inGene(score_sz-1 downto 0);
      --cumSum <= cumSum_p1 + inGene(score_sz-1 downto 0);
      if done_t = '0' then
        scalFitSum <= shr(fitSum * rng(scaling_factor_res-1 downto 0),
                          conv_std_logic_vector(scaling_factor_res, scaling_factor_res));
      elsif done_t = '1' and count = '0' then
        scalFitSum <= shr(fitSum * rng(scaling_factor_res-1 downto 0),
                          conv_std_logic_vector(scaling_factor_res, scaling_factor_res));
      elsif done_t = '1' and count = '1' then
        scalFitSum <= scalFitSum_p;
      else
        scalFitSum <= scalFitSum_p;
      end if;

      if cumSum_p1 < scalFitSum or cumSum_p1 = scalFitSum then
        sel_gene <= (others => '0');
        if count = '0' then
          done <= '0';
        else
          done <= '1';
        end if;
        rd_p1 <= '0';
      else
        sel_gene <= inGene(genom_lngt+score_sz-1 downto score_sz);
        done     <= '0';
        rd_p1    <= '1';
      end if;
      
    elsif data_valid = '0' then
      rd_p1      <= '0';
      sel_gene   <= (others => '0');
      scalFitSum <= scalFitSum_p;
      done       <= done_t;
    else
      rd_p1      <= temp_rd;
      sel_gene   <= selParent_p;
      scalFitSum <= scalFitSum_p;
      done       <= done_t;
    end if;
    
  end process selection;

  -- purpose: force synplify to invoke mult18x18s
  -- type   : sequential
  -- inputs : clk, rst_n, scalFitSum
  -- outputs: scalFitSum_p
  mult18x18s : process (clk) is
  begin  -- process mult18x18s
    if rising_edge(clk) then            -- rising clock edge
      if rst_n = '0' then               -- synchronous reset (active low)
        scalFitSum_p <= (others => '0');
      else
        scalFitSum_p <= scalFitSum;
      end if;
    end if;
  end process mult18x18s;

end rtl;
