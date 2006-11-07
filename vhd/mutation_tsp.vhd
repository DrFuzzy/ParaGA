--------------------------------Mutation block for tsp-------------------------------------
-- Title      : Mutation block for tsp
-- Project    : GA
-------------------------------------------------------------------------------
-- File       : mutation_tsp.vhd
-- Author     :   <George Doyamis@GEORGEDOYAMIS>
-- Company    : NTUA/IRAL
-- Created    : 23/03/06
-- Last update: 07/11/06
-- Platform   : Modelsim 6.1d, Synplify Pro 8.5.1, ISE 8.1.03i
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This block implements the mutation algorithm block 
-------------------------------------------------------------------------------
-- Copyright (c) 2006 NTUA/IRAL
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 07/11/06     1.0     geod    Created
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
entity mutation_tsp is
  generic(
    genom_lngt : positive := 21;
    mr         : integer  := 25;  -- mutation rate coded in mut_res bits --> 25/255 ~= 0,1  
    mut_res    : integer  := 8;         -- mutation resolution
    num_towns  : integer  := 8
    );          
  port (
    clk       : in  std_logic;          -- clock
    rst_n     : in  std_logic;          -- reset (active low)
    mutPoint  : in  std_logic_vector(2*log2(num_towns)-1 downto 0);  -- mutation points -- comes from rng2
    cont      : in  std_logic;
    flag      : in  std_logic;
    rng       : in  std_logic_vector(mut_res-1 downto 0);  -- XORed with input Gene
    inGene    : in  std_logic_vector(genom_lngt-1 downto 0);
    rd        : out std_logic;          -- mutation ended for current parent
    mutOffspr : out std_logic_vector(genom_lngt-1 downto 0));  -- produced mutation offspring (kid)
end entity mutation_tsp;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of mutation_tsp is

  signal mutout    : std_logic_vector(genom_lngt-1 downto 0) := (others => '0');
  signal mutout_p1 : std_logic_vector(genom_lngt-1 downto 0) := (others => '0');
  signal done      : std_logic                               := '0';
  signal done_p    : std_logic                               := '0';
