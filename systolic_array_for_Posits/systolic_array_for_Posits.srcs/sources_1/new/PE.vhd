----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 29.11.2023 11:16:27
-- Design Name: 
-- Module Name: PE - Behavioral
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

entity PE is
    generic(
        -- Posit Values
        N : integer := 8;
        Bs : integer := 3; -- log2(N)
        es : integer := 2
    );
    Port ( 
        clk : in std_logic;
        
        weight_in : in STD_LOGIC_VECTOR (0 downto 0);
        input_in : in STD_LOGIC_VECTOR (0 downto 0);
        psum_in : in STD_LOGIC_VECTOR (0 downto 0);
        instr_in : in STD_LOGIC_VECTOR (0 downto 0);
        
        weight_out : out STD_LOGIC_VECTOR (0 downto 0);
        input_out : out STD_LOGIC_VECTOR (0 downto 0);
        psum_out : out STD_LOGIC_VECTOR (0 downto 0);
        instr_out : out STD_LOGIC_VECTOR (0 downto 0)
    );
end PE;

architecture Behavioral of PE is


    
    

begin


    calc : process (clk)
        
        
    begin
        
        
    end process;

end Behavioral;
