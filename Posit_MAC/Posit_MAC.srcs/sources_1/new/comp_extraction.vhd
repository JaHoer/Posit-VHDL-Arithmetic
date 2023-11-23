----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 15.11.2023 11:30:54
-- Design Name: 
-- Module Name: comp_extraction - Behavioral
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
use ieee.std_logic_misc.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comp_extraction is
    generic (
        N : integer := 8;
        Bs : integer := 3;      -- round_up(log2(N-1))
        es : integer := 4
    
    -- Pipe_stages : integer := 3      -- between 2 and 3 possible
    );

    Port ( 
        clk : in STD_LOGIC;
        operand : in STD_LOGIC_VECTOR (N-2 downto 0);
        sign : in STD_LOGIC;
        exp : out STD_LOGIC_VECTOR (es-1 downto 0);
        mant : out STD_LOGIC_VECTOR (N-es-1 downto 0);
        exp_eff : out STD_LOGIC_VECTOR (Bs+es downto 0)
    );
           
end comp_extraction;

architecture Behavioral of comp_extraction is

    signal operand_LOD : std_logic_vector(N-2 downto 0);
    signal cone : std_logic_vector(Bs-1 downto 0);
    signal vo : std_logic;
    
    signal operand_LZD : std_logic_vector(N-2 downto 0);
    signal czip : std_logic_vector(Bs-1 downto 0);
    signal vz : std_logic;
    

    signal operand_neg : std_logic_vector(N-2 downto 0);
--    signal shift_rg_zip : std_logic_vector(Bs-1 downto 0);
--    signal shift_rg_one : std_logic_vector(Bs-1 downto 0);
--    signal shift_rg : std_logic_vector(Bs-1 downto 0);
--    signal rg_zip : std_logic_vector(Bs downto 0);
--    signal rg_one : std_logic_vector(Bs downto 0);
--    signal rg : std_logic_vector(Bs downto 0);
--    signal op_no_rg : std_logic_vector(N-2 downto 0);
--    signal exp_sig : std_logic_vector(es-1 downto 0);
--    signal zeros : std_logic_vector(es-1 downto 0);
    

begin
    
    comp_LOD : entity work.LOD_comb
        generic map (
            N => N,
            Bs => Bs,      -- log2(N)
            es => es
        )
        port map (
--            clk => clk,
            operand => operand_LOD,
            cone => cone,
            vo => vo
        );
       
    comp_LZD : entity work.LZD_comb
        generic map (
            N => N,
            Bs => Bs,      -- log2(N)
            es => es
        )
        port map (
--            clk => clk,
            operand => operand_LZD,
            czip => czip,
            vz => vz
        );    



    operand_neg <= std_logic_vector(- signed(operand)) when sign = '1' else operand;

--    if sign = '1' then
--                v_operand_neg := (not operand);
--            else
--                v_operand_neg := operand;
--            end if;
            
            
--### Entity call ### -------------------------------------------
            operand_LOD <= operand_neg;
            operand_LZD <= operand_neg;
    
    
    comp_extraction : process (clk)
        
        variable v_operand_neg : std_logic_vector(N-2 downto 0);
        variable v_shift_rg_zip : std_logic_vector(Bs-1 downto 0);
        variable v_shift_rg_one : std_logic_vector(Bs-1 downto 0);
        variable v_shift_rg : std_logic_vector(Bs-1 downto 0);
        variable v_rg_zip : std_logic_vector(Bs downto 0);
        variable v_rg_one : std_logic_vector(Bs downto 0);
        variable v_rg : std_logic_vector(Bs downto 0);
        variable v_op_no_rg : std_logic_vector(N-2 downto 0);
        variable v_exp : std_logic_vector(es-1 downto 0);
        variable v_zeros : std_logic_vector(es-1 downto 0);

    begin
        if rising_edge(clk) then
        
            
            
            if vz = '1' then            
                v_shift_rg_zip := std_logic_vector(unsigned(czip) + 1);
            else
                v_shift_rg_zip := czip;
            end if;
            
            if vo = '1' then
                v_shift_rg_one := std_logic_vector(unsigned(cone) + 1);
            else
                v_shift_rg_one := cone;
            end if;
            
            v_rg_zip := std_logic_vector(resize(unsigned(std_logic_vector(- signed(czip))), Bs+1));
            v_rg_one := std_logic_vector(resize(unsigned(cone) - 1, Bs+1));
            
            
            
            if v_operand_neg(N-2) = '1' then
                v_shift_rg := v_shift_rg_one;
                v_rg := v_rg_one;
            else
                v_shift_rg := v_shift_rg_zip;
                v_rg := v_rg_zip;
            end if;
            
            
            v_op_no_rg := std_logic_vector(shift_left(unsigned(v_operand_neg), to_integer(unsigned(v_shift_rg))));
            v_exp := v_op_no_rg(N-2 downto N-2-es+1);
            mant <= OR_REDUCE(operand(N-2 downto 0)) & v_op_no_rg(N-2-es downto 0);
            exp <= v_exp;
            
            v_zeros := (others => '0');
            exp_eff <= std_logic_vector(unsigned(v_exp) + unsigned(v_rg & v_zeros));
            
            
        
        end if;
    end process;
end Behavioral;

