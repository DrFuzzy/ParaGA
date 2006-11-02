-------------------------------------------------------------------------------
-- Title      : Mutation block
-- Project    : Genetic Algorithm
-------------------------------------------------------------------------------
-- File       : mutation_v1.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 23/03/06
-- Last update: 2006-11-02
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
entity mutation_v1 is
  generic(
    genom_lngt : positive;
    mr         : integer;               -- 8bit coding
    mut_res    : integer;
    mut_method : std_logic_vector(1 downto 0)

    );          
  port (clk        : in  std_logic;     -- clock
         rst_n     : in  std_logic;     -- reset (active low)
         mutEn     : in  std_logic;
         mutPoint  : in  std_logic_vector(log2(genom_lngt)-1 downto 0);  -- mutation point (for 1point mutation) comes from rng2
         --rng1      : in  std_logic_vector(mut_res-1 downto 0);
         rng       : in  std_logic_vector(genom_lngt+mut_res-1 downto 0);
         inGene    : in  std_logic_vector(genom_lngt-1 downto 0);
         -- we         : out  std_logic;
         --mutDone     : out std_logic;
         rd        : out std_logic;
         mutOffspr : out std_logic_vector(genom_lngt-1 downto 0)
         );
end entity mutation_v1;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of mutation_v1 is

  signal WeirdTRUE  : std_logic_vector(1 downto 0)            := "01";
  signal mask       : std_logic_vector(genom_lngt-1 downto 0);
  signal maskUnif   : std_logic_vector(genom_lngt-1 downto 0);
  signal mutout     : std_logic_vector(genom_lngt-1 downto 0) := (others => '0');
  signal mutout_p1  : std_logic_vector(genom_lngt-1 downto 0);
  signal inGene_mut : std_logic_vector(genom_lngt-1 downto 0);
  signal done       : std_logic                               := '0';
  signal rng1       : std_logic_vector(mut_res-1 downto 0);
  signal count      : std_logic_vector(log2(genom_lngt) downto 0);  -- count'length = log2(genom_lngt)+1
  --signal count2     : integer := 0;
  --signal fin        : std_logic:='0';
  --signal fin_t      : std_logic:='0';

begin

  process (clk, rst_n)
  begin
    if (rst_n = '0') then
      mutOffspr <= (others => '0');
      mutout_p1 <= (others => '0');
      count     <= (others => '0');
      --mutDone <= '0';
      --count2 <= 0; 
      rd        <= '0';

    elsif clk = '1' and clk'event then
      mutOffspr <= mutout;
      mutout_p1 <= mutout;
      --mutDone <= fin;
      rd        <= done;
      --fin_t <= fin;
      if done = '1' then
        count <= (others => '0');
      else
        count <= count + 1;
      end if;
      --if fin='1' then 
      --count2 <= 0;
      --elsif fin='0' and done='1' then 
      --count2 <= count2 + 1;
      --elsif fin='0' and done='0' then
      --count2 <= count2;
      --end if;
    end if;
  end process;

  rng1 <= rng(mut_res-1 downto 0);  -------------------- tha paiksei ayto ? ----------------------------------

  onePointMut : if mut_method = "00" generate  -- One point mutation

    mutout <= inGene when rng1 > conv_std_logic_vector(mr, mut_res) else
              inGene_mut;
    mask       <= ext(WeirdTRUE, genom_lngt);
    inGene_mut <= inGene xor shl(mask, mutPoint);
    done       <= '1';
    --fin<='1' when count2=mr*(popSz-elite) else 
    --    '0';
  end generate;

  XORMut : if mut_method = "01" generate  -- XOR (masked) mutation

    mutout <= inGene when rng1 > conv_std_logic_vector(mr, mut_res) else
              inGene_mut;
    inGene_mut <= inGene xor rng(genom_lngt+mut_res-1 downto mut_res);
    done       <= '1';
    --fin<='1' when count2=mr*(popSz-elite) else 
    --    '0';

  end generate;

  unifMut : if mut_method = "10" generate  -- uniform mutation
    
    
    mutout <= inGene xor maskUnif when rng1 < conv_std_logic_vector(mr, mut_res) and count = ext("00", count'length) else
              mutout_p1 xor maskUnif when rng1 < conv_std_logic_vector(mr, mut_res) and count /= ext("00", count'length) else
              inGene                 when rng1 > conv_std_logic_vector(mr, mut_res) and count = ext("00", count'length)  else
              mutout_p1;
    mask     <= ext(WeirdTRUE, genom_lngt);
    maskUnif <= shl(mask, count);

    done <= '1' when count = conv_std_logic_vector(genom_lngt, log2(genom_lngt)+1)-1 else
           '0';
    --fin<='1' when count2=mr*(popSz-elite) else 
    --    '0';
  end generate;

  dummy : if mut_method = "11" generate  -- dummy

    -- empty
  end generate;

end rtl;
