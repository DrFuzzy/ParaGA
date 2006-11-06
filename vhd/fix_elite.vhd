-------------------------------------------------------------------------------
-- Title      : Fitness Evaluation block
-- Project    : genetic Algorithm
-------------------------------------------------------------------------------
-- File       : fix_elite.vhd
-- Author     : George Doyamis & Kyriakos Deliparaschos 
-- Company    : NTUA/IRAL
-- Created    : 08/08/06
-- Last update: 2006-11-06
-- Platform   : Modelsim & Synplify & Xilinx ISE
-- Standard   : VHDL'93
-------------------------------------------------------------------------------
-- Description: This block implements the fitness evaluation block 
-- ATTENTION  : FOR MORE THAN ONE ELITE CHILD 
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
entity fix_elite is
  generic(
    genom_lngt : positive;
    score_sz   : integer;
    pop_sz     : positive;
    elite      : positive);  
  port (
    clk           : in  std_logic;      -- clock
    rst_n         : in  std_logic;      -- reset (active low)
    decode        : in  std_logic;  -- evaluation after rng_s or after mut_s
    valid         : in  std_logic;      -- if H compute else if L don't 
    elite_null    : in  std_logic;      -- if H 
    index         : in  integer;        -- the address of the current gene
    fit           : in  std_logic_vector(score_sz-1 downto 0);
    count_parents : in  integer;        -- how many parents have been selected
    ready_in      : in  std_logic;
    elite_offs    : out int_array(0 to elite-1);  -- addresses of elite children (integer)
    fit_sum       : out std_logic_vector(score_sz+log2(pop_sz)-1 downto 0);  -- sum of fitnesses
    max_fit       : out std_logic_vector(score_sz-1 downto 0);  -- maximum fitness
    rd            : out std_logic);
end entity fix_elite;

-------------------------------------------------------------------------------
-- ARCHITECTURE
-------------------------------------------------------------------------------
architecture rtl of fix_elite is
  
  subtype score is std_logic_vector(score_sz-1 downto 0);
  type fit_array is array (natural range 0 to elite-1) of score;

  signal sum               : std_logic_vector(score_sz+log2(pop_sz)-1 downto 0) := (others => '0');  -- accumulated sum of fitnesses
  signal sum_p             : std_logic_vector(score_sz+log2(pop_sz)-1 downto 0) := (others => '0');  -- previous accumulated sum of fitnesses
  signal best_fit          : fit_array                                          := (others => (others => '0'));
  signal best_fit_prev_gen : fit_array                                          := (others => (others => '0'));
  signal temp1             : fit_array                                          := (others => (others => '0'));
  signal temp2             : fit_array                                          := (others => (others => '0'));
  signal elite_indexs      : int_array(0 to elite-1)                            := (others => 0);
  signal temp_indexs_1     : int_array(0 to elite-1)                            := (others => 0);
  signal temp_indexs_2     : int_array(0 to elite-1)                            := (others => 0);
  signal fin               : std_logic;
  signal count_cycle       : integer range 0 to 3;
  signal counter           : integer range 0 to elite-1;
  
