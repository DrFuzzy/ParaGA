-------------------------------------------------------------------------------
-- Title      : Single port RAM block (1)
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : sdram1.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 23/03/06
-- Last update: 23/03/06
-- Platform   : Modelsim & Synplify & Xilinx ISE
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This block implements the fitness evaluation block 
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
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
library work;
use work.dhga_pkg.all;
use work.arith_pkg.all;

entity spram1 is
generic ( add_width : integer;
	  data_width: integer 
	  );

  port (
    clk      : in  std_logic;                                            -- write clock
    rst_n    : in  std_logic;                                            -- system reset
    add      : in  std_logic_vector(add_width downto 0);       -- address (integer instead of std_vec)
    data_in  : in  std_logic_vector(data_width -1 downto 0);      -- input data (width ram1: genomLngt+scoreSz, width ram2: genomLngt)
    data_out : out std_logic_vector(data_width -1 downto 0);      -- output data (width ram1: genomLngt+scoreSz, width ram2: genomLngt)
    wr       : in  std_logic;	           	                         -- read/write enable
    clear    : in  std_logic
    );                    
end entity spram1;


architecture rtl of spram1 is
  
  type data_array is array (integer range <>) of std_logic_vector(data_width-1 downto 0);     -- memory type
  signal data : data_array(0 to (2** add_width)-1 );                                          -- local data


  procedure init_mem ( signal memory_cell : inout data_array ) is
  begin

    for i in 0 to ((2** add_width) - 1) loop
    	memory_cell(i) <= (others => '0');
    end loop;

  end init_mem;


begin  -- spram1


 process (clk, rst_n)

 begin  -- process

    if rst_n = '0' then
    	data_out <= (others => 'Z');
    	init_mem (data);
      
    elsif clk'event and clk = '1' then
        if wr = '1' then         -- wr=1 means write ram
            data(conv_integer(add)) <= data_in;
        else
            data_out <= data(conv_integer(add));  -- wr=0 means read ram
        end if;
        
        if clear = '1' and wr = '0' then 
        	init_mem (data);
        end if;
          
    end if;

 end process;

end rtl;
