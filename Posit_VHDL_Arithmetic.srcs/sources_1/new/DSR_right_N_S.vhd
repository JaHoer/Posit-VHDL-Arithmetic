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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DSR_right_N_S is

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

end DSR_right_N_S;

architecture Behavioral of DSR_right_N_S is

-- ChatGPT
  signal tmp : std_logic_vector(N-1 downto 0)(S-1 downto 0);

begin

-- ChatGPT
  tmp(0) <= b(0) when b(0) = '1' else a(0) & a(N-1 downto 1);
  
  loop_blk: for i in 1 to S-1 generate
    tmp(i) <= b(i) when b(i) = '1' else tmp(i-1)(N-1) & tmp(i-1)(N-1 downto 1);
  end generate loop_blk;
  
  c <= tmp(S-1);

end Behavioral;
