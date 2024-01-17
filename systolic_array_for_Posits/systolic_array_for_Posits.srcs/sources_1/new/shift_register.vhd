----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 17.01.2024 09:42:28
-- Design Name: 
-- Module Name: shift_register - Behavioral
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

entity shift_register is
    generic(
        length : integer := 4;
        data_width : integer := 8

    );
    Port ( 
        clk : in std_logic;
        enable : in std_logic;
        data_in : in std_logic_vector(data_width-1 downto 0);
        data_out : out std_logic_vector(data_width-1 downto 0)
    );
           
end shift_register;

architecture Behavioral of shift_register is
    
    type register_array is array (length-1 downto 0)
        of std_logic_vector(data_width-1 downto 0);
        
    signal shift_register : register_array;
    
begin

    process (clk)
    
    begin
        if rising_edge(clk) then
            if enable = '1'then

                shift_register <= shift_register(shift_register'high-1 downto shift_register'low) & data_in;


            end if;
        end if;
    end process;

    data_out <= shift_register(shift_register'high);
    
end Behavioral;
