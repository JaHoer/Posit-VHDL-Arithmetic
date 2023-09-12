----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jan Hörtig
-- 
-- Create Date: 11.09.2023 15:34:56
-- Design Name: 
-- Module Name: LOD - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Subcomponent for LOD_N
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

use ieee.std_logic_misc.all;

--use ieee.math_real.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LOD is
    generic (
        N : integer := 8;
        log2N : integer := 3
    );

    Port ( input : in STD_LOGIC_VECTOR (N-1 downto 0);
           output : out STD_LOGIC_VECTOR (log2N-1 downto 0);
           vld : out STD_LOGIC);
end LOD;


architecture Behavioral of LOD is


begin
    
    c2: if N = 2 generate
        vld <= or_reduce(input);
        output <= "1" when ((not input(1)) and input(0)) = '1' else "0";
    end generate c2;
    
    celse: if (std_logic_vector(to_unsigned(N, log2N)) and std_logic_vector(to_unsigned(N-1, log2N))) = "1" generate
        --LOD_c : LOD
        --generic map (
        
        --)
       -- port map (
        
        --)
        
    end generate celse;


end Behavioral;
