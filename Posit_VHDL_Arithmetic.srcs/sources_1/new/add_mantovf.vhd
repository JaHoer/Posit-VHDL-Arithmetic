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

entity add_mantovf is

-- ChatGPT
  generic (
    N : integer := 10
  );
  port (
    a : in std_logic_vector(N downto 0);
    mant_ovf : in std_logic;
    c : out std_logic_vector(N downto 0)
  );

end add_mantovf;

architecture Behavioral of add_mantovf is
    signal mant : std_logic_vector(N downto 0);

begin
    mant <= (0 => mant_ovf, others => '0'); 

    c <= std_logic_vector(unsigned(a) + unsigned(mant));

end Behavioral;
