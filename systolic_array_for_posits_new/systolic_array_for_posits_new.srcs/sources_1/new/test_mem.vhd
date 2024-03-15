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
        length : integer := 20
    );
    port ( 
        clk : in STD_LOGIC;
        rst : in STD_LOGIC;
        enable : in std_logic;
        output : out std_logic_vector(width * data_width -1 downto 0)
    );
end test_mem;

architecture Behavioral of test_mem is

begin

    create_register : for k in width downto 1 generate
        
            register_entity : entity work.shift_register
            generic map(
                length => length,
                data_width => data_width
            )
            port map(
                clk => clk,
                enable => enable,
                data_in => (others => '1'),
                data_out => output(((k)*data_width)-1 downto (k-1)*data_width)
            );

    end generate;

end Behavioral;
