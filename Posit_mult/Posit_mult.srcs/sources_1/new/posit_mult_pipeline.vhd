----------------------------------------------------------------------------------
-- Company: FAU
-- Engineer: Jan Hoertig
-- 
-- Create Date: 30.10.2023 10:08:10
-- Design Name: 
-- Module Name: posit_mult_pipeline - Behavioral
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

entity posit_mult_pipeline is
    generic (
        N : integer := 16;
        Bs : integer := 4;  -- log2(N)
        es : integer := 2;
        
        Pipe_stages : integer := 3      -- between 1 and 3 possible

    );
    Port ( 
        rst : in std_logic;
        clk : in std_logic;
    
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
        
        mult_s_o : out std_logic;
    
        rc1_o : out std_logic;
        rc2_o : out std_logic;
        regime1_o : out std_logic_vector(Bs-1 downto 0); 
        regime2_o : out std_logic_vector(Bs-1 downto 0); 
        e1_o : out std_logic_vector(es-1 downto 0);
        e2_o : out std_logic_vector(es-1 downto 0);
        mant1_o : out std_logic_vector(N-es-1 downto 0); 
        mant2_o : out std_logic_vector(N-es-1 downto 0);
        
        m1_o : out std_logic_vector(N-es downto 0);
        m2_o : out std_logic_vector(N-es downto 0);
        r1_o : out std_logic_vector(Bs+1 downto 0);
        r2_o : out std_logic_vector(Bs+1 downto 0);
        
        r1e1_o : out std_logic_vector(Bs+es+1 downto 0);
        r2e2_o : out std_logic_vector(Bs+es+1 downto 0);
        
        mult_m_o : out std_logic_vector(2*(N-es)+1 downto 0);
        mult_e_o : out std_logic_vector(Bs+es+1 downto 0);
        
        e_o_o : out std_logic_vector(es-1 downto 0);
        r_o_o : out std_logic_vector(Bs downto 0);
        tmp_o_o : out std_logic_vector(2*N-1 downto 0);
        tmp1_o_o : out std_logic_vector(2*N-1 downto 0);
        r_o_dsr_o : out std_logic_vector(Bs downto 0);
        tmp1_oN_o : out std_logic_vector(2*N-1 downto 0)

    );
end posit_mult_pipeline;

architecture Behavioral of posit_mult_pipeline is

    signal start0 : std_logic;
--    signal s1 : std_logic;
--    signal s2 : std_logic;
    signal zero_tmp1 : std_logic;
    signal zero_tmp2 : std_logic;
--    signal inf1 : std_logic;
--    signal inf2 : std_logic;
--    signal zero1 : std_logic;
--    signal zero2 : std_logic;
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
    
    
--    signal m1, m2 : std_logic_vector(N-es downto 0);
--    signal mult_s : std_logic;
    signal mult_s_p2 : std_logic;
    signal mult_s_p3 : std_logic;
    signal mult_s_p4 : std_logic;
    
--    signal mult_m : std_logic_vector(2*(N-es)+1 downto 0);
    signal mult_m_p3 : std_logic_vector(2*(N-es)+1 downto 0);
--    signal mult_m_ovf : std_logic;
--    signal mult_m_ovf_v : std_logic_vector(0 downto 0);
--    signal mult_mN : std_logic_vector(2*(N-es)+1 downto 0);
    signal mult_mN_p4 : std_logic_vector(2*(N-es)+1 downto 0);
    
--    signal regime1_long_inv : std_logic_vector(Bs+1 downto 0);
--    signal regime2_long_inv : std_logic_vector(Bs+1 downto 0);
    
--    signal r1 : std_logic_vector(Bs+1 downto 0);
--    signal r2 : std_logic_vector(Bs+1 downto 0);
    
--    signal r1e1 : std_logic_vector(Bs+es+1 downto 0);
    signal r1e1_p3 : std_logic_vector(Bs+es+1 downto 0);
--    signal r2e2 : std_logic_vector(Bs+es+1 downto 0);
    signal r2e2_p3 : std_logic_vector(Bs+es+1 downto 0);
    
--    signal mult_e : std_logic_vector(Bs+es+1 downto 0);
    signal mult_e_p4 : std_logic_vector(Bs+es+1 downto 0);
    
--    signal mult_eN : std_logic_vector(es+Bs downto 0);
--    signal e_o : std_logic_vector(es-1 downto 0);
--    signal r_o : std_logic_vector(Bs downto 0);
    
--    signal not_mult_e : std_logic_vector(N-1 downto 0);
--    signal tmp_o : std_logic_vector(2*N-1 downto 0);
    
--    signal tmp1_o : std_logic_vector(2*N-1 downto 0);
--    signal r_o_dsr_tmp : std_logic_vector(Bs downto 0);
--    signal r_o_dsr : std_logic_vector(Bs downto 0);
    
--    signal tmp1_oN : std_logic_vector(2*N-1 downto 0);
    
--    signal out_zeros : std_logic_vector(N-2 downto 0);
    
    

