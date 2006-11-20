-------------------------------------------------------------------------------
-- Title      : Crossover block
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : crossover.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 23/03/06
-- Last update: 20/11/06
-- Platform   : Modelsim 6.1c, Synplify 8.1, Xilinx ISE 8.1
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This block implements the mutation algorithm block 
-------------------------------------------------------------------------------
-- Copyright (c) 2006 NTUA
-------------------------------------------------------------------------------
-- revisions  :
-- date        version  author  description
-- 23/03/06    1.1      kdelip  created
-- 20/11/06    1.2      kdelip  updated
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- LIBRARIES
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.ga_pkg.all;
use work.arith_pkg.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity crossover is
  generic(
    genom_lngt : positive);
  port (
    clk          : in  std_logic;       -- clock
    rst_n        : in  std_logic;       -- reset (active low)
    cont         : in  std_logic;
    crossPoints  : in  std_logic_vector(2*log2(genom_lngt)-1 downto 0);
    crossMethod  : in  std_logic_vector(1 downto 0);
    rng          : in  std_logic_vector(genom_lngt-1 downto 0);
    inGene1      : in  std_logic_vector(genom_lngt-1 downto 0);
    inGene2      : in  std_logic_vector(genom_lngt-1 downto 0);
    rd           : out std_logic;
    crossOffspr1 : out std_logic_vector(genom_lngt-1 downto 0));
end entity crossover;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of crossover is

  
  signal mask        : std_logic_vector(genom_lngt-1 downto 0)     := (others => '0');
  signal mask1       : std_logic_vector(genom_lngt-1 downto 0)     := (others => '0');
  signal mask2       : std_logic_vector(genom_lngt-1 downto 0)     := (others => '0');
  signal temp        : std_logic_vector(log2(genom_lngt) downto 0) := (others => '0');
  signal temp_int    : integer                                     := 0;
  signal temp1       : std_logic_vector(genom_lngt-1 downto 0)     := (others => '0');
  signal temp2       : std_logic_vector(genom_lngt-1 downto 0)     := (others => '0');
  signal crossout1   : std_logic_vector(genom_lngt-1 downto 0)     := (others => '0');
  signal crossout1_t : std_logic_vector(genom_lngt-1 downto 0)     := (others => '0');
  signal done        : std_logic                                   := '0';
  signal done_t      : std_logic                                   := '0';
begin

  process (clk, rst_n)
  begin
    if (rst_n = '0') then
      crossout1_t <= (others => '0');
      done_t      <= '0';
    elsif clk = '1' and clk'event then
      crossout1_t <= crossout1;
      done_t      <= done;
    end if;
  end process;

  rd           <= done_t;
  crossOffspr1 <= crossout1_t;

  crossover : process (crossMethod, crossout1_t, mask, mask1, mask2, inGene1, inGene2,
                      temp_int, temp1, temp2, temp, rng, crossPoints, cont, done_t)
  begin

    if cont = '1' and done_t = '0' then
      case crossMethod is
        
        when "00" =>                    -- one Point crossover 
          mask <= (others => '1');

          mask1 <= shr(mask, conv_std_logic_vector(genom_lngt-1, log2(genom_lngt))
                           - crossPoints(2*log2(genom_lngt)-1 downto log2(genom_lngt)));
          temp1     <= inGene1 and mask1;
          temp2     <= inGene2 and (not mask1);
          crossout1 <= (temp1 xor temp2);
          done      <= '1';
          mask2     <= (others => '0');
          temp      <= (others => '0');
          temp_int  <= 0;
          
        when "01" =>                    -- two point crossover
          mask     <= (others => '1');
          temp_int <= conv_integer(crossPoints(log2(genom_lngt)-1 downto 0))
                      - conv_integer(crossPoints(2*log2(genom_lngt)-1 downto log2(genom_lngt)));
          temp <= abs(conv_signed(temp_int, temp'length));
          if crossPoints(log2(genom_lngt)-1 downto 0) /= crossPoints(2*log2(genom_lngt)-1 downto log2(genom_lngt)) then
            mask1 <= shr(mask, conv_std_logic_vector(genom_lngt, temp'length)-temp);
          else
            mask1 <= shr(mask, conv_std_logic_vector(genom_lngt-1, log2(genom_lngt)));
          end if;
          if crossPoints(log2(genom_lngt)-1 downto 0) > crossPoints(2*log2(genom_lngt)-1 downto log2(genom_lngt)) then
            mask2 <= shl(mask1, crossPoints(2*log2(genom_lngt)-1 downto log2(genom_lngt)) + 1);
          elsif crossPoints(log2(genom_lngt)-1 downto 0) < crossPoints(2*log2(genom_lngt)-1 downto log2(genom_lngt)) then
            mask2 <= shl(mask1, crossPoints(log2(genom_lngt)-1 downto 0) + 1);
          elsif crossPoints(log2(genom_lngt)-1 downto 0) = crossPoints(2*log2(genom_lngt)-1 downto log2(genom_lngt)) then
            mask2 <= shl(mask1, crossPoints(log2(genom_lngt)-1 downto 0));
          end if;
          temp1     <= inGene1 and mask2;
          temp2     <= inGene2 and (not mask2);
          crossout1 <= (temp1 xor temp2);
          done      <= '1';

        when "10" =>                    -- uniform crossover
          temp1     <= inGene1 and (not rng);
          temp2     <= inGene2 and rng;
          crossout1 <= (temp1 xor temp2);
          done      <= '1';
          temp      <= (others => '0');
          mask      <= (others => '0');
          mask1     <= (others => '0');
          mask2     <= (others => '0');
          temp_int  <= 0;
          
        when others =>
          mask      <= (others => '0');
          mask1     <= (others => '0');
          mask2     <= (others => '0');
          temp_int  <= 0;
          temp      <= (others => '0');
          temp1     <= (others => '0');
          temp2     <= (others => '0');
          done      <= '0';
          crossout1 <= (others => '0');
      end case;
    elsif done_t = '1' then
      mask      <= (others => '0');
      mask1     <= (others => '0');
      mask2     <= (others => '0');
      temp_int  <= 0;
      temp      <= (others => '0');
      temp1     <= (others => '0');
      temp2     <= (others => '0');
      done      <= '0';
      crossout1 <= crossout1_t;
    else
      mask      <= (others => '0');
      mask1     <= (others => '0');
      mask2     <= (others => '0');
      temp_int  <= 0;
      temp      <= (others => '0');
      temp1     <= (others => '0');
      temp2     <= (others => '0');
      done      <= '0';
      crossout1 <= (others => '0');
    end if;
  end process crossover;

end rtl;
