-------------------------------------------------------------------------------
-- Title      : Arithmetic Package
-- Project    : Public
-------------------------------------------------------------------------------
-- File       : arith_pkg.vhd
-- Author     : kyriakos deliparaschos, kdelip@mail.ntua.gr
-- Company    : NTUA/IRAL
-- Created    : 19/12/05
-- Last update: 19/12/05
-- Platform   : Modelsim, Synplify, ISE
-------------------------------------------------------------------------------
-- Description: contains the following arithmetic functions:
--              log2 Function        - accepts an integer number and returns 
--                                     its vector size in bits.
--              signum function      - 
--              polarity Function    - accepts std_logic_vector and returns '0' 
--                                     if negative number and '1' and positive
--                                     number.
--              rad2pi function      - accepts an integer number in rads and 
--                                     returns its equivalence in degrees.
--              clip function        - accepts std_logic_vector, an integer 
--                                     number of the vector's width, and an 
--                                     integer number to perform arithmetic 
--                                     saturation.
--              clip_simple function - similar to clip function
--              ceil function        - accepts std_logic_vector, an integer 
--                                     number of the vector's width, and an 
--                                     integer number to perform arithmetic 
--                                     ceiling.
-------------------------------------------------------------------------------
-- Copyright (c) 2005 NTUA
-------------------------------------------------------------------------------
-- Revisions  :
-- date        version  author  description
-- 19/12/05    1.1      kdelip  created
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;

package arith_pkg is

  constant twopi_8       : integer := 3294198;  -- (2*pi/8 IN 22 bits precision)
  constant big_prec      : integer := 22;
  constant pi            : integer := 26353589;  -- pi in 22 bits precision
  constant twopi_8_round : integer := 101;
  
  function log2 (
    no : integer) 
    return integer;

  function signum (
    x, y : in std_logic_vector)
    return std_logic_vector;

  function polarity (
    y : in std_logic_vector)
    return std_logic;

  function rad2pi (
    small_prec : in integer) 
    return integer;
  
  function clip (
    var  : std_logic_vector;
    int1 : integer;
    int2 : integer) 
    return std_logic_vector;  -- clipping of the dynamic range of the input

  function clip_simple (
    var  : std_logic_vector;
    int1 : integer;
    int2 : integer) 
    return std_logic_vector;  -- clipping the dynamic range by just subtructing the MSBs 

  function ceil (
    var  : std_logic_vector;
    int1 : integer;
    int2 : integer) 
    return std_logic_vector;  -- clipping of the dynamic range of the input
    

end arith_pkg;

package body arith_pkg is

-- purpose: implements log2 block

-- Function depreciated!
-- Old log2 function from intracom vlsi Dpt.
-- ceil the log2 result
-- "if val = 2**i then" causes the synthesizer to 
-- enter in an infinite loop until it satisfies
-- val = 2**i. Practically trapped into compilation
-- phase forever.

-- log2 function
--  function log2(no : integer) return integer is
--    variable i : integer;
--  begin
--    i := 1;
--    for val in 1 to no-1 loop
--      if val = 2**i then
--        i := i+1;
--      end if;
--    end loop;
--    return i; -- i+1, to return signed number
--  end log2;  
  
-- ceil the log2 result
-- ex. log2(5) = 2.3219 ~= 3
function log2(
  no: integer) 
  return integer is
begin
  for I in 1 to 30 loop  -- Works for up to 32 bit integers
    if(2**I >= no) then return(I);
    end if;
  end loop;
  return(30);
end log2;

-- floor (truncate) the log2 result
-- ex. log2(5) = 2.3219 ~= 2
--function log2(no: integer) return integer is
--begin
--  for I in 1 to 30 loop  -- Works for up to 32 bit integers
--    if(2**I > no) then return(I-1);
--    end if;
--  end loop;
--  return(30);
--end log2;

