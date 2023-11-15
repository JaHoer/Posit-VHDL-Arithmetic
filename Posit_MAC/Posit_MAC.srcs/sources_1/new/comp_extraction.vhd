----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.11.2023 11:30:54
-- Design Name: 
-- Module Name: comp_extraction - Behavioral
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

entity comp_extraction is
    generic (
        N : integer := 8;
        Bs : integer := 3;
        es : integer := 4
    
    -- Pipe_stages : integer := 3      -- between 2 and 3 possible
    );

    Port ( 
        clk : in STD_LOGIC;
        operand : in STD_LOGIC_VECTOR (0 downto 0);
        sign : in STD_LOGIC;
        exp : out STD_LOGIC_VECTOR (0 downto 0);
        mant : out STD_LOGIC_VECTOR (0 downto 0);
        exp_eff : out STD_LOGIC_VECTOR (0 downto 0)
    );
           
end comp_extraction;

architecture Behavioral of comp_extraction is

begin

    comp_extraction : process (clk)
    
    begin
        if rising_edge(clk) then
        
        
        
        
        
        
        end if;
    end process;
end Behavioral;
