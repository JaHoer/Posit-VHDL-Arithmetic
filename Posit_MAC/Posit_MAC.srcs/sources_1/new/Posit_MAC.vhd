----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 15.11.2023 10:34:44
-- Design Name: 
-- Module Name: Posit_MAC - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- Implementaion of Efficient Posit Multiply-Accumulate Unit Generator for Deep Learning Applications
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

entity Posit_MAC is
    generic (
        N : integer := 16;
        Bs : integer := 4;  -- log2(N)
        es : integer := 2
    );
    Port ( 
        clk : in STD_LOGIC;
        in_A : in STD_LOGIC_VECTOR (N-1 downto 0);
        in_B : in STD_LOGIC_VECTOR (N-1 downto 0);
        in_C : in STD_LOGIC_VECTOR (N-1 downto 0);
        in_op : in STD_LOGIC;
        result : out STD_LOGIC_VECTOR (N-1 downto 0)
    );
end Posit_MAC;

architecture Behavioral of Posit_MAC is

begin
    
    comp_ext_A : entity work.comp_extraction
    generic map (
      N => N,
      Bs => Bs,
      es => es
    )
    port map (
        clk => clk,
        operand => ,
        sign => ,
        exp =>,
        exp_eff => ,
        mant =>
    );
    
    comp_ext_B : entity work.comp_extraction
    generic map (
      N => N,
      Bs => Bs,
      es => es
    )
    port map (
        clk => clk,
        operand => ,
        sign => ,
        exp =>,
        exp_eff => ,
        mant =>
    );
    
    comp_ext_C : entity work.comp_extraction
    generic map (
      N => N,
      Bs => Bs,
      es => es
    )
    port map (
        clk => clk,
        operand => ,
        sign => ,
        exp =>,
        exp_eff => ,
        mant =>
    );
    

    mac_main : process (clk)
    
        variable v_in_A : std_logic_vector(N-1 downto 0);
        variable v_in_B : std_logic_vector(N-1 downto 0);
        variable v_in_C : std_logic_vector(N-1 downto 0);
        variable v_in_op : std_logic;
        
        
        
        variable v_result : std_logic_vector(N-1 downto 0);
    
    begin
    
        if rising_edge(clk) then
            
            v_in_A := in_A;
            v_in_B := in_B;
            v_in_C := in_C;
            v_in_op := in_op;
            
            
            
            
            
            
            
            
            
            result <= result;
            
        end if;
    end process;
end Behavioral;
