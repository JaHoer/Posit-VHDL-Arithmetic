----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 13.09.2023 13:11:18
-- Design Name: 
-- Module Name: posit_mult - Behavioral
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

use ieee.math_real.all;

use ieee.std_logic_misc.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity posit_mult is
    generic (
        N : integer := 16;
        Bs : integer := 4;  -- log2(N)
        es : integer := 2
    );
    Port ( 
        in1 : in std_logic_vector(N-1 downto 0);
        in2 : in std_logic_vector(N-1 downto 0);
        start : in std_logic;
        out_val : out std_logic_vector(N-1 downto 0);
        inf : out std_logic;
        zero : out std_logic;
        done : out std_logic;
    
        -- Debug Outputs

        inf1_o : out std_logic;
        inf2_o : out std_logic;
        zero1_o : out std_logic;
        zero2_o : out std_logic;
    
        rc1_o : out std_logic;
        rc2_o : out std_logic;
        regime1_o : out std_logic_vector(Bs-1 downto 0); 
        regime2_o : out std_logic_vector(Bs-1 downto 0); 
        e1_o : out std_logic_vector(es-1 downto 0);
        e2_o : out std_logic_vector(es-1 downto 0);
        mant1_o : out std_logic_vector(N-es-1 downto 0); 
        mant2_o : out std_logic_vector(N-es-1 downto 0)
    );
end posit_mult;

architecture Behavioral of posit_mult is

    signal start0 : std_logic;
    signal s1 : std_logic;
    signal s2 : std_logic;
    signal zero_tmp1 : std_logic;
    signal zero_tmp2 : std_logic;
    signal inf1 : std_logic;
    signal inf2 : std_logic;
    signal zero1 : std_logic;
    signal zero2 : std_logic;
    signal inf_sig : std_logic;
    signal zero_sig : std_logic;
    
    -- Data Extraction
    signal rc1, rc2 : std_logic;
    signal regime1, regime2, Lshift1, Lshift2 : std_logic_vector(Bs-1 downto 0);
    signal e1, e2 : std_logic_vector(es-1 downto 0);
    signal mant1, mant2 : std_logic_vector(N-es-1 downto 0);
    
    
    signal xin1 : std_logic_vector(N-1 downto 0);
    signal xin2 : std_logic_vector(N-1 downto 0);
    
    
    component data_extract
        generic (
            N : integer;
            Bs : integer;
            es : integer
        );
        port (
            in_val : in std_logic_vector(N-1 downto 0);
            rc : out std_logic;
            regime : out std_logic_vector(Bs-1 downto 0);
            Lshift : out std_logic_vector(Bs-1 downto 0);
            exp : out std_logic_vector(es-1 downto 0);
            mant : out std_logic_vector(N-es-1 downto 0)
        );
    end component data_extract;
    
    
    signal m1, m2 : std_logic_vector(N-es downto 0);
    signal mult_s : std_logic;
    
    signal mult_m : std_logic_vector(2*(N-es)+1 downto 0);
    signal mult_m_ovf : std_logic;
    signal mult_m_ovf_v : std_logic_vector(0 downto 0);
    signal mult_mN : std_logic_vector(2*(N-es)+1 downto 0);
    
    signal r1 : std_logic_vector(Bs+1 downto 0);
    signal r2 : std_logic_vector(Bs+1 downto 0);
    signal mult_e : std_logic_vector(Bs+es+1 downto 0);
    
    signal mult_eN : std_logic_vector(es+Bs downto 0);
    signal e_o : std_logic_vector(es-1 downto 0);
    signal r_o : std_logic_vector(Bs downto 0);
    
    signal not_mult_e : std_logic_vector(N-1 downto 0);
    signal tmp_o : std_logic_vector(2*N-1 downto 0);
    
    signal tmp1_o : std_logic_vector(2*N-1 downto 0);
    signal r_o_dsr : std_logic_vector(Bs downto 0);
    
    signal tmp1_oN : std_logic_vector(2*N-1 downto 0);
    
    signal out_zeros : std_logic_vector(N-2 downto 0);
    
    

