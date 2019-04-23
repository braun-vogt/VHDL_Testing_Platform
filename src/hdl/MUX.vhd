----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 17.04.2019 10:53:09
-- Design Name:
-- Module Name: MUX - Behavioral
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
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX is
	port (
	    --Sysclk
		SYSCLK_125MHZ : in STD_LOGIC;
		
		--IO Controll
		MUX_GPIO : in STD_LOGIC_VECTOR(28 downto 0);
		
		--Leds
		RGB_LED1 : out STD_LOGIC_VECTOR(2 downto 0);
		RGB_LED2 : out STD_LOGIC_VECTOR(2 downto 0);
		LEDS : out STD_LOGIC_VECTOR(3 downto 0);
 
		PMOD_JB_IN : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JB_OUT : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JB_OE : out STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JC_IN : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JC_OUT : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JC_OE : out STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JD_IN : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JD_OUT : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JD_OE : out STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JE_IN : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JE_OUT : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JE_OE : out STD_LOGIC_VECTOR(7 downto 0);
 
		--par0
		PMOD_JB_IN_0 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JB_OUT_0 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JB_OE_0 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JC_IN_0 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JC_OUT_0 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JC_OE_0 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JD_IN_0 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JD_OUT_0 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JD_OE_0 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JE_IN_0 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JE_OUT_0 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JE_OE_0 : in STD_LOGIC_VECTOR(7 downto 0);
 
		RGB_LED1_0 : in STD_LOGIC_VECTOR(2 downto 0);
		RGB_LED2_0 : in STD_LOGIC_VECTOR(2 downto 0);
		LEDS_0 : in STD_LOGIC_VECTOR(3 downto 0);
 
		--par1
		PMOD_JB_IN_1 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JB_OUT_1 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JB_OE_1 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JC_IN_1 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JC_OUT_1 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JC_OE_1 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JD_IN_1 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JD_OUT_1 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JD_OE_1 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JE_IN_1 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JE_OUT_1 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JE_OE_1 : in STD_LOGIC_VECTOR(7 downto 0);
 
		RGB_LED1_1 : in STD_LOGIC_VECTOR(2 downto 0);
		RGB_LED2_1 : in STD_LOGIC_VECTOR(2 downto 0);
		LEDS_1 : in STD_LOGIC_VECTOR(3 downto 0);
		--par2
		PMOD_JB_IN_2 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JB_OUT_2 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JB_OE_2 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JC_IN_2 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JC_OUT_2 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JC_OE_2 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JD_IN_2 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JD_OUT_2 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JD_OE_2 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JE_IN_2 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JE_OUT_2 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JE_OE_2 : in STD_LOGIC_VECTOR(7 downto 0);
 
		RGB_LED1_2 : in STD_LOGIC_VECTOR(2 downto 0);
		RGB_LED2_2 : in STD_LOGIC_VECTOR(2 downto 0);
		LEDS_2 : in STD_LOGIC_VECTOR(3 downto 0);
 
		--par3
		PMOD_JB_IN_3 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JB_OUT_3 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JB_OE_3 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JC_IN_3 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JC_OUT_3 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JC_OE_3 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JD_IN_3 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JD_OUT_3 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JD_OE_3 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JE_IN_3 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JE_OUT_3 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JE_OE_3 : in STD_LOGIC_VECTOR(7 downto 0);
 
		RGB_LED1_3 : in STD_LOGIC_VECTOR(2 downto 0);
		RGB_LED2_3 : in STD_LOGIC_VECTOR(2 downto 0);
		LEDS_3 : in STD_LOGIC_VECTOR(3 downto 0);
 
		--par4
		PMOD_JB_IN_4 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JB_OUT_4 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JB_OE_4 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JC_IN_4 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JC_OUT_4 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JC_OE_4 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JD_IN_4 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JD_OUT_4 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JD_OE_4 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JE_IN_4 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JE_OUT_4 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JE_OE_4 : in STD_LOGIC_VECTOR(7 downto 0);
 
		RGB_LED1_4 : in STD_LOGIC_VECTOR(2 downto 0);
		RGB_LED2_4 : in STD_LOGIC_VECTOR(2 downto 0);
		LEDS_4 : in STD_LOGIC_VECTOR(3 downto 0);
 
		--par5
		PMOD_JB_IN_5 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JB_OUT_5 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JB_OE_5 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JC_IN_5 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JC_OUT_5 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JC_OE_5 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JD_IN_5 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JD_OUT_5 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JD_OE_5 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JE_IN_5 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JE_OUT_5 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JE_OE_5 : in STD_LOGIC_VECTOR(7 downto 0);
 
		RGB_LED1_5 : in STD_LOGIC_VECTOR(2 downto 0);
		RGB_LED2_5 : in STD_LOGIC_VECTOR(2 downto 0);
		LEDS_5 : in STD_LOGIC_VECTOR(3 downto 0);
 
		--par6
		PMOD_JB_IN_6 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JB_OUT_6 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JB_OE_6 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JC_IN_6 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JC_OUT_6 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JC_OE_6 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JD_IN_6 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JD_OUT_6 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JD_OE_6 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JE_IN_6 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JE_OUT_6 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JE_OE_6 : in STD_LOGIC_VECTOR(7 downto 0);
 
		RGB_LED1_6 : in STD_LOGIC_VECTOR(2 downto 0);
		RGB_LED2_6 : in STD_LOGIC_VECTOR(2 downto 0);
		LEDS_6 : in STD_LOGIC_VECTOR(3 downto 0);
 
		--par7
		PMOD_JB_IN_7 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JB_OUT_7 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JB_OE_7 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JC_IN_7 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JC_OUT_7 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JC_OE_7 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JD_IN_7 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JD_OUT_7 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JD_OE_7 : in STD_LOGIC_VECTOR(7 downto 0);
 
		PMOD_JE_IN_7 : out STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JE_OUT_7 : in STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JE_OE_7 : in STD_LOGIC_VECTOR(7 downto 0);
 
		RGB_LED1_7 : in STD_LOGIC_VECTOR(2 downto 0);
		RGB_LED2_7 : in STD_LOGIC_VECTOR(2 downto 0);
		LEDS_7 : in STD_LOGIC_VECTOR(3 downto 0)
 
	);
