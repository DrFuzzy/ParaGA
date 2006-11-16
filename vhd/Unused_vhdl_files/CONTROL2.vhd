--  C:\DOCUMENTS AND SETTINGS\DELK\...\CONTROL2.vhd
--  VHDL code created by Xilinx's StateCAD 7.1i
--  Thu Apr 06 19:11:20 2006

--  This VHDL code (for use with IEEE compliant tools) was generated using: 
--  enumerated state assignment with structured code format.
--  Minimization is enabled,  implied else is disabled, 
--  and outputs are manually optimized.

library ieee;
use ieee.std_logic_1164.all;

entity CONTROL2 is
  port (CLK, cross_in, done, fill_ram, fit_eval, mut_in, ram, rd_in, rst_n, sel, sort_in
        , term_in, wr : in std_logic;
        clear, cross_out, eval, fill, idl, init, mut_out, sel_out, sort_out, term_out, we :
        out std_logic);
end;

architecture BEHAVIOR of CONTROL2 is
  type type_sreg is (clear_ram_s, cross_s, done_s, fill_ram_s, fit_eval_s,
                     fit_scal_sort_s, idle_s, init_s, mut_s, sel_s, write_ram_0_s, write_ram_1_s,
                     write_ram_2_s, write_ram_3_s, write_ram_4_s);
  signal sreg, next_sreg : type_sreg;
