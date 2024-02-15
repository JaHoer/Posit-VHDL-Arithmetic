----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 15.02.2024 09:33:41
-- Design Name: 
-- Module Name: priority_encode_4_2 - Behavioral
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

entity priority_encode_4_2 is

  port (
    input_vector : in std_logic_vector(3 downto 0);

    output_vector : out std_logic_vector(1 downto 0);
    valid : out std_logic

  );
end priority_encode_4_2;

architecture Behavioral of priority_encode_4_2 is

begin

    process(input_vector)
    begin
        if (input_vector(3) = '1') then
            -- Std_logic_vector literals use double quotes.
            output_vector <= "11";
            -- Valid is std_logic, so its literal still uses single quotes.
            valid  <= '1';
        elsif (input_vector(2) = '1') then
            output_vector <= "10";
            valid  <= '1';
        elsif (input_vector(1) = '1') then
            output_vector <= "01";
            valid  <= '1';
        elsif (input_vector(0) = '1') then
            output_vector <= "00";
            valid  <= '1';
        else
            output_vector <= "00";
            valid  <= '0';
        end if;
    end process;


end Behavioral;
