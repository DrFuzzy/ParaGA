-------------------------------------------------------------------------------
-- Title      : Fitness Evaluation block
-- Project    : genetic Algorithm
-------------------------------------------------------------------------------
-- File       : fit_calc_TSP.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 08/08/06
-- Last update: 2006-11-02
-- Platform   : Modelsim & Synplify & Xilinx ISE
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This block implements the fitness calculation block for TSP
-- 
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
use ieee.std_logic_unsigned.all;
library work;
use work.dhga_pkg.all;
use work.arith_pkg.all;

-------------------------------------------------------------------------------
-- ENTITY
-------------------------------------------------------------------------------
entity fit_calc_tsp is
  generic(
    genom_lngt : positive;
    score_sz   : integer;
    pop_sz     : positive;
    townres    : positive;
    num_towns  : positive);           
  port (
    clk        : in  std_logic;         -- clock
    rst_n      : in  std_logic;         -- reset (active low)
    decode     : in  std_logic;  -- evaluation after rng_s or after mut_s
    valid      : in  std_logic;  -- if H compute else if L don't                                         -- if H 
    in_genes   : in  std_logic_vector(2*genom_lngt-1 downto 0);  -- both mutation or rng fill evaluation block         
    data_in    : in  std_logic_vector(2*townres-1 downto 0);  -- importing ROM data
    gene_score : out std_logic_vector(genom_lngt+score_sz-1 downto 0);  -- ingene and its fitness value
    fit        : out std_logic_vector(score_sz-1 downto 0) := (others => '0');  -- fitness of current gene ()
    addr_rom   : out integer;
    ready_out  : out std_logic);
end entity fit_calc_tsp;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of fit_calc_tsp is

  signal gene_scr         : std_logic_vector(genom_lngt+score_sz-1 downto 0) := (others => '0');
  signal gene             : std_logic_vector(genom_lngt-1 downto 0)          := (others => '0');
  signal fit_n            : std_logic_vector(score_sz-1 downto 0)            := (others => '0');
  signal fit_p            : std_logic_vector(score_sz-1 downto 0)            := (others => '0');
  signal temp_fit         : std_logic_vector(score_sz-1 downto 0)            := (others => '0');
  signal max_fit          : std_logic_vector(score_sz-1 downto 0)            := (others => '1');
  signal dist_1           : std_logic_vector(2*townres-1 downto 0)           := (others => '0');
  signal dist_2           : std_logic_vector(2*townres-1 downto 0)           := (others => '0');
  signal temp_1           : std_logic_vector(2*townres-1 downto 0)           := (others => '0');
  signal temp_2           : std_logic_vector(2*townres-1 downto 0)           := (others => '0');
  signal temp1            : integer;
  signal temp2            : integer;
  signal done             : std_logic;
  signal done_p           : std_logic;
  signal counter_read_rom : integer range 0 to num_towns+4;
