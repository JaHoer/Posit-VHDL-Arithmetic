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
use IEEE.std_logic_misc.all;
use ieee.math_real.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LOD_N is

-- ChatGPT
  generic (
    N : integer := 64
  );
  port (
    input_vector : in std_logic_vector(N-1 downto 0);
    output_vector : out std_logic_vector(log2(N)-1 downto 0);
    vld : out std_logic
  );

end LOD_N;

architecture Behavioral of LOD_N is

-- ChatGPT
--  function log2(value : integer) return integer is
--    variable temp : integer := value;
--    variable result : integer := 0;
--  begin
--    temp := temp - 1;
--    while temp > 0 loop
--     temp := temp / 2;
--      result := result + 1;
--    end loop;
--    return result;
--  end function log2;

begin


  

-- ChatGPT
  process(input_vector)
    variable out_l : std_logic_vector(log2(N)-2 downto 0);
    variable out_h : std_logic_vector(log2(N)-2 downto 0);
    variable out_vl, out_vh : std_logic;
    variable l : LOD_N;
    variable h : LOD_N;
    
    
    
    
  begin
  
    
  
  
  
    if N = 2 then
    
      -- vld <= |input_vector;  <-- or-reduction
      vld <= OR_REDUCE(input_vector);
      output_vector <= not input_vector(1) & input_vector(0);
    -- elsif (N and (N-1)) /= 0 then  <-- and not for integer defined
    elsif (unsigned(N) and unsigned(N-1)) /= 0 then
    
    -- Hier wird eine Entity abhängig von N dynamisch generiert
    -- Nicht klar ob sowas in VHDL möglich ist !!!                                  !!!
     
      l: entity work.LOD_N(behavioral)
        generic map (
          N => 1 << log2(N)
        );
      
      l.input_vector <= (1 << log2(N)) & (others => '0') or input_vector;
      l.output_vector <= output_vector;
      l.vld <= vld;
    else
      l: entity work.LOD_N(behavioral)
        generic map (
          N => N >> 1
        );
      h: entity work.LOD_N(behavioral)
        generic map (
          N => N >> 1
        );
      l.input_vector <= input_vector(N >> 1 - 1 downto 0);
      l.output_vector <= out_l;
      l.vld <= out_vl;
      h.input_vector <= input_vector(N - 1 downto N >> 1);
      h.output_vector <= out_h;
      h.vld <= out_vh;
      vld <= out_vl or out_vh;
      output_vector <= std_logic_vector(resize(unsigned(out_l), log2(N-1) + 1)) when out_vh = '1' else std_logic_vector(resize(unsigned(out_h), log2(N-1) + 1));
    end if;
  end process;

end Behavioral;
