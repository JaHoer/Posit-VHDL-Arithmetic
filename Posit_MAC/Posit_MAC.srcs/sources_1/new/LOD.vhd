----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 11/17/2023 12:54:50 PM
-- Design Name: 
-- Module Name: LOD - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Counts the number of leading Ones
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

entity LOD is
    generic (
        N : integer := 8;
        Bs : integer := 3;      -- log2(N)
        es : integer := 4
    
    -- Pipe_stages : integer := 3      -- between 2 and 3 possible
    );
    Port (
        clk : in std_logic;
        operand : in STD_LOGIC_VECTOR (N-2 downto 0);
        cone : out STD_LOGIC_VECTOR (Bs-1 downto 0);
        vo : out STD_LOGIC
    );
end LOD;

architecture Behavioral of LOD is

begin

    process(clk)
  
        variable found_zero : std_logic := '0';
        variable out_var : std_logic_vector(Bs-1 downto 0);
    
    begin
        if rising_edge(clk) then

            found_zero := '0';
            -- itariere durch Vector und breche bei erster 0 ab
            fl: for i in N-2 downto 0 loop
        
                if(operand(i) = '0' and found_zero = '0') then
                    out_var := std_logic_vector(to_unsigned(N-2 - i,Bs));
                    --                                          ^-- berechne die Anzahl der 1 vor der ersten 0
                    found_zero := '1';
            
                end if;
    
            end loop fl;
        
        
            -- Falls keine Null gefunden wurde -> laenge des Regimes = ganze Laenge
            if found_zero = '0' then
                out_var := std_logic_vector(to_unsigned(N-1,Bs));
            end if;
        
            vo <= found_zero;
            cone <= out_var; 
        
        end if;
  
    end process;

end Behavioral;