begin

  process (clk, rst_n)

  begin
    if rst_n = '0' then
      gene_score       <= (others => '0');
      fit              <= (others => '0');
      counter_read_rom <= 0;
      ready_out        <= '0';
      dist_1           <= (others => '0');
      dist_2           <= (others => '0');
      fit_n            <= (others => '0');
      done_p           <= '0';
    elsif rising_edge(clk) then
      done_p <= done;
      if valid = '1' and done_p /= '1' then
        gene_score       <= gene_scr;
        fit              <= fit_p;
        fit_n            <= fit_n + temp_fit;
        counter_read_rom <= counter_read_rom + 1;
        dist_1           <= data_in;
        dist_2           <= dist_1;
        
      elsif valid = '0' then
        counter_read_rom <= 0;
        ready_out        <= '0';
        dist_1           <= (others => '0');
        dist_2           <= (others => '0');
        fit_n            <= (others => '0');
        
      elsif done_p = '1' and valid = '1' then  -- preserve same outputs
        counter_read_rom <= 0;
        ready_out        <= done;
        dist_1           <= (others => '0');
        dist_2           <= (others => '0');
        
      end if;
    end if;
  end process;

  fit_calc : process (in_genes, gene, fit_n, decode, valid, counter_read_rom, done_p, temp_fit, dist_1, dist_2, temp1, temp_1, temp2, temp_2)

  begin

    if valid = '1' and done_p /= '1' then  -- evaluate gene - calculate fitness
      if decode = '1' then               -- pick out the rng offspring
        gene <= in_genes(2*genom_lngt -1 downto genom_lngt);
      elsif decode = '0' then            -- pick out the mutation offspring
        gene <= in_genes(genom_lngt -1 downto 0);
      end if;

      max_fit <= (others => '1');
      if counter_read_rom = 1 then      -- read initial town from ROM
        done     <= '0';
        temp1    <= 0;
        temp_1   <= (others=>'0');
        temp2    <= 0;
        temp_2   <= (others=>'0');
        temp_fit <= (others=>'0');
        fit_p      <= (others=>'0');
       	gene_scr <= (others=>'0');
       	addr_rom <= 1;
      elsif counter_read_rom = 2 then  -- read first town from ROM and THEN compute for first time
        done     <= '0';
        temp1    <= 0;
        temp_1   <= (others=>'0');
        temp2    <= 0;
        temp_2   <= (others=>'0');
        temp_fit <= (others=>'0');
        fit_p      <= (others=>'0');
       	gene_scr <= (others=>'0');
        addr_rom <= conv_integer(gene(genom_lngt-1 downto genom_lngt-log2(num_towns))) + 1;
      elsif counter_read_rom = num_towns+1 then
        addr_rom <= 1;
        temp1    <= conv_integer(dist_1(2*townres-1 downto townres))- conv_integer(dist_2(2*townres-1 downto townres));
        temp_1   <= abs(conv_signed(temp1, temp_1'length));
        temp2    <= conv_integer(dist_1(townres-1 downto 0))- conv_integer(dist_2(townres-1 downto 0));
        temp_2   <= abs(conv_signed(temp2, temp_2'length));
        temp_fit <= ext(temp_2*temp_2 + temp_1*temp_1, score_sz);
        done     <= '0';
        fit_p      <= (others=>'0');
       	gene_scr <= (others=>'0');
      elsif counter_read_rom /= num_towns+1 and counter_read_rom /= num_towns+2 and counter_read_rom /= 1 and counter_read_rom /= 0 and counter_read_rom /= num_towns+3 then
        for i in 2 to num_towns loop
        	if i = counter_read_rom then 
        		addr_rom <= conv_integer(gene(genom_lngt-(i-2)*log2(num_towns)-1 downto genom_lngt-(i-1)*log2(num_towns))) + 1;
        		exit;
        	else 
        		addr_rom <= 0;
        		next;
        	end if;
        end loop;
        temp1    <= conv_integer(dist_1(2*townres-1 downto townres))- conv_integer(dist_2(2*townres-1 downto townres));
        temp_1   <= abs(conv_signed(temp1, temp_1'length));
        temp2    <= conv_integer(dist_1(townres-1 downto 0)) - conv_integer(dist_2(townres-1 downto 0));
        temp_2   <= abs(conv_signed(temp2, temp_2'length));
        temp_fit <= ext(temp_2*temp_2 + temp_1*temp_1, score_sz);
        done     <= '0';
        fit_p      <= (others=>'0');
       	gene_scr <= (others=>'0');
      elsif counter_read_rom = num_towns+2 then
        addr_rom <= 0;
        temp1    <= conv_integer(dist_1(2*townres-1 downto townres))- conv_integer(dist_2(2*townres-1 downto townres));
        temp_1   <= abs(conv_signed(temp1, temp_1'length));
        temp2    <= conv_integer(dist_1(townres-1 downto 0))- conv_integer(dist_2(townres-1 downto 0));
        temp_2   <= abs(conv_signed(temp2, temp_2'length));
        temp_fit <= ext(temp_2*temp_2 + temp_1*temp_1, score_sz);
        done     <= '0';
        fit_p      <= (others=>'0');
       	gene_scr <= (others=>'0');
      elsif counter_read_rom = num_towns+3 then
        done     <= '1';
        addr_rom <= 0;
        temp1    <= 0;
        temp_1   <= (others=>'0');
        temp2    <= 0;
        temp_2   <= (others=>'0');        
        fit_p <= max_fit - fit_n;
        gene_scr <= gene & fit_n;
        --fit_p      <= conv_std_logic_vector(100000/conv_integer(fit_n), fit_p'length);  -- Kalitera afairesi anti gia diairesi
        --gene_scr <= gene & conv_std_logic_vector(100000/conv_integer(fit_n), fit_p'length);
        temp_fit <= (others => '0');
      else
        fit_p      <= (others => '0');
	gene     <= (others => '0');
	gene_scr <= (others => '0');
	temp1    <= 0;
	temp2    <= 0;
	temp_1   <= (others => '0');
	temp_2   <= (others => '0');
	temp_fit <= (others => '0');
	max_fit  <= (others => '1');
	done     <= '0';
      	addr_rom <= 0;
      end if;

    elsif valid = '1' and done_p = '1' then
      fit_p      <= (others => '0');
      gene     <= (others => '0');
      gene_scr <= (others => '0');
      temp1    <= 0;
      temp2    <= 0;
      temp_1   <= (others => '0');
      temp_2   <= (others => '0');
      temp_fit <= (others => '0');
      max_fit  <= (others => '1');
      done     <= done_p;
      addr_rom <= 0;
      -- do nothing, preserve same outputs

    elsif valid = '0' then
      fit_p      <= (others => '0');
      gene     <= (others => '0');
      gene_scr <= (others => '0');
      temp1    <= 0;
      temp2    <= 0;
      temp_1   <= (others => '0');
      temp_2   <= (others => '0');
      temp_fit <= (others => '0');
      max_fit  <= (others => '1');
      done     <= '0';
      addr_rom <= 0;
    else
      fit_p      <= (others => '0');
      gene     <= (others => '0');
      gene_scr <= (others => '0');
      temp1    <= 0;
      temp2    <= 0;
      temp_1   <= (others => '0');
      temp_2   <= (others => '0');
      temp_fit <= (others => '0');
      max_fit  <= (others => '1');
      done     <= '0';
      addr_rom <= 0;
    end if;  -- valid

  end process fit_calc;

end rtl;
