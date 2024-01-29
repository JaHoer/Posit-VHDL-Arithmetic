----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 24.01.2024 11:11:32
-- Design Name: 
-- Module Name: tb_PE_block - Behavioral
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

entity tb_PE_block is
    generic (
        N_tb : integer := 8;
        Bs_tb : integer := 3; -- log2(N)
        es_tb : integer := 2;
        array_width_tb : integer := 4
    );
--  Port ( );
end tb_PE_block;

architecture Behavioral of tb_PE_block is

    constant CLOCK_PERIOD : time := 50 ns;

    signal clk_tb : std_logic;
    --signal rst_tb : std_logic;
    --signal w_en_tb : std_logic;
    
    signal comp_en_tb : std_logic;
    signal weight_en_tb : std_logic;
    --signal weight_en_out_tb : std_logic;
    
    --signal inst_in_tb : std_logic_vector(5 downto 0);
    signal weight_in_tb : STD_LOGIC_VECTOR (N_tb-1 downto 0);
    signal input_in_tb : STD_LOGIC_VECTOR (array_width_tb*N_tb-1 downto 0);
    signal psum_in_tb : STD_LOGIC_VECTOR (N_tb-1 downto 0);
    signal weight_w_en_in_tb : std_logic;
    
    --signal inst_out_tb : std_logic_vector(5 downto 0);
    signal input_out_tb : STD_LOGIC_VECTOR (array_width_tb*N_tb-1 downto 0);
    --signal input_out_tb : STD_LOGIC_VECTOR (N_tb-1 downto 0);
    signal psum_out_tb : STD_LOGIC_VECTOR (N_tb-1 downto 0);
    signal weight_w_en_out_tb : std_logic;
    
    
    
--    signal external_intermediate_w_write : std_logic_vector(array_width_tb downto 0);
    signal external_intermediate_weight : std_logic_vector((array_width_tb+1)*N_tb-1 downto 0);
    signal external_intermediate_psum : std_logic_vector((array_width_tb+1)*N_tb-1 downto 0);
    
    signal external_saved_weight_3 : std_logic_vector(N_tb-1 downto 0);
    signal external_saved_weight_2 : std_logic_vector(N_tb-1 downto 0);
    signal external_saved_weight_1 : std_logic_vector(N_tb-1 downto 0);
    signal external_saved_weight_0 : std_logic_vector(N_tb-1 downto 0);
    
    signal external_temp_weight_3 : std_logic_vector(N_tb-1 downto 0);
    signal external_temp_weight_2 : std_logic_vector(N_tb-1 downto 0);
    signal external_temp_weight_1 : std_logic_vector(N_tb-1 downto 0);
    signal external_temp_weight_0 : std_logic_vector(N_tb-1 downto 0);
    
    --signal external_weight : std_logic_vector(array_width_tb*N_tb-1 downto 0);
