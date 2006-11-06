-------------------------------------------------------------------------------
-- Title      : Mutation block
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : mutation_v2.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 23/03/06
-- Last update: 2006-11-06
-- Platform   : Modelsim & Synplify & Xilinx ISE
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This block implements the mutation algorithm block 
-------------------------------------------------------------------------------
-- Copyright (c) 2006 NTUA
-------------------------------------------------------------------------------
-- revisions  :
-- date        version  author  description
-- 23/03/06    1.1      kdelip  created
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
entity mutation_v2 is
  generic(
    genom_lngt : positive := 8;
    mr         : integer  := 25;  -- mutation rate coded in mut_res bits --> 25/255 ~= 0,1  
    mut_res    : integer  := 8);        -- mutation resolution
  port (
    clk       : in  std_logic;          -- clock
    rst_n     : in  std_logic;          -- reset (active low)
    mutPoint  : in  std_logic_vector(log2(genom_lngt)-1 downto 0);  -- mutation point (for 1point mutation) comes from rng2
    mutMethod : in  std_logic_vector(1 downto 0);
    cont      : in  std_logic;
    flag      : in  std_logic;
    rng       : in  std_logic_vector(genom_lngt + mut_res-1 downto 0);  -- XORed with input Gene
    inGene    : in  std_logic_vector(genom_lngt-1 downto 0);
    rd        : out std_logic;          -- mutation ended for current parent
    mutOffspr : out std_logic_vector(genom_lngt-1 downto 0));  -- produced mutation offspring (kid)
end entity mutation_v2;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of mutation_v2 is

  constant WeirdTRUE : std_logic_vector(1 downto 0)                := "01";
  --signal mask       : std_logic_vector(genom_lngt-1 downto 0):= (others=>'0');
  --signal maskUnif   : std_logic_vector(genom_lngt-1 downto 0):= (others=>'0');
  signal mutout      : std_logic_vector(genom_lngt-1 downto 0)     := (others => '0');
  signal mutout_p1   : std_logic_vector(genom_lngt-1 downto 0)     := (others => '0');
  --signal inGene_mut : std_logic_vector(genom_lngt-1 downto 0):= (others=>'0');
  --signal rng1     : std_logic_vector(mut_res-1 downto 0):= (others=>'0');
  signal count       : std_logic_vector(log2(genom_lngt) downto 0) := (others => '0');  -- count'length = log2(genom_lngt)+1
  signal done        : std_logic                                   := '0';
  signal done_p      : std_logic                                   := '0';


begin

  process (clk, rst_n)
  begin
    if (rst_n = '0') then
      mutout_p1 <= (others => '0');
      count     <= (others => '0');
      done_p    <= '0';
    elsif clk = '1' and clk'event then
      mutout_p1 <= mutout;
      if flag = '1' then
        done_p <= '0';
      else
        done_p <= done;
      end if;

      if done = '1' or flag = '1' or cont = '0' then
        count <= (others => '0');
      else
        count <= count + 1;
      end if;
      
    end if;
  end process;

  mutOffspr <= mutout_p1;
  rd        <= done_p;
  mutation_v2 : process (mutMethod, mutPoint, rng, inGene, mutout_p1, count, cont, flag, done_p)
  begin

    case done_p is
      
      when '0' =>
        case cont is
          
          when '1' =>                   -- mutation block enabled
            
            case mutMethod is
              
              when "00" =>              -- one Point mutation 

                --mask <= ext(WeirdTRUE, genom_lngt); -- initial mask creation
                --inGene_mut <= inGene xor shl(mask, mutPoint);
                if rng(mut_res-1 downto 0) > conv_std_logic_vector(mr, mut_res) then
                  mutout <= inGene;
                  done   <= '1';
                else
                  mutout <= inGene xor shl(ext(WeirdTRUE, genom_lngt), mutPoint);
                  done   <= '1';
                end if;

                --maskUnif <= (others=>'0');
                
              when "01" =>              -- XOR (masked) mutation

                --inGene_mut <= inGene xor rng(genom_lngt+mut_res-1 downto mut_res);        
                if rng(mut_res-1 downto 0) > conv_std_logic_vector(mr, mut_res) then
                  mutout <= inGene;
                  done   <= '1';
                else
                  mutout <= inGene xor rng(genom_lngt+mut_res-1 downto mut_res);
                  done   <= '1';
                end if;

                --maskUnif <= (others=>'0');
                --mask <= (others=>'0');
                
              when "10" =>              -- uniform mutation

                --mask <= ext(WeirdTRUE, genom_lngt);
                --maskUnif <= shl(mask, count);

                if rng(mut_res-1 downto 0) < conv_std_logic_vector(mr, mut_res) and count = ext("00", count'length) then
                  mutout <= inGene xor shl(ext(WeirdTRUE, genom_lngt), count);
                elsif rng(mut_res-1 downto 0) < conv_std_logic_vector(mr, mut_res) and count /= ext("00", count'length) then
                  mutout <= mutout_p1 xor shl(ext(WeirdTRUE, genom_lngt), count);
                elsif rng(mut_res-1 downto 0) >= conv_std_logic_vector(mr, mut_res) and count = ext("00", count'length) then
                  mutout <= inGene;
                else
                  mutout <= mutout_p1;
                end if;

                if count = conv_std_logic_vector(genom_lngt, log2(genom_lngt)+1)-1 then
                  done <= '1';
                else
                  done <= '0';
                end if;

              when others =>
                mutout <= mutout_p1;
                done   <= '0';
            end case;


          when '0' =>                   -- mutation block disabled   
            mutout <= mutout_p1;
            if flag = '1' then
              done <= '0';
            else
              done <= done_p;
            end if;

          when others =>

        end case;
        
        
      when '1' =>
        mutout <= mutout_p1;
        done   <= done_p;
        
      when others =>
        
    end case;
  end process mutation_v2;

end rtl;