begin
  fix_sum : process (sum, fit, valid, sum_p, ready_in)
  begin
    if valid = '1' and ready_in = '1' then
      sum <= sum_p + fit;
    else
      sum <= (others => '0');           -- do nothing, preserve same outputs
    end if;
  end process fix_sum;

  process (clk, rst_n)
  begin
    if rst_n = '0' then
      fin         <= '0';
      count_cycle <= 0;
      counter     <= 0;
      max_fit     <= (others => '0');
      fit_sum     <= (others => '0');
      sum_p       <= (others => '0');
      for i in elite-1 downto 0 loop
        elite_offs(i)    <= 0;
        elite_indexs(i)  <= 0;
        temp_indexs_1(i) <= 0;
        temp_indexs_2(i) <= 0;
      end loop;
      for i in elite-1 downto 0 loop
        best_fit(i)          <= (others => '0');
        best_fit_prev_gen(i) <= (others => '0');
        temp1(i)             <= (others => '0');
        temp2(i)             <= (others => '0');
      end loop;
    elsif rising_edge(clk) then
      if valid = '1' and ready_in = '1' then
        -- 1st clock cycle      
        if count_cycle = 0 then
          fin <= '0';
          for i in elite-1 downto 1 loop
            temp1(i)         <= best_fit(i-1);
            temp2(i)         <= best_fit(i);
            temp_indexs_1(i) <= elite_indexs(i-1);
            temp_indexs_2(i) <= elite_indexs(i);
            if i = 1 then
              temp1(0)         <= (others => '0');
              temp2(0)         <= best_fit(0);
              temp_indexs_1(0) <= 0;
              temp_indexs_2(0) <= elite_indexs(0);
              count_cycle      <= 1;
            else
              count_cycle <= 0;
            end if;
          end loop;
        end if;
        -- 2nd clock cycle
        if count_cycle = 1 then
          for i in elite-1 downto 1 loop  -- for more than one elite child !!!!!!!!!
            if temp1(i) < fit and temp2(i) < fit and temp1(i) /= temp2(i) then
              best_fit(i)     <= temp1(i);
              elite_indexs(i) <= temp_indexs_1(i);
            elsif temp1(i) > fit and temp2(i) > fit and temp1(i) /= temp2(i) then
              best_fit(i)     <= temp2(i);
              elite_indexs(i) <= temp_indexs_2(i);
            elsif temp1(i) = temp2(i) and fit > temp1(i) then
              best_fit(i)     <= temp1(i);
              elite_indexs(i) <= temp_indexs_1(i);
            elsif temp1(i) = temp2(i) and fit < temp1(i) then
              best_fit(i)     <= temp2(i);
              elite_indexs(i) <= temp_indexs_2(i);
            elsif temp1(i) >= fit and temp2(i) < fit then
              best_fit(i)     <= fit;
              elite_indexs(i) <= index;
            end if;
            if i = 1 then
              if fit > temp2(0) then
                best_fit(0)     <= fit;
                elite_indexs(0) <= index;
              else
                best_fit(0)     <= temp2(0);
                elite_indexs(0) <= temp_indexs_2(0);
              end if;
              fin         <= '0';
              count_cycle <= 2;
            else
              fin         <= '0';
              count_cycle <= 1;
            end if;
          end loop;
        end if;
        -- 3rd clock cycle
        if count_cycle = 2 then
          max_fit <= best_fit(0);
          if count_parents < 2*elite+1 and decode = '0' then
            fit_sum <= sum + best_fit_prev_gen(counter);
            sum_p   <= sum + best_fit_prev_gen(counter);
          else
            fit_sum <= sum;
            sum_p   <= sum;
          end if;
          if counter < elite-1 then
            counter <= counter + 1;
          else
            counter <= 0;
          end if;
          if decode = '0' and valid = '1' and count_parents = 2*(pop_sz-elite) then  --  produce new elite indexes only at the last mut offs
            elite_offs        <= elite_indexs;
            best_fit_prev_gen <= best_fit;
          elsif decode = '1' and valid = '1' then  -- rng offs evaluation
            elite_offs        <= elite_indexs;
            best_fit_prev_gen <= best_fit;
          end if;
          fin         <= '1';
          count_cycle <= 3;
        end if;
      else
        fin         <= '0';
        count_cycle <= 0;
        if (count_parents = 0 and decode = '0') or (decode = '1' and valid = '0' and index = pop_sz - 1) then
          sum_p <= (others => '0');
        end if;
        if elite_null = '1' then
          sum_p   <= (others => '0');
          max_fit <= (others => '0');
          fit_sum <= (others => '0');
          for i in elite-1 downto 0 loop
            elite_offs(i)        <= 0;
            best_fit(i)          <= (others => '0');
            best_fit_prev_gen(i) <= (others => '0');
            elite_indexs(i)      <= 0;
          end loop;
        end if;
      end if;
    end if;
  end process;

  rd <= fin;
  --fit_sum <= sum_p;
end rtl;
