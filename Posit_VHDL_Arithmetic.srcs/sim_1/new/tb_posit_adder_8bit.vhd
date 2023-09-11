----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jan Hörig
-- 
-- Create Date: 08/30/2023 12:33:32 PM
-- Design Name: 
-- Module Name: tb_posit_adder_8bit - Behavioral
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

entity tb_posit_adder_8bit is
    generic (
        N_tb : integer := 8;
        Bs_tb : integer := 3; -- log2(N)
        es_tb : integer := 4
        
    );

--  Port ( );
end tb_posit_adder_8bit;



architecture Behavioral of tb_posit_adder_8bit is

    constant CLOCK_PERIOD : time := 100 ns;

    signal clk  : std_logic;

    signal in1_tb : std_logic_vector(N_tb-1 downto 0);
    signal in2_tb : std_logic_vector(N_tb-1 downto 0);
    signal start_tb : std_logic;
    signal out_val_tb : std_logic_vector(N_tb-1 downto 0);
    signal inf_tb : std_logic;
    signal zero_tb : std_logic;
    signal done_tb : std_logic;
    
    signal inf1_tb :  std_logic;
    signal inf2_tb :  std_logic;
    signal zero1_tb :  std_logic;
    signal zero2_tb :  std_logic;
    
    signal rc1_tb : std_logic;
    signal rc2_tb : std_logic;
    signal regime1_tb : std_logic_vector(Bs_tb-1 downto 0); 
    signal regime2_tb : std_logic_vector(Bs_tb-1 downto 0); 
    signal Lshift1_tb : std_logic_vector(Bs_tb-1 downto 0); 
    signal Lshift2_tb : std_logic_vector(Bs_tb-1 downto 0);
    signal e1_tb : std_logic_vector(es_tb-1 downto 0);
    signal e2_tb : std_logic_vector(es_tb-1 downto 0);
    signal mant1_tb : std_logic_vector(N_tb-es_tb-1 downto 0); 
    signal mant2_tb : std_logic_vector(N_tb-es_tb-1 downto 0);

begin

    UUT : entity work.posit_adder
    generic map (
        N => N_tb,
        Bs => Bs_tb,
        es => es_tb
    )
    port map (
        in1 => in1_tb,
        in2 => in2_tb,
        start => start_tb,
        out_val => out_val_tb,
        inf => inf_tb,
        zero => zero_tb,
        done => done_tb,
        
        inf1_o => inf1_tb,
        inf2_o => inf2_tb,
        zero1_o => zero1_tb,
        zero2_o => zero2_tb,
    
        rc1_o => rc1_tb,
        rc2_o => rc2_tb,
        regime1_o => regime1_tb,
        regime2_o => regime2_tb,
        Lshift1_o => Lshift1_tb,
        Lshift2_o => Lshift2_tb,
        e1_o => e1_tb,
        e2_o => e2_tb,
        mant1_o => mant1_tb,
        mant2_o => mant2_tb
       
    );
    
    
    stimuli: process
    
    begin
    
        wait for CLOCK_PERIOD;
        -- Zeile 5
        in1_tb <= "00000100";
        in2_tb <= "00000000";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Should be 1";
        assert out_val_tb = "00000100" report "Should be 00000100";
        wait for CLOCK_PERIOD;
        
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        -- Zeile 265
        in1_tb <= "00001000";
        in2_tb <= "00000001";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Should be 1";
        assert out_val_tb = "00001000" report "Should be 00001000";
        wait for CLOCK_PERIOD;
        
        start_tb <= '0';
        wait for CLOCK_PERIOD;
        
        -- Zeile 2520
        in1_tb <= "11010111";
        in2_tb <= "00001001";
        start_tb <= '1';
        wait for CLOCK_PERIOD;
        assert done_tb = '1' report "Should be 1";
        assert out_val_tb = "11010111" report "Should be 11010111";
        wait for CLOCK_PERIOD;
        
        
        
    
    end process;


end Behavioral;