begin
    
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
        

    
    --#####################################################################################--
    -- with 3 Pipeline stages
    max_Pipeline : if Pipe_stages >= 3 generate
    
    data_extract_p : process (clk)
    
        variable v_start0 : std_logic;
        variable v_s1 : std_logic;
        variable v_s2 : std_logic;
        variable v_zero_tmp1 : std_logic;
        variable v_zero_tmp1_p2 : std_logic;     -- second Pipeline Stage        
        variable v_zero_tmp2 : std_logic;
        variable v_zero_tmp2_p2 : std_logic;     -- second Pipeline Stage
        variable v_inf1 : std_logic;
        variable v_inf2 : std_logic;
        variable v_zero1 : std_logic;
        variable v_zero2 : std_logic;
        variable v_inf_sig : std_logic;
        variable v_inf_sig_p2 : std_logic;      -- 2nd Pipeline Stage
        variable v_inf_sig_p3 : std_logic;      -- 3rd Pipeline Stage
        variable v_inf_sig_p4 : std_logic;      -- 4th Pipeline Stage
        variable v_zero_sig : std_logic;
        variable v_zero_sig_p2 : std_logic;     -- 2nd Pipeline Stage
        variable v_zero_sig_p3 : std_logic;     -- 3rd Pipeline Stage
        variable v_zero_sig_p4 : std_logic;     -- 4th Pipeline Stage
    
        -- Data Extraction
        variable v_rc1, v_rc2 : std_logic;
        variable v_regime1, v_regime2, v_Lshift1, v_Lshift2 : std_logic_vector(Bs-1 downto 0);
        variable v_e1, v_e2 : std_logic_vector(es-1 downto 0);
        variable v_mant1, v_mant2 : std_logic_vector(N-es-1 downto 0);
    
    
        variable v_xin1 : std_logic_vector(N-1 downto 0);
        variable v_xin2 : std_logic_vector(N-1 downto 0);
        
        variable v_m1, v_m2 : std_logic_vector(N-es downto 0);
        variable v_mult_s : std_logic;
        variable v_mult_s_p2 : std_logic;    -- 2nd Pipeline Stage
        variable v_mult_s_p3 : std_logic;    -- 3rd Pipeline Stage
        variable v_mult_s_p4 : std_logic;    -- 4th Pipeline Stage
    
        variable v_mult_m : std_logic_vector(2*(N-es)+1 downto 0);
        variable v_mult_m_p3 : std_logic_vector(2*(N-es)+1 downto 0);   -- for 3rd Pipeline Stage
        variable v_mult_m_ovf : std_logic;
        variable v_mult_m_ovf_v : std_logic_vector(0 downto 0);
        variable v_mult_mN : std_logic_vector(2*(N-es)+1 downto 0);
        variable v_mult_mN_p4 : std_logic_vector(2*(N-es)+1 downto 0);  -- for 4th Pipeline Stage
    
        variable v_regime1_long_inv : std_logic_vector(Bs+1 downto 0);
        variable v_regime2_long_inv : std_logic_vector(Bs+1 downto 0);
    
        variable v_r1 : std_logic_vector(Bs+1 downto 0);
        variable v_r2 : std_logic_vector(Bs+1 downto 0);
    
        variable v_r1e1 : std_logic_vector(Bs+es+1 downto 0);
        variable v_r1e1_p3 : std_logic_vector(Bs+es+1 downto 0);        -- for 3rd Pipeline Stage
        variable v_r2e2 : std_logic_vector(Bs+es+1 downto 0);
        variable v_r2e2_p3 : std_logic_vector(Bs+es+1 downto 0);        -- for 3rd Pipeline Stage
    
        variable v_mult_e : std_logic_vector(Bs+es+1 downto 0);
        variable v_mult_e_p4 : std_logic_vector(Bs+es+1 downto 0);      -- for 4th Pipeline Stage
    
        variable v_mult_eN : std_logic_vector(es+Bs downto 0);
        variable v_e_o : std_logic_vector(es-1 downto 0);
        variable v_r_o : std_logic_vector(Bs downto 0);
    
        variable v_not_mult_e : std_logic_vector(N-1 downto 0);
        variable v_tmp_o : std_logic_vector(2*N-1 downto 0);
    
        variable v_tmp1_o : std_logic_vector(2*N-1 downto 0);
        variable v_r_o_dsr_tmp : std_logic_vector(Bs downto 0);
        variable v_r_o_dsr : std_logic_vector(Bs downto 0);
    
        variable v_tmp1_oN : std_logic_vector(2*N-1 downto 0);
    
        variable v_out_zeros : std_logic_vector(N-2 downto 0);
    
    
    begin
    if rst = '1' then

        zero_tmp1 <= '0';
        zero_tmp2 <= '0';
        inf_sig <= '0';
        inf_sig_p2 <= '0';
        inf_sig_p3 <= '0';
        inf_sig_p4 <= '0';
        zero_sig <= '0';
        zero_sig_p2 <= '0';
        zero_sig_p3 <= '0';
        zero_sig_p4 <= '0';
    
