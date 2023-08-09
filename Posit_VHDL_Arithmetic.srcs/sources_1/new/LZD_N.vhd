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
use ieee.math_real.all;
-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LZD_N is

-- ChatGPT
  generic (
    N : integer := 64
  );
  port (
    input_vector : in std_logic_vector(N-1 downto 0);
    output_vector : out std_logic_vector(natural(log2(real(N)))-1 downto 0);
    vld : out std_logic
  );

end LZD_N;

architecture Behavioral of LZD_N is

-- ChatGPT
  function log2(value : integer) return integer is
    variable temp : integer := value;
    variable result : integer := 0;
  begin
    temp := temp - 1;
    while temp > 0 loop
      temp := temp / 2;
      result := result + 1;
    end loop;
    return result;
  end function log2;

begin

-- ChatGPT
  process(input_vector)
    variable out_l : std_logic_vector(log2(N)-2 downto 0);
    variable out_h : std_logic_vector(log2(N)-2 downto 0);
    variable out_vl, out_vh : std_logic;
    variable l : LZD_N;
    variable h : LZD_N;
  begin
    
  end process;

end Behavioral;
