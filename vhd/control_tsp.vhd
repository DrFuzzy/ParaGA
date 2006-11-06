--  c:\documents and settings\delk\...\control2.vhd
--  vhdl code created by xilinx's statecad 7.1i
--  thu apr 06 19:11:20 2006

--  this vhdl code (for use with ieee compliant tools) was generated using: 
--  enumerated state assignment with structured code format.
--  minimization is enabled,  implied else is disabled, 
--  and outputs are manually optimized.


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library work;
use work.dhga_pkg.all;
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
    data_in_ram2    : in  std_logic_vector(genom_lngt-1 downto 0);  -- Parent from RAM 2
    data_out_cross1 : out std_logic_vector(genom_lngt-1 downto 0);
    data_out_cross2 : out std_logic_vector(genom_lngt-1 downto 0);
    addr_1          : out integer;
    addr_2          : out integer;
    cnt_parents     : out integer;
    we1             : out std_logic;
    we2             : out std_logic;
    data_valid      : out std_logic;
    next_gene       : out std_logic;
    clear           : out std_logic;
    ga_fin          : out std_logic;
    cross_out       : out std_logic;
    valid           : out std_logic;
    elite_null      : out std_logic;
    index           : out integer;      -- memory address of the current gene 
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
  signal mut_rd_p1           : std_logic;
  signal data_out_cross1_p1  : std_logic_vector(genom_lngt-1 downto 0);
  signal data_out_cross2_p1  : std_logic_vector(genom_lngt-1 downto 0);
  signal temp1               : std_logic_vector(genom_lngt-1 downto 0);
  signal temp2               : std_logic_vector(genom_lngt-1 downto 0);
  signal incr_p1             : integer;
  signal count_offs          : integer;
  signal count_gen_p1        : integer;
  signal count_offs_p1       : integer;
  signal count_gen           : integer;
  signal count_sel_wr_p1     : integer;
  signal count_sel_rd_p1     : integer;
  signal count_parents_p1    : integer;
  signal count_cross_offs_p1 : integer;
  signal count_sel_wr        : integer;
  signal count_sel_rd        : integer;
  signal count_parents       : integer;
  signal count_cross_offs    : integer;
  
  signal notify_cnt          : integer range 0 to 9;
  signal notify_cnt_p        : integer range 0 to 9;
  signal dummy_cnt_adapt     : std_logic;
  signal cnt_adapted         : std_logic;
  signal ga_fin_r            : std_logic;
  signal incr                : integer;
  signal next_generation     : std_logic;

  -- reg'd outputs