--        rc1 <= '0'; 
--        rc2 <= '0';
--        regime1 <= (others => '0'); 
--        regime2 <= (others => '0');
--        e1 <= (others => '0');
--        e2 <= (others => '0');
--        mant1 <= (others => '0');
--        mant2 <= (others => '0');
        
        xin1 <= (others => '0');
        xin2 <= (others => '0');
        mult_s_p2 <= '0';
        mult_s_p3 <= '0';
        mult_s_p4 <= '0';
        mult_m_p3 <= (others => '0');
        mult_mN_p4 <= (others => '0');
        r1e1_p3 <= (others => '0');
        r2e2_p3 <= (others => '0');
        mult_e_p4 <= (others => '0');
    
    elsif rising_edge(clk) then
    
    v_start0 := start;
    v_s1 := in1(N-1);
    v_s2 := in2(N-1);
    v_zero_tmp1 := or_reduce(in1(N-2 downto 0));
    v_zero_tmp2 := or_reduce(in2(N-2 downto 0));
    v_inf1 := v_s1 and (not v_zero_tmp1);
    v_inf2 := v_s2 and (not v_zero_tmp2);
    v_zero1 := not (v_s1 or v_zero_tmp1);
    v_zero2 := not (v_s2 or v_zero_tmp2);
    v_inf_sig := v_inf1 or v_inf2;
    v_zero_sig := v_zero1 and v_zero2;


    -- xin1
    if v_s1 = '1' then
        xin1 <= std_logic_vector( - signed(in1(N-1 downto 0)));
    else
        xin1 <= in1(N-1 downto 0);
    end if;
    
    
    -- xin2
    if v_s2 = '1' then
        xin2 <= std_logic_vector( - signed(in2(N-1 downto 0)));
    else
        xin2 <= in2(N-1 downto 0);
    end if;
    

    -- Subcomponent Output in Variable
    v_rc1 := rc1;
    v_regime1 := regime1;
    v_e1 := e1;
    v_mant1 := mant1;
    
    v_rc2 := rc2;
    v_regime2 := regime2;
    v_e2 := e2;
    v_mant2 := mant2;
    
    
    v_mult_s := v_s1 xor v_s2;
    
    --------------------------------------------------------------------------
    -- Pipeline stage for synchronisation with data_extract
    mult_s_p2 <= v_mult_s;
    zero_tmp1 <= v_zero_tmp1;
    zero_tmp2 <= v_zero_tmp2;
    inf_sig_p2 <= v_inf_sig;
    zero_sig_p2 <= v_zero_sig;
    
    
    v_mult_s_p2 := mult_s_p2;
    v_zero_tmp1_p2 := zero_tmp1;
    v_zero_tmp2_p2 := zero_tmp2;
    --v_inf_sig_p2 := inf_sig_p2;
    --v_zero_sig_p2 := zero_sig_p2;
    --------------------------------------------------------------------------

    v_regime1_long_inv := std_logic_vector(resize(unsigned(v_regime1), Bs + 2));  -- r1'length
    v_regime2_long_inv := std_logic_vector(resize(unsigned(v_regime2), Bs + 2));  -- r2'length
    

    -- r1
    if v_rc1 = '1' then
        v_r1 := ("00" & v_regime1);
    else
        v_r1 := std_logic_vector(- signed(v_regime1_long_inv));
    end if;
    
    -- r2
    if v_rc2 = '1' then
        v_r2 := ("00" & v_regime2);
    else
        v_r2 := std_logic_vector(- signed(v_regime2_long_inv));
    end if;
    
    v_r1e1 := v_r1 & v_e1;
    v_r2e2 := v_r2 & v_e2;
    
    
    v_m1 := v_zero_tmp1_p2 & v_mant1;
    v_m2 := v_zero_tmp2_p2 & v_mant2;
    
    v_mult_m := std_logic_vector(unsigned(v_m1) * unsigned(v_m2));
    
    --------------------------------------------------------------------------
    -- Pipeline Stage 2
    mult_m_p3 <= v_mult_m;
    r1e1_p3 <= v_r1e1;
    r2e2_p3 <= v_r2e2;
    mult_s_p3 <= mult_s_p2;
    inf_sig_p3 <= inf_sig_p2;
    zero_sig_p3 <= zero_sig_p2;


    v_mult_m_p3 := mult_m_p3;
    v_r1e1_p3 := r1e1_p3;
    v_r2e2_p3 := r2e2_p3;
    --------------------------------------------------------------------------

    -- check for overflow
    v_mult_m_ovf := v_mult_m_p3(2*(N-es)+1);
    
    --mult_mN
    if v_mult_m_ovf = '0' then
        v_mult_mN := std_logic_vector(shift_left(unsigned(v_mult_m_p3), 1));
    else
        v_mult_mN := v_mult_m_p3;
    end if;
    
    
    
    
    v_mult_m_ovf_v(0) := v_mult_m_ovf;
    
    v_mult_e := std_logic_vector(unsigned(v_r1e1_p3) + unsigned(v_r2e2_p3) + unsigned( v_mult_m_ovf_v));
    
    --------------------------------------------------------------------------
    -- Pipeline Stage 3
    mult_mN_p4 <= v_mult_mN;
    mult_e_p4 <= v_mult_e;
    mult_s_p4 <= mult_s_p3;
    inf_sig_p4 <= inf_sig_p3;
    zero_sig_p4 <= zero_sig_p3;
    
    
    v_mult_mN_p4 := mult_mN_p4;
    v_mult_e_p4 := mult_e_p4;
    v_mult_s_p4 := mult_s_p4;
    v_inf_sig_p4 := inf_sig_p4;
    v_zero_sig_p4 := zero_sig_p4;
    --------------------------------------------------------------------------
    
    -- Exponent and Regime Computation
    
    -- mult_eN
    if v_mult_e_p4(es +Bs+1) = '1' then
        v_mult_eN := std_logic_vector(- signed(v_mult_e_p4(es+Bs downto 0)));
    else
        v_mult_eN := v_mult_e_p4(es+Bs downto 0);
    end if;
    
    
    -- e_o
    if v_mult_e_p4(es+Bs+1) = '1' and OR_REDUCE(v_mult_eN(es-1 downto 0)) = '1' then
        v_e_o := v_mult_e_p4(es-1 downto 0);
    else
        v_e_o := v_mult_eN(es-1 downto 0);
    end if;
    
    
    -- r_o
    if v_mult_e_p4(es+Bs+1) = '0' or (v_mult_e_p4(es+Bs+1)= '1' and OR_REDUCE(v_mult_eN(es-1 downto 0)) = '1') then
        v_r_o := std_logic_vector(unsigned(v_mult_eN(es+Bs downto es)) + 1);
    else
        v_r_o := v_mult_eN(es+Bs downto es); 
    end if;
    
    
    -- Exponent and Mantissa Packing
    
    v_not_mult_e := (others => not v_mult_e_p4(es+Bs+1));
    
    v_tmp_o := v_not_mult_e & v_mult_e_p4(es+Bs+1) & v_e_o & v_mult_mN_p4(2*(N-es) downto N-es+2);
    
    
    -- Including Regime bits in Exponent-Mantissa Packing
    
    -- r_o_dsr_tmp
    if v_r_o(Bs) = '1' then
        v_r_o_dsr_tmp := (others => '1');
    else
        v_r_o_dsr_tmp := v_r_o;
    end if;
    
    v_r_o_dsr := '0' & v_r_o_dsr_tmp(Bs-1 downto 0);
    
    v_tmp1_o := std_logic_vector(shift_right(unsigned(v_tmp_o), to_integer(unsigned(v_r_o_dsr))));  
    
    
    -- Final Output
    
    --tmp1_oN
    if v_mult_s_p4 = '1' then
        v_tmp1_oN := std_logic_vector(- signed(v_tmp1_o));
    else
        v_tmp1_oN := v_tmp1_o;
    end if;
    
    v_out_zeros := (others => '0');
    
    -- Combine SFP with LSB (N-1) bit of REM
    --out_val
    if (v_inf_sig_p4 = '1' or v_zero_sig_p4 = '1') or v_mult_mN_p4(2*(N-es)+1) = '0' then
        out_val <= v_inf_sig_p4 & v_out_zeros;
    else
        out_val <= v_mult_s_p4 & v_tmp1_oN(N-1 downto 1);
    end if;
    
    inf <= v_inf_sig_p4;
    zero <= v_zero_sig_p4;
    
    done <= '1';
    
    
    
    -- Debug Outputs
    
    inf1_o <= v_inf1;
    inf2_o <= v_inf2;
    zero1_o <= v_zero1;
    zero2_o <= v_zero2;
    
    mult_s_o <= v_mult_s_p2;
    
    rc1_o <= v_rc1;
    rc2_o <= v_rc2;
    regime1_o <= v_regime1;
    regime2_o <= v_regime2;
    e1_o <= v_e1;
    e2_o <= v_e2;
    mant1_o <= v_mant1;
    mant2_o <= v_mant2;
    
    m1_o <= v_m1;
    m2_o <= v_m2;
    r1_o <= v_r1;
    r2_o <= v_r2;
    
    r1e1_o <= v_r1e1;
    r2e2_o <= v_r2e2;
    
    mult_m_o <= v_mult_m;
    mult_e_o <= v_mult_e;
    e_o_o <= v_e_o;
    r_o_o <= v_r_o;
    tmp_o_o <= v_tmp_o;
    tmp1_o_o <= v_tmp1_o;
    r_o_dsr_o <= v_r_o_dsr;
    tmp1_oN_o <= v_tmp1_oN;
    
    
    end if;
    end process;
    
    end generate;
    
    
    --#####################################################################################--
    -- with 2 Pipeline stages
    two_pipeline_stages : if Pipe_stages = 2 generate
    
    data_extract_p : process (clk)
    
        variable v_start0 : std_logic;
        variable v_s1 : std_logic;
        variable v_s2 : std_logic;
        variable v_zero_tmp1 : std_logic;
        variable v_zero_tmp1_p2 : std_logic;     -- second Pipeline Stage        
        variable v_zero_tmp2 : std_logic;
        variable v_zero_tmp2_p2 : std_logic;     -- second Pipeline Stage
        variable v_inf1 : std_logic;
        variable v_inf2 : std_logic;
        variable v_zero1 : std_logic;
        variable v_zero2 : std_logic;
        variable v_inf_sig : std_logic;
        variable v_inf_sig_p2 : std_logic;      -- 2nd Pipeline Stage
        variable v_inf_sig_p3 : std_logic;      -- 3rd Pipeline Stage
        variable v_inf_sig_p4 : std_logic;      -- 4th Pipeline Stage
        variable v_zero_sig : std_logic;
        variable v_zero_sig_p2 : std_logic;     -- 2nd Pipeline Stage
        variable v_zero_sig_p3 : std_logic;     -- 3rd Pipeline Stage
        variable v_zero_sig_p4 : std_logic;     -- 4th Pipeline Stage
    
        -- Data Extraction
        variable v_rc1, v_rc2 : std_logic;
        variable v_regime1, v_regime2, v_Lshift1, v_Lshift2 : std_logic_vector(Bs-1 downto 0);
        variable v_e1, v_e2 : std_logic_vector(es-1 downto 0);
        variable v_mant1, v_mant2 : std_logic_vector(N-es-1 downto 0);
    
    
        variable v_xin1 : std_logic_vector(N-1 downto 0);
        variable v_xin2 : std_logic_vector(N-1 downto 0);
        
        variable v_m1, v_m2 : std_logic_vector(N-es downto 0);
        variable v_mult_s : std_logic;
        variable v_mult_s_p2 : std_logic;    -- 2nd Pipeline Stage
        variable v_mult_s_p3 : std_logic;    -- 3rd Pipeline Stage
        variable v_mult_s_p4 : std_logic;    -- 4th Pipeline Stage
    
        variable v_mult_m : std_logic_vector(2*(N-es)+1 downto 0);
        variable v_mult_m_p3 : std_logic_vector(2*(N-es)+1 downto 0);   -- for 3rd Pipeline Stage
        variable v_mult_m_ovf : std_logic;
        variable v_mult_m_ovf_v : std_logic_vector(0 downto 0);
        variable v_mult_mN : std_logic_vector(2*(N-es)+1 downto 0);
        variable v_mult_mN_p4 : std_logic_vector(2*(N-es)+1 downto 0);  -- for 4th Pipeline Stage
    
        variable v_regime1_long_inv : std_logic_vector(Bs+1 downto 0);
        variable v_regime2_long_inv : std_logic_vector(Bs+1 downto 0);
    
        variable v_r1 : std_logic_vector(Bs+1 downto 0);
        variable v_r2 : std_logic_vector(Bs+1 downto 0);
    
        variable v_r1e1 : std_logic_vector(Bs+es+1 downto 0);
        variable v_r1e1_p3 : std_logic_vector(Bs+es+1 downto 0);        -- for 3rd Pipeline Stage
        variable v_r2e2 : std_logic_vector(Bs+es+1 downto 0);
        variable v_r2e2_p3 : std_logic_vector(Bs+es+1 downto 0);        -- for 3rd Pipeline Stage
    
        variable v_mult_e : std_logic_vector(Bs+es+1 downto 0);
        variable v_mult_e_p4 : std_logic_vector(Bs+es+1 downto 0);      -- for 4th Pipeline Stage
    
        variable v_mult_eN : std_logic_vector(es+Bs downto 0);
        variable v_e_o : std_logic_vector(es-1 downto 0);
        variable v_r_o : std_logic_vector(Bs downto 0);
    
        variable v_not_mult_e : std_logic_vector(N-1 downto 0);
        variable v_tmp_o : std_logic_vector(2*N-1 downto 0);
    
        variable v_tmp1_o : std_logic_vector(2*N-1 downto 0);
        variable v_r_o_dsr_tmp : std_logic_vector(Bs downto 0);
        variable v_r_o_dsr : std_logic_vector(Bs downto 0);
    
        variable v_tmp1_oN : std_logic_vector(2*N-1 downto 0);
    
        variable v_out_zeros : std_logic_vector(N-2 downto 0);
    
    
    begin
    if rst = '1' then

        zero_tmp1 <= '0';
        zero_tmp2 <= '0';
        inf_sig <= '0';
        inf_sig_p2 <= '0';
        inf_sig_p3 <= '0';
        inf_sig_p4 <= '0';
        zero_sig <= '0';
        zero_sig_p2 <= '0';
        zero_sig_p3 <= '0';
        zero_sig_p4 <= '0';
    
