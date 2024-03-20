----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 26.02.2024 09:16:45
-- Design Name: 
-- Module Name: weight_mem - Behavioral
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

entity weight_mem is
    generic(
    
        -- Posit Values
        N : integer := 8;
        --Bs : integer := 3; -- log2(N)
        es : integer := 2;
        
        -- Mem Size
        -- number of parallel shift register
        mem_width : integer := 4
        
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        w_en : in std_logic;
        input_vektor : in std_logic_vector(mem_width*N-1 downto 0);
        diagonal_output_vector : out std_logic_vector(mem_width*N-1 downto 0)
        
    );
end weight_mem;

architecture Behavioral of weight_mem is
    
    -- continue loading after load of first column is finished for remaining columns
    signal delayed_load_shift_register : std_logic_vector(mem_width-2 downto 0);
    
    
    signal enable : std_logic;
    

begin

    enable <= w_en; -- '1' when w_en = '1'  or load_cooldown = '1' or delayed_load_shift_register(delayed_load_shift_register'high) = '1' else '0' ;--
--    enable_out <= enable;

    create_register : for k in 1 to mem_width generate
        
        register_entity : entity work.shift_register
            generic map(
                length => k,
                data_width => N
            )
            port map(
                clk => clk,
                enable => enable,
                data_in => input_vektor(((mem_width-k+1)*N)-1 downto (mem_width-k)*N),
                data_out => diagonal_output_vector(((mem_width-k+1)*N)-1 downto (mem_width-k)*N)
            );
        
    end generate;

end Behavioral;
