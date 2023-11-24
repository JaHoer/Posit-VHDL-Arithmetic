----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 22.11.2023 11:58:50
-- Design Name: 
-- Module Name: tb_comp_extraction - Behavioral
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

entity tb_comp_extraction is
    generic (
        N_tb : integer := 8;
        Bs_tb : integer := 3; -- log2(N)
        es_tb : integer := 2
        
        -- Pipe_stages_tb : integer := 2      -- between 2 and 3 possible

    );
--  Port ( );
end tb_comp_extraction;

architecture Behavioral of tb_comp_extraction is
    constant CLOCK_PERIOD : time := 200 ns;
    
    signal clk_tb  : std_logic;
    
    signal operand_tb : STD_LOGIC_VECTOR (N_tb-2 downto 0);
    signal sign_tb : STD_LOGIC;
    signal exp_tb : STD_LOGIC_VECTOR (es_tb-1 downto 0);
    signal mant_tb : STD_LOGIC_VECTOR (N_tb-es_tb-1 downto 0);
    signal exp_eff_tb : STD_LOGIC_VECTOR (Bs_tb+es_tb downto 0);
    
    
    -- Debug
    signal operand_neg_tb : std_logic_vector(N_tb-2 downto 0);
    signal cone_tb : std_logic_vector(Bs_tb-1 downto 0);
    signal vo_tb : std_logic;
    signal czip_tb : std_logic_vector(Bs_tb-1 downto 0);
    signal vz_tb : std_logic;
    signal shift_rg_zip_tb : std_logic_vector(Bs_tb-1 downto 0);
    signal shift_rg_one_tb : std_logic_vector(Bs_tb-1 downto 0);
    signal shift_rg_tb : std_logic_vector(Bs_tb-1 downto 0);
    signal rg_zip_tb : std_logic_vector(Bs_tb downto 0);
    signal rg_one_tb : std_logic_vector(Bs_tb downto 0);
    signal rg_tb : std_logic_vector(Bs_tb downto 0);
    signal op_no_rg_tb : std_logic_vector(N_tb-2 downto 0);    

begin

    UUT : entity work.comp_extraction
    generic map (
        N => N_tb,
        Bs => Bs_tb,
        es => es_tb
        
        --Pipe_stages => Pipe_stages_tb
    )
    port map (
        clk => clk_tb,
        operand => operand_tb,
        sign => sign_tb,
        exp => exp_tb,
        mant => mant_tb,
        exp_eff => exp_eff_tb,
        
        operand_neg_o => operand_neg_tb,
        cone_o => cone_tb,
        vo_o => vo_tb,
        czip_o => czip_tb,
        vz_o => vz_tb,
        shift_rg_zip_o => shift_rg_zip_tb,
        shift_rg_one_o => shift_rg_one_tb,
        shift_rg_o => shift_rg_tb,
        rg_zip_o => rg_zip_tb,
        rg_one_o => rg_one_tb,
        rg_o => rg_tb,
        op_no_rg_o => op_no_rg_tb
    );
    
    
    
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
        
        operand_tb <= "0001011";
        sign_tb <= '0';
        
        wait for CLOCK_PERIOD;
        
    
    
    end process;


end Behavioral;