--        rc1 <= '0'; 
--        rc2 <= '0';
--        regime1 <= (others => '0'); 
--        regime2 <= (others => '0');
--        e1 <= (others => '0');
--        e2 <= (others => '0');
--        mant1 <= (others => '0');
--        mant2 <= (others => '0');
        
        xin1 <= (others => '0');
        xin2 <= (others => '0');
        mult_s_p2 <= '0';
        mult_s_p3 <= '0';
        mult_s_p4 <= '0';
        mult_m_p3 <= (others => '0');
        mult_mN_p4 <= (others => '0');
        r1e1_p3 <= (others => '0');
        r2e2_p3 <= (others => '0');
        mult_e_p4 <= (others => '0');
    
    elsif rising_edge(clk) then
    
    v_start0 := start;
    v_s1 := in1(N-1);
    v_s2 := in2(N-1);
    v_zero_tmp1 := or_reduce(in1(N-2 downto 0));
    v_zero_tmp2 := or_reduce(in2(N-2 downto 0));
    v_inf1 := v_s1 and (not v_zero_tmp1);
    v_inf2 := v_s2 and (not v_zero_tmp2);
    v_zero1 := not (v_s1 or v_zero_tmp1);
    v_zero2 := not (v_s2 or v_zero_tmp2);
    v_inf_sig := v_inf1 or v_inf2;
    v_zero_sig := v_zero1 and v_zero2;


    -- xin1
    if v_s1 = '1' then
        xin1 <= std_logic_vector( - signed(in1(N-1 downto 0)));
    else
        xin1 <= in1(N-1 downto 0);
    end if;
    
    
    -- xin2
    if v_s2 = '1' then
        xin2 <= std_logic_vector( - signed(in2(N-1 downto 0)));
    else
        xin2 <= in2(N-1 downto 0);
    end if;
    

    -- Subcomponent Output in Variable
    v_rc1 := rc1;
    v_regime1 := regime1;
    v_e1 := e1;
    v_mant1 := mant1;
    
    v_rc2 := rc2;
    v_regime2 := regime2;
    v_e2 := e2;
    v_mant2 := mant2;
    
    
    v_mult_s := v_s1 xor v_s2;
    
    --------------------------------------------------------------------------
    -- Pipeline stage for synchronisation with data_extract
    mult_s_p2 <= v_mult_s;
    zero_tmp1 <= v_zero_tmp1;
    zero_tmp2 <= v_zero_tmp2;
    inf_sig_p2 <= v_inf_sig;
    zero_sig_p2 <= v_zero_sig;
    
    
    v_mult_s_p2 := mult_s_p2;
    v_zero_tmp1_p2 := zero_tmp1;
    v_zero_tmp2_p2 := zero_tmp2;
    --v_inf_sig_p2 := inf_sig_p2;
    --v_zero_sig_p2 := zero_sig_p2;
    --------------------------------------------------------------------------

    v_regime1_long_inv := std_logic_vector(resize(unsigned(v_regime1), Bs + 2));  -- r1'length
    v_regime2_long_inv := std_logic_vector(resize(unsigned(v_regime2), Bs + 2));  -- r2'length
    

    -- r1
    if v_rc1 = '1' then
        v_r1 := ("00" & v_regime1);
    else
        v_r1 := std_logic_vector(- signed(v_regime1_long_inv));
    end if;
    
    -- r2
    if v_rc2 = '1' then
        v_r2 := ("00" & v_regime2);
    else
        v_r2 := std_logic_vector(- signed(v_regime2_long_inv));
    end if;
    
    v_r1e1 := v_r1 & v_e1;
    v_r2e2 := v_r2 & v_e2;
    
    
    v_m1 := v_zero_tmp1_p2 & v_mant1;
    v_m2 := v_zero_tmp2_p2 & v_mant2;
    
    v_mult_m := std_logic_vector(unsigned(v_m1) * unsigned(v_m2));
    
    --------------------------------------------------------------------------
    -- Pipeline Stage 2
    mult_m_p3 <= v_mult_m;
    r1e1_p3 <= v_r1e1;
    r2e2_p3 <= v_r2e2;
    mult_s_p3 <= mult_s_p2;
    inf_sig_p3 <= inf_sig_p2;
    zero_sig_p3 <= zero_sig_p2;


    v_mult_m_p3 := mult_m_p3;
    v_r1e1_p3 := r1e1_p3;
    v_r2e2_p3 := r2e2_p3;
    --------------------------------------------------------------------------

    -- check for overflow
    v_mult_m_ovf := v_mult_m_p3(2*(N-es)+1);
    
    --mult_mN
    if v_mult_m_ovf = '0' then
        v_mult_mN := std_logic_vector(shift_left(unsigned(v_mult_m_p3), 1));
    else
        v_mult_mN := v_mult_m_p3;
    end if;
    
    
    
    
    v_mult_m_ovf_v(0) := v_mult_m_ovf;
    
    v_mult_e := std_logic_vector(unsigned(v_r1e1_p3) + unsigned(v_r2e2_p3) + unsigned( v_mult_m_ovf_v));
    
    --------------------------------------------------------------------------
    -- Pipeline Stage 3 
    -- NOT USED !!!

    v_mult_mN_p4 := v_mult_mN;
    v_mult_e_p4 := v_mult_e;
    v_mult_s_p4 := mult_s_p3;
    v_inf_sig_p4 := inf_sig_p3;
    v_zero_sig_p4 := zero_sig_p3;
    --------------------------------------------------------------------------
    
    -- Exponent and Regime Computation
    
    -- mult_eN
    if v_mult_e_p4(es +Bs+1) = '1' then
        v_mult_eN := std_logic_vector(- signed(v_mult_e_p4(es+Bs downto 0)));
    else
        v_mult_eN := v_mult_e_p4(es+Bs downto 0);
    end if;
    
    
    -- e_o
    if v_mult_e_p4(es+Bs+1) = '1' and OR_REDUCE(v_mult_eN(es-1 downto 0)) = '1' then
        v_e_o := v_mult_e_p4(es-1 downto 0);
    else
        v_e_o := v_mult_eN(es-1 downto 0);
    end if;
    
    
    -- r_o
    if v_mult_e_p4(es+Bs+1) = '0' or (v_mult_e_p4(es+Bs+1)= '1' and OR_REDUCE(v_mult_eN(es-1 downto 0)) = '1') then
        v_r_o := std_logic_vector(unsigned(v_mult_eN(es+Bs downto es)) + 1);
    else
        v_r_o := v_mult_eN(es+Bs downto es); 
    end if;
    
    
    -- Exponent and Mantissa Packing
    
    v_not_mult_e := (others => not v_mult_e_p4(es+Bs+1));
    
    v_tmp_o := v_not_mult_e & v_mult_e_p4(es+Bs+1) & v_e_o & v_mult_mN_p4(2*(N-es) downto N-es+2);
    
    
    -- Including Regime bits in Exponent-Mantissa Packing
    
    -- r_o_dsr_tmp
    if v_r_o(Bs) = '1' then
        v_r_o_dsr_tmp := (others => '1');
    else
        v_r_o_dsr_tmp := v_r_o;
    end if;
    
    v_r_o_dsr := '0' & v_r_o_dsr_tmp(Bs-1 downto 0);
    
    v_tmp1_o := std_logic_vector(shift_right(unsigned(v_tmp_o), to_integer(unsigned(v_r_o_dsr))));  
    
    
    -- Final Output
    
    --tmp1_oN
    if v_mult_s_p4 = '1' then
        v_tmp1_oN := std_logic_vector(- signed(v_tmp1_o));
    else
        v_tmp1_oN := v_tmp1_o;
    end if;
    
    v_out_zeros := (others => '0');
    
    -- Combine SFP with LSB (N-1) bit of REM
    --out_val
    if (v_inf_sig_p4 = '1' or v_zero_sig_p4 = '1') or v_mult_mN_p4(2*(N-es)+1) = '0' then
        out_val <= v_inf_sig_p4 & v_out_zeros;
    else
        out_val <= v_mult_s_p4 & v_tmp1_oN(N-1 downto 1);
    end if;
    
    inf <= v_inf_sig_p4;
    zero <= v_zero_sig_p4;
    
    done <= '1';
    
    
    
    -- Debug Outputs
    
    inf1_o <= v_inf1;
    inf2_o <= v_inf2;
    zero1_o <= v_zero1;
    zero2_o <= v_zero2;
    
    mult_s_o <= v_mult_s_p2;
    
    rc1_o <= v_rc1;
    rc2_o <= v_rc2;
    regime1_o <= v_regime1;
    regime2_o <= v_regime2;
    e1_o <= v_e1;
    e2_o <= v_e2;
    mant1_o <= v_mant1;
    mant2_o <= v_mant2;
    
    m1_o <= v_m1;
    m2_o <= v_m2;
    r1_o <= v_r1;
    r2_o <= v_r2;
    
    r1e1_o <= v_r1e1;
    r2e2_o <= v_r2e2;
    
    mult_m_o <= v_mult_m;
    mult_e_o <= v_mult_e;
    e_o_o <= v_e_o;
    r_o_o <= v_r_o;
    tmp_o_o <= v_tmp_o;
    tmp1_o_o <= v_tmp1_o;
    r_o_dsr_o <= v_r_o_dsr;
    tmp1_oN_o <= v_tmp1_oN;
    
    
    end if;
    end process;
    
    end generate;
    
    
    --#####################################################################################--
    -- with 1 Pipeline stage
    min_pipeline_stages : if Pipe_stages <= 1 generate
    
    data_extract_p : process (clk)
    
        variable v_start0 : std_logic;
        variable v_s1 : std_logic;
        variable v_s2 : std_logic;
        variable v_zero_tmp1 : std_logic;
        variable v_zero_tmp1_p2 : std_logic;     -- second Pipeline Stage        
        variable v_zero_tmp2 : std_logic;
        variable v_zero_tmp2_p2 : std_logic;     -- second Pipeline Stage
        variable v_inf1 : std_logic;
        variable v_inf2 : std_logic;
        variable v_zero1 : std_logic;
        variable v_zero2 : std_logic;
        variable v_inf_sig : std_logic;
        variable v_inf_sig_p2 : std_logic;      -- 2nd Pipeline Stage
        variable v_inf_sig_p3 : std_logic;      -- 3rd Pipeline Stage
        variable v_inf_sig_p4 : std_logic;      -- 4th Pipeline Stage
        variable v_zero_sig : std_logic;
        variable v_zero_sig_p2 : std_logic;     -- 2nd Pipeline Stage
        variable v_zero_sig_p3 : std_logic;     -- 3rd Pipeline Stage
        variable v_zero_sig_p4 : std_logic;     -- 4th Pipeline Stage
    
        -- Data Extraction
        variable v_rc1, v_rc2 : std_logic;
        variable v_regime1, v_regime2, v_Lshift1, v_Lshift2 : std_logic_vector(Bs-1 downto 0);
        variable v_e1, v_e2 : std_logic_vector(es-1 downto 0);
        variable v_mant1, v_mant2 : std_logic_vector(N-es-1 downto 0);
    
    
        variable v_xin1 : std_logic_vector(N-1 downto 0);
        variable v_xin2 : std_logic_vector(N-1 downto 0);
        
        variable v_m1, v_m2 : std_logic_vector(N-es downto 0);
        variable v_mult_s : std_logic;
        variable v_mult_s_p2 : std_logic;    -- 2nd Pipeline Stage
        variable v_mult_s_p3 : std_logic;    -- 3rd Pipeline Stage
        variable v_mult_s_p4 : std_logic;    -- 4th Pipeline Stage
    
        variable v_mult_m : std_logic_vector(2*(N-es)+1 downto 0);
        variable v_mult_m_p3 : std_logic_vector(2*(N-es)+1 downto 0);   -- for 3rd Pipeline Stage
        variable v_mult_m_ovf : std_logic;
        variable v_mult_m_ovf_v : std_logic_vector(0 downto 0);
        variable v_mult_mN : std_logic_vector(2*(N-es)+1 downto 0);
        variable v_mult_mN_p4 : std_logic_vector(2*(N-es)+1 downto 0);  -- for 4th Pipeline Stage
    
        variable v_regime1_long_inv : std_logic_vector(Bs+1 downto 0);
        variable v_regime2_long_inv : std_logic_vector(Bs+1 downto 0);
    
        variable v_r1 : std_logic_vector(Bs+1 downto 0);
        variable v_r2 : std_logic_vector(Bs+1 downto 0);
    
        variable v_r1e1 : std_logic_vector(Bs+es+1 downto 0);
        variable v_r1e1_p3 : std_logic_vector(Bs+es+1 downto 0);        -- for 3rd Pipeline Stage
        variable v_r2e2 : std_logic_vector(Bs+es+1 downto 0);
        variable v_r2e2_p3 : std_logic_vector(Bs+es+1 downto 0);        -- for 3rd Pipeline Stage
    
        variable v_mult_e : std_logic_vector(Bs+es+1 downto 0);
        variable v_mult_e_p4 : std_logic_vector(Bs+es+1 downto 0);      -- for 4th Pipeline Stage
    
        variable v_mult_eN : std_logic_vector(es+Bs downto 0);
        variable v_e_o : std_logic_vector(es-1 downto 0);
        variable v_r_o : std_logic_vector(Bs downto 0);
    
        variable v_not_mult_e : std_logic_vector(N-1 downto 0);
        variable v_tmp_o : std_logic_vector(2*N-1 downto 0);
    
        variable v_tmp1_o : std_logic_vector(2*N-1 downto 0);
        variable v_r_o_dsr_tmp : std_logic_vector(Bs downto 0);
        variable v_r_o_dsr : std_logic_vector(Bs downto 0);
    
        variable v_tmp1_oN : std_logic_vector(2*N-1 downto 0);
    
        variable v_out_zeros : std_logic_vector(N-2 downto 0);
    
    
    begin
    if rst = '1' then

        zero_tmp1 <= '0';
        zero_tmp2 <= '0';
