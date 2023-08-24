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
    N : integer := 8
  );
  port (
    --clk : std_logic;
    input_vector : in std_logic_vector(N-1 downto 0);
    --output_vector : out std_logic_vector(natural(log2(real(N)))-1 downto 0)
    output_vector : out std_logic_vector(3-1 downto 0)

  );

end LOD_N;





architecture Behavioral of LOD_N is


begin

  process(input_vector)
  
    variable z : integer := 7;
    variable found : std_logic := '0';
    variable out_var : std_logic_vector(3-1 downto 0);
    
  begin
        z := 7;
        found := '0';
    --if rising_edge(clk) then
        -- itariere durch Vector und breche bei erster 1 ab
        fl: for i in 8-1 downto 0 loop
        
        if(input_vector(i) = '0' and found = '0') then
            out_var := std_logic_vector(to_unsigned(z,3));
            found := '1';
            
        else
            z := z - 1;
        end if;
    
        end loop fl;
        
        
        -- Falls keine Null gefunden wurde
        if found = '0' then
            out_var := "000";
        end if;
        
        output_vector <= out_var; 
   --end if;
  
  end process;

end Behavioral;
