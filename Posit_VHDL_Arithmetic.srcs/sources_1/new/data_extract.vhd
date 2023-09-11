----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jan Hoertig
-- 
-- Create Date: 28.06.2023 14:39:13
-- Design Name: 
-- Module Name: add_N - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity data_extract is

-- ChatGPT
  generic (
    N : integer := 16;
    Bs : integer := 4;      -- log2(N)
    es : integer := 2
  );
  port (
    in_val : in std_logic_vector(N-1 downto 0);
    rc : out std_logic;
    regime : out std_logic_vector(Bs-1 downto 0);
    Lshift : out std_logic_vector(Bs-1 downto 0);
    exp : out std_logic_vector(es-1 downto 0);
    mant : out std_logic_vector(N-es-1 downto 0)
  );


end data_extract;

architecture Behavioral of data_extract is

-- ChatGPT
--  function log2(value : integer) return integer is
--    variable tmp : integer := value - 1;
--    variable result : integer := 0;
--  begin
--    while tmp > 0 loop
--    -- srl nicht mehr vern�nftig unterst�tzt
--      tmp := to_integer(shift_right(unsigned(tmp), 1));
--      result := result + 1;
--    end loop;
--    return result;
--  end function log2;

  signal xin : std_logic_vector(N-1 downto 0);
  signal xin_tmp : std_logic_vector(N-1 downto 0);
  signal k0, k1 : std_logic_vector(Bs-1 downto 0);

begin

    -- 2's complement conversion already in posit_adder
    
    xin <= in_val;
  
    -- The MSB of XINs depicts the sign of regime value and acts as Regime Check (RC) bit
    -- rc <= xin(N-2);
    rc <= xin(N-1);
    

    -- A leading zero detector (LZD) is employed to count a sequence of 1 with terminating 0 and a leading one detector (LOD) is
    -- used to count the sequence of 0 with terminating 1 (one less than the actual count of 1). RC determines either of K0 or
    -- K1 as R[RS-1:0] (absolute regime value) and regime left shift amount (Lshift) of respective operands.
    
    -- Leading One Detection (LOD) of XIN1[N-2:0] (? K0)
    LOD_N_inst_2 : entity work.LOD_N
        generic map (N => N, log2N => Bs)
        port map (input_vector => xin(N-2 downto 0) & '0', output_vector => k0);
    
    --Leading Zero Detection (LZD) of XIN1[N-3:0] (? K1)
    LZD_N_inst_3 : entity work.LZD_N
        generic map (N => N, log2N => Bs)
        port map (input_vector => xin(N-3 downto 0) & "00", output_vector => k1);

    -- Regime Value: R1 ? RC1 ? K1 : K0
    regime <= k0 when rc = '0' else k1;
    -- Regime Left Shift Amount: Lshift ? RC1 ? K1+1 : K0
    Lshift <= k0 when rc = '0' else std_logic_vector(unsigned(k1) + 1);


    -- To extract the exponent and mantissa, the respective XIN is dynamically left shifted by Lshift to push-out the entire regime
    -- bits and align exponent and mantissa at MSB. Now the MSB ES bit will act as the exponent and remaining bit would be mantissa bits
    DSR_left_N_S_inst : entity work.DSR_left_N_S
        generic map (N => N, S => Bs)
        port map (a => xin(N-3 downto 0) & "00", b => Lshift, c => xin_tmp);

    exp <= xin_tmp(N-1 downto N-es);
    mant <= xin_tmp(N-es-1 downto 0);


end Behavioral;