--        inf_sig <= '0';
        inf_sig_p2 <= '0';
--        inf_sig_p3 <= '0';
--        inf_sig_p4 <= '0';
--        zero_sig <= '0';
        zero_sig_p2 <= '0';
--        zero_sig_p3 <= '0';
--        zero_sig_p4 <= '0';
    
--        rc1 <= '0'; 
--        rc2 <= '0';
--        regime1 <= (others => '0'); 
--        regime2 <= (others => '0');
--        e1 <= (others => '0');
--        e2 <= (others => '0');
--        mant1 <= (others => '0');
--        mant2 <= (others => '0');
        
        xin1 <= (others => '0');
        xin2 <= (others => '0');
        mult_s_p2 <= '0';
--        mult_s_p3 <= '0';
--        mult_s_p4 <= '0';
--        mult_m_p3 <= (others => '0');
--        mult_mN_p4 <= (others => '0');
--        r1e1_p3 <= (others => '0');
--        r2e2_p3 <= (others => '0');
--        mult_e_p4 <= (others => '0');
    
    elsif rising_edge(clk) then
    
    v_start0 := start;
    v_s1 := in1(N-1);
    v_s2 := in2(N-1);
    v_zero_tmp1 := or_reduce(in1(N-2 downto 0));
    v_zero_tmp2 := or_reduce(in2(N-2 downto 0));
    v_inf1 := v_s1 and (not v_zero_tmp1);
    v_inf2 := v_s2 and (not v_zero_tmp2);
    v_zero1 := not (v_s1 or v_zero_tmp1);
    v_zero2 := not (v_s2 or v_zero_tmp2);
    v_inf_sig := v_inf1 or v_inf2;
    v_zero_sig := v_zero1 and v_zero2;


    -- xin1
    if v_s1 = '1' then
        xin1 <= std_logic_vector( - signed(in1(N-1 downto 0)));
    else
        xin1 <= in1(N-1 downto 0);
    end if;
    
    
    -- xin2
    if v_s2 = '1' then
        xin2 <= std_logic_vector( - signed(in2(N-1 downto 0)));
    else
        xin2 <= in2(N-1 downto 0);
    end if;
    

    -- Subcomponent Output in Variable
    v_rc1 := rc1;
    v_regime1 := regime1;
    v_e1 := e1;
    v_mant1 := mant1;
    
    v_rc2 := rc2;
    v_regime2 := regime2;
    v_e2 := e2;
    v_mant2 := mant2;
    
    
    v_mult_s := v_s1 xor v_s2;
    
    --------------------------------------------------------------------------
    -- Pipeline stage for synchronisation with data_extract
    mult_s_p2 <= v_mult_s;
    zero_tmp1 <= v_zero_tmp1;
    zero_tmp2 <= v_zero_tmp2;
    inf_sig_p2 <= v_inf_sig;
    zero_sig_p2 <= v_zero_sig;
    
    
    v_mult_s_p2 := mult_s_p2;
    v_zero_tmp1_p2 := zero_tmp1;
    v_zero_tmp2_p2 := zero_tmp2;
    --v_inf_sig_p2 := inf_sig_p2;
    --v_zero_sig_p2 := zero_sig_p2;
    --------------------------------------------------------------------------

    v_regime1_long_inv := std_logic_vector(resize(unsigned(v_regime1), Bs + 2));  -- r1'length
    v_regime2_long_inv := std_logic_vector(resize(unsigned(v_regime2), Bs + 2));  -- r2'length
    

    -- r1
    if v_rc1 = '1' then
        v_r1 := ("00" & v_regime1);
    else
        v_r1 := std_logic_vector(- signed(v_regime1_long_inv));
    end if;
    
    -- r2
    if v_rc2 = '1' then
        v_r2 := ("00" & v_regime2);
    else
        v_r2 := std_logic_vector(- signed(v_regime2_long_inv));
    end if;
    
    v_r1e1 := v_r1 & v_e1;
    v_r2e2 := v_r2 & v_e2;
    
    
    v_m1 := v_zero_tmp1_p2 & v_mant1;
    v_m2 := v_zero_tmp2_p2 & v_mant2;
    
    v_mult_m := std_logic_vector(unsigned(v_m1) * unsigned(v_m2));
    
    --------------------------------------------------------------------------
    -- Pipeline Stage 2
    -- NOT USED !!!
    --mult_m_p3 <= v_mult_m;
    --r1e1_p3 <= v_r1e1;
    --r2e2_p3 <= v_r2e2;
    --mult_s_p3 <= mult_s_p2;
    --inf_sig_p3 <= inf_sig_p2;
    --zero_sig_p3 <= zero_sig_p2;


    v_mult_m_p3 := v_mult_m;
    v_r1e1_p3 := v_r1e1;
    v_r2e2_p3 := v_r2e2;
    --------------------------------------------------------------------------

    -- check for overflow
    v_mult_m_ovf := v_mult_m_p3(2*(N-es)+1);
    
    --mult_mN
    if v_mult_m_ovf = '0' then
        v_mult_mN := std_logic_vector(shift_left(unsigned(v_mult_m_p3), 1));
    else
        v_mult_mN := v_mult_m_p3;
    end if;
    
    
    
    
    v_mult_m_ovf_v(0) := v_mult_m_ovf;
    
    v_mult_e := std_logic_vector(unsigned(v_r1e1_p3) + unsigned(v_r2e2_p3) + unsigned( v_mult_m_ovf_v));
    
    --------------------------------------------------------------------------
    -- Pipeline Stage 3 
    -- NOT USED !!!

    v_mult_mN_p4 := v_mult_mN;
    v_mult_e_p4 := v_mult_e;
    v_mult_s_p4 := mult_s_p2;
    v_inf_sig_p4 := inf_sig_p2;
    v_zero_sig_p4 := zero_sig_p2;
    --------------------------------------------------------------------------
    
    -- Exponent and Regime Computation
    
    -- mult_eN
    if v_mult_e_p4(es +Bs+1) = '1' then
        v_mult_eN := std_logic_vector(- signed(v_mult_e_p4(es+Bs downto 0)));
    else
        v_mult_eN := v_mult_e_p4(es+Bs downto 0);
    end if;
    
    
    -- e_o
    if v_mult_e_p4(es+Bs+1) = '1' and OR_REDUCE(v_mult_eN(es-1 downto 0)) = '1' then
        v_e_o := v_mult_e_p4(es-1 downto 0);
    else
        v_e_o := v_mult_eN(es-1 downto 0);
    end if;
    
    
    -- r_o
    if v_mult_e_p4(es+Bs+1) = '0' or (v_mult_e_p4(es+Bs+1)= '1' and OR_REDUCE(v_mult_eN(es-1 downto 0)) = '1') then
        v_r_o := std_logic_vector(unsigned(v_mult_eN(es+Bs downto es)) + 1);
    else
        v_r_o := v_mult_eN(es+Bs downto es); 
    end if;
    
    
    -- Exponent and Mantissa Packing
    
    v_not_mult_e := (others => not v_mult_e_p4(es+Bs+1));
    
    v_tmp_o := v_not_mult_e & v_mult_e_p4(es+Bs+1) & v_e_o & v_mult_mN_p4(2*(N-es) downto N-es+2);
    
    
    -- Including Regime bits in Exponent-Mantissa Packing
    
    -- r_o_dsr_tmp
    if v_r_o(Bs) = '1' then
        v_r_o_dsr_tmp := (others => '1');
    else
        v_r_o_dsr_tmp := v_r_o;
    end if;
    
    v_r_o_dsr := '0' & v_r_o_dsr_tmp(Bs-1 downto 0);
    
    v_tmp1_o := std_logic_vector(shift_right(unsigned(v_tmp_o), to_integer(unsigned(v_r_o_dsr))));  
    
    
    -- Final Output
    
    --tmp1_oN
    if v_mult_s_p4 = '1' then
        v_tmp1_oN := std_logic_vector(- signed(v_tmp1_o));
    else
        v_tmp1_oN := v_tmp1_o;
    end if;
    
    v_out_zeros := (others => '0');
    
    -- Combine SFP with LSB (N-1) bit of REM
    --out_val
    if (v_inf_sig_p4 = '1' or v_zero_sig_p4 = '1') or v_mult_mN_p4(2*(N-es)+1) = '0' then
        out_val <= v_inf_sig_p4 & v_out_zeros;
    else
        out_val <= v_mult_s_p4 & v_tmp1_oN(N-1 downto 1);
    end if;
    
    inf <= v_inf_sig_p4;
    zero <= v_zero_sig_p4;
    
    done <= '1';
    
    
    
    -- Debug Outputs
    
    inf1_o <= v_inf1;
    inf2_o <= v_inf2;
    zero1_o <= v_zero1;
    zero2_o <= v_zero2;
    
    mult_s_o <= v_mult_s_p2;
    
    rc1_o <= v_rc1;
    rc2_o <= v_rc2;
    regime1_o <= v_regime1;
    regime2_o <= v_regime2;
    e1_o <= v_e1;
    e2_o <= v_e2;
    mant1_o <= v_mant1;
    mant2_o <= v_mant2;
    
    m1_o <= v_m1;
    m2_o <= v_m2;
    r1_o <= v_r1;
    r2_o <= v_r2;
    
    r1e1_o <= v_r1e1;
    r2e2_o <= v_r2e2;
    
    mult_m_o <= v_mult_m;
    mult_e_o <= v_mult_e;
    e_o_o <= v_e_o;
    r_o_o <= v_r_o;
    tmp_o_o <= v_tmp_o;
    tmp1_o_o <= v_tmp1_o;
    r_o_dsr_o <= v_r_o_dsr;
    tmp1_oN_o <= v_tmp1_oN;
    
    
    end if;
    end process;
    
    end generate;
    
    

end Behavioral;
