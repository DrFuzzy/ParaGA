-------------------------------------------------------------------------------
-- Title      : Random Number Generator
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : rng.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos (kdelip@mail.ntua.gr)
-- Company    : NTUA/IRAL
-- Created    : 23/03/06
-- Last update: 2006-11-02
-- Platform   : Modelsim & Synplify & Xilinx ISE
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This block implements a random number generator that generates 
--              a sequence of 2^N-1 non-repeating pseudo-random numbers using a 
--              Linear feedback Shift Register (LFSR).
--              The bit-width or length of the pseudo random sequence is 
--              defined by the generic "n".  
--              The length of the pseudorandom sequence can vary from 2 to 32.  
--              (2^32 = 4,294,967,295 numbers in sequence).
--              The seed input variable allows to start the pseudo-random 
--              sequence at a certain position in the pseudo-random sequence.
-------------------------------------------------------------------------------
-- Copyright (c) 2006 NTUA
-------------------------------------------------------------------------------
-- revisions  :
-- date        version  author  description
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- LIBRARIES
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
library work;
use work.dhga_pkg.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity rng is
  generic(
    n : positive);                -- length of pseudo-random sequence
  port (
    clk           : in  std_logic;  -- clock
    rst_n        : in  std_logic;  -- reset (active low)
    load         : in  std_logic;  -- load (active high)
    seed         : in  std_logic_vector(n-1 downto 0);  -- parallel seed input
    run          : in  std_logic;  -- if 1 run else output=high-Z
    parallel_out : out std_logic_vector(n-1 downto 0)  -- parallel data out
    --serial_out   : out std_logic -- serial data out); (from last shift register)
    end entity rng;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
    architecture rtl of rng is

          type   taps_arrayType is array(2 to 32) of std_logic_vector(31 downto 0);
              signal Taps : std_logic_vector(n-1 downto 0);

        begin

              LFSR : process (rst_n, clk, load, run, seed)

                    -- internal registers and signals
                    variable LFSR_reg   : std_logic_vector(n-1 downto 0);
                        variable feedback   : std_logic;
                        variable taps_array : taps_arrayType;
                        
                  begin

                        Taps <= taps_array(n)(n-1 downto 0);  -- get tap points from lookup table

                            if rst_n = '0' then
                                  LFSR_reg := (others => '1');

                                      -- Look-Up Table for Tap points to insert XOR gates as feedback into D-FF 
                                      -- outputs.  Taps are designed so that 2^N-1 (N=n of Register) numbers 
                                      -- are cycled through before the sequence is repeated
                                      taps_array(2)  := "00000000000000000000000000000011";
                                      taps_array(3)  := "00000000000000000000000000000101";
                                      taps_array(4)  := "00000000000000000000000000001001";
                                      taps_array(5)  := "00000000000000000000000000010010";
                                      taps_array(6)  := "00000000000000000000000000100001";
                                      taps_array(7)  := "00000000000000000000000001000001";
                                      taps_array(8)  := "00000000000000000000000010001110";
                                      taps_array(9)  := "00000000000000000000000100001000";
                                      taps_array(10) := "00000000000000000000001000000100";
                                      taps_array(11) := "00000000000000000000010000000010";
                                      taps_array(12) := "00000000000000000000100000101001";
                                      taps_array(13) := "00000000000000000001000000001101";
                                      taps_array(14) := "00000000000000000010000000010101";
                                      taps_array(15) := "00000000000000000100000000000001";
                                      taps_array(16) := "00000000000000001000000000010110";
                                      taps_array(17) := "00000000000000010000000000000100";
                                      taps_array(18) := "00000000000000100000000001000000";
                                      taps_array(19) := "00000000000001000000000000010011";
                                      taps_array(20) := "00000000000010000000000000000100";
                                      taps_array(21) := "00000000000100000000000000000010";
                                      taps_array(22) := "00000000001000000000000000000001";
                                      taps_array(23) := "00000000010000000000000000010000";
                                      taps_array(24) := "00000000100000000000000000001101";
                                      taps_array(25) := "00000001000000000000000000000100";
                                      taps_array(26) := "00000010000000000000000000100011";
                                      taps_array(27) := "00000100000000000000000000010011";
                                      taps_array(28) := "00001000000000000000000000000100";
                                      taps_array(29) := "00010000000000000000000000000010";
                                      taps_array(30) := "00100000000000000000000000101001";
                                      taps_array(31) := "01000000000000000000000000000100";
                                      taps_array(32) := "10000000000000000000000001100010";
                                      parallel_out   <= LFSR_reg;
                                      -- load signal asserted, use seed value on port to determine where
                                      -- to start in the pseudo-random sequence
                                elsif load = '1' then
                                      for index in seed'range loop
                                            
                                            if seed(index) = '1' then
                                                  LFSR_reg := seed;
                                                end if;
                                                      
                                                end loop;
                                                      parallel_out <= LFSR_reg;
                                                      -- construct linear feedback shift register network only if run = 1 
                                                elsif rising_edge(clk) and (run = '1') then
                                                      
                                                      feedback := LFSR_reg(n-1);

                                                          for N in n-1 downto 1 loop

                                                                if (Taps(N-1) = '1') then
                                                                      LFSR_reg(N) := LFSR_reg(N-1) xor feedback;
                                                                    else
                                                                          LFSR_reg(N) := LFSR_reg(N-1);

                                                                        end if;

                                                                        end loop;
                                                                              LFSR_reg(0)  := feedback;
                                                                              parallel_out <= LFSR_reg;
                                                                              
                                                                        elsif (run = '0') then              -- same output
                                                                              
                                                                              for N in n-1 downto 0 loop
                                                                                    --LFSR_reg(N) := LFSR_reg(N);
                                                                                  end loop;
                                                                                      parallel_out <= LFSR_reg;
                                                                                  end if;

                                                                                  --parallel_out <= LFSR_reg;           -- parallel data out
                                                                                  --serial_out   <= LFSR_reg(n-1);      -- serial data out

                                                                              end process;

                                                                        end rtl;
