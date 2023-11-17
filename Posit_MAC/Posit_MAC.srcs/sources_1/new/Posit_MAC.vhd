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

    signal operand_A : std_logic_vector(N-2 downto 0);
    signal sign_A : STD_LOGIC;
    signal exp_A : STD_LOGIC_VECTOR (es-1 downto 0);
    signal mant_A : STD_LOGIC_VECTOR (N-es downto 0);
    signal exp_eff_A : STD_LOGIC_VECTOR (Bs+es downto 0);
    
    signal operand_B : std_logic_vector(N-2 downto 0);
    signal sign_B : STD_LOGIC;
    signal exp_B : STD_LOGIC_VECTOR (es-1 downto 0);
    signal mant_B : STD_LOGIC_VECTOR (N-es downto 0);
    signal exp_eff_B : STD_LOGIC_VECTOR (Bs+es downto 0);
    
    signal operand_C : std_logic_vector(N-2 downto 0);
    signal sign_C : STD_LOGIC;
    signal exp_C : STD_LOGIC_VECTOR (es-1 downto 0);
    signal mant_C : STD_LOGIC_VECTOR (N-es downto 0);
    signal exp_eff_C : STD_LOGIC_VECTOR (Bs+es downto 0);

begin
    
    comp_ext_A : entity work.comp_extraction
    generic map (
      N => N,
      Bs => Bs,
      es => es
    )
    port map (
        clk => clk,
        operand => operand_A,
        sign => sign_A,
        exp => exp_A,
        mant => mant_A,
        exp_eff => exp_eff_A
    );
    
    comp_ext_B : entity work.comp_extraction
    generic map (
      N => N,
      Bs => Bs,
      es => es
    )
    port map (
        clk => clk,
        operand => operand_B,
        sign => sign_B,
        exp => exp_B,
        mant => mant_B,
        exp_eff => exp_eff_B
    );
    
    comp_ext_C : entity work.comp_extraction
    generic map (
      N => N,
      Bs => Bs,
      es => es
    )
    port map (
        clk => clk,
        operand => operand_C,
        sign => sign_C,
        exp => exp_C,
        mant => mant_C,
        exp_eff => exp_eff_C
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
            
            
            
            
            
            
            
            
            
            result <= v_result;
            
        end if;
    end process;
end Behavioral;
