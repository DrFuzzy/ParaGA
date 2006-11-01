library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;

library modelsim_lib;
use modelsim_lib.util.all;

use std.textio.all;
use work.dhga_pkg.all;
use work.arith_pkg.all;


-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity selection_tb is
  generic(
           genomLngt  : positive := 16;
           --res        : integer  := 8;
           xr         : integer  := 230; -- 8bit coding
           mr         : integer  := 25;  -- 8bit coding
           popSz      : positive := 256;
           elite      : integer  := 2;
           scoreSz    : integer  := 8;
           r          : integer  := 10 -- scaling factor resolution (bits)
           );  
           
end entity selection_tb;


-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture bench of selection_tb is

  component selection

  generic(
           genomLngt  : positive;
           --res        : integer;
           xr         : integer; 
           mr         : integer;  
           popSz      : positive;
           elite      : integer;
           scoreSz    : integer;
           r          : integer
           );   
           
  port ( 
  	 clk      : in  std_logic;  
         rst_n    : in  std_logic;  
  	 nParents : in  std_logic_vector(log2(xr) + log2(mr) + 2*log2(popSz-elite)+1 -1 downto 0); 
  	 score    : in  std_logic_vector(scoreSz-1 downto 0); 
  	 inGene   : in  std_logic_vector(genomLngt-1 downto 0);
  	 rng	  : in  std_logic_vector(scoreSz+log2(popSz)-1 downto 0); 
  	 fitSum   : in  std_logic_vector(scoreSz+log2(popSz)-1 downto 0); 
  	 selParent: out std_logic_vector(genomLngt-1 downto 0); 
  	 selDone  : out std_logic 
         );

  end component;
    
  signal period : time := 13.333 ns; -- 75 MHz
  signal clk           : std_logic := '0';
  signal rst_n         : std_logic := '0';  
  signal nParents      : std_logic_vector(log2(xr) + log2(mr) + 2*log2(popSz-elite)+1 -1 downto 0); 
  signal score         : std_logic_vector(scoreSz-1 downto 0); 
  signal inGene        : std_logic_vector(genomLngt-1 downto 0);
  signal rng	       : std_logic_vector(scoreSz+log2(popSz)-1 downto 0); 
  signal fitSum        : std_logic_vector(scoreSz+log2(popSz)-1 downto 0); 
  signal selParent     : std_logic_vector(genomLngt-1 downto 0); 
  signal selDone       : std_logic; 

  
  
  begin -- ARCHITECTURE bench
  
    u_bench : selection -- component instantiation
      generic map (
           genomLngt => genomLngt,
           --res       => res,      
           xr        => xr,      
           mr        => mr,        
           popSz     => popSz,    
           elite     => elite,    
           scoreSz   => scoreSz,  
           r         => r)        

      port map (
           clk       => clk,      
           rst_n     => rst_n,    
           nParents  => nParents, 
           score     => score,    
           inGene    => inGene,   
           rng	     => rng,	    
           fitSum    => fitSum,   
           selParent => selParent,
           selDone   => selDone);
                 
 -- clock and reset generator
      clk   <= not clk after period/2;
      rst_n <= '1'     after 6*period/2;
      
 -- testing all possible values
  stimuli_gen : process
  begin 
      
    nParents	<= (others=>'0');
    score       <= (others=>'0');
    rng         <= (others=>'0');
    inGene      <= (others=>'0');
    fitSum      <= (others=>'0');

 wait for 30 ns;

 for i in 0 to 5 loop
 
 
    nParents	<= sxt(X"05",nParents'length);
    score       <= X"F8";
    rng         <= X"00CC"; -- ñ=0.2  (10 bits coding)
    inGene      <= sxt(X"0FFF",inGene'length);
    fitSum      <= sxt(X"05F8",fitSum'length);
 
   
     for j in 0 to 3 loop
       wait for period*7.5;
     end loop;  -- j

 end loop;  -- i
 
 wait;

end process stimuli_gen;

  -- simulation time check
check : process(clk)
  begin
      assert now < 1000000*period
      report "End of simulation"
      severity failure;
  end process;

end bench;


configuration cfg_selection_tb of selection_tb is
  for bench
    for u_bench: selection
      -- Default configuration
    end for;
  end for;
end cfg_selection_tb;

configuration cfg_selection_tb_rtl of selection_tb is
  for bench
    for u_bench: selection
      use entity work.selection(rtl);
    end for;
  end for;
end cfg_selection_tb_rtl;

configuration cfg_selection_tb_gat of selection_tb is
  for bench
    for u_bench: selection
      use entity work.selection(gat);
    end for;
  end for;
end cfg_selection_tb_gat;