begin

  process (clk, rst_n)
  begin
    if (rst_n = '0') then
      mutout_p1 <= (others => '0');
      done_p    <= '0';
    elsif clk = '1' and clk'event then
      mutout_p1 <= mutout;
      if flag = '1' then
        done_p <= '0';
      else
        done_p <= done;
      end if;
    end if;
  end process;

  mutOffspr <= mutout_p1;
  rd        <= done_p;

  mutation_tsp : process (mutPoint, rng, inGene, mutout_p1, cont, flag, done_p)
  begin

    case cont is
      
      when '1' =>                       -- mutation block enabled
        
        if rng(mut_res-1 downto 0) > conv_std_logic_vector(mr, mut_res) or ((rng(mut_res-1 downto 0) < conv_std_logic_vector(mr, mut_res)) and (mutPoint(2*log2(num_towns)-1 downto log2(num_towns)) = mutPoint(log2(num_towns)-1 downto 0))) then
          mutout <= inGene;
          done   <= '1';
        else
          if conv_integer(mutPoint(2*log2(num_towns)-1 downto log2(num_towns))) = num_towns-1 then
            for i in 0 to num_towns-2 loop
              for j in 0 to num_towns-2 loop
                if i /= conv_integer(mutPoint(2*log2(num_towns)-1 downto log2(num_towns)))-1 and i /= conv_integer(mutPoint(log2(num_towns)-1 downto 0)) then
                  mutout((i+1)*log2(num_towns)-1 downto i*log2(num_towns)) <= inGene((i+1)*log2(num_towns)-1 downto i*log2(num_towns));
                  exit;
                -- i=mutPoint(1) and j=mutPoint(2)
                elsif i = conv_integer(mutPoint(log2(num_towns)-1 downto 0)) then
                  mutout((i+1)*log2(num_towns)-1 downto i*log2(num_towns)) <= inGene((num_towns-1)*log2(num_towns)-1 downto (num_towns-2)*log2(num_towns));
                  exit;
                -- i=mutPoint(2) and j=mutPoint(1)
                elsif j = conv_integer(mutPoint(log2(num_towns)-1 downto 0)) and i = conv_integer(mutPoint(2*log2(num_towns)-1 downto log2(num_towns)))-1 then
                  mutout((i+1)*log2(num_towns)-1 downto i*log2(num_towns)) <= inGene((j+1)*log2(num_towns)-1 downto j*log2(num_towns));
                  exit;
                else
                  mutout((i+1)*log2(num_towns)-1 downto i*log2(num_towns)) <= (others => '1');
                end if;
              end loop;
            end loop;
            done <= '1';
          elsif conv_integer(mutPoint(log2(num_towns)-1 downto 0)) = num_towns-1 then
            for i in 0 to num_towns-2 loop
              for j in 0 to num_towns-2 loop
                if i /= conv_integer(mutPoint(2*log2(num_towns)-1 downto log2(num_towns))) and i /= conv_integer(mutPoint(log2(num_towns)-1 downto 0))-1 then
                  mutout((i+1)*log2(num_towns)-1 downto i*log2(num_towns)) <= inGene((i+1)*log2(num_towns)-1 downto i*log2(num_towns));
                  exit;
                -- i=mutPoint(1) and j=mutPoint(2)
                elsif i = conv_integer(mutPoint(log2(num_towns)-1 downto 0))-1 and j = conv_integer(mutPoint(2*log2(num_towns)-1 downto log2(num_towns))) then
                  mutout((i+1)*log2(num_towns)-1 downto i*log2(num_towns)) <= inGene((j+1)*log2(num_towns)-1 downto j*log2(num_towns));
                  exit;
                -- i=mutPoint(2) and j=mutPoint(1)
                elsif i = conv_integer(mutPoint(2*log2(num_towns)-1 downto log2(num_towns))) then
                  mutout((i+1)*log2(num_towns)-1 downto i*log2(num_towns)) <= inGene((num_towns-1)*log2(num_towns)-1 downto (num_towns-2)*log2(num_towns));
                  exit;
                else
                  mutout((i+1)*log2(num_towns)-1 downto i*log2(num_towns)) <= (others => '1');
                end if;
              end loop;
            end loop;
            done <= '1';
          else
            for i in 0 to num_towns-2 loop
              for j in 0 to num_towns-2 loop
                if i /= conv_integer(mutPoint(2*log2(num_towns)-1 downto log2(num_towns))) and i /= conv_integer(mutPoint(log2(num_towns)-1 downto 0)) then
                  mutout((i+1)*log2(num_towns)-1 downto i*log2(num_towns)) <= inGene((i+1)*log2(num_towns)-1 downto i*log2(num_towns));
                  exit;
                -- i=mutPoint(1) and j=mutPoint(2)
                elsif i = conv_integer(mutPoint(log2(num_towns)-1 downto 0)) and j = conv_integer(mutPoint(2*log2(num_towns)-1 downto log2(num_towns))) then
                  mutout((i+1)*log2(num_towns)-1 downto i*log2(num_towns)) <= inGene((j+1)*log2(num_towns)-1 downto j*log2(num_towns));
                  exit;
                -- i=mutPoint(2) and j=mutPoint(1)
                elsif j = conv_integer(mutPoint(log2(num_towns)-1 downto 0)) and i = conv_integer(mutPoint(2*log2(num_towns)-1 downto log2(num_towns))) then
                  mutout((i+1)*log2(num_towns)-1 downto i*log2(num_towns)) <= inGene((j+1)*log2(num_towns)-1 downto j*log2(num_towns));
                  exit;
                else
                  mutout((i+1)*log2(num_towns)-1 downto i*log2(num_towns)) <= (others => '1');
                end if;
              end loop;
            end loop;
            done <= '1';
          end if;
        end if;

      when '0' =>                       -- mutation block disabled

        mutout <= mutout_p1;
        if flag = '1' then
          done <= '0';
        else
          done <= done_p;
        end if;

      when others =>
        
    end case;

  end process mutation_tsp;

end rtl;
