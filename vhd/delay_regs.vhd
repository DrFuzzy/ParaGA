-------------------------------------------------------------------------------
-- Title      : Delay Register
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : delay_reg.vhd
-- Author     : Kyriakos Deliparaschos (kdelip@mail.ntua.gr)
-- Company    : NTUA/IRAL
-- Created    : 07/11/04
-- Last update: 16/11/06
-- Platform   : Modelsim 6.1c, Synplify 8.1, ISE 8.1
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This block implements a delay register with parametric number 
--              of delays. It is a series of D-flipflop which are trigered at 
--              the positive edge.
-------------------------------------------------------------------------------
-- Copyright (c) 2004 NTUA
-------------------------------------------------------------------------------
-- revisions  :
-- date        version  author  description
-- 07/11/04    1.1      kdelip  created
-- 16/11/06    1.2      kdelip  fix model to support 1 bit width (single dff)
--                              (width-1 -> width)
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- LIBRARIES
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity delay_regs is
  generic (
    width   : integer;                  -- data width
    latency : integer);                 -- number of delay elements
  port (
    clk      : in  std_logic;           -- clock
    rst_n    : in  std_logic;           -- reset (active low)
    in_data  : in  std_logic_vector(width downto 0);   -- input data
    out_data : out std_logic_vector(width downto 0));  -- ouput data
end delay_regs;

-------------------------------------------------------------------------------
-- ARCITECTURE
-------------------------------------------------------------------------------
architecture rtl of delay_regs is

  type   intern_type is array (latency-1 downto 0) of std_logic_vector(width downto 0);
  signal intern : intern_type;

begin

  case1 : if (latency > 0) generate

-- make a word bit by bit iwidth: for i in 0 to (width-1) generate
    iwidth : for i in 0 to (width) generate
      --make the number of delay stages
      ilatency : for j in 0 to (latency-1) generate

        --connect the input bus into the first bank
        idin : if (j = 0) generate
          process (clk, rst_n)
          begin
            if (rst_n = '0') then
              intern(j)(i) <= '0';
            elsif rising_edge(clk) then
              intern(j)(i) <= in_data(i);
            end if;
          end process;
        end generate;
        --connect the rest of the delay regs
        iint : if (j /= 0) generate
          process (clk, rst_n)
          begin
            if (rst_n = '0') then
              intern(j)(i) <= '0';
            elsif rising_edge(clk) then
              intern(j)(i) <= intern(j-1)(i);
            end if;
          end process;
        end generate;

        --connect the last bank to the output
        idout : if (j = (latency-1)) generate
          out_data(i) <= intern(j)(i);
        end generate;
      end generate;
    end generate;
    
  end generate;

  case2 : if (latency = 0) generate
    
    out_data <= in_data;
    
  end generate;

end rtl;
