-------------------------------------------------------------------------------
-- Title      : TSP solution using GA 
-- Project    : GA
-------------------------------------------------------------------------------
-- File       : control_tsp.vhd
-- Author     : geod, gdoyamis@ieee.org
-- Company    : NTUA/IRAL
-- Created    : 19/04/06
-- Last update: 20/11/06
-- Platform   : Modelsim 6.1c, Synplify 8.1, Xilinx ISE 8.1
-------------------------------------------------------------------------------
-- Description: Implementation of the control module of the GA
--              for the TSP solution 
-------------------------------------------------------------------------------
-- Copyright (c) 2006 NTUA
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        version  author  description
-- 19/04/06    1.1      geod  created
-- 20/11/06    1.2      geod  updated
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.ga_pkg.all;
use work.arith_pkg.all;

entity control_tsp is
  generic(
    genom_lngt : integer  := 21;
    max_gen    : positive := 100;
    pop_sz     : integer  := 8;
    score_sz   : integer  := 16;
    elite      : integer  := 2); 
  port (
    clk             : in  std_logic;
    rst_n           : in  std_logic;
    fit_eval_rd     : in  std_logic;
    sel_rd          : in  std_logic;
    cross_rd        : in  std_logic;
    mut_rd          : in  std_logic;
    run_ga          : in  std_logic;
    elite_offs      : in  int_array(0 to elite-1);  -- addresses of elite children (integer) 
    data_in_ram2    : in  std_logic_vector(genom_lngt-1 downto 0);
    data_out_cross1 : out std_logic_vector(genom_lngt-1 downto 0);
    data_out_cross2 : out std_logic_vector(genom_lngt-1 downto 0);
    addr_1_c        : out integer;
    addr_2_c        : out integer;
    cnt_parents     : out integer;
    we1_c           : out std_logic;
    we2_c           : out std_logic;
    data_valid      : out std_logic;
    next_gene       : out std_logic;
    ga_fin          : out std_logic;
    cross_out       : out std_logic;
    valid           : out std_logic;
    elite_null      : out std_logic;
    index           : out integer range 0 to pop_sz+1;  -- memory address of the current gene 
    mut_out         : out std_logic;
    flag            : out std_logic;
    decode          : out std_logic;
    sel_out         : out std_logic;
    addr_rom        : out integer;
    run1            : out std_logic;
    run2            : out std_logic;
    run3            : out std_logic;
    load            : out std_logic);
end entity control_tsp;

architecture rtl of control_tsp is
  type type_sreg is (clear_ram_s, cross_s, done_s, fill_ram_s, fit_eval_s, mut_s, sel_s,
                     read_write_ram_1_s, read_write_ram_2_s);

  signal sreg, next_sreg     : type_sreg;
  signal data_out_cross1_p1  : std_logic_vector(genom_lngt-1 downto 0);
  signal data_out_cross2_p1  : std_logic_vector(genom_lngt-1 downto 0);
  signal temp1               : std_logic_vector(genom_lngt-1 downto 0);
  signal temp2               : std_logic_vector(genom_lngt-1 downto 0);
  signal incr_p1             : integer range 0 to pop_sz;
  signal count_offs          : integer range 0 to pop_sz;
  signal count_gen_p1        : integer range 0 to max_gen;
  signal count_offs_p1       : integer range 0 to pop_sz;
  signal count_gen           : integer range 0 to max_gen;
  signal count_sel_wr_p1     : integer range 0 to 2*(pop_sz-elite);
  signal count_sel_rd_p1     : integer range 0 to pop_sz;
  signal count_parents_p1    : integer range 0 to 2*(pop_sz-elite);
  signal count_cross_offs_p1 : integer range 0 to 4;
  signal count_sel_wr        : integer range 0 to 2*(pop_sz-elite);
  signal count_sel_rd        : integer range 0 to pop_sz;
  signal count_parents       : integer range 0 to 2*(pop_sz-elite);
  signal count_cross_offs    : integer range 0 to 4;
  signal notify_cnt          : integer range 0 to 9;
  signal notify_cnt_p        : integer range 0 to 9;
  signal dummy_cnt_adapt     : std_logic;
  signal cnt_adapted         : std_logic;
  signal ga_fin_r            : std_logic;
  signal incr                : integer range 0 to pop_sz;
  signal next_generation     : std_logic;

  -- reg'd outputs
  signal data_out_cross1_c : std_logic_vector(genom_lngt-1 downto 0);
  signal data_out_cross2_c : std_logic_vector(genom_lngt-1 downto 0);
  signal cnt_parents_c     : integer;
  signal data_valid_c      : std_logic;
  signal next_gene_c       : std_logic;
  signal ga_fin_c          : std_logic;
  signal cross_out_c       : std_logic;
  signal valid_c           : std_logic;
  signal elite_null_c      : std_logic;
  signal index_c           : integer;
  signal mut_out_c         : std_logic;
  signal flag_c            : std_logic;
  signal decode_c          : std_logic;
  signal sel_out_c         : std_logic;
  signal addr_rom_c        : integer;
  signal run1_c            : std_logic;
  signal run2_c            : std_logic;
  signal run3_c            : std_logic;
  signal load_c            : std_logic;

