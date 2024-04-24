----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 29.03.2024 09:38:01
-- Design Name: 
-- Module Name: posit_multiplier_r - Behavioral
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

entity posit_multiplier_r is
    generic (
        N : integer := 8;
        --Bs : integer := 3;  -- log2(N)
        es : integer := 2;
        pipeline_num : integer := 3
    );
    port ( 
        clk : in std_logic;
        enable : in std_logic;
        in1 : in std_logic_vector(N-1 downto 0);
        in2 : in std_logic_vector(N-1 downto 0);
        start : in std_logic;
        out_val : out std_logic_vector(N-1 downto 0);
        inf : out std_logic;
        zero : out std_logic;
        done : out std_logic
    

    );
end posit_multiplier_r;

architecture Behavioral of posit_multiplier_r is

    constant Bs : integer := integer(log2(real(N)));
    
    
    
    signal start0 : std_logic;
    signal start0_p2 : std_logic;
    signal start0_p3 : std_logic;
    signal start0_p4 : std_logic;
    signal s1 : std_logic;
    signal s2 : std_logic;
    signal zero_tmp1 : std_logic;
    signal zero_tmp2 : std_logic;
    signal inf1 : std_logic;
    signal inf2 : std_logic;
    signal zero1 : std_logic;
    signal zero2 : std_logic;
    signal inf_sig : std_logic;
    signal inf_sig_p2 : std_logic;
    signal inf_sig_p3 : std_logic;
    signal inf_sig_p4 : std_logic;
    signal zero_sig : std_logic;
    signal zero_sig_p2 : std_logic;
    signal zero_sig_p3 : std_logic;
    signal zero_sig_p4 : std_logic;
    
    
    
    -- Data Extraction
    signal rc1, rc2 : std_logic;
    signal regime1, regime2 : std_logic_vector(Bs-1 downto 0);
    signal e1, e2 : std_logic_vector(es-1 downto 0);
    signal mant1, mant2 : std_logic_vector(N-es-1 downto 0);
    
    signal rc1_p2, rc2_p2 : std_logic;
    signal regime1_p2, regime2_p2 : std_logic_vector(Bs-1 downto 0);
    signal e1_p2, e2_p2 : std_logic_vector(es-1 downto 0);
    
    
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
            exp : out std_logic_vector(es-1 downto 0);
            mant : out std_logic_vector(N-es-1 downto 0)
        );
    end component data_extract;
    
    
    signal m1, m2 : std_logic_vector(N-es downto 0);
    signal m1_p2, m2_p2 : std_logic_vector(N-es downto 0);      -- for 2nd pipeline stage
    signal mult_s : std_logic;
    signal mult_s_p2 : std_logic;
    signal mult_s_p3 : std_logic;
    signal mult_s_p4 : std_logic;
    
    signal mult_m : std_logic_vector(2*(N-es)+1 downto 0);
    signal mult_m_p3 : std_logic_vector(2*(N-es)+1 downto 0);   -- for 3rd pipeline stage
    
    signal mult_m_ovf : std_logic;
    signal mult_m_ovf_v : std_logic_vector(0 downto 0);
    signal mult_mN : std_logic_vector(2*(N-es)+1 downto 0);
    signal mult_mN_p4 : std_logic_vector(2*(N-es)+1 downto 0);     -- for 4th pipeline stage
    
    signal regime1_long_inv : std_logic_vector(Bs+1 downto 0);
    signal regime2_long_inv : std_logic_vector(Bs+1 downto 0);
    
    signal r1 : std_logic_vector(Bs+1 downto 0);
    signal r2 : std_logic_vector(Bs+1 downto 0);
    
    signal r1e1 : std_logic_vector(Bs+es+1 downto 0);
    signal r2e2 : std_logic_vector(Bs+es+1 downto 0);
    signal r1e1_p3 : std_logic_vector(Bs+es+1 downto 0);    -- for 3rd pipeline stage
    signal r2e2_p3 : std_logic_vector(Bs+es+1 downto 0);    -- for 3rd pipeline stage
    
    signal mult_e : std_logic_vector(Bs+es+1 downto 0);
    signal mult_e_p4 : std_logic_vector(Bs+es+1 downto 0);  -- for 4th pipeline stage
    
    signal mult_eN : std_logic_vector(es+Bs downto 0);
    signal e_o : std_logic_vector(es-1 downto 0);
    signal r_o : std_logic_vector(Bs downto 0);
    
    signal r_o_dsr_tmp : std_logic_vector(Bs downto 0);
    signal r_o_dsr : std_logic_vector(Bs downto 0);
    signal not_mult_e : std_logic_vector(N-1 downto 0);
    signal tmp_o : std_logic_vector(2*N+1 downto 0);        -- longer for rounding bits +2
    signal tmp1_o : std_logic_vector(2*N+1 downto 0);       -- longer for rounding bits +2
    signal tmp2_o : std_logic_vector(2*N-1 downto 0);
    
    signal tmp1_oN : std_logic_vector(2*N-1 downto 0);
    
    signal out_zeros : std_logic_vector(N-2 downto 0);
    
    signal lsb_bit    : std_logic;
    signal guard_bit  : std_logic;
    signal round_bit  : std_logic;
    signal sticky_bit : std_logic;
    signal edge_case  : std_logic;
    signal round      : std_logic;

    

    
    

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
            exp => e2,
            mant => mant2
        );
        
    -- Sign, Exponent and Mantissa Computation
    
    m1 <= zero_tmp1 & mant1;
    m2 <= zero_tmp2 & mant2;
    
    mult_s <= s1 xor s2;
    
    
    
    
    pipe_1 : if pipeline_num > 1 generate
    
        pipe_1_proc : process(clk)
        begin
            if rising_edge(clk) and enable = '1' then
            rc1_p2 <= rc1;
            rc2_p2 <= rc2;
            regime1_p2 <= regime1;
            regime2_p2 <= regime2;
            e1_p2 <= e1;
            e2_p2 <= e2;
            
            m1_p2 <= m1;
            m2_p2 <= m2;
            
            start0_p2 <= start0;
            mult_s_p2 <= mult_s;
            inf_sig_p2 <= inf_sig;
            zero_sig_p2 <= zero_sig;
            end if;
        
        end process;
    
    end generate;
    
    pipe_1_not : if pipeline_num <= 1 generate
    
        rc1_p2 <= rc1;
        rc2_p2 <= rc2;
        regime1_p2 <= regime1;
        regime2_p2 <= regime2;
        e1_p2 <= e1;
        e2_p2 <= e2;
        
        m1_p2 <= m1;
        m2_p2 <= m2;
           
        start0_p2 <= start0;
        mult_s_p2 <= mult_s;
        inf_sig_p2 <= inf_sig;
        zero_sig_p2 <= zero_sig;
 
    end generate;
    
    
    
    
    
    mult_m <= std_logic_vector(unsigned(m1_p2) * unsigned(m2_p2));

    regime1_long_inv <= std_logic_vector(resize(unsigned(regime1_p2), Bs + 2));  -- r1'length
    regime2_long_inv <= std_logic_vector(resize(unsigned(regime2_p2), Bs + 2));  -- r2'length

    r1 <= ("00" & regime1_p2) when rc1_p2 = '1' else std_logic_vector(- signed(regime1_long_inv));
    r2 <= ("00" & regime2_p2) when rc2_p2 = '1' else std_logic_vector(- signed(regime2_long_inv));
    
    r1e1 <= r1 & e1_p2;
    r2e2 <= r2 & e2_p2;
    
    
    
    
    
    
    
    
    pipe_2 : if pipeline_num > 0 generate
    
        pipe_1_proc : process(clk)
        begin
            if rising_edge(clk) and enable = '1' then
            mult_m_p3 <= mult_m;
            r1e1_p3 <= r1e1;
            r2e2_p3 <= r2e2;
            
            start0_p3 <= start0_p2;
            mult_s_p3 <= mult_s_p2;
            inf_sig_p3 <= inf_sig_p2;
            zero_sig_p3 <= zero_sig_p2;
            end if;
        end process;
    
    end generate;
    
    pipe_2_not : if pipeline_num <= 0 generate
        mult_m_p3 <= mult_m;
        r1e1_p3 <= r1e1;
        r2e2_p3 <= r2e2;
        
        start0_p3 <= start0_p2;
        mult_s_p3 <= mult_s_p2;
        inf_sig_p3 <= inf_sig_p2;
        zero_sig_p3 <= zero_sig_p2;
 
    end generate;
    
    
    
    
    
        -- check for overflow
    mult_m_ovf <= mult_m_p3(2*(N-es)+1);
    mult_m_ovf_v(0) <= mult_m_ovf;
    
    mult_mN <= std_logic_vector(shift_left(unsigned(mult_m_p3), 1)) when mult_m_ovf = '0' else mult_m_p3;
    
 
    mult_e <= std_logic_vector(unsigned(r1e1_p3) + unsigned(r2e2_p3) + unsigned( mult_m_ovf_v));
    
    
    
    
    
    
    pipe_3 : if pipeline_num > 2 generate
    
        pipe_1_proc : process(clk)
        begin
            if rising_edge(clk) and enable = '1' then
            mult_e_p4 <= mult_e;
            mult_mN_p4 <= mult_mN;

            start0_p4 <= start0_p3;
            mult_s_p4 <= mult_s_p3;
            inf_sig_p4 <= inf_sig_p3;
            zero_sig_p4 <= zero_sig_p3;
            end if;
        end process;
    
    end generate;
    
    pipe_3_not : if pipeline_num <= 2 generate
        mult_e_p4 <= mult_e;
        mult_mN_p4 <= mult_mN;

        start0_p4 <= start0_p3;
        mult_s_p4 <= mult_s_p3;
        inf_sig_p4 <= inf_sig_p3;
        zero_sig_p4 <= zero_sig_p3;
 
    end generate;
    
    
    
    
    
    
    
    -- Exponent and Regime Computation
    
    mult_eN <= std_logic_vector(- signed(mult_e_p4(es+Bs downto 0))) when mult_e_p4(es+Bs+1) = '1' else mult_e_p4(es+Bs downto 0);
  
    e_o <= mult_e_p4(es-1 downto 0) when mult_e_p4(es+Bs+1) = '1' and OR_REDUCE(mult_eN(es-1 downto 0)) = '1' else mult_eN(es-1 downto 0);
    
    r_o <= std_logic_vector(unsigned(mult_eN(es+Bs downto es)) + 1) when mult_e_p4(es+Bs+1) = '0' or (mult_e_p4(es+Bs+1)= '1' and OR_REDUCE(mult_eN(es-1 downto 0)) = '1') else mult_eN(es+Bs downto es); 
    
    
    
    -- Exponent and Mantissa Packing
    
    not_mult_e <= (others => not mult_e_p4(es+Bs+1));
    
    
    -- REM[2 ?N -1:0] ? {N{!Exp[E]},Exp[E],EO,MFP[N -2 : ES]}
    tmp_o <= not_mult_e & mult_e_p4(es+Bs+1) & e_o & mult_mN_p4(2*(N-es) downto N-es);
    
    
    
    -- Including Regime bits in Exponent-Mantissa Packing
    
    r_o_dsr_tmp <= (others => '1') when r_o(Bs) = '1' else r_o;
    r_o_dsr <= '0' & r_o_dsr_tmp(Bs-1 downto 0);
    
    tmp1_o <= std_logic_vector(shift_right(unsigned(tmp_o), to_integer(unsigned(r_o_dsr))));  
    
    
    -- Rounding
    lsb_bit    <= tmp1_o(3);
    guard_bit  <= tmp1_o(2);
    round_bit  <= tmp1_o(1);
    sticky_bit <= tmp1_o(0);
    edge_case <= or_reduce(tmp1_o(N+1 downto 3));  -- check if result would be rounded to zero
    round      <= (guard_bit and (lsb_bit or round_bit or sticky_bit)) or (not edge_case);



    tmp2_o <= std_logic_vector(unsigned(tmp1_o(2*N+1 downto 2)) + 1) when round = '1' 
              else tmp1_o(2*N+1 downto 2);
    -- end Rounding
    
    
    -- Final Output
    -- If (SFP == 1): REM ? (2's complement of REM)
    tmp1_oN <= std_logic_vector(- signed(tmp2_o)) when mult_s_p4 = '1' else tmp2_o;
    
    out_zeros <= (others => '0');
    -- Combine SFP with LSB (N-1) bit of REM
    out_val <= inf_sig_p4 & out_zeros when (inf_sig_p4 = '1' or zero_sig_p4 = '1') or mult_mN_p4(2*(N-es)+1) = '0' else mult_s_p4 & tmp1_oN(N-1 downto 1);
    
    inf <= inf_sig_p4;
    zero <= zero_sig_p4;
    
    done <= start0_p4;
    
    

end Behavioral;