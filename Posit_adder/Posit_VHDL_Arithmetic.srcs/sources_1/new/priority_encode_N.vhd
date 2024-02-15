----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 02/15/2024 11:43:06 AM
-- Design Name: 
-- Module Name: priority_encode_N - Behavioral
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
use IEEE.std_logic_misc.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity priority_encode_N is
    generic(
        N : integer := 4;
        log2N : integer := 2
    );

    port (
        input_vector : in std_logic_vector(N-1 downto 0);

        output_vector : out std_logic_vector(log2N-1 downto 0);
        valid : out std_logic

    );
end priority_encode_N;

architecture Behavioral of priority_encode_N is

    signal out_S1 : std_logic_vector((N/8)*3-1 downto 0);
    signal out_S2 : std_logic_vector((N/16)*4-1 downto 0);
    signal out_S3 : std_logic_vector((N/32)*5-1 downto 0);
    
    signal valids_S1 : std_logic_vector((N/8)-1 downto 0);
    signal valids_S2 : std_logic_vector((N/16)-1 downto 0);
    signal valids_S3 : std_logic_vector((N/32)-1 downto 0);

    signal out_A_8 : std_logic_vector(7 downto 0);
    signal out_B_8 : std_logic_vector(7 downto 0);
    signal out_C_8 : std_logic_vector(7 downto 0);
    signal out_D_8 : std_logic_vector(7 downto 0);
    signal out_E_8 : std_logic_vector(7 downto 0);
    signal out_F_8 : std_logic_vector(7 downto 0);
    signal out_G_8 : std_logic_vector(7 downto 0);
    signal out_H_8 : std_logic_vector(7 downto 0);
    
    signal out_A_16 : std_logic_vector(15 downto 0);
    signal out_B_16 : std_logic_vector(15 downto 0);
    signal out_C_16 : std_logic_vector(15 downto 0);
    signal out_D_16 : std_logic_vector(15 downto 0);
    
    signal out_A_32 : std_logic_vector(31 downto 0);
    signal out_B_32 : std_logic_vector(31 downto 0);

begin

    gen_tables : if N = 4 generate
        prio_enc_entity : entity work.priority_encode_4_2
        generic map(
            N => 4,
            log2N => 2
        )
        port map (
            input_vector => input_vector , 
            output_vector => output_vector,
            valid => valid
        );
    end generate;
    
    
    
    gen_table_8 : if N = 8 generate
        prio_enc_entity : entity work.priority_encode_4_2
        generic map(
            N => 8,
            log2N => 3
        )
        port map (
            input_vector => input_vector , 
            output_vector => output_vector,
            valid => valid
        );
    end generate;
    
    
    
    gen_table_16 : if N = 16 generate
        prio_enc_entity : entity work.priority_encode_4_2
        generic map(
            N => 16,
            log2N => 4
        )
        port map (
            input_vector => input_vector , 
            output_vector => output_vector,
            valid => valid
        );
        
    end generate;
    
    gen_table_32 : if N = 32 generate
        prio_enc_entity : entity work.priority_encode_4_2
        generic map(
            N => 32,
            log2N => 5
        )
        port map (
            input_vector => input_vector , 
            output_vector => output_vector,
            valid => valid
        );
    
    end generate;
    
    gen_table_64 : if N = 64 generate
    
    
    end generate;

end Behavioral;
