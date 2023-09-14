----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jan Hoertig
-- 
-- Create Date: 28.06.2023 14:39:13
-- Design Name: 
-- Module Name: add_N - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: count a sequence of 1 with terminating 0
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


  generic (
    N : integer := 8;
    log2N : integer := 3
  );
  port (

    input_vector : in std_logic_vector(N-1 downto 0);
    output_vector : out std_logic_vector(log2N-1 downto 0)
  );

end LZD_N;

architecture Behavioral of LZD_N is

begin
    process(input_vector)


    variable found : std_logic := '0';
    variable out_var : std_logic_vector(log2N-1 downto 0);
    
  begin

        found := '0';

        -- itariere durch Vector und breche bei erster 1 ab
        fl: for i in N-1 downto 0 loop
        
        if(input_vector(i) = '0' and found = '0') then
            out_var := std_logic_vector(to_unsigned(N-1 - i,log2N));
            --                                          ^-- berechne die Anzahl der 0 vor der ersten 1
            found := '1';
            
        end if;
    
        end loop fl;
        
        
        -- Falls keine Null gefunden wurde
        if found = '0' then
            out_var := "000";
        end if;
        
        output_vector <= out_var; 

  
  end process;

end Behavioral;