begin

    uut : entity work.PE_block
        generic map(
            N => N_tb,
            Bs => Bs_tb,
            es => es_tb,
            array_width => array_width_tb
        )
        port map(
            clk => clk_tb,
            comp_en => comp_en_tb,
            weight_en => weight_en_tb,
            --weight_en_out => weight_en_out_tb,

            weight_in => weight_in_tb,
            input_in => input_in_tb,
            psum_in => psum_in_tb,
            weight_w_en_in => weight_w_en_in_tb,
        
            input_out => input_out_tb,
            psum_out => psum_out_tb

        );
    
    
    --external_intermediate_w_write <= << signal uut.intermediate_w_write : std_logic_vector(array_width_tb downto 0)>>;
    external_intermediate_weight <= << signal uut.intermediate_weight : std_logic_vector((array_width_tb+1)*N_tb-1 downto 0)>>;
    external_intermediate_psum <= << signal uut.intermediate_psum : std_logic_vector((array_width_tb+1)*N_tb-1 downto 0)>>;
    
    external_saved_weight_3 <= << signal uut.gen_pe(3).PE_entity.weight_mem : std_logic_vector(N_tb-1 downto 0)>>;
    external_saved_weight_2 <= << signal uut.gen_pe(2).PE_entity.weight_mem : std_logic_vector(N_tb-1 downto 0)>>;
    external_saved_weight_1 <= << signal uut.gen_pe(1).PE_entity.weight_mem : std_logic_vector(N_tb-1 downto 0)>>;
    external_saved_weight_0 <= << signal uut.gen_pe(0).PE_entity.weight_mem : std_logic_vector(N_tb-1 downto 0)>>;
    
    external_temp_weight_3 <= << signal uut.gen_pe(3).PE_entity.weight : std_logic_vector(N_tb-1 downto 0)>>;
    external_temp_weight_2 <= << signal uut.gen_pe(2).PE_entity.weight : std_logic_vector(N_tb-1 downto 0)>>;
    external_temp_weight_1 <= << signal uut.gen_pe(1).PE_entity.weight : std_logic_vector(N_tb-1 downto 0)>>;
    external_temp_weight_0 <= << signal uut.gen_pe(0).PE_entity.weight : std_logic_vector(N_tb-1 downto 0)>>;
    
    --external_weight <= << signal uut.weight : std_logic_vector(array_width_tb*N_tb-1 downto 0)>>;
    
    
    
    generate_sim_clock: process
    begin
    	clk_tb <= '1';
    	wait for CLOCK_PERIOD/2;
    	clk_tb <= '0';
    	wait for CLOCK_PERIOD/2;
    end process;
    
    
    stimuli: process
    
    begin
        
        
        wait for CLOCK_PERIOD;
        comp_en_tb <= '0';
        weight_en_tb <= '0';
        weight_w_en_in_tb <= '0';
        psum_in_tb <= "00000000";
        weight_in_tb <= X"00";
        
        wait for CLOCK_PERIOD;
        comp_en_tb <= '0';
        weight_en_tb <= '1';
        weight_w_en_in_tb <= '0';
        weight_in_tb <= X"01";
        
        
        wait for CLOCK_PERIOD;
        weight_w_en_in_tb <= '0';
        weight_in_tb <= X"02";
        
        
        wait for CLOCK_PERIOD;
        weight_w_en_in_tb <= '0';
        weight_en_tb <= '0';
        weight_in_tb <= X"03";
        
        
        wait for CLOCK_PERIOD;
        weight_en_tb <= '1';
        weight_w_en_in_tb <= '0';
        weight_in_tb <= X"04";
        
        
        
        wait for CLOCK_PERIOD;
        
        weight_w_en_in_tb <= '0';
        weight_in_tb <= X"05";
        
        input_in_tb <= X"02020202";
        
        
        wait for CLOCK_PERIOD;
        weight_w_en_in_tb <= '1';
        weight_in_tb <= X"06";
        weight_en_tb <= '0';
        
        comp_en_tb <= '1';
        input_in_tb <= X"02020202";
        --weight_in_tb <= "00000010";
        

        
        wait for CLOCK_PERIOD;        
        input_in_tb <= X"02020202";
        --weight_in_tb <= "00000010";
        weight_w_en_in_tb <= '0';
        
        
        
        

        wait for CLOCK_PERIOD;
        input_in_tb <= X"02020202";
        --weight_in_tb <= "00000010";
        
        wait for CLOCK_PERIOD;
        input_in_tb <= X"02020202";
        
        wait for CLOCK_PERIOD;
        input_in_tb <= X"02020202";
        
        wait for CLOCK_PERIOD;
        input_in_tb <= X"02020202";
        
        wait for CLOCK_PERIOD;
        input_in_tb <= X"02020202";
        
        wait for CLOCK_PERIOD;
        
        
        
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        wait for CLOCK_PERIOD;
        
        
        
        
        
        
        
    
    
    end process;

    

end Behavioral;
