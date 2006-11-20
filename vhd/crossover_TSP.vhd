-------------------------------------------------------------------------------
-- Title      : Crossover block for TSP problem 
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : crossover_tsp.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 11/09/06
-- Last update: 20/11/06
-- Platform   : Modelsim 6.1c, Synplify 8.1, Xilinx ISE 8.1
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This block implements the crossover algorithm block (with TSP Xover)
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
entity crossover_tsp is
  generic(
    genom_lngt : positive := 21;
    num_towns  : positive := 8);
  port (
    clk          : in  std_logic;       -- clock
    rst_n        : in  std_logic;       -- reset (active low)
    cont         : in  std_logic;
    crossPoints  : in  std_logic_vector(2*log2(num_towns)-1 downto 0);
    inGene1      : in  std_logic_vector(genom_lngt-1 downto 0);
    inGene2      : in  std_logic_vector(genom_lngt-1 downto 0);
    rd           : out std_logic;
    crossOffspr1 : out std_logic_vector(genom_lngt-1 downto 0));
end entity crossover_tsp;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of crossover_tsp is

  
  signal cross_point_int : integer range 0 to 7                         := 0;
  signal ind             : integer range 1 to 7                         := 1;
  signal counter         : integer range 0 to num_towns-1               := num_towns-2;
  signal temp1           : std_logic_vector(genom_lngt-1 downto 0)      := (others => '0');
  signal temp2           : std_logic_vector(log2(num_towns)-1 downto 0) := (others => '0');
  signal crossout1       : std_logic_vector(genom_lngt-1 downto 0)      := (others => '0');
  signal done            : std_logic                                    := '0';
  signal cont1           : integer range 0 to 5                         := 0;
  signal index           : int_array(1 to num_towns-1)                  := (others => 0);
  signal pool_int        : int_array(0 to num_towns-2)                  := (others => 0);
begin

  process (clk, rst_n)
  begin
    if (rst_n = '0') then
      crossOffspr1 <= (others => '0');
      rd           <= '0';
    elsif clk = '1' and clk'event then
      crossOffspr1 <= crossout1;
      rd           <= done;
    end if;
  end process;

  process (clk, rst_n)
  begin
    if (rst_n = '0') then
      
      done            <= '0';
      cont1           <= 0;
      cross_point_int <= 0;
      temp1           <= (others => '0');
      temp2           <= (others => '0');
      ind             <= 1;
      counter         <= 0;
      for i in num_towns-1 downto 1 loop
        index(i)      <= 0;
        pool_int(i-1) <= 0;
      end loop;
      crossout1 <= (others => '0');
    elsif clk = '1' and clk'event then
      
      if cont = '1' then
        
        if cont1 = 0 then  -- Left part from Parent A , right part from Parent B
          pool_int <= pool;
          for i in 0 to num_towns-1 loop
            
            if i = conv_integer(crossPoints(2*log2(num_towns)-1 downto log2(num_towns))) then
              cross_point_int <= i;
              if i = 0 then
                temp1 <= inGene1;
                cont1 <= 5;
                exit;
              elsif i = 7 then
                temp1 <= inGene2;
                cont1 <= 5;
                exit;
              else
                temp1(genom_lngt-1 downto i*log2(num_towns)) <= inGene1(genom_lngt-1 downto i*log2(num_towns));
                temp1(i*log2(num_towns)-1 downto 0)          <= inGene2(i*log2(num_towns)-1 downto 0);
                cont1                                        <= 1;
                exit;
              end if;
            end if;
            
          end loop;
          crossout1 <= (others => '0');
        end if;

        if cont1 = 1 then
          for i in num_towns-1 downto 1 loop  -- Change to zero the towns in the pool which came from Parent A
            pool_int(conv_integer(temp1(i*log2(num_towns)-1 downto (i-1)*log2(num_towns)))-1) <= 0;
            if i = 1 then
              cont1   <= 2;
              counter <= num_towns-2;
            end if;
          end loop;
          crossout1 <= (others => '0');
        end if;

        if cont1 = 2 then  -- Find which towns are not in the left part and hold their index in the pool 
          temp2 <= (others => '0');
          if conv_std_logic_vector(pool_int(counter), log2(num_towns)) /= temp2 then
            index(ind) <= counter;
            ind        <= ind+1;
          end if;

          if counter = 0 then
            cont1   <= 3;
            ind     <= 1;
            counter <= 0;
          else
            counter <= counter-1;
          end if;
          crossout1 <= (others => '0');
        end if;

        if cont1 = 3 then  -- Find which towns in the left and right part are the same and replace them with zeros
          for cnt in 1 to num_towns-1 loop
            if cnt = cross_point_int then
              for i in cnt downto 1 loop
                for j in num_towns-1 downto cnt+1 loop
                  if conv_integer(temp1(i*log2(num_towns)-1 downto (i-1)*log2(num_towns)) xor
                                  temp1(j*log2(num_towns)-1 downto (j-1)*log2(num_towns))) = 0 then
                    temp1(i*log2(num_towns)-1 downto (i-1)*log2(num_towns)) <= (others => '0');
                    exit;
                  end if;
                end loop;
              end loop;
              cont1 <= 4;
              exit;
            else
              next;
            end if;
          end loop;
          crossout1 <= (others => '0');
        end if;

        if cont1 = 4 then  -- Replace zeros with the towns remained in the pool
          temp2 <= (others => '0');
          for i in 0 to num_towns-2 loop
            if i = counter then
              counter <= counter+1;
              if temp1((i+1)*log2(num_towns)-1 downto (i)*log2(num_towns)) = temp2 then  -- equals zero
                temp1((i+1)*log2(num_towns)-1 downto (i)*log2(num_towns)) <= conv_std_logic_vector(pool_int(index(ind)), log2(num_towns));
                ind                                                       <= ind+1;
              end if;
            else
              next;
            end if;
          end loop;
          crossout1 <= (others => '0');
          if counter = num_towns-2 then
            cont1 <= 5;
          end if;
          
        end if;

        if cont1 = 5 then
          crossout1 <= temp1;
          done      <= '1';
        end if;
        
      else
        done            <= '0';
        cont1           <= 0;
        cross_point_int <= 0;
        temp1           <= (others => '0');
        temp2           <= (others => '0');
        ind             <= 1;
        counter         <= 0;
        for i in num_towns-1 downto 1 loop
          index(i) <= 0;
        end loop;
      end if;
    end if;
  end process;

end rtl;
