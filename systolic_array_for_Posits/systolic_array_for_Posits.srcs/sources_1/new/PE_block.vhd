----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.01.2024 10:18:30
-- Design Name: 
-- Module Name: PE_block - Behavioral
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

entity PE_block is
    generic(
        N : integer := 8;
        Bs : integer := 3; -- log2(N)
        es : integer := 2;
        
        array_width : integer := 4
        
    );
    Port ( 
        clk : in std_logic;
        comp_en : in std_logic;
        weight_en : in std_logic;
        
        weight_in : in STD_LOGIC_VECTOR (array_width*N-1 downto 0);
        input_in : in STD_LOGIC_VECTOR (N-1 downto 0);
        psum_in : in STD_LOGIC_VECTOR (N-1 downto 0);
        weight_w_en_in : in std_logic;

        weight_out : out STD_LOGIC_VECTOR (array_width*N-1 downto 0);
        psum_out : out STD_LOGIC_VECTOR (N-1 downto 0)

    );
end PE_block;

architecture Behavioral of PE_block is

    signal intermediate_w_write : std_logic_vector(array_width downto 0);
    signal intermediate_input : std_logic_vector((array_width+1)*N-1 downto 0);
    signal intermediate_psum : std_logic_vector((array_width+1)*N-1 downto 0);
    
    signal weight : std_logic_vector(array_width*N-1 downto 0);

begin

    intermediate_w_write(array_width) <= weight_w_en_in;
    intermediate_input((array_width+1)*N-1 downto (array_width)*N) <= input_in;
    intermediate_psum((array_width+1)*N-1 downto (array_width)*N) <= psum_in;
    psum_out <= intermediate_psum(N-1 downto 0);


    gen_block : for i in array_width-1 downto 0 generate 

        PE_entity : entity work.PE
        generic map(
            N => N,
            Bs => Bs, -- log2(N)
            es => es
        )
        port map( 
            clk => clk,
            comp_en => comp_en,
            weight_en => weight_en,

            weight_in => weight_in((i+1)*N-1 downto i*N),
            input_in => intermediate_input((i+2)*N-1 downto (i+1)*N),
            psum_in => intermediate_psum((i+2)*N-1 downto (i+1)*N),
            weight_w_en_in => intermediate_w_write(i+1),

            weight_out => weight_out((i+1)*N-1 downto i*N),
            input_out => intermediate_input((i+1)*N-1 downto (i)*N),
            psum_out => intermediate_psum((i+1)*N-1 downto (i)*N),
            weight_w_en_out => intermediate_w_write(i)
        );


    end generate;

end Behavioral;