begin
  process (clk, rst_n)
  begin
    if (rst_n = '0') then
      sreg <= clear_ram_s;
    elsif rising_edge(clk) then
      sreg <= next_sreg;
    end if;
  end process;

  process (clk, rst_n)                  -- Registered counters
  begin
    if (rst_n = '0') then
      notify_cnt_p        <= 0;
      count_offs_p1       <= 0;
      count_parents_p1    <= 0;
      count_sel_wr_p1     <= 0;
      count_sel_rd_p1     <= 0;
      count_cross_offs_p1 <= 0;
      count_gen_p1        <= 0;
      
    elsif rising_edge(clk) then
      notify_cnt_p        <= notify_cnt;
      count_offs_p1       <= count_offs;
      count_parents_p1    <= count_parents;
      count_sel_wr_p1     <= count_sel_wr;
      count_sel_rd_p1     <= count_sel_rd;
      count_cross_offs_p1 <= count_cross_offs;
      count_gen_p1        <= count_gen;
    end if;
  end process;

  process (clk, rst_n)                  -- Registered outputs
  begin
    if (rst_n = '0') then
      temp1 <= (others => '0');
      temp2 <= (others => '0');
    elsif rising_edge(clk) then
      temp1 <= data_out_cross1_p1;
      temp2 <= data_out_cross2_p1;
    end if;
  end process;

  data_out_cross1_c <= temp1;
  data_out_cross2_c <= temp2;
  cnt_parents_c     <= count_parents_p1;
  ga_fin_c          <= ga_fin_r;

  process (clk, rst_n)

  begin
    if rst_n = '0' then
      cnt_adapted <= '0';
      incr        <= 0;
      incr_p1     <= 0;
    elsif rising_edge(clk) then
      incr_p1 <= incr;
      if (dummy_cnt_adapt = '1') then
        
        for i in 0 to elite-1 loop
          if count_offs_p1+incr = elite_offs(i) then
            incr        <= incr_p1 + 1;
            cnt_adapted <= '0';
            exit;
          elsif count_offs_p1+incr /= elite_offs(i) and i = elite-1 then
            cnt_adapted <= '1';
          end if;
        end loop;
      else
      end if;

      if notify_cnt_p = 3 then
        incr        <= 0;
        cnt_adapted <= '0';
      end if;
      
    end if;
  end process;

  process (sreg, sel_rd, cross_rd, mut_rd, fit_eval_rd, notify_cnt_p, count_offs_p1, count_gen_p1,
           count_sel_wr_p1, count_sel_rd_p1, count_parents_p1, count_cross_offs_p1, run_ga,
           data_in_ram2, incr_p1, cnt_adapted, dummy_cnt_adapt, incr, elite_offs, next_generation, temp1, temp2)

  begin
    
    next_sreg <= fill_ram_s;

    case sreg is
      
      when clear_ram_s =>
        next_generation    <= '0';
        dummy_cnt_adapt    <= '0';
        --Counters
        count_offs         <= 0;
        count_parents      <= 0;
        count_sel_wr       <= 0;
        count_sel_rd       <= 0;
        count_cross_offs   <= 0;
        count_gen          <= 0;
        -- Outputs
        cross_out_c        <= '0';
        mut_out_c          <= '0';
        sel_out_c          <= '0';
        run1_c             <= '0';
        run2_c             <= '0';
        run3_c             <= '0';
        flag_c             <= '0';
        decode_c           <= '0';
        valid_c            <= '0';
        next_gene_c        <= '0';
        data_valid_c       <= '0';
        we1_c              <= '0';
        we2_c              <= '0';
        addr_2_c           <= 0;
        index_c            <= 0;
        data_out_cross1_p1 <= (others => '0');
        data_out_cross2_p1 <= (others => '0');

        case run_ga is
          when '1' =>
            next_sreg    <= fill_ram_s;
            addr_rom_c   <= count_offs_p1 + 1;
            load_c       <= '1';
            elite_null_c <= '1';
            addr_1_c     <= 0;
            ga_fin_r     <= '0';
            notify_cnt   <= 0;
          when '0' =>
            next_sreg    <= clear_ram_s;
            addr_rom_c   <= 0;
            load_c       <= '0';
            elite_null_c <= '0';
            addr_1_c     <= elite_offs(0);
            if notify_cnt_p = 1 then
              ga_fin_r   <= '1';
              notify_cnt <= 1;
            else
              ga_fin_r   <= '0';
              notify_cnt <= 0;
            end if;
          when others =>                -- empty
        end case;

        
      when fill_ram_s =>
        next_sreg          <= fit_eval_s;
        next_generation    <= '0';
        notify_cnt         <= 1;
        dummy_cnt_adapt    <= '0';
        -- Counters
        count_offs         <= count_offs_p1;
        count_parents      <= count_parents_p1;
        count_sel_wr       <= count_sel_wr_p1;
        count_sel_rd       <= count_sel_rd_p1;
        count_cross_offs   <= count_cross_offs_p1;
        count_gen          <= count_gen_p1;
        -- Outputs 
        addr_rom_c         <= count_offs_p1 + 1;  -- Read ROM (where the initial generation is stored)
        cross_out_c        <= '0';
        mut_out_c          <= '0';
        sel_out_c          <= '0';
        load_c             <= '0';
        run1_c             <= '0';
        run2_c             <= '0';
        run3_c             <= '0';
        flag_c             <= '0';
        decode_c           <= '1';
        elite_null_c       <= '0';
        valid_c            <= '1';
        ga_fin_r           <= '0';
        next_gene_c        <= '0';
        data_valid_c       <= '0';
        we1_c              <= '0';
        we2_c              <= '0';
        addr_1_c           <= 0;
        addr_2_c           <= 0;
        index_c            <= count_offs_p1;
        data_out_cross1_p1 <= (others => '0');
        data_out_cross2_p1 <= (others => '0');

      when fit_eval_s =>
        dummy_cnt_adapt    <= '0';
        next_generation    <= '0';
        next_gene_c        <= '0';
        data_valid_c       <= '0';
        -- Counters
        count_parents      <= count_parents_p1;
        count_sel_wr       <= count_sel_wr_p1;
        count_sel_rd       <= count_sel_rd_p1;
        count_cross_offs   <= count_cross_offs_p1;
        count_gen          <= count_gen_p1;
        -- Outputs 
        cross_out_c        <= '0';
        mut_out_c          <= '0';  -- doesnot calculate but holds latest results
        sel_out_c          <= '0';
        load_c             <= '0';
        run1_c             <= '0';
        run2_c             <= '0';
        run3_c             <= '0';
        elite_null_c       <= '0';
        ga_fin_r           <= '0';
        we2_c              <= '0';
        data_out_cross1_p1 <= (others => '0');
        data_out_cross2_p1 <= (others => '0');
        addr_rom_c         <= count_offs_p1 + 1;
        if (fit_eval_rd = '1') and (notify_cnt_p = 1) then  -- 1st generation's evaluation 
          next_sreg  <= read_write_ram_1_s;
          addr_1_c   <= count_offs_p1;
          addr_2_c   <= 0;
          we1_c      <= '1';
          notify_cnt <= 2;
          valid_c    <= '0';
          flag_c     <= '0';
          count_offs <= count_offs_p1;
          decode_c   <= '1';
          index_c    <= count_offs_p1;
        elsif (fit_eval_rd = '1') and (notify_cnt_p = 8) then  -- evaluate new offspring           
          next_sreg  <= read_write_ram_1_s;
          notify_cnt <= 3;
          flag_c     <= '1';
          decode_c   <= '0';
          addr_2_c   <= 0;
          index_c    <= count_offs_p1 + incr_p1;
          if (count_offs_p1+incr_p1) < pop_sz then
            count_offs <= count_offs_p1 + incr_p1 + 1;
            valid_c    <= '1';
            we1_c      <= '1';
            addr_1_c   <= count_offs_p1 + incr;
          else
            count_offs <= pop_sz;
            valid_c    <= '0';
            we1_c      <= '0';
            addr_1_c   <= 0;
          end if;
        elsif (fit_eval_rd = '0') then  -- fitness evaluation not ready yet
          next_sreg  <= fit_eval_s;
          we1_c      <= '0';
          notify_cnt <= notify_cnt_p;
          flag_c     <= '0';
          valid_c    <= '1';
          count_offs <= count_offs_p1;
          addr_1_c   <= 0;
          addr_2_c   <= 0;
          if notify_cnt_p = 1 then
            decode_c <= '1';
            index_c  <= count_offs_p1;
          else
            decode_c <= '0';
            index_c  <= count_offs_p1 + incr_p1;
          end if;
        else
          next_sreg  <= fit_eval_s;
          we1_c      <= '0';
          notify_cnt <= notify_cnt_p;
          flag_c     <= '0';
          valid_c    <= '1';
          count_offs <= count_offs_p1;
          addr_1_c   <= 0;
          addr_2_c   <= 0;
          if notify_cnt_p = 1 then
            decode_c <= '1';
            index_c  <= count_offs_p1;
          else
            decode_c <= '0';
            index_c  <= count_offs_p1 + incr_p1;
          end if;
        end if;

        
      when read_write_ram_1_s =>
        dummy_cnt_adapt    <= '0';
        -- Counters
        count_sel_wr       <= count_sel_wr_p1;
        count_gen          <= count_gen_p1;
        -- Outputs 
        cross_out_c        <= '0';
        mut_out_c          <= '0';
        run1_c             <= '0';
        run2_c             <= '0';
        load_c             <= '0';
        flag_c             <= '0';
        elite_null_c       <= '0';
        valid_c            <= '0';
        ga_fin_r           <= '0';
        we1_c              <= '0';
        we2_c              <= '0';
        data_out_cross1_p1 <= (others => '0');
        data_out_cross2_p1 <= (others => '0');
        index_c            <= 0;
        if (notify_cnt_p = 2) then  -- write 1st pop / need more genes          
          if (count_offs_p1 /= pop_sz-1) then
            next_sreg  <= fill_ram_s;
            notify_cnt <= notify_cnt_p;
            count_offs <= count_offs_p1 + 1;
            run3_c     <= '0';
            addr_1_c   <= count_offs_p1;
            addr_rom_c <= 0;
          else
            next_sreg  <= read_write_ram_1_s;
            notify_cnt <= 5;
            count_offs <= 0;
            run3_c     <= '1';
            addr_1_c   <= count_sel_rd_p1;
            addr_rom_c <= 0;
          end if;
          next_generation  <= '0';
          count_parents    <= count_parents_p1;
          count_cross_offs <= count_cross_offs_p1;
          count_sel_rd     <= count_sel_rd_p1;
          sel_out_c        <= '0';
          decode_c         <= '1';
          next_gene_c      <= '0';
          data_valid_c     <= '0';
          addr_2_c         <= 0;
        elsif (notify_cnt_p = 5) then
          next_sreg        <= sel_s;
          next_generation  <= '0';
          notify_cnt       <= notify_cnt_p;
          count_offs       <= count_offs_p1;
          count_parents    <= count_parents_p1;
          count_cross_offs <= count_cross_offs_p1;
          count_sel_rd     <= count_sel_rd_p1 + 1;
          sel_out_c        <= '1';
          run3_c           <= '0';
          decode_c         <= '1';
          next_gene_c      <= '0';
          data_valid_c     <= '1';
          addr_1_c         <= 0;
          addr_2_c         <= 0;
          addr_rom_c       <= 0;
        elsif (notify_cnt_p = 6) then
          next_sreg        <= sel_s;
          next_generation  <= '0';
          notify_cnt       <= notify_cnt_p;
          count_offs       <= count_offs_p1;
          count_parents    <= count_parents_p1;
          count_cross_offs <= count_cross_offs_p1;
          if count_sel_rd_p1 /= pop_sz - 1 then
            count_sel_rd <= count_sel_rd_p1 + 1;  -- next gene for reading if needed
          else
            count_sel_rd <= 0;
          end if;
          sel_out_c    <= '1';
          run3_c       <= '0';
          decode_c     <= '0';
          next_gene_c  <= '1';
          data_valid_c <= '1';
          addr_1_c     <= count_sel_rd_p1;
          addr_2_c     <= count_sel_wr_p1;
          addr_rom_c   <= 0;
        elsif (notify_cnt_p = 7) then
          next_sreg        <= sel_s;
          next_generation  <= '0';
          notify_cnt       <= notify_cnt_p;
          count_offs       <= count_offs_p1;
          count_parents    <= count_parents_p1;
          count_cross_offs <= count_cross_offs_p1;
          count_sel_rd     <= count_sel_rd_p1 + 1;
          sel_out_c        <= '1';
          run3_c           <= '0';
          decode_c         <= '0';
          next_gene_c      <= '0';
          data_valid_c     <= '1';
          addr_1_c         <= count_sel_rd_p1;
          addr_2_c         <= count_sel_wr_p1;
          addr_rom_c       <= 0;
        elsif (notify_cnt_p /= 2) and (notify_cnt_p /= 3) and (notify_cnt_p /= 7) and (notify_cnt_p = 9) then
          next_sreg        <= sel_s;    -- came here from done_s 
          next_generation  <= '0';
          notify_cnt       <= notify_cnt_p;
          count_offs       <= count_offs_p1;
          count_parents    <= count_parents_p1;
          count_cross_offs <= count_cross_offs_p1;
          count_sel_rd     <= count_sel_rd_p1 + 1;
          sel_out_c        <= '1';
          run3_c           <= '0';
          decode_c         <= '0';
          next_gene_c      <= '0';
          data_valid_c     <= '1';
          addr_1_c         <= count_sel_rd_p1;
          addr_2_c         <= count_sel_wr_p1;
          addr_rom_c       <= 0;
        elsif (notify_cnt_p = 3) then
          if (count_parents_p1 /= 2*(pop_sz-elite)) then
            next_sreg        <= read_write_ram_2_s;
            next_generation  <= '0';
            notify_cnt       <= 7;
            count_parents    <= count_parents_p1+1;
            count_cross_offs <= count_cross_offs_p1+1;
            addr_1_c         <= 0;
          else
            next_sreg        <= done_s;
            next_generation  <= '1';
            notify_cnt       <= notify_cnt_p;
            count_parents    <= count_parents_p1;
            count_cross_offs <= count_cross_offs_p1;
            addr_1_c         <= elite_offs(0);
          end if;
          count_offs   <= count_offs_p1;
          count_sel_rd <= count_sel_rd_p1;
          sel_out_c    <= '0';
          run3_c       <= '0';
          decode_c     <= '0';
          next_gene_c  <= '0';
          data_valid_c <= '0';
          addr_2_c     <= count_parents_p1;
          addr_rom_c   <= 0;
        else
          next_sreg        <= read_write_ram_1_s;
          next_generation  <= '0';
          notify_cnt       <= notify_cnt_p;
          count_offs       <= count_offs_p1;
          count_parents    <= count_parents_p1;
          count_cross_offs <= count_cross_offs_p1;
          count_sel_rd     <= count_sel_rd_p1;
          sel_out_c        <= '1';
          run3_c           <= '0';
          decode_c         <= '0';
          next_gene_c      <= '0';
          data_valid_c     <= '1';
          addr_1_c         <= count_sel_rd_p1;
          addr_2_c         <= count_sel_wr_p1;
          addr_rom_c       <= 0;
        end if;
      when sel_s =>
        dummy_cnt_adapt    <= '0';
        next_generation    <= '0';
        -- Counters
        notify_cnt         <= 6;
        count_parents      <= count_parents_p1;
        count_sel_wr       <= count_sel_wr_p1;
        count_cross_offs   <= count_cross_offs_p1;
        count_gen          <= count_gen_p1;
        count_offs         <= count_offs_p1;
        -- Outputs 
        cross_out_c        <= '0';
        mut_out_c          <= '0';
        sel_out_c          <= '1';
        run1_c             <= '0';
        run2_c             <= '0';
        run3_c             <= '0';
        load_c             <= '0';
        flag_c             <= '0';
        decode_c           <= '0';
        elite_null_c       <= '0';
        valid_c            <= '0';
        ga_fin_r           <= '0';
        we1_c              <= '0';
        next_gene_c        <= '0';
        data_valid_c       <= '1';
        data_out_cross1_p1 <= (others => '0');
        data_out_cross2_p1 <= (others => '0');
        index_c            <= 0;
        addr_rom_c         <= 0;
        case sel_rd is
          when '1' =>
            next_sreg    <= read_write_ram_2_s;
            count_sel_rd <= 0;
            we2_c        <= '1';
            addr_2_c     <= count_sel_wr_p1;
            addr_1_c     <= count_sel_rd_p1;
          when '0' =>
            next_sreg    <= read_write_ram_1_s;
            count_sel_rd <= count_sel_rd_p1;
            we2_c        <= '0';
            addr_1_c     <= count_sel_rd_p1;
            addr_2_c     <= count_sel_wr_p1;
          when others =>                -- empty
        end case;
        
        
      when read_write_ram_2_s =>
        dummy_cnt_adapt <= '0';
        next_generation <= '0';
        -- Counters
        count_offs      <= count_offs_p1;
        count_gen       <= count_gen_p1;
        count_sel_rd    <= count_sel_rd_p1;
        -- Outputs 
        mut_out_c       <= '0';
        load_c          <= '0';
        flag_c          <= '0';
        decode_c        <= '0';
        elite_null_c    <= '0';
        valid_c         <= '0';
        ga_fin_r        <= '0';
        next_gene_c     <= '0';
        data_valid_c    <= '0';
        we1_c           <= '0';
        we2_c           <= '0';
        index_c         <= 0;
        addr_rom_c      <= 0;
        if (count_sel_wr_p1 /= 2*(pop_sz-elite)-1) and (notify_cnt_p /= 5) and (notify_cnt_p /= 7) then
          next_sreg          <= read_write_ram_1_s;
          count_sel_wr       <= count_sel_wr_p1 + 1;
          notify_cnt         <= 7;
          count_parents      <= count_parents_p1;
          count_cross_offs   <= count_cross_offs_p1;
          cross_out_c        <= '0';
          sel_out_c          <= '1';
          run1_c             <= '0';
          run2_c             <= '0';
          run3_c             <= '1';
          addr_1_c           <= count_sel_rd_p1;
          addr_2_c           <= count_sel_wr_p1;
          data_out_cross1_p1 <= (others => '0');
          data_out_cross2_p1 <= (others => '0');
        elsif count_sel_wr_p1 = 2*(pop_sz-elite)-1 and (count_cross_offs_p1 /= 2) and (notify_cnt_p /= 7) then  -- nParents selected         
          next_sreg          <= read_write_ram_2_s;
          count_sel_wr       <= count_sel_wr_p1;
          notify_cnt         <= 7;
          count_parents      <= count_parents_p1+1;
          count_cross_offs   <= count_cross_offs_p1 + 1;
          cross_out_c        <= '0';
          sel_out_c          <= '1';
          run1_c             <= '0';
          run2_c             <= '0';
          run3_c             <= '0';
          addr_1_c           <= count_sel_rd_p1;
          addr_2_c           <= count_parents_p1;
          data_out_cross1_p1 <= (others => '0');
          data_out_cross2_p1 <= (others => '0');
        elsif (notify_cnt_p = 7) and (count_cross_offs_p1 = 1) then
          next_sreg          <= read_write_ram_2_s;
          count_sel_wr       <= count_sel_wr_p1;
          notify_cnt         <= 7;
          count_parents      <= count_parents_p1+1;
          count_cross_offs   <= count_cross_offs_p1 + 1;
          cross_out_c        <= '0';
          sel_out_c          <= '1';
          run1_c             <= '0';
          run2_c             <= '0';
          run3_c             <= '0';
          addr_1_c           <= count_sel_rd_p1;
          addr_2_c           <= count_parents_p1;
          data_out_cross1_p1 <= (others => '0');
          data_out_cross2_p1 <= (others => '0');
          
        elsif (notify_cnt_p = 7) and (count_cross_offs_p1 = 2) then
          next_sreg          <= read_write_ram_2_s;
          count_sel_wr       <= count_sel_wr_p1;
          notify_cnt         <= 7;
          count_parents      <= count_parents_p1;
          count_cross_offs   <= count_cross_offs_p1 + 1;
          cross_out_c        <= '0';
          sel_out_c          <= '1';
          run1_c             <= '0';
          run2_c             <= '0';
          run3_c             <= '0';
          addr_1_c           <= count_sel_rd_p1;
          addr_2_c           <= count_parents_p1;
          data_out_cross1_p1 <= data_in_ram2;
          data_out_cross2_p1 <= (others => '0');
        elsif (notify_cnt_p = 7) and (count_cross_offs_p1 = 3) then
          next_sreg          <= read_write_ram_2_s;
          count_sel_wr       <= count_sel_wr_p1;
          notify_cnt         <= 7;
          count_parents      <= count_parents_p1;
          count_cross_offs   <= count_cross_offs_p1 + 1;
          cross_out_c        <= '0';
          sel_out_c          <= '1';
          run1_c             <= '1';
          run2_c             <= '1';
          run3_c             <= '0';
          addr_1_c           <= count_sel_rd_p1;
          addr_2_c           <= count_parents_p1;
          data_out_cross1_p1 <= temp1;
          data_out_cross2_p1 <= data_in_ram2;
        elsif (notify_cnt_p = 7) and (count_cross_offs_p1 = 4) then
          next_sreg          <= cross_s;
          count_sel_wr       <= 0;
          notify_cnt         <= notify_cnt_p;
          count_parents      <= count_parents_p1;
          count_cross_offs   <= count_cross_offs_p1;
          cross_out_c        <= '1';
          sel_out_c          <= '0';
          run1_c             <= '0';
          run2_c             <= '0';
          run3_c             <= '0';
          addr_1_c           <= count_sel_rd_p1;
          addr_2_c           <= count_parents_p1;
          data_out_cross1_p1 <= temp1;
          data_out_cross2_p1 <= temp2;
        else
          next_sreg          <= read_write_ram_2_s;
          count_sel_wr       <= count_sel_wr_p1;
          notify_cnt         <= notify_cnt_p;
          count_parents      <= count_parents_p1;
          count_cross_offs   <= count_cross_offs_p1;
          cross_out_c        <= '0';
          sel_out_c          <= '1';
          run1_c             <= '0';
          run2_c             <= '0';
          run3_c             <= '0';
          addr_1_c           <= count_sel_rd_p1;
          addr_2_c           <= count_parents_p1;
          data_out_cross1_p1 <= temp1;
          data_out_cross2_p1 <= temp2;
        end if;
        
      when cross_s =>
        notify_cnt         <= 0;
        dummy_cnt_adapt    <= '0';
        next_generation    <= '0';
        -- Counters
        count_offs         <= count_offs_p1;
        count_parents      <= count_parents_p1;
        count_sel_wr       <= count_sel_wr_p1;
        count_cross_offs   <= 0;
        count_gen          <= count_gen_p1;
        count_sel_rd       <= count_sel_rd_p1;
        -- Outputs       
        sel_out_c          <= '0';
        run1_c             <= '0';
        run2_c             <= '0';
        run3_c             <= '0';
        load_c             <= '0';
        flag_c             <= '0';
        decode_c           <= '0';
        elite_null_c       <= '0';
        valid_c            <= '0';
        ga_fin_r           <= '0';
        next_gene_c        <= '0';
        data_valid_c       <= '0';
        we1_c              <= '0';
        we2_c              <= '0';
        addr_1_c           <= 0;
        addr_2_c           <= 0;
        data_out_cross1_p1 <= temp1;
        data_out_cross2_p1 <= temp2;
        index_c            <= 0;
        addr_rom_c         <= 0;
        case cross_rd is
          when '1' =>
            next_sreg   <= mut_s;
            cross_out_c <= '0';
            mut_out_c   <= '1';
          when '0' =>
            next_sreg   <= cross_s;
            cross_out_c <= '1';
            mut_out_c   <= '0';
          when others =>
        end case;
        
      when mut_s =>
        next_generation    <= '0';
        -- Counters
        count_offs         <= count_offs_p1;
        count_parents      <= count_parents_p1;
        count_sel_wr       <= count_sel_wr_p1;
        count_cross_offs   <= count_cross_offs_p1;
        count_gen          <= count_gen_p1;
        count_sel_rd       <= count_sel_rd_p1;
        -- Outputs 
        cross_out_c        <= '0';
        sel_out_c          <= '0';
        run2_c             <= '0';
        run3_c             <= '0';
        load_c             <= '0';
        flag_c             <= '0';
        decode_c           <= '0';
        elite_null_c       <= '0';
        ga_fin_r           <= '0';
        next_gene_c        <= '0';
        data_valid_c       <= '0';
        we1_c              <= '0';
        we2_c              <= '0';
        addr_1_c           <= 0;
        addr_2_c           <= 0;
        data_out_cross1_p1 <= temp1;
        data_out_cross2_p1 <= temp2;
        addr_rom_c         <= 0;
        if (mut_rd = '1') or (notify_cnt_p = 8) then
          if cnt_adapted = '1' then
            next_sreg       <= fit_eval_s;
            notify_cnt      <= notify_cnt_p;
            dummy_cnt_adapt <= '0';
            mut_out_c       <= '0';
            valid_c         <= '1';
            index_c         <= count_offs_p1 + incr;
            run1_c          <= '0';
          else
            next_sreg       <= mut_s;
            notify_cnt      <= 8;
            dummy_cnt_adapt <= '1';
            mut_out_c       <= '0';
            valid_c         <= '0';
            index_c         <= count_offs_p1;
            run1_c          <= '0';
          end if;
        elsif (mut_rd = '0') and (notify_cnt_p = 0) then
          next_sreg       <= mut_s;
          notify_cnt      <= notify_cnt_p;
          dummy_cnt_adapt <= '0';
          mut_out_c       <= '1';
          run1_c          <= '0';
          valid_c         <= '0';
          index_c         <= 0;
        else
          next_sreg       <= mut_s;
          notify_cnt      <= notify_cnt_p;
          dummy_cnt_adapt <= '0';
          mut_out_c       <= '1';
          run1_c          <= '0';
          valid_c         <= '0';
          index_c         <= 0;
        end if;
        
      when done_s =>
        dummy_cnt_adapt    <= '0';
        next_generation    <= '0';
        -- Counters
        notify_cnt         <= 1;
        count_sel_wr       <= count_sel_wr_p1;
        count_cross_offs   <= count_cross_offs_p1;
        count_sel_rd       <= count_sel_rd_p1;
        -- Outputs 
        cross_out_c        <= '0';
        mut_out_c          <= '0';
        sel_out_c          <= '0';
        run1_c             <= '0';
        run2_c             <= '0';
        flag_c             <= '0';
        elite_null_c       <= '0';
        valid_c            <= '0';
        next_gene_c        <= '0';
        data_valid_c       <= '0';
        decode_c           <= '0';
        we1_c              <= '0';
        we2_c              <= '0';
        addr_1_c           <= 0;
        addr_2_c           <= 0;
        data_out_cross1_p1 <= (others => '0');
        data_out_cross2_p1 <= (others => '0');
        index_c            <= 0;
        addr_rom_c         <= 0;
        if (count_gen_p1 = max_gen-1) then  -- max gen reached
          next_sreg     <= clear_ram_s;
          count_offs    <= count_offs_p1;
          count_parents <= count_parents_p1;
          count_gen     <= count_gen_p1;
          notify_cnt    <= 1;
          ga_fin_r      <= '1';
          load_c        <= '1';
          run3_c        <= '0';

        else
          next_sreg     <= read_write_ram_1_s;
          count_offs    <= 0;
          count_parents <= 0;
          count_gen     <= count_gen_p1+1;
          notify_cnt    <= 9;
          load_c        <= '1';
          run3_c        <= '1';
          ga_fin_r      <= '0';
          addr_1_c      <= count_sel_rd_p1;

        end if;

      when others =>
        -- empty
    end case;
  end process;
