----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 29.11.2023 11:16:27
-- Design Name: 
-- Module Name: PE - Behavioral
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

entity PE is
    generic(
        -- Posit Values
        N : integer := 8;
        Bs : integer := 3; -- log2(N)
        es : integer := 2;
        inst_length : integer := 6
    );
    Port ( 
        clk : in std_logic;
        --w_en : in std_logic;
        
        inst_in : in std_logic_vector(inst_length-1 downto 0);
        weight_in : in STD_LOGIC_VECTOR (N-1 downto 0);
        input_in : in STD_LOGIC_VECTOR (N-1 downto 0);
        psum_in : in STD_LOGIC_VECTOR (N-1 downto 0);
        --instr_in : in STD_LOGIC_VECTOR (N-1 downto 0);
        
        inst_out : out std_logic_vector(inst_length-1 downto 0);
        weight_out : out STD_LOGIC_VECTOR (N-1 downto 0);
        input_out : out STD_LOGIC_VECTOR (N-1 downto 0);
        psum_out : out STD_LOGIC_VECTOR (N-1 downto 0)
        --instr_out : out STD_LOGIC_VECTOR (N-1 downto 0)
    );
end PE;

architecture Behavioral of PE is


    signal psum_old : std_logic_vector(N-1 downto 0);
    signal psum_new : std_logic_vector(N-1 downto 0);
    signal input : std_logic_vector(N-1 downto 0);
    signal weight : std_logic_vector(N-1 downto 0);
    
    

begin
    psum_old <= psum_in;
    input <= input_in;
    weight <= weight_in;
    

    calc : process (clk)
        
    begin
        if rising_edge(clk) then
            if inst_in(inst_in'high) = '1' then
                input_out <= input;
                weight_out <= weight;
                
                
                -- ### TODO: here Posit operations ###
                psum_out <= std_logic_vector(resize( (signed(psum_old) + (signed(input) * signed(weight))), N));
                -- ###
            end if;
        end if;
    end process;

end Behavioral;