end MUX;

architecture Behavioral of MUX is
    alias Enable :std_logic_vector (0 downto 0) is MUX_GPIO(0 downto 0);
	alias MUX_PMODB : std_logic_vector(3 downto 0) is MUX_GPIO(4 downto 1);
	alias MUX_PMODC : std_logic_vector(3 downto 0) is MUX_GPIO(8 downto 5);
	alias MUX_PMODD : std_logic_vector(3 downto 0) is MUX_GPIO(12 downto 9);
	alias MUX_PMODE : std_logic_vector(3 downto 0) is MUX_GPIO(16 downto 13);
	alias MUX_RGBLED1 : std_logic_vector(3 downto 0) is MUX_GPIO(20 downto 17);
	alias MUX_RGBLED2 : std_logic_vector(3 downto 0) is MUX_GPIO(24 downto 21);
	alias MUX_LEDS : std_logic_vector(3 downto 0) is MUX_GPIO(28 downto 25); 
 
begin
	process (SYSCLK_125MHZ)
	begin
		if (rising_edge(SYSCLK_125MHZ)) then
		  if(Enable="1") then
			case MUX_PMODB is
				when "0000" => 
					PMOD_JB_IN_0 <= PMOD_JB_IN;
					PMOD_JB_OUT <= PMOD_JB_OUT_0;
					PMOD_JB_OE <= PMOD_JB_OE_0; 
				when "0001" => 
					PMOD_JB_IN_1 <= PMOD_JB_IN;
					PMOD_JB_OUT <= PMOD_JB_OUT_1;
					PMOD_JB_OE <= PMOD_JB_OE_1; 
				when "0010" => 
					PMOD_JB_IN_2 <= PMOD_JB_IN;
					PMOD_JB_OUT <= PMOD_JB_OUT_2;
					PMOD_JB_OE <= PMOD_JB_OE_2; 
				when "0011" => 
					PMOD_JB_IN_3 <= PMOD_JB_IN;
					PMOD_JB_OUT <= PMOD_JB_OUT_3;
					PMOD_JB_OE <= PMOD_JB_OE_3; 
				when "0100" => 
					PMOD_JB_IN_4 <= PMOD_JB_IN;
					PMOD_JB_OUT <= PMOD_JB_OUT_4;
					PMOD_JB_OE <= PMOD_JB_OE_4; 
				when "0101" => 
					PMOD_JB_IN_5 <= PMOD_JB_IN;
					PMOD_JB_OUT <= PMOD_JB_OUT_5;
					PMOD_JB_OE <= PMOD_JB_OE_5; 
				when "0110" => 
					PMOD_JB_IN_6 <= PMOD_JB_IN;
					PMOD_JB_OUT <= PMOD_JB_OUT_6;
					PMOD_JB_OE <= PMOD_JB_OE_6; 
				when "0111" => 
					PMOD_JB_IN_7 <= PMOD_JB_IN;
					PMOD_JB_OUT <= PMOD_JB_OUT_7;
					PMOD_JB_OE <= PMOD_JB_OE_7; 
				when others => 
					PMOD_JB_IN_0 <= (others => '0');
					PMOD_JB_OUT <= (others => '0');
					PMOD_JB_OE <= (others => '0'); 
			end case;
 
			case MUX_PMODC is
				when "0000" => 
					PMOD_JC_IN_0 <= PMOD_JC_IN;
					PMOD_JC_OUT <= PMOD_JC_OUT_0;
					PMOD_JC_OE <= PMOD_JC_OE_0; 
				when "0001" => 
					PMOD_JC_IN_1 <= PMOD_JC_IN;
					PMOD_JC_OUT <= PMOD_JC_OUT_1;
					PMOD_JC_OE <= PMOD_JC_OE_1; 
				when "0010" => 
					PMOD_JC_IN_2 <= PMOD_JC_IN;
					PMOD_JC_OUT <= PMOD_JC_OUT_2;
					PMOD_JC_OE <= PMOD_JC_OE_2; 
				when "0011" => 
					PMOD_JC_IN_3 <= PMOD_JC_IN;
					PMOD_JC_OUT <= PMOD_JC_OUT_3;
					PMOD_JC_OE <= PMOD_JC_OE_3; 
				when "0100" => 
					PMOD_JC_IN_4 <= PMOD_JC_IN;
					PMOD_JC_OUT <= PMOD_JC_OUT_4;
					PMOD_JC_OE <= PMOD_JC_OE_4; 
				when "0101" => 
					PMOD_JC_IN_5 <= PMOD_JC_IN;
					PMOD_JC_OUT <= PMOD_JC_OUT_5;
					PMOD_JC_OE <= PMOD_JC_OE_5; 
				when "0110" => 
					PMOD_JC_IN_6 <= PMOD_JC_IN;
					PMOD_JC_OUT <= PMOD_JC_OUT_6;
					PMOD_JC_OE <= PMOD_JC_OE_6; 
				when "0111" => 
					PMOD_JC_IN_7 <= PMOD_JC_IN;
					PMOD_JC_OUT <= PMOD_JC_OUT_7;
					PMOD_JC_OE <= PMOD_JC_OE_7; 
				when others => 
					PMOD_JC_IN_0 <= (others => '0');
					PMOD_JC_OUT <= (others => '0');
					PMOD_JC_OE <= (others => '0'); 
			end case;

			case MUX_PMODD is
				when "0000" => 
					PMOD_JD_IN_0 <= PMOD_JD_IN;
					PMOD_JD_OUT <= PMOD_JD_OUT_0;
					PMOD_JD_OE <= PMOD_JD_OE_0; 
				when "0001" => 
					PMOD_JD_IN_1 <= PMOD_JD_IN;
					PMOD_JD_OUT <= PMOD_JD_OUT_1;
					PMOD_JD_OE <= PMOD_JD_OE_1; 
				when "0010" => 
					PMOD_JD_IN_2 <= PMOD_JD_IN;
					PMOD_JD_OUT <= PMOD_JD_OUT_2;
					PMOD_JD_OE <= PMOD_JD_OE_2; 
				when "0011" => 
					PMOD_JD_IN_3 <= PMOD_JD_IN;
					PMOD_JD_OUT <= PMOD_JD_OUT_3;
					PMOD_JD_OE <= PMOD_JD_OE_3; 
				when "0100" => 
					PMOD_JD_IN_4 <= PMOD_JD_IN;
					PMOD_JD_OUT <= PMOD_JD_OUT_4;
					PMOD_JD_OE <= PMOD_JD_OE_4; 
				when "0101" => 
					PMOD_JD_IN_5 <= PMOD_JD_IN;
					PMOD_JD_OUT <= PMOD_JD_OUT_5;
					PMOD_JD_OE <= PMOD_JD_OE_5; 
				when "0110" => 
					PMOD_JD_IN_6 <= PMOD_JD_IN;
					PMOD_JD_OUT <= PMOD_JD_OUT_6;
					PMOD_JD_OE <= PMOD_JD_OE_6; 
				when "0111" => 
					PMOD_JD_IN_7 <= PMOD_JD_IN;
					PMOD_JD_OUT <= PMOD_JD_OUT_7;
					PMOD_JD_OE <= PMOD_JD_OE_7; 
				when others => 
					PMOD_JD_IN_0 <= (others => '0');
					PMOD_JD_OUT <= (others => '0');
					PMOD_JD_OE <= (others => '0'); 
			end case; 
 
			case MUX_PMODE is
				when "0000" => 
					PMOD_JE_IN_0 <= PMOD_JE_IN;
					PMOD_JE_OUT <= PMOD_JE_OUT_0;
					PMOD_JE_OE <= PMOD_JE_OE_0; 
				when "0001" => 
					PMOD_JE_IN_1 <= PMOD_JE_IN;
					PMOD_JE_OUT <= PMOD_JE_OUT_1;
					PMOD_JE_OE <= PMOD_JE_OE_1; 
				when "0010" => 
					PMOD_JE_IN_2 <= PMOD_JE_IN;
					PMOD_JE_OUT <= PMOD_JE_OUT_2;
					PMOD_JE_OE <= PMOD_JE_OE_2; 
				when "0011" => 
					PMOD_JE_IN_3 <= PMOD_JE_IN;
					PMOD_JE_OUT <= PMOD_JE_OUT_3;
					PMOD_JE_OE <= PMOD_JE_OE_3; 
				when "0100" => 
					PMOD_JE_IN_4 <= PMOD_JE_IN;
					PMOD_JE_OUT <= PMOD_JE_OUT_4;
					PMOD_JE_OE <= PMOD_JE_OE_4; 
				when "0101" => 
					PMOD_JE_IN_5 <= PMOD_JE_IN;
					PMOD_JE_OUT <= PMOD_JE_OUT_5;
					PMOD_JE_OE <= PMOD_JE_OE_5; 
				when "0110" => 
					PMOD_JE_IN_6 <= PMOD_JE_IN;
					PMOD_JE_OUT <= PMOD_JE_OUT_6;
					PMOD_JE_OE <= PMOD_JE_OE_6; 
				when "0111" => 
					PMOD_JE_IN_7 <= PMOD_JE_IN;
					PMOD_JE_OUT <= PMOD_JE_OUT_7;
					PMOD_JE_OE <= PMOD_JE_OE_7; 
				when others => 
					PMOD_JE_IN_0 <= (others => '0');
					PMOD_JE_OUT <= (others => '0');
					PMOD_JE_OE <= (others => '0'); 
			end case; 
 
			case MUX_RGBLED1 is
				when "0000" => 
					RGB_LED1 <= RGB_LED1_0; 
				when "0001" => 
					RGB_LED1 <= RGB_LED1_1; 
				when "0010" => 
					RGB_LED1 <= RGB_LED1_2; 
				when "0011" => 
					RGB_LED1 <= RGB_LED1_3; 
				when "0100" => 
					RGB_LED1 <= RGB_LED1_4; 
				when "0101" => 
					RGB_LED1 <= RGB_LED1_5;
				when "0110" => 
					RGB_LED1 <= RGB_LED1_6; 
				when "0111" => 
					RGB_LED1 <= RGB_LED1_7; 
				when others => 
					RGB_LED1 <= (others => '0');
			end case;
 
			case MUX_RGBLED2 is
				when "0000" => 
					RGB_LED2 <= RGB_LED2_0; 
				when "0001" => 
					RGB_LED2 <= RGB_LED2_1; 
				when "0010" => 
					RGB_LED2 <= RGB_LED2_2; 
				when "0011" => 
					RGB_LED2 <= RGB_LED2_3; 
				when "0100" => 
					RGB_LED2 <= RGB_LED2_4; 
				when "0101" => 
					RGB_LED2 <= RGB_LED2_5;
				when "0110" => 
					RGB_LED2 <= RGB_LED2_6; 
				when "0111" => 
					RGB_LED2 <= RGB_LED2_7; 
				when others => 
					RGB_LED2 <= (others => '0');
			end case;
 
			case MUX_LEDS is
				when "0000" => 
					LEDS <= LEDS_0; 
				when "0001" => 
					LEDS <= LEDS_1; 
				when "0010" => 
					LEDS <= LEDS_2; 
				when "0011" => 
					LEDS <= LEDS_3; 
				when "0100" => 
					LEDS <= LEDS_4; 
				when "0101" => 
					LEDS <= LEDS_5;
				when "0110" => 
					LEDS <= LEDS_6; 
				when "0111" => 
					LEDS <= LEDS_7; 
				when others => 
					LEDS <= (others => '0');
			end case;
			
            end if;
		end if;
	end process;
end Behavioral;

 