--  signal data_out_cross1_c   : std_logic_vector(genom_lngt-1 downto 0);
--  signal data_out_cross2_c   : std_logic_vector(genom_lngt-1 downto 0);
--  signal addr_1_c            : integer;
--  signal addr_2_c            : integer;
--  signal cnt_parents_c       : integer;
--  signal we1_c               : std_logic;
--  signal we2_c               : std_logic;
--  signal data_valid_c        : std_logic;
--  signal next_gene_c         : std_logic;
--  signal clear_c             : std_logic;
--  signal ga_fin_c            : std_logic;
--  signal cross_out_c         : std_logic;
--  signal valid_c             : std_logic;
--  signal elite_null_c        : std_logic;
--  signal index_c             : integer;
--  signal mut_out_c           : std_logic;
--  signal flag_c              : std_logic;
--  signal decode_c            : std_logic;
--  signal sel_out_c           : std_logic;
--  signal addr_rom_c          : integer;
--  signal run1_c              : std_logic;
--  signal run2_c              : std_logic;
--  signal run3_c              : std_logic;
--  signal load_c              : std_logic;

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
      mut_rd_p1           <= '0';
      count_offs_p1       <= 0;
      count_parents_p1    <= 0;
      count_sel_wr_p1     <= 0;
      count_sel_rd_p1     <= 0;
      count_cross_offs_p1 <= 0;
      count_gen_p1        <= 0;
      
    elsif rising_edge(clk) then
      notify_cnt_p        <= notify_cnt;
      mut_rd_p1           <= mut_rd;
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

  data_out_cross1 <= temp1;
  data_out_cross2 <= temp2;
  cnt_parents     <= count_parents_p1;
  ga_fin          <= ga_fin_r;

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
          if count_offs_p1+incr = elite_offs(i) then  -- mpike to incr 
            incr        <= incr_p1 + 1;
                                                      --equal <= '0';
            cnt_adapted <= '0';
            exit;
          elsif count_offs_p1+incr /= elite_offs(i) and i = elite-1 then
                                                      --incr <= incr_p1;
                                                      --equal <= '1';
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



  -- sensitivity list needs update -- 
  process (sreg, sel_rd, cross_rd, mut_rd, mut_rd_p1, fit_eval_rd, notify_cnt_p,
           count_offs_p1, count_gen_p1, count_sel_wr_p1, count_sel_rd_p1, count_parents_p1, count_cross_offs_p1,
           data_in_ram2, incr_p1, cnt_adapted, dummy_cnt_adapt, incr, elite_offs, run_ga, next_generation)

  begin
    
    next_sreg <= fill_ram_s;

    case sreg is
      
      when clear_ram_s =>
        next_generation  <= '0';
        dummy_cnt_adapt  <= '0';
        --Counters
        count_offs       <= 0;
        count_parents    <= 0;
        count_sel_wr     <= 0;
        count_sel_rd     <= 0;
        count_cross_offs <= 0;
        count_gen        <= 0;
        -- Outputs
        cross_out      <= '0';
        mut_out        <= '0';
        sel_out        <= '0';

        run1             <= '0';
        run2             <= '0';
        run3             <= '0';
        flag             <= '0';
        decode           <= '0';
        valid            <= '0';
        next_gene        <= '0';
        data_valid       <= '0';
        we1              <= '0';
        we2              <= '0';
        addr_2           <= 0;
        index            <= 0;
        data_out_cross1_p1 <= (others => '0');
        data_out_cross2_p1 <= (others => '0');

        case run_ga is
          when '1' =>
            next_sreg    <= fill_ram_s;
            addr_rom         <= count_offs_p1 + 1;
            clear      <= '1';
            load       <= '1';
            elite_null <= '1';
            addr_1     <= 0;
            ga_fin_r     <= '0';
            notify_cnt   <= 0;
          when '0' =>
            next_sreg    <= clear_ram_s;
            addr_rom         <= 0;
            clear      <= '0';
            load       <= '0';
            elite_null <= '0';
            addr_1     <= elite_offs(0);
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
        addr_rom        <= count_offs_p1 + 1;  -- Read ROM (where the initial generation is stored)
        clear            <= '0';
        cross_out        <= '0';
        mut_out          <= '0';
        sel_out          <= '0';
        load             <= '0';
        run1             <= '0';
        run2             <= '0';
        run3             <= '0';
        flag             <= '0';
        decode           <= '1';
        elite_null       <= '0';
        valid            <= '1';
        ga_fin_r           <= '0';
        next_gene        <= '0';
        data_valid       <= '0';
        we1              <= '0';
        we2              <= '0';
        addr_1           <= 0;
        addr_2           <= 0;
        index            <= count_offs_p1;
        data_out_cross1_p1 <= (others => '0');
        data_out_cross2_p1 <= (others => '0');

     when fit_eval_s =>
        dummy_cnt_adapt    <= '0';
        next_generation    <= '0';
        next_gene        <= '0';
        data_valid       <= '0';
        -- Counters
        count_parents      <= count_parents_p1;
        count_sel_wr       <= count_sel_wr_p1;
        count_sel_rd       <= count_sel_rd_p1;
        count_cross_offs   <= count_cross_offs_p1;
        count_gen          <= count_gen_p1;
        -- Outputs 
        clear            <= '0';
        cross_out        <= '0';
        mut_out          <= '0';  -- doesnot calculate but holds latest results
        sel_out          <= '0';
        load             <= '0';
        run1             <= '0';
        run2             <= '0';
        run3             <= '0';
        elite_null       <= '0';
        ga_fin_r           <= '0';
        we2              <= '0';
        data_out_cross1_p1 <= (others => '0');
        data_out_cross2_p1 <= (others => '0');
	--addr_rom        <= 0;			 check if correct
        if (fit_eval_rd = '1') and (notify_cnt_p = 1) then  -- 1st generation's evaluation     ok
          next_sreg  <= read_write_ram_1_s;                 -- write to ram1 
          addr_1   <= count_offs_p1;
          addr_2   <= 0;
          we1      <= '1';
          notify_cnt <= 2;
          valid    <= '0';
          flag     <= '0';
          count_offs <= count_offs_p1;
          decode   <= '1';
          index    <= count_offs_p1;
        elsif (fit_eval_rd = '1') and (notify_cnt_p = 8) then  -- evaluate new offspring           
          next_sreg  <= read_write_ram_1_s;
          notify_cnt <= 3;
          flag     <= '1';
          decode   <= '0';
          addr_2   <= 0;
          index    <= count_offs_p1 + incr_p1;
          if (count_offs_p1+incr_p1) < pop_sz then
            count_offs <= count_offs_p1 + incr_p1 + 1;
            valid    <= '1';
            we1      <= '1';
            addr_1   <= count_offs_p1 + incr;
          else
            count_offs <= pop_sz;
            valid    <= '0';
            we1      <= '0';
            addr_1   <= 0;
          end if;
        elsif (fit_eval_rd = '0') then  -- fitness evaluation not ready yet
          next_sreg  <= fit_eval_s;
          we1      <= '0';
          notify_cnt <= notify_cnt_p;
          flag     <= '0';
          valid    <= '1';
          count_offs <= count_offs_p1;
          addr_1   <= 0;
          addr_2   <= 0;
          if notify_cnt_p = 1 then
            decode <= '1';
            index  <= count_offs_p1;
          else
            decode <= '0';
            index  <= count_offs_p1 + incr_p1;
          end if;
        else
          next_sreg  <= fit_eval_s;
          we1      <= '0';
          notify_cnt <= notify_cnt_p;
          flag     <= '0';
          valid    <= '1';
          count_offs <= count_offs_p1;
          addr_1   <= 0;
          addr_2   <= 0;
          if notify_cnt_p = 1 then
            decode <= '1';
            index  <= count_offs_p1;
          else
            decode <= '0';
            index  <= count_offs_p1 + incr_p1;
          end if;
        end if;

        
      when read_write_ram_1_s =>
        dummy_cnt_adapt    <= '0';
        -- Counters
        count_sel_wr       <= count_sel_wr_p1;
        count_gen          <= count_gen_p1;
        -- Outputs 
        clear            <= '0';
        cross_out        <= '0';
        mut_out          <= '0';
        run1             <= '0';
        run2             <= '0';
        load             <= '0';      -- SOS
        flag             <= '0';
        elite_null       <= '0';
        valid            <= '0';
        ga_fin_r           <= '0';
        we1              <= '0';
        we2              <= '0';
        data_out_cross1_p1 <= (others => '0');
        data_out_cross2_p1 <= (others => '0');
        index            <= 0;
        if (notify_cnt_p = 2) then  -- write 1st pop / need more genes          
          if (count_offs_p1 /= pop_sz-1) then
            next_sreg  <= fill_ram_s;
            notify_cnt <= notify_cnt_p;
            count_offs <= count_offs_p1 + 1;
            run3     <= '0';
            addr_1   <= count_offs_p1;
            addr_rom <= 0;
          else
            next_sreg  <= read_write_ram_1_s;
            notify_cnt <= 5;
            count_offs <= 0;
            run3     <= '1';
            addr_1   <= count_sel_rd_p1;
            addr_rom <= 0;
          end if;
          next_generation  <= '0';
          count_parents    <= count_parents_p1;
          count_cross_offs <= count_cross_offs_p1;
          count_sel_rd     <= count_sel_rd_p1;
          sel_out        <= '0';
          decode         <= '1';
          next_gene      <= '0';
          data_valid     <= '0';
          addr_2         <= 0;
        elsif (notify_cnt_p = 5) then
          next_sreg        <= sel_s;
          next_generation  <= '0';
          notify_cnt       <= notify_cnt_p;
          count_offs       <= count_offs_p1;
          count_parents    <= count_parents_p1;
          count_cross_offs <= count_cross_offs_p1;
          count_sel_rd     <= count_sel_rd_p1 + 1;
          sel_out        <= '1';
          run3           <= '0';
          decode         <= '1';
          next_gene      <= '0';
          data_valid     <= '1';
          addr_1         <= 0;
          addr_2         <= 0;
          addr_rom <= 0;
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
          sel_out    <= '1';
          run3       <= '0';
          decode     <= '0';          -- prepei na meinei opos prin
          next_gene  <= '1';
          data_valid <= '1';
          addr_1     <= count_sel_rd_p1;
          addr_2     <= count_sel_wr_p1;
          addr_rom <= 0;
        elsif (notify_cnt_p = 7) then
          next_sreg        <= sel_s;
          next_generation  <= '0';
          notify_cnt       <= notify_cnt_p;
          count_offs       <= count_offs_p1;
          count_parents    <= count_parents_p1;
          count_cross_offs <= count_cross_offs_p1;
          count_sel_rd     <= count_sel_rd_p1 + 1;
          sel_out        <= '1';
          run3           <= '0';
          decode         <= '0';
          next_gene      <= '0';
          data_valid     <= '1';
          addr_1         <= count_sel_rd_p1;
          addr_2         <= count_sel_wr_p1;
          addr_rom <= 0;
        elsif (notify_cnt_p /= 2) and (notify_cnt_p /= 3) and (notify_cnt_p /= 7) and (notify_cnt_p = 9) then
          next_sreg        <= sel_s;    -- came here from done_s 
          next_generation  <= '0';
          notify_cnt       <= notify_cnt_p;
          count_offs       <= count_offs_p1;
          count_parents    <= count_parents_p1;
          count_cross_offs <= count_cross_offs_p1;
          count_sel_rd     <= count_sel_rd_p1 + 1;
          sel_out        <= '1';
          run3           <= '0';
          decode         <= '0';
          next_gene      <= '0';
          data_valid     <= '1';
          addr_1         <= count_sel_rd_p1;
          addr_2         <= count_sel_wr_p1;
          addr_rom <= 0;
        elsif (notify_cnt_p = 3) then
          if (count_parents_p1 /= 2*(pop_sz-elite)) then
            next_sreg        <= read_write_ram_2_s;
            next_generation  <= '0';
            notify_cnt       <= 7;
            count_parents    <= count_parents_p1+1;
            count_cross_offs <= count_cross_offs_p1+1;
            addr_1         <= 0;
          else
            next_sreg        <= done_s;
            next_generation  <= '1';
            notify_cnt       <= notify_cnt_p;
            count_parents    <= count_parents_p1;
            count_cross_offs <= count_cross_offs_p1;
            addr_1         <= elite_offs(0);
          end if;
          count_offs   <= count_offs_p1;
          count_sel_rd <= count_sel_rd_p1;
          sel_out    <= '0';
          run3       <= '0';
          decode     <= '0';
          next_gene  <= '0';
          data_valid <= '0';
          addr_2     <= count_parents_p1;
          addr_rom <= 0;
        else
          next_sreg        <= read_write_ram_1_s;
          next_generation  <= '0';
          notify_cnt       <= notify_cnt_p;
          count_offs       <= count_offs_p1;
          count_parents    <= count_parents_p1;
          count_cross_offs <= count_cross_offs_p1;
          count_sel_rd     <= count_sel_rd_p1;
          sel_out        <= '1';
          run3           <= '0';
          decode         <= '0';
          next_gene      <= '0';
          data_valid     <= '1';
          addr_1         <= count_sel_rd_p1;
          addr_2         <= count_sel_wr_p1;
          addr_rom <= 0;
        end if;        
      when sel_s =>
        dummy_cnt_adapt    <= '0';
        next_generation    <= '0';
        -- Counters
        notify_cnt         <= 6;        -- What is happening here?
        count_parents      <= count_parents_p1;
        count_sel_wr       <= count_sel_wr_p1;
        count_cross_offs   <= count_cross_offs_p1;
        count_gen          <= count_gen_p1;
        count_offs         <= count_offs_p1;
        -- Outputs 
        clear            <= '0';
        cross_out        <= '0';
        mut_out          <= '0';
        sel_out          <= '1';
        run1             <= '0';
        run2             <= '0';
        run3             <= '0';
        load             <= '0';
        flag             <= '0';
        decode           <= '0';
        elite_null       <= '0';
        valid            <= '0';
        ga_fin_r           <= '0';
        we1              <= '0';
        next_gene        <= '0';
        data_valid       <= '1';
        data_out_cross1_p1 <= (others => '0');
        data_out_cross2_p1 <= (others => '0');
        index            <= 0;
        addr_rom <= 0;
        case sel_rd is
          when '1' =>
            next_sreg    <= read_write_ram_2_s;
            count_sel_rd <= 0;
            we2        <= '1';
            addr_2     <= count_sel_wr_p1;
            addr_1     <= count_sel_rd_p1;
          when '0' =>             -- new gene is needed to be read from ram1 
            next_sreg    <= read_write_ram_1_s;
            count_sel_rd <= count_sel_rd_p1;
            we2        <= '0';
            addr_1     <= count_sel_rd_p1;
            addr_2     <= count_sel_wr_p1;
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
        clear         <= '0';
        mut_out       <= '0';
        load          <= '0';
        flag          <= '0';
        decode        <= '0';
        elite_null    <= '0';
        valid         <= '0';
        ga_fin_r        <= '0';
        next_gene     <= '0';
        data_valid    <= '0';
        we1           <= '0';
        we2           <= '0';
        index         <= 0;
        addr_rom <= 0;
        if (count_sel_wr_p1 /= 2*(pop_sz-elite)-1) and (notify_cnt_p /= 5) and (notify_cnt_p /= 7) then
          next_sreg          <= read_write_ram_1_s;
          count_sel_wr       <= count_sel_wr_p1 + 1;
          notify_cnt         <= 7;
          count_parents      <= count_parents_p1;
          count_cross_offs   <= count_cross_offs_p1;
          cross_out        <= '0';
          sel_out          <= '1';
          run1             <= '0';
          run2             <= '0';
          run3             <= '1';
          addr_1           <= count_sel_rd_p1;
          addr_2           <= count_sel_wr_p1;
          data_out_cross1_p1 <= (others => '0');
          data_out_cross2_p1 <= (others => '0');
        elsif count_sel_wr_p1 = 2*(pop_sz-elite)-1 and (count_cross_offs_p1 /= 2) and (notify_cnt_p /= 7) then  -- nParents selected         
          next_sreg          <= read_write_ram_2_s;
          count_sel_wr       <= count_sel_wr_p1;
          notify_cnt         <= 7;
          count_parents      <= count_parents_p1+1;
          count_cross_offs   <= count_cross_offs_p1 + 1;
          cross_out        <= '0';
          sel_out          <= '1';
          run1             <= '0';
          run2             <= '0';
          run3             <= '0';
          addr_1           <= count_sel_rd_p1;
          addr_2           <= count_parents_p1;
          data_out_cross1_p1 <= (others => '0');
          data_out_cross2_p1 <= (others => '0');
        elsif (notify_cnt_p = 7) and (count_cross_offs_p1 = 1) then
          next_sreg          <= read_write_ram_2_s;
          count_sel_wr       <= count_sel_wr_p1;
          notify_cnt         <= 7;
          count_parents      <= count_parents_p1+1;
          count_cross_offs   <= count_cross_offs_p1 + 1;
          cross_out        <= '0';
          sel_out          <= '1';
          run1             <= '0';
          run2             <= '0';
          run3             <= '0';
          addr_1           <= count_sel_rd_p1;
          addr_2           <= count_parents_p1;
          data_out_cross1_p1 <= data_in_ram2;             -- change it to '0' after registering the outputs
          data_out_cross2_p1 <= (others => '0');
        elsif (notify_cnt_p = 7) and (count_cross_offs_p1 = 2) then
          next_sreg          <= read_write_ram_2_s;
          count_sel_wr       <= count_sel_wr_p1;
          notify_cnt         <= 7;
          count_parents      <= count_parents_p1;
          count_cross_offs   <= count_cross_offs_p1 + 1;
          cross_out        <= '0';
          sel_out          <= '1';
          run1             <= '1';    -- changed
          run2             <= '1';    -- changed
          run3             <= '0';
          addr_1           <= count_sel_rd_p1;
          addr_2           <= count_parents_p1;
          data_out_cross1_p1 <= temp1;
          data_out_cross2_p1 <= data_in_ram2;
          --data_out_cross1_p1 <= data_in_ram2;
          --data_out_cross2_p1 <= (others => '0');
  --      elsif (notify_cnt_p = 7) and (count_cross_offs_p1 = 3) then  -- new if statement
  --        next_sreg          <= read_write_ram_2_s;
  --        count_sel_wr       <= count_sel_wr_p1;
  --        notify_cnt         <= 7;
  --        count_parents      <= count_parents_p1;
  --        count_cross_offs   <= count_cross_offs_p1 + 1;
  --        cross_out_c        <= '0';
  --        sel_out_c          <= '1';
  --        run1_c             <= '1';
  --        run2_c             <= '1';
  --        run3_c             <= '0';
  --        addr_1_c           <= count_sel_rd_p1;
  --        addr_2_c           <= count_parents_p1;
  --        data_out_cross1_p1 <= temp1;
  --        data_out_cross2_p1 <= data_in_ram2;
        elsif (notify_cnt_p = 7) and (count_cross_offs_p1 = 3) then
          next_sreg          <= cross_s;
          count_sel_wr       <= 0;
          notify_cnt         <= notify_cnt_p;
          count_parents      <= count_parents_p1;
          count_cross_offs   <= count_cross_offs_p1;
          cross_out        <= '1';
          sel_out          <= '0';
          run1             <= '0';    -- changed
          run2             <= '0';
          run3             <= '0';
          addr_1           <= count_sel_rd_p1;
          addr_2           <= count_parents_p1;
          data_out_cross1_p1 <= temp1;
          data_out_cross2_p1 <= temp2;
        else
          next_sreg          <= read_write_ram_2_s;
          count_sel_wr       <= count_sel_wr_p1;
          notify_cnt         <= notify_cnt_p;
          count_parents      <= count_parents_p1;
          count_cross_offs   <= count_cross_offs_p1;
          cross_out        <= '0';
          sel_out          <= '1';
          run1             <= '0';
          run2             <= '0';
          run3             <= '0';
          addr_1           <= count_sel_rd_p1;
          addr_2           <= count_parents_p1;
          data_out_cross1_p1 <= temp1;
          data_out_cross2_p1 <= temp2;
        end if;

        
      when cross_s =>
        notify_cnt       <= 0;
        dummy_cnt_adapt  <= '0';
        next_generation  <= '0';
        -- Counters
        count_offs       <= count_offs_p1;
        count_parents    <= count_parents_p1;
        count_sel_wr     <= count_sel_wr_p1;
        count_cross_offs <= 0;
        count_gen        <= count_gen_p1;
        count_sel_rd     <= count_sel_rd_p1;
        -- Outputs       
        clear          <= '0';
        sel_out        <= '0';
        run1 		<= '0';
        run2             <= '0';
        run3             <= '0';
        load             <= '0';
        flag             <= '0';
        decode           <= '0';
        elite_null       <= '0';
        valid            <= '0';
        ga_fin_r           <= '0';
        next_gene        <= '0';
        data_valid       <= '0';
        we1              <= '0';
        we2              <= '0';
        addr_1           <= 0;
        addr_2           <= 0;
        data_out_cross1_p1 <= temp1;
        data_out_cross2_p1 <= temp2;
        index            <= 0;
        case cross_rd is
          when '1' =>                   -- crossover ready
            next_sreg   <= mut_s;
            cross_out <= '0';
            mut_out   <= '1';
          when '0' =>
            next_sreg   <= cross_s;
            cross_out <= '1';
            mut_out   <= '0';
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
        clear            <= '0';
        cross_out        <= '0';
        sel_out          <= '0';
        run2             <= '0';
        run3             <= '0';
        load             <= '0';
        flag             <= '0';
        decode           <= '0';
        elite_null       <= '0';
        ga_fin_r           <= '0';
        next_gene        <= '0';
        data_valid       <= '0';
        we1              <= '0';
        we2              <= '0';
        addr_1           <= 0;
        addr_2           <= 0;
        data_out_cross1_p1 <= temp1;
        data_out_cross2_p1 <= temp2;
        if (mut_rd = '1') or (notify_cnt_p = 8) then  -- mutation ready          
          if cnt_adapted = '1' then
            next_sreg       <= fit_eval_s;
            notify_cnt      <= notify_cnt_p;
            dummy_cnt_adapt <= '0';
            mut_out       <= '0';
            valid         <= '1';
            index         <= count_offs_p1 + incr;
            run1          <= '0';
          else
            next_sreg       <= mut_s;
            notify_cnt      <= 8;
            dummy_cnt_adapt <= '1';
            mut_out       <= '0';
            valid         <= '0';
            index         <= count_offs_p1;
            run1          <= '0';
          end if;
        elsif (mut_rd = '0') and (notify_cnt_p = 0) then
          next_sreg       <= mut_s;
          notify_cnt      <= notify_cnt_p;
          dummy_cnt_adapt <= '0';
          mut_out       <= '1';
          run1 <= '1';
          valid <= '0';
          index <= 0;
        else
          next_sreg       <= mut_s;
          notify_cnt      <= notify_cnt_p;
          dummy_cnt_adapt <= '0';
          mut_out       <= '1';
          run1          <= '0';
          valid         <= '0';
          index         <= 0;
        end if;
        
      when done_s =>
        dummy_cnt_adapt    <= '0';
        next_generation    <= '0';
        -- Counters
        notify_cnt         <= 1;  -- notify yto clear_c ram to hold ga_fin_r = 1
        count_sel_wr       <= count_sel_wr_p1;
        count_cross_offs   <= count_cross_offs_p1;
        count_sel_rd       <= count_sel_rd_p1;
        -- Outputs 
        cross_out        <= '0';
        mut_out          <= '0';
        sel_out          <= '0';
        run1             <= '0';
        run2             <= '0';
        flag             <= '0';
        elite_null       <= '0';
        valid            <= '0';
        next_gene        <= '0';
        data_valid       <= '0';
        decode           <= '0';
        we1              <= '0';
        we2              <= '0';
        addr_1           <= 0;
        addr_2           <= 0;
        data_out_cross1_p1 <= (others => '0');
        data_out_cross2_p1 <= (others => '0');
        index            <= 0;
        if (count_gen_p1 = max_gen-1) then  -- max gen reached
          next_sreg     <= clear_ram_s;
          count_offs    <= count_offs_p1;
          count_parents <= count_parents_p1;
          count_gen     <= count_gen_p1;
          notify_cnt    <= 1;
          ga_fin_r      <= '1';
          if run_ga = '1' then
            clear <= '1';
          else
            clear <= '0';
          end if;
          load     <= '1';
          run3     <= '0';

        else
          next_sreg     <= read_write_ram_1_s;
          count_offs    <= 0;
          count_parents <= 0;
          count_gen     <= count_gen_p1+1;
          notify_cnt    <= 9;
          clear       <= '0';
          load        <= '1';
          run3        <= '1';
          ga_fin_r      <= '0';
          addr_1      <= count_sel_rd_p1;

        end if;

      when others =>
        -- empty
    end case;
  end process;
  
end rtl;
