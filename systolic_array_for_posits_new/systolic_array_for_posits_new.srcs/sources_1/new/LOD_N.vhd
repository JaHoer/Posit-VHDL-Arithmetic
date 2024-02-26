----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 26.02.2024 09:21:03
-- Design Name: 
-- Module Name: LOD_N - Behavioral
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
    N : integer := 8;
    log2N : integer := 3
  );
  port (
    input_vector : in std_logic_vector(N-1 downto 0);
    output_vector : out std_logic_vector(log2N-1 downto 0)

  );

end LOD_N;





architecture Behavioral of LOD_N is

    signal results : std_logic_vector(log2N-1 downto 0);
    signal valid : std_logic;
    signal zero_count : std_logic_vector(log2N-1 downto 0);
    
begin


    prio_enc_entity : entity work.priority_encode_N
        generic map(
            N => N,
            log2N => log2N
        )
        port map (
            input_vector => input_vector , 
            output_vector => results,
            valid => valid
        );
    
    
    -- calculate the number of Zeros before the first '1'
    zero_count <= std_logic_vector(to_unsigned(N-1, log2N) - unsigned(results));

    output_vector <= (others => '1') when valid = '0' else zero_count;


end Behavioral;