-- a different log2 implementation with floor log2 result
--  function log2 (no : integer) return integer is
--    variable temp, log: natural;
--    begin
--      temp := no / 2;
--      log := 0;
--      while (temp /= 0) loop
--        temp := temp/2;
--        log := log;
--      end loop;
--      return log+1;
--  end function log2;

  -- purpose: implements signum block
  function signum (
    -- x: input vector, y: sign vector (MSB) 
    x, y : in std_logic_vector)         -- N bits
    return std_logic_vector is

    variable x_pos : std_logic_vector((x'left+1) downto 0);  -- N+1 bits
    variable x_neg : std_logic_vector((y'left+1) downto 0);  -- N+1 bits
--    VARIABLE tmp   : std_logic_vector((
  begin
    -- x positive number 
    x_pos := x(x'left) & x;                                  -- N+1 bits

    -- find 2's complement of x and assign in x_neg
--    x_neg := conv_std_logic_vector((conv_integer(NOT x) + 1), x_neg'LENGTH);  -- sign extension, N+1 bits

    x_neg := sxt(not x, x_neg'length)+1;  -- sign extension, N+1 bits

    if y = 0 then
      return conv_std_logic_vector(0, y'length+1);
    elsif y(y'left) = '1' then
      return x_neg;
    else
      return x_pos;
    end if;

  end signum;

  -- purpose: implements polarity block
  function polarity (
    y : in std_logic_vector)            -- input vector
    return std_logic is

    variable y_neg_int : unsigned((y'left) downto 0);          -- N bits
    variable y_neg     : std_logic_vector((y'left) downto 0);  -- N bits
    variable y_abs     : std_logic_vector((y'left) downto 0);  -- N bits
    variable threshold : std_logic;
    variable vcc       : std_logic;

  begin
    -- Logical 1
    vcc := '1';

    -- find 2's complement of y and assign in y_neg
    y_neg_int := unsigned(not y) + 1;   -- N bits
    y_neg     := std_logic_vector(y_neg_int);

    if y(y'left) = '0' then
      y_abs := y;
    else
      y_abs := y_neg;
    end if;

    threshold := y_abs(y_abs'left-1) or y_abs(y_abs'left-2) or y_abs(y_abs'left);

    return threshold;

  end polarity;

  -- purpose: implements rad2pi block
  function rad2pi (
    small_prec : in integer) 
    return integer is
    
    variable z : integer;
  
  begin
    z := (twopi_8 + 2**(big_prec-small_prec))/(2**(big_prec-small_prec));
    return (z);
  
  end rad2pi;

  -- purpose: implements clip block
  function clip (
    var  : std_logic_vector;
    int1 : integer;
    int2 : integer) 
    return std_logic_vector is

    variable result   : std_logic_vector(int2 - 1 downto 0);
    variable var1     : std_logic_vector(int1 - 1 downto 0);
    variable var2     : std_logic_vector(int2 - 1 downto 0);
    variable overflow : std_logic_vector(int2 - 1 downto 0);
    variable vcc      : std_logic_vector(int2 - 2 downto 0);
    variable sign_pos : std_logic_vector(int1 - int2 downto 0);
    variable sign_neg : std_logic_vector(int1 - int2 downto 0);
    variable enable   : std_logic_vector(1 downto 0);

  begin

    vcc                                := (others => '1');
    sign_pos                           := (others => '0');
    sign_neg                           := (others => '1');
    var1                               := var;
--    overflow  := '0' & vcc; -- causes bad pointer error in modelsim
    overflow(overflow'left)            := '0';
    overflow(overflow'left-1 downto 0) := VCC;
    enable(0)                          := var1(var1'left);
    if (var1(int1 - 1 downto int2 - 1) = sign_pos or var1(int1 - 1 downto int2 - 1) = sign_neg) then
      enable(1) := '0';
    else
      enable(1) := '1';
    end if;

    case enable is
      when "00" | "01" =>
        var2 := var1(int2 - 1 downto 0);
      when "10" =>
        var2 := overflow;
      when "11" =>
        var2 := not overflow;
      when others =>
        var2 := (others => '0');
    end case;

    result := var2;
    return result;

  end clip;

  -- purpose: implements clip_simple block
  function clip_simple (
    VAR  : std_logic_vector;
    int1 : integer;
    int2 : integer) 
    return std_logic_vector is

    variable result : std_logic_vector(int2 - 1 downto 0);
    variable var1   : std_logic_vector(int1 - 1 downto 0);
    variable var2   : std_logic_vector(int2 - 1 downto 0);

  begin

    var1   := var;
    var2   := var1(int2 - 1 downto 0);
    result := var2;
    return result;

  end clip_simple;

  -- purpose: implements ceil block
  function ceil (
    VAR  : std_logic_vector;
    int1 : integer;
    int2 : integer)
    return std_logic_vector is

    variable result : std_logic_vector(int2 - 1 downto 0);
    variable zeros  : std_logic_vector(int1-int2 -1 downto 0);
    variable var1   : std_logic_vector(int1 - 1 downto 0);
    variable var2   : std_logic_vector(int2 - 1 downto 0);
    variable var3   : std_logic_vector(int2+1 - 1 downto 0);
    variable var4   : std_logic_vector(int2 - 1 downto 0);

  begin

    var1  := var;
    zeros := (others => '0');
    if (var1(int1-int2-1 downto 0) = zeros) then
      var2 := var1(int1 - 1 downto int1-int2);
      var3 := (var2(var2'left) & var2);
    else
      var2 := var1(int1 - 1 downto int1-int2);
      var3 := (var2(var2'left) & var2) + '1';
    end if;

    var4   := clip(var3, int2+1, int2);
    result := var4;
    return result;

  end ceil;
  
end arith_pkg;