-- purpose: reduce_critical path
-- type   : sequential
-- inputs : clk, rst_n, all module outputs_c
-- outputs: all module outputs
  reg_op : process (clk, rst_n)
  begin  -- process reg_op
    if rst_n = '0' then                 -- asynchronous reset (active low)

      data_out_cross1 <= (others => '0');
      data_out_cross2 <= (others => '0');
      cnt_parents     <= 0;
      data_valid      <= '0';
      next_gene       <= '0';
      ga_fin          <= '0';
      cross_out       <= '0';
      valid           <= '0';
      elite_null      <= '0';
      index           <= 0;
      mut_out         <= '0';
      flag            <= '0';
      decode          <= '0';
      sel_out         <= '0';
      run1            <= '0';
      run2            <= '0';
      run3            <= '0';
      load            <= '0';
      addr_rom        <= 0;
    elsif clk'event and clk = '1' then  -- rising clock edge
      data_out_cross1 <= data_out_cross1_c;
      data_out_cross2 <= data_out_cross2_c;
      cnt_parents     <= cnt_parents_c;
      data_valid      <= data_valid_c;
      next_gene       <= next_gene_c;
      ga_fin          <= ga_fin_c;
      cross_out       <= cross_out_c;
      valid           <= valid_c;
      elite_null      <= elite_null_c;
      index           <= index_c;
      mut_out         <= mut_out_c;
      flag            <= flag_c;
      decode          <= decode_c;
      sel_out         <= sel_out_c;
      run1            <= run1_c;
      run2            <= run2_c;
      run3            <= run3_c;
      load            <= load_c;
      addr_rom        <= addr_rom_c;
    end if;
  end process reg_op;
end rtl;
