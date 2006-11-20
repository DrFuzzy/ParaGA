-------------------------------------------------------------------------------
-- Title      : Single port RAM block
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : spram.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 23/03/06
-- Last update: 20/11/06
-- Platform   : Modelsim 6.1c, Synplify 8.1, ISE 8.1
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This block implements single port RAM
-------------------------------------------------------------------------------
-- Copyright (c) 2006 NTUA
-------------------------------------------------------------------------------
-- revisions  :
-- date        version  author  description
-- 23/03/06    1.1      geod    created
-- 16/06/06    1.2      kdelip  updated
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- LIBRARIES
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
library work;
use work.ga_pkg.all;
use work.arith_pkg.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity spram is
  generic (
    add_width  : integer;
    data_width : integer);
  port (
    clk      : in  std_logic;           -- write clock
    rst_n    : in  std_logic;           -- reset (active low)
    -- address (integer instead of std_vec)
    add      : in  std_logic_vector(add_width downto 0);
    --
    -- input data (width ram1: genomLngt+scoreSz, width ram2: genomLngt)
    data_in  : in  std_logic_vector(data_width -1 downto 0);
    --
    -- output data (width ram1: genomLngt+scoreSz, width ram2: genomLngt)
    data_out : out std_logic_vector(data_width -1 downto 0);
    --
    -- write/read enable (1: write, 0: read)
    wr       : in  std_logic);          -- read/write enable
end entity spram;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of spram is
  
  type data_array is array (integer range <>) of
    std_logic_vector(data_width-1 downto 0);          -- memory type
  signal data  : data_array(0 to (2** add_width)-1);  -- local data
  signal add_r : std_logic_vector(add_width downto 0);
  signal wr_r  : std_logic;

begin  -- spram

  -- purpose: SP RAM Model
  -- type   : sequential
  -- inputs : clk, rst_n, data_in, add_r, wr_r
  -- outputs: data_out
  sp_ram : process (clk, rst_n)
  begin  -- process sp_ram
    if rst_n = '0' then
      data_out <= (others => 'Z');
    elsif rising_edge(clk) then
      if wr_r = '1' then
        data(conv_integer(add_r)) <= data_in;
      else
        data_out <= data(conv_integer(add_r));
      end if;
    end if;
  end process sp_ram;

  -- purpose: registered inputs (Xilinx Block RAM's)
  -- type   : sequential
  -- inputs : clk, rst_n, add
  -- outputs: add_r
  reg_ip : process (clk, rst_n)
  begin  -- process reg_ips
    if rst_n = '0' then                 -- asynchronous reset (active low)
      add_r <= (others => '0');
      wr_r  <= '0';
    elsif rising_edge(clk) then         -- rising clock edge
      add_r <= add;
      wr_r  <= wr;
    end if;
  end process reg_ip;

end rtl;
