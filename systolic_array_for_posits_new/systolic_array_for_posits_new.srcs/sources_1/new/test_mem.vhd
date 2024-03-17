----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 14.03.2024 08:31:31
-- Design Name: 
-- Module Name: test_mem - Behavioral
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

entity test_mem is
    generic(
        data_width : integer := 8;
        width : integer := 4;
        length : integer := 32
    );
    port ( 
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        enable : in std_logic;
        output_data_weight : out std_logic_vector(width * data_width -1 downto 0);
        output_valid_weight : out std_logic;
        output_data_input : out std_logic_vector(width * data_width -1 downto 0);
        output_valid_input : out std_logic
    );
end test_mem;

architecture Behavioral of test_mem is

    type register_array is array (length-1 downto 0)
        of std_logic_vector(data_width*width-1 downto 0);
        
    signal sr_w : register_array;
    signal sr_i : register_array;
    
    signal valid_sig_w : std_logic_vector(length-1 downto 0);
    signal valid_sig_i : std_logic_vector(length-1 downto 0);
    
    
    signal zeros : std_logic_vector(data_width*width-1 downto 0) := (others => '0');
    
    
begin

    process (clk)
    begin
    
        if rst = '1' then
            sr_w(0)  <= x"00000000";
            sr_w(1)  <= x"40404040";
            sr_w(2)  <= x"40404040";
            sr_w(3)  <= x"40404040";
            sr_w(4)  <= x"40404040";
            sr_w(5)  <= x"00000000";
            sr_w(6)  <= x"00000000";
            sr_w(7)  <= x"00000000";
            
            sr_w(8)  <= x"00000000";
            sr_w(9)  <= x"00000000";
            sr_w(10) <= x"00000000";
            sr_w(11) <= x"00000000";
            sr_w(12) <= x"00000000";
            sr_w(13) <= x"00000000";
            sr_w(14) <= x"00000000";
            sr_w(15) <= x"00000000";
            
            sr_w(16) <= x"00000000";
            sr_w(17) <= x"00000000";
            sr_w(18) <= x"00000000";
            sr_w(19) <= x"00000000";
            sr_w(20) <= x"00000000";
            sr_w(21) <= x"00000000";
            sr_w(22) <= x"00000000";
            sr_w(23) <= x"00000000";
            
            sr_w(24) <= x"00000000";
            sr_w(25) <= x"00000000";
            sr_w(26) <= x"00000000";
            sr_w(27) <= x"00000000";
            sr_w(28) <= x"00000000";
            sr_w(29) <= x"00000000";
            sr_w(30) <= x"00000000";
            sr_w(31) <= x"00000000";
            
            valid_sig_w <= x"78000000";
            
            
            
            sr_w(0)  <= x"00000000";
            sr_w(1)  <= x"40404040";
            sr_w(2)  <= x"40404040";
            sr_w(3)  <= x"40404040";
            sr_w(4)  <= x"40404040";
            sr_w(5)  <= x"00000000";
            sr_w(6)  <= x"40404040";
            sr_w(7)  <= x"48484848";
            
            sr_w(8)  <= x"38383838";
            sr_w(9)  <= x"50505050";
            sr_w(10) <= x"00000000";
            sr_w(11) <= x"00000000";
            sr_w(12) <= x"00000000";
            sr_w(13) <= x"00000000";
            sr_w(14) <= x"00000000";
            sr_w(15) <= x"00000000";
            
            sr_w(16) <= x"00000000";
            sr_w(17) <= x"00000000";
            sr_w(18) <= x"00000000";
            sr_w(19) <= x"00000000";
            sr_w(20) <= x"00000000";
            sr_w(21) <= x"00000000";
            sr_w(22) <= x"00000000";
            sr_w(23) <= x"00000000";
            
            sr_w(24) <= x"00000000";
            sr_w(25) <= x"00000000";
            sr_w(26) <= x"00000000";
            sr_w(27) <= x"00000000";
            sr_w(28) <= x"00000000";
            sr_w(29) <= x"00000000";
            sr_w(30) <= x"00000000";
            sr_w(31) <= x"00000000";
            
            valid_sig_w <= x"03c00000";
            
            
        else 
            if rising_edge(clk) then
                if enable = '1' then

                    sr_w <= sr_w(sr_w'high-1 downto sr_w'low) & zeros;
                    valid_sig_w <= valid_sig_w(valid_sig_w'high-1 downto valid_sig_w'low) & '0';
                    
                    sr_i <= sr_i(sr_i'high-1 downto sr_i'low) & zeros;
                    valid_sig_i <= valid_sig_i(valid_sig_i'high-1 downto valid_sig_i'low) & '0';

                end if;
            end if;
        end if;
    end process;
    
    output_data_weight <= sr_w(sr_w'high);
    output_valid_weight <= valid_sig_w(valid_sig_w'high);
    
    output_data_input <= sr_i(sr_i'high);
    output_valid_input <= valid_sig_i(valid_sig_i'high);

end Behavioral;
