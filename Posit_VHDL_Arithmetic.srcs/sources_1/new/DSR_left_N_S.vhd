----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.06.2023 14:39:13
-- Design Name: 
-- Module Name: add_N - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DSR_left_N_S is

-- ChatGPT
  generic (
    N : integer := 16;
    S : integer := 4
    
  );
  port (
    a : in std_logic_vector(N-1 downto 0);
    b : in std_logic_vector(S-1 downto 0);
    c : out std_logic_vector(N-1 downto 0)
  );
  
end DSR_left_N_S;

architecture Behavioral of DSR_left_N_S is

    type tmp_matrix is array (S-1 downto 0) of std_logic_vector(N-1 downto 0);
-- ChatGPT
  --signal tmp : std_logic_vector(N-1 downto 0)(S-1 downto 0);
  
  signal tmp_m : tmp_matrix;
  constant SHIFT_2 : unsigned := to_unsigned(2, N);

begin

-- ChatGPT
--  tmp(0) <= b(0) when b(0) = '1' else a(0) & a(N-2 downto 0);
--  tmp(0) <= b(0) when b(0) = '1' else a(0);
  tmp_m(0) <= std_logic_vector(shift_left(unsigned(a), 1)) when b(0) = '1' else a;
  
  loop_blk: for i in 1 to S-1 generate
   -- tmp(i) <= b(i) when b(i) = '1' else tmp(i-1)(0) & tmp(i-1)(N-2 downto 0);
    -- assign tmp[i] = b[i] ? tmp[i-1] << 2**i : tmp[i-1];
    
    tmp_m(i) <= std_logic_vector(shift_left(unsigned(tmp_m(i-1)), to_integer(shift_left(SHIFT_2, i)))) when b(i) = '1' else tmp_m(i-1);

  end generate loop_blk;
  
  c <= tmp_m(S-1);

end Behavioral;
