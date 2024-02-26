----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 26.02.2024 09:16:45
-- Design Name: 
-- Module Name: output_mem - Behavioral
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

entity output_mem is
    generic(
        --input_width : integer := 32;
        --output_width : integer := 32;
        
        -- Posit Values
        N : integer := 8;
        Bs : integer := 3; -- log2(N)
        es : integer := 2;
        
        -- Mem Size
        -- depth of shift register
        --mem_depth : integer := 4;
        -- number of parallel shift register
        mem_width : integer := 4
    );
    Port ( 
        clk : in std_logic;
        rst : in std_logic;
        w_en : in std_logic;
        input_vektor : in std_logic_vector(mem_width*N-1 downto 0);
        --output_vector : out std_logic_vector(output_width-1 downto 0);
        diagonal_output_vector : out std_logic_vector(mem_width*N-1 downto 0)
    );
end output_mem;

architecture Behavioral of output_mem is

    type posit_array is array (mem_width-1 downto 0)
        of std_logic_vector(N-1 downto 0);
        
    type outer_array is array (mem_width-1 downto 0)
        of posit_array;
        
    signal shift_array : outer_array;

begin

    create_register : for k in mem_width downto 1 generate
        
--        if_k_large : if k > 1 generate
            register_entity : entity work.shift_register
            generic map(
--                length => k-1,
                length => k,
                data_width => N
            )
            port map(
                clk => clk,
                enable => w_en,
                data_in => input_vektor(((k)*N)-1 downto (k-1)*N),
                data_out => diagonal_output_vector(((k)*N)-1 downto (k-1)*N)
            );
--        end generate;
        
--        if_k_small : if k <= 1 generate
--            diagonal_output_vector(((k)*N)-1 downto (k-1)*N) <= input_vektor(((k)*N)-1 downto (k-1)*N) when w_en = '1';
--        end generate;
    end generate;

--    process (clk)
        --variable tmp_output : std_logic_vector(output_width-1 downto 0);
    
--    begin
--        if rising_edge(clk) then
--            if rst = '1' then
--                shift_array <= (others => (others => (others => '0')));
--                diagonal_output_vector <= (others => '0');
--            elsif w_en = '1' then
--                for i in mem_width-1 downto 0 loop
--                    shift_array(i) <= shift_array(i)(shift_array(i)'high -1 downto shift_array(i)'low) & input_vektor(((i+1)*N)-1 downto (i)*N);
--                    --output_vector(((i+1)*N)-1 downto (i)*N) <= shift_array(i)(shift_array'high);
--                    diagonal_output_vector(((i+1)*N)-1 downto (i)*N) <= shift_array(i)(i);
--                end loop;
                
                --output_vector <= tmp_output;
--            end if;
            
           
            
             
--        end if;
    
--    end process;


end Behavioral;