begin
  process (CLK, rst_n)
  begin
    if (rst_n = '0') then
      sreg <= idle_s;
    elsif CLK = '1' and CLK'event then
      sreg <= next_sreg;
    end if;
  end process;

  process (sreg, cross_in, done, fill_ram, fit_eval, mut_in, ram, rd_in, sel, sort_in,
           term_in, wr)
  begin
    clear <= '0'; cross_out <= '0'; eval <= '0'; fill <= '0'; idl <= '0'; init
 <= '0'; mut_out <= '0'; sel_out <= '0'; sort_out <= '0'; term_out <= '0'; we
 <= '0';

    next_sreg <= clear_ram_s;

    case sreg is
      when clear_ram_s =>
        clear     <= '0';
        cross_out <= '0';
        eval      <= '0';
        idl       <= '0';
        init      <= '0';
        mut_out   <= '0';
        sel_out   <= '0';
        sort_out  <= '0';
        term_out  <= '0';
        we        <= '0';
        if (ram = '0') then
          next_sreg <= clear_ram_s;
          fill      <= '0';
        end if;
        if (ram = '1') then
          next_sreg <= fill_ram_s;
          fill      <= '1';
        end if;
      when cross_s =>
        clear     <= '0';
        cross_out <= '0';
        eval      <= '0';
        fill      <= '0';
        idl       <= '0';
        init      <= '0';
        mut_out   <= '0';
        sel_out   <= '0';
        sort_out  <= '0';
        term_out  <= '0';
        if (cross_in = '1') then
          next_sreg <= write_ram_4_s;
          we        <= '1';
        end if;
        if (cross_in = '0') then
          next_sreg <= cross_s;
          we        <= '0';
        end if;
      when done_s =>
        clear     <= '0';
        cross_out <= '0';
        eval      <= '0';
        fill      <= '0';
        mut_out   <= '0';
        sel_out   <= '0';
        sort_out  <= '0';
        term_out  <= '0';
        we        <= '0';
        if (done = '1' and term_in = '1') then
          next_sreg <= idle_s;
          init      <= '0';
          idl       <= '1';
        end if;
        if (done = '0' and term_in = '1') then
          next_sreg <= init_s;
          idl       <= '0';
          init      <= '1';
        end if;
        if (term_in = '0') then
          next_sreg <= done_s;
          idl       <= '0';
          init      <= '0';
        end if;
      when fill_ram_s =>
        clear     <= '0';
        cross_out <= '0';
        eval      <= '0';
        fill      <= '0';
        idl       <= '0';
        mut_out   <= '0';
        sel_out   <= '0';
        sort_out  <= '0';
        term_out  <= '0';
        we        <= '0';
        if (fill_ram = '0') then
          next_sreg <= fill_ram_s;
          init      <= '0';
        end if;
        if (fill_ram = '1') then
          next_sreg <= init_s;
          init      <= '1';
        end if;
      when fit_eval_s =>
        clear     <= '0';
        cross_out <= '0';
        eval      <= '0';
        fill      <= '0';
        idl       <= '0';
        init      <= '0';
        mut_out   <= '0';
        sel_out   <= '0';
        sort_out  <= '0';
        term_out  <= '0';
        if (fit_eval = '1') then
          next_sreg <= write_ram_0_s;
          we        <= '1';
        end if;
        if (fit_eval = '0') then
          next_sreg <= fit_eval_s;
          we        <= '0';
        end if;
      when fit_scal_sort_s =>
        clear     <= '0';
        cross_out <= '0';
        eval      <= '0';
        fill      <= '0';
        idl       <= '0';
        init      <= '0';
        mut_out   <= '0';
        sel_out   <= '0';
        sort_out  <= '0';
        term_out  <= '0';
        if (sort_in = '1') then
          next_sreg <= write_ram_1_s;
          we        <= '1';
        end if;
        if (sort_in = '0') then
          next_sreg <= fit_scal_sort_s;
          we        <= '0';
        end if;
      when idle_s =>
        cross_out <= '0';
        eval      <= '0';
        fill      <= '0';
        idl       <= '0';
        init      <= '0';
        mut_out   <= '0';
        sel_out   <= '0';
        sort_out  <= '0';
        term_out  <= '0';
        we        <= '0';
        if (rd_in = '1') then
          next_sreg <= clear_ram_s;
          clear     <= '1';
        end if;
        if (rd_in = '0') then
          next_sreg <= idle_s;
          clear     <= '0';
        end if;
      when init_s =>
        clear     <= '0';
        cross_out <= '0';
        fill      <= '0';
        idl       <= '0';
        init      <= '0';
        mut_out   <= '0';
        sel_out   <= '0';
        sort_out  <= '0';
        term_out  <= '0';
        we        <= '0';
        next_sreg <= fit_eval_s;
        eval      <= '1';
      when mut_s =>
        clear     <= '0';
        cross_out <= '0';
        eval      <= '0';
        fill      <= '0';
        idl       <= '0';
        init      <= '0';
        mut_out   <= '0';
        sel_out   <= '0';
        sort_out  <= '0';
        term_out  <= '0';
        if (mut_in = '1') then
          next_sreg <= write_ram_3_s;
          we        <= '1';
        end if;
        if (mut_in = '0') then
          next_sreg <= mut_s;
          we        <= '0';
        end if;
      when sel_s =>
        clear     <= '0';
        cross_out <= '0';
        eval      <= '0';
        fill      <= '0';
        idl       <= '0';
        init      <= '0';
        mut_out   <= '0';
        sel_out   <= '0';
        sort_out  <= '0';
        term_out  <= '0';
        if (sel = '1') then
          next_sreg <= write_ram_2_s;
          we        <= '1';
        end if;
        if (sel = '0') then
          next_sreg <= sel_s;
          we        <= '0';
        end if;
      when write_ram_0_s =>
        clear     <= '0';
        cross_out <= '0';
        eval      <= '0';
        fill      <= '0';
        idl       <= '0';
        init      <= '0';
        mut_out   <= '0';
        sel_out   <= '0';
        term_out  <= '0';
        if (wr = '1') then
          next_sreg <= fit_scal_sort_s;
          we        <= '0';
          sort_out  <= '1';
        end if;
        if (wr = '0') then
          next_sreg <= write_ram_0_s;
          sort_out  <= '0';
          we        <= '0';
        end if;
      when write_ram_1_s =>
        clear     <= '0';
        cross_out <= '0';
        eval      <= '0';
        fill      <= '0';
        idl       <= '0';
        init      <= '0';
        mut_out   <= '0';
        sort_out  <= '0';
        term_out  <= '0';
        if (wr = '0') then
          next_sreg <= write_ram_1_s;
          sel_out   <= '0';
          we        <= '0';
        end if;
        if (wr = '1') then
          next_sreg <= sel_s;
          we        <= '0';
          sel_out   <= '1';
        end if;
      when write_ram_2_s =>
        clear     <= '0';
        cross_out <= '0';
        eval      <= '0';
        fill      <= '0';
        idl       <= '0';
        init      <= '0';
        sel_out   <= '0';
        sort_out  <= '0';
        term_out  <= '0';
        if (wr = '0') then
          next_sreg <= write_ram_2_s;
          mut_out   <= '0';
          we        <= '0';
        end if;
        if (wr = '1') then
          next_sreg <= mut_s;
          we        <= '0';
          mut_out   <= '1';
        end if;
      when write_ram_3_s =>
        clear    <= '0';
        eval     <= '0';
        fill     <= '0';
        idl      <= '0';
        init     <= '0';
        mut_out  <= '0';
        sel_out  <= '0';
        sort_out <= '0';
        term_out <= '0';
        if (wr = '0') then
          next_sreg <= write_ram_3_s;
          cross_out <= '0';
          we        <= '0';
        end if;
        if (wr = '1') then
          next_sreg <= cross_s;
          we        <= '0';
          cross_out <= '1';
        end if;
      when write_ram_4_s =>
        clear     <= '0';
        cross_out <= '0';
        eval      <= '0';
        fill      <= '0';
        idl       <= '0';
        init      <= '0';
        mut_out   <= '0';
        sel_out   <= '0';
        sort_out  <= '0';
        if (wr = '0') then
          next_sreg <= write_ram_4_s;
          term_out  <= '0';
          we        <= '0';
        end if;
        if (wr = '1') then
          next_sreg <= done_s;
          we        <= '0';
          term_out  <= '1';
        end if;
      when others =>
    end case;
  end process;
end BEHAVIOR;
