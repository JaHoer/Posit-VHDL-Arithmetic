----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/30/2023 01:12:52 PM
-- Design Name: 
-- Module Name: tb_data_extract - Behavioral
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

entity tb_data_extract is
    generic (
        N_tb : integer := 8;
        Bs_tb : integer := 3; -- log2(N)
        es_tb : integer := 4
        
    );

--  Port ( );
end tb_data_extract;



architecture Behavioral of tb_data_extract is

    constant CLOCK_PERIOD : time := 100 ns;

    signal clk  : std_logic;

    signal in_val_tb : std_logic_vector(N_tb-1 downto 0);
    signal rc_tb : std_logic;
    signal regime_tb : std_logic_vector(Bs_tb-1 downto 0);
    signal Lshift_tb : std_logic_vector(Bs_tb-1 downto 0);
    signal exp_tb : std_logic_vector(es_tb-1 downto 0);
    signal mant_tb : std_logic_vector(N_tb-es_tb-1 downto 0);

begin

    UUT : entity work.data_extract
    generic map (
        N => N_tb,
        Bs => Bs_tb,
        es => es_tb
    )
    port map(
        in_val => in_val_tb,
        rc => rc_tb,
        regime => regime_tb,
        Lshift => Lshift_tb,
        exp => exp_tb,
        mant => mant_tb
    );
    
    
    stimuli : process
    begin
   
        wait for CLOCK_PERIOD;
        in_val_tb <= "01000000"; -- +1
        wait for CLOCK_PERIOD;
        --assert rc_tb = '1' report "Should be 1";
        --assert regime_tb = "1" report "Should be 1";
        --assert Lshift_tb = "1" report "Should be 1";
        --assert exp_tb = "0000" report "Should be 0000";
        --assert mant_tb = "0" report "Should be 0";
        
        in_val_tb <= "11000000"; -- -1
        wait for CLOCK_PERIOD;
        
        in_val_tb <= "00000000"; -- 0
        wait for CLOCK_PERIOD;
        
        in_val_tb <= "01100100"; -- +6
        wait for CLOCK_PERIOD;
        
        in_val_tb <= "00011100"; -- + 3/16
        wait for CLOCK_PERIOD;
   
    
    end process;
   

end Behavioral;
