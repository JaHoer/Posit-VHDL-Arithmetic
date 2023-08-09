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


  generic (
    N : integer := 64
  );
  port (
    clk : std_logic;
    input_vector : in std_logic_vector(N-1 downto 0);
    output_vector : out std_logic_vector(natural(log2(real(N)))-1 downto 0)

  );

end LOD_N;





architecture Behavioral of LOD_N is



begin

  process(input_vector)

  begin
  
    if rising_edge(clk) then
  
        -- itariere durch Vector und breche bei erster 1 ab
        for i in N-1 to 0 loop
      
        if(input_vector(i) = '0') then
            output_vector <= std_logic_vector(i);
            exit;
        end if;
    
        end loop; 
  
    end if;
  
  end process;

end Behavioral;
