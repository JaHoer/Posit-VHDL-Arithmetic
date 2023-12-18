----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 29.11.2023 11:16:27
-- Design Name: 
-- Module Name: Controller - Behavioral
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

entity Controller is
    generic(
        -- Posit Values
        N : integer := 8;
        Bs : integer := 3; -- log2(N)
        es : integer := 2;
        
        inst_length : integer := 6;
        array_width : integer := 4;
        
        -- width of Data Bus inputs
        -- should be N * array_width
        data_port_width : integer := 32;
        internal_data_width : integer := 32
    );
    Port (
        clk : in std_logic;
        rst : in std_logic;
        
        data_weight_in : in std_logic_vector(data_port_width -1 downto 0);
        weight_valid : in std_logic;
        data_input_in : in std_logic_vector(data_port_width -1 downto 0);
        input_valid : in std_logic;
        data_output_in : in std_logic_vector(internal_data_width -1 downto 0);
        
        data_weight_out : out std_logic_vector(internal_data_width -1 downto 0);
        data_input_out : out std_logic_vector(internal_data_width -1 downto 0);
        data_output_out : out std_logic_vector(data_port_width -1 downto 0);
        output_valid : out std_logic;
        enable_PE : out std_logic;
        enable_weight_mem : out std_logic;
        enable_input_mem : out std_logic;
        enable_output_mem : out std_logic;
        
        inst : out std_logic_vector(inst_length-1 downto 0);
        weight_write : out std_logic
    );
end Controller;

architecture Behavioral of Controller is
    signal both_valid : std_logic;
    
    signal control_shift_register : std_logic_vector(2*array_width -1 downto 0);
    signal output_valid_sig : std_logic;

begin

    data_output_out <= std_logic_vector(resize(unsigned(data_output_in), data_port_width));
    output_valid <= output_valid_sig;
    
    
    process (clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                control_shift_register <= (others => '0');
            elsif both_valid = '1' then
                
                control_shift_register <= control_shift_register(control_shift_register'high -1 downto control_shift_register'low) & both_valid;
                output_valid_sig <= control_shift_register(control_shift_register'high);
               
            end if;
        end if;
    end process;
    
    



end Behavioral;
