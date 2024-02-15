----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 15.02.2024 14:59:09
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity priority_encode_N is
    generic(
        N : integer := 8;
        log2N : integer := 3
    );

    port (
        input_vector : in std_logic_vector(N-1 downto 0);

        output_vector : out std_logic_vector(log2N-1 downto 0);
        valid : out std_logic
    );
end priority_encode_N;

architecture Behavioral of priority_encode_N is

    -- each length of log2(32) = 5 for output of prio_enc_32
    signal out_A : std_logic_vector(log2N-2 downto 0);
    signal out_B : std_logic_vector(log2N-2 downto 0);
    
    signal valid_A : std_logic;
    signal valid_B : std_logic;

begin

    gen_tables : if N = 4 generate
        prio_enc_entity : entity work.priority_encode_table
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
        
        prio_enc_entity_A : entity work.priority_encode_table
        generic map(
            N => 4,
            log2N => 2
        )
        port map (
            input_vector => input_vector(N-1 downto N/2), 
            output_vector => out_A,
            valid => valid_A
        );
        

        prio_enc_entity_B : entity work.priority_encode_table
        generic map(
            N => 4,
            log2N => 2
        )
        port map (
            input_vector => input_vector(N/2-1 downto 0), 
            output_vector => out_B,
            valid => valid_B
        );
        
        valid <= valid_A or valid_B;
        
        output_vector(log2N-1) <= valid_A;
        
        fusion : for i in log2N-2 downto 0 generate
        output_vector(i) <= (valid_A and out_A(i)) or (not valid_A and out_B(i));
        end generate;
        
    end generate;
    
    
    
    gen_table_16 : if N = 16 generate
        
        prio_enc_entity_A : entity work.priority_encode_table
        generic map(
            N => 8,
            log2N => 3
        )
        port map (
            input_vector => input_vector(N-1 downto N/2), 
            output_vector => out_A,
            valid => valid_A
        );
        

        prio_enc_entity_B : entity work.priority_encode_table
        generic map(
            N => 8,
            log2N => 3
        )
        port map (
            input_vector => input_vector(N/2-1 downto 0), 
            output_vector => out_B,
            valid => valid_B
        );
        
        valid <= valid_A or valid_B;
        
        output_vector(log2N-1) <= valid_A;
        
        fusion : for i in log2N-2 downto 0 generate
            output_vector(i) <= (valid_A and out_A(i)) or (not valid_A and out_B(i));
        end generate;
        
    end generate;
    
    
    
    
    gen_table_32 : if N = 32 generate
    
        prio_enc_entity_A : entity work.priority_encode_table
        generic map(
            N => 16,
            log2N => 4
        )
        port map (
            input_vector => input_vector(N-1 downto N/2), 
            output_vector => out_A,
            valid => valid_A
        );
        

        prio_enc_entity_B : entity work.priority_encode_table
        generic map(
            N => 16,
            log2N => 4
        )
        port map (
            input_vector => input_vector(N/2-1 downto 0), 
            output_vector => out_B,
            valid => valid_B
        );
        
        valid <= valid_A or valid_B;
        
        output_vector(log2N-1) <= valid_A;
        
        fusion : for i in log2N-2 downto 0 generate 
            output_vector(i) <= (valid_A and out_A(i)) or (not valid_A and out_B(i)); 
        end generate;
        
    end generate;
    
    
    
    
    gen_table_64 : if N = 64 generate
   
        prio_enc_entity_A : entity work.priority_encode_table
        generic map(
            N => 32,
            log2N => 5
        )
        port map (
            input_vector => input_vector(N-1 downto N/2), 
            output_vector => out_A,
            valid => valid_A
        );
        

        prio_enc_entity_B : entity work.priority_encode_table
        generic map(
            N => 32,
            log2N => 5
        )
        port map (
            input_vector => input_vector(N/2-1 downto 0), 
            output_vector => out_B,
            valid => valid_B
        );
        
        valid <= valid_A or valid_B;
        
        output_vector(log2N-1) <= valid_A;
        
        fusion : for i in log2N-2 downto 0 generate
            output_vector(i) <= (valid_A and out_A(i)) or (not valid_A and out_B(i));
        end generate;
    
    end generate;

end Behavioral;
