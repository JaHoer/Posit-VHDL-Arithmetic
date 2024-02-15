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
    generic(
        N : integer := 4;
        log2N : integer := 2
    );

    port (
    input_vector : in std_logic_vector(N-1 downto 0);

    output_vector : out std_logic_vector(log2N-1 downto 0);
    valid : out std_logic

    );
end priority_encode_4_2;

architecture Behavioral of priority_encode_4_2 is

begin
    
    gen_tables : if N = 4 generate
    
        process(input_vector)
        begin
            if (input_vector(3) = '1') then
                output_vector <= "11";
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
    
    end generate;
    
    gen_table_8 : if N = 8 generate
    
        process(input_vector)
        begin
            if (input_vector(7) = '1') then
                output_vector <= "111";
                valid  <= '1';
            elsif (input_vector(6) = '1') then
                output_vector <= "110";
                valid  <= '1';
            elsif (input_vector(5) = '1') then
                output_vector <= "101";
                valid  <= '1';
            elsif (input_vector(4) = '1') then
                output_vector <= "100";
                valid  <= '1';
            elsif (input_vector(3) = '1') then
                output_vector <= "011";
                valid  <= '1';
            elsif (input_vector(2) = '1') then
                output_vector <= "010";
                valid  <= '1';
            elsif (input_vector(1) = '1') then
                output_vector <= "001";
                valid  <= '1';
            elsif (input_vector(0) = '1') then
                output_vector <= "000";
                valid  <= '1';
            else
                output_vector <= "000";
                valid  <= '0';
            end if;
        end process;
    
    end generate;
    
    
    
    
    gen_table_16 : if N = 16 generate
        process(input_vector)
        begin
            if (input_vector(15) = '1') then
                output_vector <= "1111";
                valid  <= '1';
            elsif (input_vector(14) = '1') then
                output_vector <= "1110";
                valid  <= '1';
            elsif (input_vector(13) = '1') then
                output_vector <= "1101";
                valid  <= '1';
            elsif (input_vector(12) = '1') then
                output_vector <= "1100";
                valid  <= '1';
            elsif (input_vector(11) = '1') then
                output_vector <= "1011";
                valid  <= '1';
            elsif (input_vector(10) = '1') then
                output_vector <= "1010";
                valid  <= '1';
            elsif (input_vector(9) = '1') then
                output_vector <= "1001";
                valid  <= '1';
            elsif (input_vector(8) = '1') then
                output_vector <= "1000";
                valid  <= '1';
            elsif (input_vector(7) = '1') then
                output_vector <= "0111";
                valid  <= '1';
            elsif (input_vector(6) = '1') then
                output_vector <= "0110";
                valid  <= '1';
            elsif (input_vector(5) = '1') then
                output_vector <= "0101";
                valid  <= '1';
            elsif (input_vector(4) = '1') then
                output_vector <= "0100";
                valid  <= '1';
            elsif (input_vector(3) = '1') then
                output_vector <= "0011";
                valid  <= '1';
            elsif (input_vector(2) = '1') then
                output_vector <= "0010";
                valid  <= '1';
            elsif (input_vector(1) = '1') then
                output_vector <= "0001";
                valid  <= '1';
            elsif (input_vector(0) = '1') then
                output_vector <= "0000";
                valid  <= '1';
            else
                output_vector <= "0000";
                valid  <= '0';
            end if;
        end process;
    end generate;
    
    
    
    
    gen_table_32 : if N = 32 generate
        process(input_vector)
        begin
            if (input_vector(31) = '1') then
                output_vector <= "11111";
                valid  <= '1';
            elsif (input_vector(30) = '1') then
                output_vector <= "11110";
                valid  <= '1';
            elsif (input_vector(29) = '1') then
                output_vector <= "11101";
                valid  <= '1';
            elsif (input_vector(28) = '1') then
                output_vector <= "11100";
                valid  <= '1';
            elsif (input_vector(27) = '1') then
                output_vector <= "11011";
                valid  <= '1';
            elsif (input_vector(26) = '1') then
                output_vector <= "11010";
                valid  <= '1';
            elsif (input_vector(25) = '1') then
                output_vector <= "11001";
                valid  <= '1';
            elsif (input_vector(24) = '1') then
                output_vector <= "11000";
                valid  <= '1';
            elsif (input_vector(23) = '1') then
                output_vector <= "10111";
                valid  <= '1';
            elsif (input_vector(22) = '1') then
                output_vector <= "10110";
                valid  <= '1';
            elsif (input_vector(21) = '1') then
                output_vector <= "10101";
                valid  <= '1';
            elsif (input_vector(20) = '1') then
                output_vector <= "10100";
                valid  <= '1';
            elsif (input_vector(19) = '1') then
                output_vector <= "11011";
                valid  <= '1';
            elsif (input_vector(18) = '1') then
                output_vector <= "11010";
                valid  <= '1';
            elsif (input_vector(17) = '1') then
                output_vector <= "11001";
                valid  <= '1';
            elsif (input_vector(16) = '1') then
                output_vector <= "10000";
                valid  <= '1';
            elsif (input_vector(15) = '1') then
                output_vector <= "01111";
                valid  <= '1';
            elsif (input_vector(14) = '1') then
                output_vector <= "01110";
                valid  <= '1';
            elsif (input_vector(13) = '1') then
                output_vector <= "01101";
                valid  <= '1';
            elsif (input_vector(12) = '1') then
                output_vector <= "01100";
                valid  <= '1';
            elsif (input_vector(11) = '1') then
                output_vector <= "01011";
                valid  <= '1';
            elsif (input_vector(10) = '1') then
                output_vector <= "01010";
                valid  <= '1';
            elsif (input_vector(9) = '1') then
                output_vector <= "01001";
                valid  <= '1';
            elsif (input_vector(8) = '1') then
                output_vector <= "01000";
                valid  <= '1';
            elsif (input_vector(7) = '1') then
                output_vector <= "00111";
                valid  <= '1';
            elsif (input_vector(6) = '1') then
                output_vector <= "00110";
                valid  <= '1';
            elsif (input_vector(5) = '1') then
                output_vector <= "00101";
                valid  <= '1';
            elsif (input_vector(4) = '1') then
                output_vector <= "00100";
                valid  <= '1';
            elsif (input_vector(3) = '1') then
                output_vector <= "00011";
                valid  <= '1';
            elsif (input_vector(2) = '1') then
                output_vector <= "00010";
                valid  <= '1';
            elsif (input_vector(1) = '1') then
                output_vector <= "00001";
                valid  <= '1';
            elsif (input_vector(0) = '1') then
                output_vector <= "00000";
                valid  <= '1';
            else
                output_vector <= "0000";
                valid  <= '0';
            end if;
        end process;
        
    
    end generate;
    
    
    

end Behavioral;