begin
    
    start0 <= start;
    s1 <= in1(N-1);
    s2 <= in2(N-1);
    zero_tmp1 <= or_reduce(in1(N-2 downto 0));
    zero_tmp2 <= or_reduce(in2(N-2 downto 0));
    inf1 <= s1 and (not zero_tmp1);
    inf2 <= s2 and (not zero_tmp2);
    zero1 <= not (s1 or zero_tmp1);
    zero2 <= not (s2 or zero_tmp2);
    inf_sig <= inf1 or inf2;
    zero_sig <= zero1 and zero2;

    -- For true sign bit, operands undergo 2's complement conversion which produces XIN1 and XIN2, each of N-1 bits (except the respective sign bit)
    -- XIN1 ? S1 ? -IN1[N -2 : 0] : IN1[N -2 : 0]

    -- xin1 = s1 ? -in1 : in1;      -- ???
    xin1 <= std_logic_vector( - signed(in1(N-1 downto 0))) when s1 = '1' else in1(N-1 downto 0);
    
    xin2 <= std_logic_vector( - signed(in2(N-1 downto 0))) when s2 = '1' else in2(N-1 downto 0);
    
    
    
    -- Data Extraction
    uut_de1 : data_extract
        generic map (
            N => N,
            Bs => Bs,
            es => es
        )
        port map (
            in_val => xin1,
            rc => rc1,
            regime => regime1,
            Lshift => Lshift1,
            exp => e1,
            mant => mant1
        );

    uut_de2 : data_extract
        generic map (
            N => N,
            Bs => Bs,
            es => es
        )
        port map (
            in_val => xin2,
            rc => rc2,
            regime => regime2,
            Lshift => Lshift2,
            exp => e2,
            mant => mant2
        );
        
    -- Sign, Exponent and Mantissa Computation
    
    m1 <= zero_tmp1 & mant1;
    m2 <= zero_tmp2 & mant2;
    
    mult_s <= s1 xnor s2;
    
    mult_m <= std_logic_vector(unsigned(m1) * unsigned(m2));
    
    -- check for overflow
    mult_m_ovf <= mult_m(2*(N-es)+1);
    
    mult_mN <= std_logic_vector(shift_left(unsigned(mult_m), 1)) when mult_m_ovf = '0' else mult_m;
    
    
    r1 <= ("00" & regime1) when rc1 = '1' else std_logic_vector(- signed(regime1));
    r1 <= ("00" & regime2) when rc2 = '1' else std_logic_vector(- signed(regime2));
    
    mult_m_ovf_v(0) <= mult_m_ovf;
    mult_e <= std_logic_vector(unsigned(r1 & e1) + unsigned(r2 & e2) + unsigned( mult_m_ovf_v));
    
    
    -- Exponent and Regime Computation
    
    mult_eN <= std_logic_vector(- signed(mult_e(es+Bs downto 0))) when mult_e(es+Bs+1) = '1' else mult_e(es+Bs downto 0);
    
    e_o <= mult_e(es-1 downto 0) when mult_e(es+Bs+1) = '1' and OR_REDUCE(mult_eN(es-1 downto 0)) = '1' else mult_eN(es-1 downto 0);
    
    r_o <= std_logic_vector(unsigned(mult_eN(es+Bs downto es)) + 1) when mult_e(es+Bs+1) = '0' or (mult_e(es+Bs+1)= '1' and OR_REDUCE(mult_eN(es-1 downto 0)) = '1') else mult_eN(es+Bs downto es); 
    
    
    
    -- Exponent and Mantissa Packing
    
    not_mult_e <= (others => not mult_e(es+Bs+1));
    
    tmp_o <= not_mult_e & mult_e(es+Bs+1) & e_o & mult_mN(2*(N-es) downto N-es+2);
    
    
    
    -- Including Regime bits in Exponent-Mantissa Packing
    
    r_o_dsr <= (others => '0') when r_o(Bs) = '1' else r_o;
    
    dsr2 : entity work.DSR_right_N_S
        generic map (
            N => 2*N,
            S => Bs+1
        )
        port map (
            a => tmp_o,
            b => r_o_dsr,
            c => tmp1_o
        );
        
    
    
    -- Final Output
    tmp1_oN <= std_logic_vector(- signed(tmp1_o)) when mult_s = '1' else tmp1_o;
    
    out_zeros <= (others => '0');
    out_val <= inf_sig & out_zeros when (inf_sig = '1' or zero_sig = '1') or mult_mN(2*(N-es)+1) = '0' else mult_s & tmp1_oN(N-1 downto 1);
    
    inf <= inf_sig;
    zero <= zero_sig;
    
    -- Debug Outputs
    
    inf1_o <= inf1;
    inf2_o <= inf2;
    zero1_o <= zero1;
    zero2_o <= zero2;
    
    rc1_o <= rc1;
    rc2_o <= rc2;
    regime1_o <= regime1;
    regime2_o <= regime2;
    e1_o <= e1;
    e2_o <= e2;
    mant1_o <= mant1;
    mant2_o <= mant2;
    
    
    
    
    

end Behavioral;
