-------------------------------------------------------------------------------
-- Title      : Random Number Generator up to 128 bits
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : rng_128.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos (kdelip@mail.ntua.gr)
-- Company    : NTUA/IRAL
-- Created    : 15/11/06
-- Last update: 15/11/06
-- Platform   : Modelsim & Synplify & Xilinx ISE
-- Standard   : VHDL'93 
-------------------------------------------------------------------------------
-- Description: This block implements a random number generator that generates 
--              a sequence of 2^N-1 non-repeating pseudo-random numbers using a 
--              Linear feedback Shift Register (LFSR).
--              The bit-width or length of the pseudo random sequence is 
--              defined by the generic "n".  
--              The length of the pseudorandom sequence can vary from 2 to 128.  
--              (2^128 numbers in sequence).
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
entity rng_128 is
  generic(n : positive);                      -- length of pseudo-random sequence
  port (
    clk          : in  std_logic;       -- clock
    rst_n        : in  std_logic;       -- reset (active low)
    load         : in  std_logic;       -- load (active high)
    seed         : in  std_logic_vector(n-1 downto 0);   -- parallel seed input
    run          : in  std_logic;       -- if 1 run else output=high-Z
    parallel_out : out std_logic_vector(n-1 downto 0));  -- parallel data out
end entity rng_128;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of rng_128 is

  type taps_arrayType is array(2 to 128) of std_logic_vector(127 downto 0);
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

      -- Look-Up Table for Tap points to insert XNOR gates as feedback into D-FF 
      -- outputs.  Taps are designed so that 2^N-1 (N=n of Register) numbers 
      -- are cycled through before the sequence is repeated
      taps_array(2)  :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110"; 
      taps_array(3)  :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110";
      taps_array(4)  :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001100";
      taps_array(5)  :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010100";
      taps_array(6)  :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110000";
      taps_array(7)  :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001100000";
      taps_array(8)  :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010111000";
      taps_array(9)  :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100010000";
      taps_array(10) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001001000000";
      taps_array(11) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010100000000";
      taps_array(12) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000101001";
      taps_array(13) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000001101";
      taps_array(14) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000010101";
      taps_array(15) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110000000000000";
      taps_array(16) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001101000000001000";
      taps_array(17) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010010000000000000";
      taps_array(18) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000010000000000";
      taps_array(19) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000100011";
      taps_array(20) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010010000000000000000";
      taps_array(21) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000101000000000000000000";
      taps_array(22) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001100000000000000000000";
      taps_array(23) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000100000000000000000";
      taps_array(24) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000111000010000000000000000";
      taps_array(25) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001001000000000000000000000";
      taps_array(26) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000100011";
      taps_array(27) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000010011";
      taps_array(28) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001001000000000000000000000000";
      taps_array(29) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010100000000000000000000000000";
      taps_array(30) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000101001";
      taps_array(31) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001001000000000000000000000000000";
      taps_array(32) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000001000000000000000000011";
      taps_array(33) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000010000000000000000000";
      taps_array(34) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000100000000000000000000000011";
      taps_array(35) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010100000000000000000000000000000000";
      taps_array(36) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000001000000000000000000000000";
      taps_array(37) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000011111";
      taps_array(38) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000110001";
      taps_array(39) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100010000000000000000000000000000000000";
      taps_array(40) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000001010000000000000000101000000000000000000";
      taps_array(41) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000010010000000000000000000000000000000000000";
      taps_array(42) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000000110000000000000000000011000000000000000000";
      taps_array(43) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000001100011000000000000000000000000000000000000";
      taps_array(44) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000011000000000000000000000000110000000000000000";
      taps_array(45) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000000110110000000000000000000000000000000000000000";
      taps_array(46) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000001100000000000000000011000000000000000000000000";
      taps_array(47) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000010000100000000000000000000000000000000000000000";
      taps_array(48) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000000110000000000000000000000000110000000000000000000";
      taps_array(49) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000001000000001000000000000000000000000000000000000000";
      taps_array(50) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000011000000000000000000000000110000000000000000000000";
      taps_array(51) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000000110000000000000110000000000000000000000000000000000";
      taps_array(52) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000001001000000000000000000000000000000000000000000000000";
      taps_array(53) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000011000000000000011000000000000000000000000000000000000";
      taps_array(54) :=  "00000000000000000000000000000000000000000000000000000000000000000000000000110000000000000000000000000000000000110000000000000000";
      taps_array(55) :=  "00000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000001000000000000000000000000000000";
      taps_array(56) :=  "00000000000000000000000000000000000000000000000000000000000000000000000011000000000000000000011000000000000000000000000000000000";
      taps_array(57) :=  "00000000000000000000000000000000000000000000000000000000000000000000000100000010000000000000000000000000000000000000000000000000";
      taps_array(58) :=  "00000000000000000000000000000000000000000000000000000000000000000000001000000000000000000100000000000000000000000000000000000000";
      taps_array(59) :=  "00000000000000000000000000000000000000000000000000000000000000000000011000000000000000000011000000000000000000000000000000000000";
      taps_array(60) :=  "00000000000000000000000000000000000000000000000000000000000000000000110000000000000000000000000000000000000000000000000000000000";
      taps_array(61) :=  "00000000000000000000000000000000000000000000000000000000000000000001100000000000001100000000000000000000000000000000000000000000";
      taps_array(62) :=  "00000000000000000000000000000000000000000000000000000000000000000011000000000000000000000000000000000000000000000000000000110000";
      taps_array(63) :=  "00000000000000000000000000000000000000000000000000000000000000000110000000000000000000000000000000000000000000000000000000000000";
      taps_array(64) :=  "00000000000000000000000000000000000000000000000000000000000000001101100000000000000000000000000000000000000000000000000000000000";
      taps_array(65) :=  "00000000000000000000000000000000000000000000000000000000000000010000000000000000010000000000000000000000000000000000000000000000";
      taps_array(66) :=  "00000000000000000000000000000000000000000000000000000000000000110000000110000000000000000000000000000000000000000000000000000000";
      taps_array(67) :=  "00000000000000000000000000000000000000000000000000000000000001100000001100000000000000000000000000000000000000000000000000000000";
      taps_array(68) :=  "00000000000000000000000000000000000000000000000000000000000010000000010000000000000000000000000000000000000000000000000000000000";
      taps_array(69) :=  "00000000000000000000000000000000000000000000000000000000000101000000000000000000000000101000000000000000000000000000000000000000";
      taps_array(70) :=  "00000000000000000000000000000000000000000000000000000000001100000000000001100000000000000000000000000000000000000000000000000000";
      taps_array(71) :=  "00000000000000000000000000000000000000000000000000000000010000010000000000000000000000000000000000000000000000000000000000000000";
      taps_array(72) :=  "00000000000000000000000000000000000000000000000000000000100000100000000000000000000000000000000000000001000001000000000000000000";
      taps_array(73) :=  "00000000000000000000000000000000000000000000000000000001000000000000000000000000100000000000000000000000000000000000000000000000";
      taps_array(74) :=  "00000000000000000000000000000000000000000000000000000011000000000000011000000000000000000000000000000000000000000000000000000000";
      taps_array(75) :=  "00000000000000000000000000000000000000000000000000000110000000011000000000000000000000000000000000000000000000000000000000000000";
      taps_array(76) :=  "00000000000000000000000000000000000000000000000000001100000000000000000000000000000000011000000000000000000000000000000000000000";
      taps_array(77) :=  "00000000000000000000000000000000000000000000000000011000000000000000000000000000011000000000000000000000000000000000000000000000";
      taps_array(78) :=  "00000000000000000000000000000000000000000000000000110000000000000000011000000000000000000000000000000000000000000000000000000000";
      taps_array(79) :=  "00000000000000000000000000000000000000000000000001000000001000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(80) :=  "00000000000000000000000000000000000000000000000011000000000000000000000000000000000001100000000000000000000000000000000000000000";
      taps_array(81) :=  "00000000000000000000000000000000000000000000000100010000000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(82) :=  "00000000000000000000000000000000000000000000001001000000000000000000000000000000010010000000000000000000000000000000000000000000";
      taps_array(83) :=  "00000000000000000000000000000000000000000000011000000000000000000000000000000000000000000011000000000000000000000000000000000000";
      taps_array(84) :=  "00000000000000000000000000000000000000000000100000000000010000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(85) :=  "00000000000000000000000000000000000000000001100000000000000000000000001100000000000000000000000000000000000000000000000000000000";
      taps_array(86) :=  "00000000000000000000000000000000000000000011000000000011000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(87) :=  "00000000000000000000000000000000000000000100000000000010000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(88) :=  "00000000000000000000000000000000000000001100000000000000000000000000000000000000000000000000000000000000000000011000000000000000";
      taps_array(89) :=  "00000000000000000000000000000000000000010000000000000000000000000000000000000100000000000000000000000000000000000000000000000000";
      taps_array(90) :=  "00000000000000000000000000000000000000110000000000000000110000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(91) :=  "00000000000000000000000000000000000001100000000000000000000000000000000000000000000000000000000000000000000000000000000011000000";
      taps_array(92) :=  "00000000000000000000000000000000000011000000000011000000000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(93) :=  "00000000000000000000000000000000000101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(94) :=  "00000000000000000000000000000000001000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(95) :=  "00000000000000000000000000000000010000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(96) :=  "00000000000000000000000000000000101000000000000000000000000000000000000000000001010000000000000000000000000000000000000000000000";
      taps_array(97) :=  "00000000000000000000000000000001000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(98) :=  "00000000000000000000000000000010000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(99) :=  "00000000000000000000000000000101000000000000000000000000000000000000000000101000000000000000000000000000000000000000000000000000";
      taps_array(100) := "00000000000000000000000000001000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000";
      taps_array(101) := "00000000000000000000000000011000011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(102) := "00000000000000000000000000110000000000000000000000000000000000000000000000000000000000000000110000000000000000000000000000000000";
      taps_array(103) := "00000000000000000000000001000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(104) := "00000000000000000000000011000000001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(105) := "00000000000000000000000100000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(106) := "00000000000000000000001000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(107) := "00000000000000000000010100000000000000000000000000000000000000000000000000000000000010100000000000000000000000000000000000000000";
      taps_array(108) := "00000000000000000000100000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(109) := "00000000000000000001100001100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(110) := "00000000000000000011000000000011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(111) := "00000000000000000100000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(112) := "00000000000000001010000000000000000000000000000000000000000101000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(113) := "00000000000000010000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";   
      taps_array(114) := "00000000000000110000000000000000000000000000000000000000000000000000000000000000000000000000000110000000000000000000000000000000";
      taps_array(115) := "00000000000001100000000000011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(116) := "00000000000011000000000000000000000000000000000000000000000000000000000000000000001100000000000000000000000000000000000000000000";
      taps_array(117) := "00000000000101000000000000000101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(118) := "00000000001000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(119) := "00000000010000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";       
      taps_array(120) := "00000000100000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000010";
      taps_array(121) := "00000001000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(122) := "00000011000000000000000000000000000000000000000000000000000000000110000000000000000000000000000000000000000000000000000000000000";
      taps_array(123) := "00000101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(124) := "00001000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(125) := "00011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110000000000000000";
      taps_array(126) := "00110000000000000000000000000000000000110000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(127) := "01100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
      taps_array(128) := "10100000000000000000000000010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000";
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
          LFSR_reg(N) := LFSR_reg(N-1) xnor feedback;
        else
          LFSR_reg(N) := LFSR_reg(N-1);
        end if;
      end loop;
      LFSR_reg(0)  := feedback;
      parallel_out <= LFSR_reg; 
    elsif (run = '0') then              -- same output
      parallel_out <= LFSR_reg;
    end if;
  end process;

end rtl;






























