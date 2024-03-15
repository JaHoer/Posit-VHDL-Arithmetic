----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 26.02.2024 09:16:45
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
    port ( 
        clk : in std_logic;
        comp_en : in std_logic;
        weight_en : in std_logic;
        --weight_en_out : out std_logic;
        
        weight_in : in STD_LOGIC_VECTOR (N-1 downto 0);
        input_in : in STD_LOGIC_VECTOR (array_width*N-1 downto 0);
        psum_in : in STD_LOGIC_VECTOR (N-1 downto 0);
        weight_w_en_in : in std_logic;

        input_out : out STD_LOGIC_VECTOR (array_width*N-1 downto 0);
        psum_out : out STD_LOGIC_VECTOR (N-1 downto 0);
        weight_w_en_out : out std_logic
        
        
        -- Debug
--        ;
--        intermediate_weight_o : out std_logic_vector((array_width+1)*N-1 downto 0);
--        intermediate_psum_o : out std_logic_vector((array_width+1)*N-1 downto 0);
--        internal_weight_mem : out std_logic_vector((array_width+1)*N-1 downto 0);
--        internal_input_mem : out std_logic_vector((array_width+1)*N-1 downto 0);
--        internal_psum_mem : out std_logic_vector((array_width+1)*N-1 downto 0);
--        product_out : out std_logic_vector(array_width*N-1 downto 0)
        
        
    );
end PE_block;

architecture Behavioral of PE_block is

    --signal intermediate_w_write : std_logic_vector(array_width downto 0);
    --signal weigth_write_mem : std_logic;
    signal intermediate_weight : std_logic_vector((array_width+1)*N-1 downto 0);
    signal intermediate_psum : std_logic_vector((array_width+1)*N-1 downto 0);
    
    signal weight : std_logic_vector(array_width*N-1 downto 0);
    
    signal weight_en_tmp : std_logic;
    
    
    

begin


    --intermediate_w_write(array_width) <= weight_w_en_in;
    
    
    intermediate_psum((array_width+1)*N-1 downto (array_width)*N) <= psum_in;
    psum_out <= intermediate_psum(N-1 downto 0);
    intermediate_weight((array_width+1)*N-1 downto (array_width)*N) <= weight_in ;


    gen_pe : for i in array_width-1 downto 0 generate 

        PE_entity : entity work.PE
        generic map(
            N => N,
            Bs => Bs, -- log2(N)
            es => es
        )
        port map( 
            clk => clk,
            comp_en => comp_en,
            --weight_en => weight_en_tmp,
            weight_en => weight_en,
            
            --weight_in => weight_in((i+1)*N-1 downto i*N),
            weight_in => intermediate_weight((i+2)*N-1 downto (i+1)*N),
            input_in => input_in((i+1)*N-1 downto i*N),
            psum_in => intermediate_psum((i+2)*N-1 downto (i+1)*N),
            weight_w_en_in => weight_w_en_in,

            --weight_out => weight_out((i+1)*N-1 downto i*N),
            weight_out => intermediate_weight((i+1)*N-1 downto (i)*N),
            input_out => input_out((i+1)*N-1 downto i*N),
            psum_out => intermediate_psum((i+1)*N-1 downto (i)*N)
            --weight_w_en_out => intermediate_w_write(i)
            
        );


    end generate;
    
    w_mem : process (clk)
    begin
        if rising_edge(clk) then
            --weigth_write_mem <= weight_w_en_in;
            weight_w_en_out <= weight_w_en_in;
            --weight_en_tmp <= weight_en;
            
            --weight_en_out <= weight_en;
            
--            if weight_en = '1' then
--                intermediate_weight((array_width+1)*N-1 downto (array_width)*N) <= weight_in;
--            end if;
        end if;
    end process;
    


end Behavioral;
