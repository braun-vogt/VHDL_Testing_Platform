----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 15.02.2019 16:46:24
-- Design Name:
-- Module Name: top - Behavioral
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

entity top is
	port (
		--user pmod
		PMOD_JB : inout STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JC : inout STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JD : inout STD_LOGIC_VECTOR(7 downto 0);
		PMOD_JE : inout STD_LOGIC_VECTOR(7 downto 0);

		--clk
		sys_clock : in STD_LOGIC;
		leds : out STD_LOGIC_VECTOR (3 downto 0);

		--part RGB
		RGB_LED1 : out STD_LOGIC_VECTOR (2 downto 0);
		RGB_LED2 : out STD_LOGIC_VECTOR (2 downto 0);

		DDR_addr : inout STD_LOGIC_VECTOR (14 downto 0);
		DDR_ba : inout STD_LOGIC_VECTOR (2 downto 0);
		DDR_cas_n : inout STD_LOGIC;
		DDR_ck_n : inout STD_LOGIC;
		DDR_ck_p : inout STD_LOGIC;
		DDR_cke : inout STD_LOGIC;
		DDR_cs_n : inout STD_LOGIC;
		DDR_dm : inout STD_LOGIC_VECTOR (3 downto 0);
		DDR_dq : inout STD_LOGIC_VECTOR (31 downto 0);
		DDR_dqs_n : inout STD_LOGIC_VECTOR (3 downto 0);
		DDR_dqs_p : inout STD_LOGIC_VECTOR (3 downto 0);
		DDR_odt : inout STD_LOGIC;
		DDR_ras_n : inout STD_LOGIC;
		DDR_reset_n : inout STD_LOGIC;
		DDR_we_n : inout STD_LOGIC;
		FIXED_IO_ddr_vrn : inout STD_LOGIC;
		FIXED_IO_ddr_vrp : inout STD_LOGIC;
		FIXED_IO_mio : inout STD_LOGIC_VECTOR (53 downto 0);
		FIXED_IO_ps_clk : inout STD_LOGIC;
		FIXED_IO_ps_porb : inout STD_LOGIC;
		FIXED_IO_ps_srstb : inout STD_LOGIC
	);
end top;

architecture Behavioral of top is

	component MUX is
		port (
			SYSCLK_125MHZ : in STD_LOGIC;
			MUX_GPIO : in STD_LOGIC_VECTOR(28 downto 0);
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
	end component;
	component par0 is
		port (
			CLK_125MHZ : in STD_LOGIC;
			CLK_MMC : in STD_LOGIC_VECTOR (0 to 0);
			CLK_PLL : in STD_LOGIC_VECTOR (0 to 0);

			reset : in STD_LOGIC;

			PAR_TEST_GPIO0_IN : in STD_LOGIC_VECTOR (31 downto 0);
			PAR_TEST_GPIO0_OUT : out STD_LOGIC_VECTOR (31 downto 0);

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

			leds : out STD_LOGIC_VECTOR (3 downto 0);

			RGB_LED : out STD_LOGIC_VECTOR (2 downto 0);
			RGB_LED2 : out STD_LOGIC_VECTOR (2 downto 0)
		);
	end component;

	component par1 is
		port (
			CLK_125MHZ : in STD_LOGIC;
			CLK_MMC : in STD_LOGIC_VECTOR (0 to 0);
			CLK_PLL : in STD_LOGIC_VECTOR (0 to 0);

			reset : in STD_LOGIC;

			PAR_TEST_GPIO0_IN : in STD_LOGIC_VECTOR (31 downto 0);
			PAR_TEST_GPIO0_OUT : out STD_LOGIC_VECTOR (31 downto 0);
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

			leds : out STD_LOGIC_VECTOR (3 downto 0);

			RGB_LED : out STD_LOGIC_VECTOR (2 downto 0);
			RGB_LED2 : out STD_LOGIC_VECTOR (2 downto 0)
		);
	end component;

	component par2 is
		port (
			CLK_125MHZ : in STD_LOGIC;
			CLK_MMC : in STD_LOGIC_VECTOR (0 to 0);
			CLK_PLL : in STD_LOGIC_VECTOR (0 to 0);

			reset : in STD_LOGIC;

			PAR_TEST_GPIO0_IN : in STD_LOGIC_VECTOR (31 downto 0);
			PAR_TEST_GPIO0_OUT : out STD_LOGIC_VECTOR (31 downto 0);
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

			leds : out STD_LOGIC_VECTOR (3 downto 0);

			RGB_LED : out STD_LOGIC_VECTOR (2 downto 0);
			RGB_LED2 : out STD_LOGIC_VECTOR (2 downto 0)
		);
	end component;

	component par3 is
		port (
			CLK_125MHZ : in STD_LOGIC;
			CLK_MMC : in STD_LOGIC_VECTOR (0 to 0);
			CLK_PLL : in STD_LOGIC_VECTOR (0 to 0);

			reset : in STD_LOGIC;

			PAR_TEST_GPIO0_IN : in STD_LOGIC_VECTOR (31 downto 0);
			PAR_TEST_GPIO0_OUT : out STD_LOGIC_VECTOR (31 downto 0);

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
			leds : out STD_LOGIC_VECTOR (3 downto 0);

			RGB_LED : out STD_LOGIC_VECTOR (2 downto 0);
			RGB_LED2 : out STD_LOGIC_VECTOR (2 downto 0)
		);
	end component;

	component par4 is
		port (
			CLK_125MHZ : in STD_LOGIC;
			CLK_MMC : in STD_LOGIC_VECTOR (0 to 0);
			CLK_PLL : in STD_LOGIC_VECTOR (0 to 0);

			reset : in STD_LOGIC;

			PAR_TEST_GPIO0_IN : in STD_LOGIC_VECTOR (31 downto 0);
			PAR_TEST_GPIO0_OUT : out STD_LOGIC_VECTOR (31 downto 0);

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
			leds : out STD_LOGIC_VECTOR (3 downto 0);

			RGB_LED : out STD_LOGIC_VECTOR (2 downto 0);
			RGB_LED2 : out STD_LOGIC_VECTOR (2 downto 0)
		);
	end component;

	component par5 is
		port (
			CLK_125MHZ : in STD_LOGIC;
			CLK_MMC : in STD_LOGIC_VECTOR (0 to 0);
			CLK_PLL : in STD_LOGIC_VECTOR (0 to 0);

			reset : in STD_LOGIC;

			PAR_TEST_GPIO0_IN : in STD_LOGIC_VECTOR (31 downto 0);
			PAR_TEST_GPIO0_OUT : out STD_LOGIC_VECTOR (31 downto 0);

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
			leds : out STD_LOGIC_VECTOR (3 downto 0);

			RGB_LED : out STD_LOGIC_VECTOR (2 downto 0);
			RGB_LED2 : out STD_LOGIC_VECTOR (2 downto 0)
		);
	end component;

	component par6 is
		port (
			CLK_125MHZ : in STD_LOGIC;
			CLK_MMC : in STD_LOGIC_VECTOR (0 to 0);
			CLK_PLL : in STD_LOGIC_VECTOR (0 to 0);

			reset : in STD_LOGIC;

			PAR_TEST_GPIO0_IN : in STD_LOGIC_VECTOR (31 downto 0);
			PAR_TEST_GPIO0_OUT : out STD_LOGIC_VECTOR (31 downto 0);

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
			leds : out STD_LOGIC_VECTOR (3 downto 0);

			RGB_LED : out STD_LOGIC_VECTOR (2 downto 0);
			RGB_LED2 : out STD_LOGIC_VECTOR (2 downto 0)
		);
	end component;
 
 
	component par7 is
		port (
			CLK_125MHZ : in STD_LOGIC;
			CLK_MMC : in STD_LOGIC_VECTOR (0 to 0);
			CLK_PLL : in STD_LOGIC_VECTOR (0 to 0);
 
			reset : in STD_LOGIC;
 
			UART_ZYNQ_txd : in STD_LOGIC;
			UART_ZYNQ_rxd : out STD_LOGIC;
 
			PAR_TEST_GPIO0_IN : in STD_LOGIC_VECTOR (31 downto 0);
			PAR_TEST_GPIO0_OUT : out STD_LOGIC_VECTOR (31 downto 0);
 
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
			leds : out STD_LOGIC_VECTOR (3 downto 0);
 
			RGB_LED : out STD_LOGIC_VECTOR (2 downto 0);
			RGB_LED2 : out STD_LOGIC_VECTOR (2 downto 0)
		);
	end component;

	component bd_name_wrapper is
		port (
			DDR_cas_n : inout STD_LOGIC;
			DDR_cke : inout STD_LOGIC;
			DDR_ck_n : inout STD_LOGIC;
			DDR_ck_p : inout STD_LOGIC;
			DDR_cs_n : inout STD_LOGIC;
			DDR_reset_n : inout STD_LOGIC;
			DDR_odt : inout STD_LOGIC;
			DDR_ras_n : inout STD_LOGIC;
			DDR_we_n : inout STD_LOGIC;
			DDR_ba : inout STD_LOGIC_VECTOR (2 downto 0);
			DDR_addr : inout STD_LOGIC_VECTOR (14 downto 0);
			DDR_dm : inout STD_LOGIC_VECTOR (3 downto 0);
			DDR_dq : inout STD_LOGIC_VECTOR (31 downto 0);
			DDR_dqs_n : inout STD_LOGIC_VECTOR (3 downto 0);
			DDR_dqs_p : inout STD_LOGIC_VECTOR (3 downto 0);
			FIXED_IO_mio : inout STD_LOGIC_VECTOR (53 downto 0);
			FIXED_IO_ddr_vrn : inout STD_LOGIC;
			FIXED_IO_ddr_vrp : inout STD_LOGIC;
			FIXED_IO_ps_srstb : inout STD_LOGIC;
			FIXED_IO_ps_clk : inout STD_LOGIC;
			FIXED_IO_ps_porb : inout STD_LOGIC;
			UART_ZYNQ_txd : out STD_LOGIC;
			UART_ZYNQ_rxd : in STD_LOGIC;
			CLK_MMC : out STD_LOGIC_VECTOR (0 to 0);
			CLK_PLL : out STD_LOGIC_VECTOR (0 to 0);
			reset_par : out STD_LOGIC_VECTOR (15 downto 0);
			PAR_TEST_GPIO0_IN : in STD_LOGIC_VECTOR (31 downto 0);
			PAR_TEST_GPIO0_OUT : out STD_LOGIC_VECTOR (31 downto 0);
			PAR_TEST_GPIO1_IN : in STD_LOGIC_VECTOR (31 downto 0);
			PAR_TEST_GPIO2_IN : in STD_LOGIC_VECTOR (31 downto 0);
			PAR_TEST_GPIO3_IN : in STD_LOGIC_VECTOR (31 downto 0);
			PAR_TEST_GPIO4_IN : in STD_LOGIC_VECTOR (31 downto 0);
			PAR_TEST_GPIO5_IN : in STD_LOGIC_VECTOR (31 downto 0);
			PAR_TEST_GPIO6_IN : in STD_LOGIC_VECTOR (31 downto 0);
			PAR_TEST_GPIO7_IN : in STD_LOGIC_VECTOR (31 downto 0);
			PAR_TEST_GPIO1_OUT : out STD_LOGIC_VECTOR (31 downto 0);
			PAR_TEST_GPIO2_OUT : out STD_LOGIC_VECTOR (31 downto 0);
			PAR_TEST_GPIO3_OUT : out STD_LOGIC_VECTOR (31 downto 0);
			PAR_TEST_GPIO5_OUT : out STD_LOGIC_VECTOR (31 downto 0);
			PAR_TEST_GPIO6_OUT : out STD_LOGIC_VECTOR (31 downto 0);
			PAR_TEST_GPIO7_OUT : out STD_LOGIC_VECTOR (31 downto 0);
			PAR_TEST_GPIO4_OUT : out STD_LOGIC_VECTOR (31 downto 0);
			MUX_GPO : out STD_LOGIC_VECTOR (28 downto 0 )
		);
	end component;

	component OBUF
		port (
			I : in STD_LOGIC;
			O : out STD_LOGIC
		);
	end component;

	component IOBUF is
		port (
			I : in STD_LOGIC;
			O : out STD_LOGIC;
			T : in STD_LOGIC;
			IO : inout STD_LOGIC
		);
	end component;

	--gpio signals
	signal reset_par : STD_LOGIC_VECTOR (15 downto 0);

	signal PAR_TEST_GPIO0_IN_s : STD_LOGIC_VECTOR (31 downto 0);
	signal PAR_TEST_GPIO0_OUT_s : STD_LOGIC_VECTOR (31 downto 0);

	signal PAR_TEST_GPIO1_IN : STD_LOGIC_VECTOR (31 downto 0);
	signal PAR_TEST_GPIO1_OUT : STD_LOGIC_VECTOR (31 downto 0);

	signal PAR_TEST_GPIO2_IN : STD_LOGIC_VECTOR (31 downto 0);
	signal PAR_TEST_GPIO2_OUT : STD_LOGIC_VECTOR (31 downto 0);

	signal PAR_TEST_GPIO3_IN_S : STD_LOGIC_VECTOR (31 downto 0);
	signal PAR_TEST_GPIO3_OUT_S : STD_LOGIC_VECTOR (31 downto 0);

	signal PAR_TEST_GPIO4_IN : STD_LOGIC_VECTOR (31 downto 0);
	signal PAR_TEST_GPIO4_OUT : STD_LOGIC_VECTOR (31 downto 0);

	signal PAR_TEST_GPIO5_IN : STD_LOGIC_VECTOR (31 downto 0);
	signal PAR_TEST_GPIO5_OUT : STD_LOGIC_VECTOR (31 downto 0);

	signal PAR_TEST_GPIO6_IN : STD_LOGIC_VECTOR (31 downto 0);
	signal PAR_TEST_GPIO6_OUT : STD_LOGIC_VECTOR (31 downto 0);

	signal PAR_TEST_GPIO7_IN : STD_LOGIC_VECTOR (31 downto 0);
	signal PAR_TEST_GPIO7_OUT : STD_LOGIC_VECTOR (31 downto 0);
	signal CLK_MMC : STD_LOGIC_VECTOR(0 downto 0);
	signal CLK_PLL : STD_LOGIC_VECTOR(0 downto 0);
	signal sys_clk : STD_LOGIC_VECTOR(0 downto 0);

	signal UART_ZYNQ_rxd : STD_LOGIC;
	signal UART_ZYNQ_txd : STD_LOGIC;

	signal PMOD_JB_IN : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JB_OUT : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JB_OE : STD_LOGIC_VECTOR(7 downto 0);

	signal PMOD_JC_IN : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JC_OUT : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JC_OE : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JD_IN : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JD_OUT : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JD_OE : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JE_IN : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JE_OUT : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JE_OE : STD_LOGIC_VECTOR(7 downto 0);

	--par0
	signal PMOD_JB_IN_0 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JB_OUT_0 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JB_OE_0 : STD_LOGIC_VECTOR(7 downto 0);

	signal PMOD_JC_IN_0 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JC_OUT_0 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JC_OE_0 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JD_IN_0 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JD_OUT_0 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JD_OE_0 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JE_IN_0 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JE_OUT_0 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JE_OE_0 : STD_LOGIC_VECTOR(7 downto 0);

	signal RGB_LED1_0 : STD_LOGIC_VECTOR(2 downto 0);
	signal RGB_LED2_0 : STD_LOGIC_VECTOR(2 downto 0);
	signal LEDS_0 : STD_LOGIC_VECTOR(3 downto 0);

	--par1
	signal PMOD_JB_IN_1 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JB_OUT_1 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JB_OE_1 : STD_LOGIC_VECTOR(7 downto 0);

	signal PMOD_JC_IN_1 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JC_OUT_1 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JC_OE_1 : STD_LOGIC_VECTOR(7 downto 0);

	signal PMOD_JD_IN_1 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JD_OUT_1 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JD_OE_1 : STD_LOGIC_VECTOR(7 downto 0);

	signal PMOD_JE_IN_1 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JE_OUT_1 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JE_OE_1 : STD_LOGIC_VECTOR(7 downto 0);

	signal RGB_LED1_1 : STD_LOGIC_VECTOR(2 downto 0);
	signal RGB_LED2_1 : STD_LOGIC_VECTOR(2 downto 0);
	signal LEDS_1 : STD_LOGIC_VECTOR(3 downto 0);
	--par2
	signal PMOD_JB_IN_2 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JB_OUT_2 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JB_OE_2 : STD_LOGIC_VECTOR(7 downto 0);

	signal PMOD_JC_IN_2 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JC_OUT_2 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JC_OE_2 : STD_LOGIC_VECTOR(7 downto 0);

	signal PMOD_JD_IN_2 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JD_OUT_2 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JD_OE_2 : STD_LOGIC_VECTOR(7 downto 0);

	signal PMOD_JE_IN_2 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JE_OUT_2 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JE_OE_2 : STD_LOGIC_VECTOR(7 downto 0);

	signal RGB_LED1_2 : STD_LOGIC_VECTOR(2 downto 0);
	signal RGB_LED2_2 : STD_LOGIC_VECTOR(2 downto 0);
	signal LEDS_2 : STD_LOGIC_VECTOR(3 downto 0);

	--par3
	signal PMOD_JB_IN_3 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JB_OUT_3 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JB_OE_3 : STD_LOGIC_VECTOR(7 downto 0);

	signal PMOD_JC_IN_3 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JC_OUT_3 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JC_OE_3 : STD_LOGIC_VECTOR(7 downto 0);

	signal PMOD_JD_IN_3 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JD_OUT_3 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JD_OE_3 : STD_LOGIC_VECTOR(7 downto 0);

	signal PMOD_JE_IN_3 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JE_OUT_3 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JE_OE_3 : STD_LOGIC_VECTOR(7 downto 0);

	signal RGB_LED1_3 : STD_LOGIC_VECTOR(2 downto 0);
	signal RGB_LED2_3 : STD_LOGIC_VECTOR(2 downto 0);
	signal LEDS_3 : STD_LOGIC_VECTOR(3 downto 0);

	--par4
	signal PMOD_JB_IN_4 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JB_OUT_4 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JB_OE_4 : STD_LOGIC_VECTOR(7 downto 0);

	signal PMOD_JC_IN_4 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JC_OUT_4 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JC_OE_4 : STD_LOGIC_VECTOR(7 downto 0);

	signal PMOD_JD_IN_4 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JD_OUT_4 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JD_OE_4 : STD_LOGIC_VECTOR(7 downto 0);

	signal PMOD_JE_IN_4 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JE_OUT_4 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JE_OE_4 : STD_LOGIC_VECTOR(7 downto 0);

	signal RGB_LED1_4 : STD_LOGIC_VECTOR(2 downto 0);
	signal RGB_LED2_4 : STD_LOGIC_VECTOR(2 downto 0);
	signal LEDS_4 : STD_LOGIC_VECTOR(3 downto 0);

	--par5
	signal PMOD_JB_IN_5 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JB_OUT_5 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JB_OE_5 : STD_LOGIC_VECTOR(7 downto 0);

	signal PMOD_JC_IN_5 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JC_OUT_5 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JC_OE_5 : STD_LOGIC_VECTOR(7 downto 0);

	signal PMOD_JD_IN_5 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JD_OUT_5 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JD_OE_5 : STD_LOGIC_VECTOR(7 downto 0);

	signal PMOD_JE_IN_5 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JE_OUT_5 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JE_OE_5 : STD_LOGIC_VECTOR(7 downto 0);

	signal RGB_LED1_5 : STD_LOGIC_VECTOR(2 downto 0);
	signal RGB_LED2_5 : STD_LOGIC_VECTOR(2 downto 0);
	signal LEDS_5 : STD_LOGIC_VECTOR(3 downto 0);

	--par6
	signal PMOD_JB_IN_6 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JB_OUT_6 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JB_OE_6 : STD_LOGIC_VECTOR(7 downto 0);

	signal PMOD_JC_IN_6 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JC_OUT_6 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JC_OE_6 : STD_LOGIC_VECTOR(7 downto 0);

	signal PMOD_JD_IN_6 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JD_OUT_6 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JD_OE_6 : STD_LOGIC_VECTOR(7 downto 0);

	signal PMOD_JE_IN_6 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JE_OUT_6 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JE_OE_6 : STD_LOGIC_VECTOR(7 downto 0);

	signal RGB_LED1_6 : STD_LOGIC_VECTOR(2 downto 0);
	signal RGB_LED2_6 : STD_LOGIC_VECTOR(2 downto 0);
	signal LEDS_6 : STD_LOGIC_VECTOR(3 downto 0);
 
	--par7
	signal PMOD_JB_IN_7 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JB_OUT_7 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JB_OE_7 : STD_LOGIC_VECTOR(7 downto 0);

	signal PMOD_JC_IN_7 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JC_OUT_7 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JC_OE_7 : STD_LOGIC_VECTOR(7 downto 0);

	signal PMOD_JD_IN_7 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JD_OUT_7 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JD_OE_7 : STD_LOGIC_VECTOR(7 downto 0);

	signal PMOD_JE_IN_7 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JE_OUT_7 : STD_LOGIC_VECTOR(7 downto 0);
	signal PMOD_JE_OE_7 : STD_LOGIC_VECTOR(7 downto 0);

	signal RGB_LED1_7 : STD_LOGIC_VECTOR(2 downto 0);
	signal RGB_LED2_7 : STD_LOGIC_VECTOR(2 downto 0);
	signal LEDS_7 : STD_LOGIC_VECTOR(3 downto 0);

	signal MUX_GPIO : STD_LOGIC_VECTOR(28 downto 0);
	signal RGB_LED_obuf : STD_LOGIC_VECTOR(2 downto 0);

begin
	bd_name_wrapper_port_map : bd_name_wrapper
	port map(
		--CLK
		CLK_MMC => CLK_MMC, 
		CLK_PLL => CLK_PLL, 
 
		--DDR
		DDR_cas_n => DDR_cas_n, 
		DDR_cke => DDR_cke, 
		DDR_ck_n => DDR_ck_n, 
		DDR_ck_p => DDR_ck_p, 
		DDR_cs_n => DDR_cs_n, 
		DDR_reset_n => DDR_reset_n, 
		DDR_odt => DDR_odt, 
		DDR_ras_n => DDR_ras_n, 
		DDR_we_n => DDR_we_n, 
		DDR_ba => DDR_ba, 
		DDR_addr => DDR_addr, 
		DDR_dm => DDR_dm, 
		DDR_dq => DDR_dq, 
		DDR_dqs_n => DDR_dqs_n, 
		DDR_dqs_p => DDR_dqs_p, 
		--FIXEDIO
		FIXED_IO_mio => FIXED_IO_mio, 
		FIXED_IO_ddr_vrn => FIXED_IO_ddr_vrn, 
		FIXED_IO_ddr_vrp => FIXED_IO_ddr_vrp, 
		FIXED_IO_ps_srstb => FIXED_IO_ps_srstb, 
		FIXED_IO_ps_clk => FIXED_IO_ps_clk, 
		FIXED_IO_ps_porb => FIXED_IO_ps_porb, 

		--UART
		UART_ZYNQ_txd => UART_ZYNQ_txd, 
		UART_ZYNQ_rxd => UART_ZYNQ_rxd, 

		--Shared Reset
		reset_par => reset_par, 
		PAR_TEST_GPIO0_IN => PAR_TEST_GPIO0_IN_s, 
		PAR_TEST_GPIO1_IN => PAR_TEST_GPIO1_IN, 
		PAR_TEST_GPIO2_IN => PAR_TEST_GPIO2_IN, 
		PAR_TEST_GPIO3_IN => PAR_TEST_GPIO3_IN_S, 
		PAR_TEST_GPIO4_IN => PAR_TEST_GPIO4_IN, 
		PAR_TEST_GPIO5_IN => PAR_TEST_GPIO5_IN, 
		PAR_TEST_GPIO6_IN => PAR_TEST_GPIO6_IN, 
		PAR_TEST_GPIO7_IN => PAR_TEST_GPIO7_IN, 

		PAR_TEST_GPIO0_OUT => PAR_TEST_GPIO0_OUT_s, 
		PAR_TEST_GPIO1_OUT => PAR_TEST_GPIO1_OUT, 
		PAR_TEST_GPIO2_OUT => PAR_TEST_GPIO2_OUT, 
		PAR_TEST_GPIO3_OUT => PAR_TEST_GPIO3_OUT_S, 
		PAR_TEST_GPIO4_OUT => PAR_TEST_GPIO4_OUT, 
		PAR_TEST_GPIO5_OUT => PAR_TEST_GPIO5_OUT, 
		PAR_TEST_GPIO6_OUT => PAR_TEST_GPIO6_OUT, 
		PAR_TEST_GPIO7_OUT => PAR_TEST_GPIO7_OUT, 
 
		MUX_GPO => MUX_GPIO
	);

	par0pm : par0
	port map(
		CLK_125MHZ => sys_clock, 
		CLK_MMC => CLK_MMC, 
		CLK_PLL => CLK_PLL, 

		reset => reset_par(0), 

		PAR_TEST_GPIO0_IN => PAR_TEST_GPIO0_OUT_S, 
		PAR_TEST_GPIO0_OUT => PAR_TEST_GPIO0_IN_S, 

		PMOD_JB_IN => PMOD_JB_IN_0, 
		PMOD_JB_OUT => PMOD_JB_OUT_0, 
		PMOD_JB_OE => PMOD_JB_OE_0, 
 
		PMOD_JC_IN => PMOD_JC_IN_0, 
		PMOD_JC_OUT => PMOD_JC_OUT_0, 
		PMOD_JC_OE => PMOD_JC_OE_0, 

		PMOD_JD_IN => PMOD_JD_IN_0, 
		PMOD_JD_OUT => PMOD_JD_OUT_0, 
		PMOD_JD_OE => PMOD_JD_OE_0, 

		PMOD_JE_IN => PMOD_JE_IN_0, 
		PMOD_JE_OUT => PMOD_JE_OUT_0, 
		PMOD_JE_OE => PMOD_JE_OE_0, 

		leds => LEDS_0, 

		RGB_LED => RGB_LED1_0, 
		RGB_LED2 => RGB_LED2_0
	);

	par1pm : par1
	port map(
		CLK_125MHZ => sys_clock, 
		CLK_MMC => CLK_MMC, 
		CLK_PLL => CLK_PLL, 

		reset => reset_par(1), 

		PAR_TEST_GPIO0_IN => PAR_TEST_GPIO1_OUT, 
		PAR_TEST_GPIO0_OUT => PAR_TEST_GPIO1_IN, 

		PMOD_JB_IN => PMOD_JB_IN_1, 
		PMOD_JB_OUT => PMOD_JB_OUT_1, 
		PMOD_JB_OE => PMOD_JB_OE_1, 
 
		PMOD_JC_IN => PMOD_JC_IN_1, 
		PMOD_JC_OUT => PMOD_JC_OUT_1, 
		PMOD_JC_OE => PMOD_JC_OE_1, 

		PMOD_JD_IN => PMOD_JD_IN_1, 
		PMOD_JD_OUT => PMOD_JD_OUT_1, 
		PMOD_JD_OE => PMOD_JD_OE_1, 

		PMOD_JE_IN => PMOD_JE_IN_1, 
		PMOD_JE_OUT => PMOD_JE_OUT_1, 
		PMOD_JE_OE => PMOD_JE_OE_1, 

		leds => LEDS_1, 

		RGB_LED => RGB_LED1_1, 
		RGB_LED2 => RGB_LED2_1
	);
	par2pm : par2
	port map(
		CLK_125MHZ => sys_clock, 
		CLK_MMC => CLK_MMC, 
		CLK_PLL => CLK_PLL, 

		reset => reset_par(2), 

		PAR_TEST_GPIO0_IN => PAR_TEST_GPIO2_OUT, 
		PAR_TEST_GPIO0_OUT => PAR_TEST_GPIO2_IN, 

		PMOD_JB_IN => PMOD_JB_IN_2, 
		PMOD_JB_OUT => PMOD_JB_OUT_2, 
		PMOD_JB_OE => PMOD_JB_OE_2, 
 
		PMOD_JC_IN => PMOD_JC_IN_2, 
		PMOD_JC_OUT => PMOD_JC_OUT_2, 
		PMOD_JC_OE => PMOD_JC_OE_2, 

		PMOD_JD_IN => PMOD_JD_IN_2, 
		PMOD_JD_OUT => PMOD_JD_OUT_2, 
		PMOD_JD_OE => PMOD_JD_OE_2, 

		PMOD_JE_IN => PMOD_JE_IN_2, 
		PMOD_JE_OUT => PMOD_JE_OUT_2, 
		PMOD_JE_OE => PMOD_JE_OE_2, 

		leds => LEDS_2, 

		RGB_LED => RGB_LED1_2, 
		RGB_LED2 => RGB_LED2_2
	);

	par3pm : par3
	port map(
		CLK_125MHZ => sys_clock, 
		CLK_MMC => CLK_MMC, 
		CLK_PLL => CLK_PLL, 

		reset => reset_par(3), 

		PAR_TEST_GPIO0_IN => PAR_TEST_GPIO3_OUT_S, 
		PAR_TEST_GPIO0_OUT => PAR_TEST_GPIO3_IN_S, 

		PMOD_JB_IN => PMOD_JB_IN_3, 
		PMOD_JB_OUT => PMOD_JB_OUT_3, 
		PMOD_JB_OE => PMOD_JB_OE_3, 
 
		PMOD_JC_IN => PMOD_JC_IN_3, 
		PMOD_JC_OUT => PMOD_JC_OUT_3, 
		PMOD_JC_OE => PMOD_JC_OE_3, 

		PMOD_JD_IN => PMOD_JD_IN_3, 
		PMOD_JD_OUT => PMOD_JD_OUT_3, 
		PMOD_JD_OE => PMOD_JD_OE_3, 

		PMOD_JE_IN => PMOD_JE_IN_3, 
		PMOD_JE_OUT => PMOD_JE_OUT_3, 
		PMOD_JE_OE => PMOD_JE_OE_3, 

		leds => LEDS_3, 

		RGB_LED => RGB_LED1_3, 
		RGB_LED2 => RGB_LED2_3
	);
 
	par4pm : par4
	port map(
		CLK_125MHZ => sys_clock, 
		CLK_MMC => CLK_MMC, 
		CLK_PLL => CLK_PLL, 

		reset => reset_par(4), 

		PAR_TEST_GPIO0_IN => PAR_TEST_GPIO4_OUT, 
		PAR_TEST_GPIO0_OUT => PAR_TEST_GPIO4_In, 

		PMOD_JB_IN => PMOD_JB_IN_4, 
		PMOD_JB_OUT => PMOD_JB_OUT_4, 
		PMOD_JB_OE => PMOD_JB_OE_4, 
 
		PMOD_JC_IN => PMOD_JC_IN_4, 
		PMOD_JC_OUT => PMOD_JC_OUT_4, 
		PMOD_JC_OE => PMOD_JC_OE_4, 

		PMOD_JD_IN => PMOD_JD_IN_4, 
		PMOD_JD_OUT => PMOD_JD_OUT_4, 
		PMOD_JD_OE => PMOD_JD_OE_4, 

		PMOD_JE_IN => PMOD_JE_IN_4, 
		PMOD_JE_OUT => PMOD_JE_OUT_4, 
		PMOD_JE_OE => PMOD_JE_OE_4, 

		leds => LEDS_4, 

		RGB_LED => RGB_LED1_4, 
		RGB_LED2 => RGB_LED2_4
	);
 
	par5pm : par5
	port map(
		CLK_125MHZ => sys_clock, 
		CLK_MMC => CLK_MMC, 
		CLK_PLL => CLK_PLL, 

		reset => reset_par(5), 

		PAR_TEST_GPIO0_IN => PAR_TEST_GPIO5_OUT, 
		PAR_TEST_GPIO0_OUT => PAR_TEST_GPIO5_IN, 

		PMOD_JB_IN => PMOD_JB_IN_5, 
		PMOD_JB_OUT => PMOD_JB_OUT_5, 
		PMOD_JB_OE => PMOD_JB_OE_5
		, 
		PMOD_JC_IN => PMOD_JC_IN_5, 
		PMOD_JC_OUT => PMOD_JC_OUT_5, 
		PMOD_JC_OE => PMOD_JC_OE_5, 

		PMOD_JD_IN => PMOD_JD_IN_5, 
		PMOD_JD_OUT => PMOD_JD_OUT_5, 
		PMOD_JD_OE => PMOD_JD_OE_5, 

		PMOD_JE_IN => PMOD_JE_IN_5, 
		PMOD_JE_OUT => PMOD_JE_OUT_5, 
		PMOD_JE_OE => PMOD_JE_OE_5, 

		leds => LEDS_5, 

		RGB_LED => RGB_LED1_5, 
		RGB_LED2 => RGB_LED2_5
	);

	par6pm : par6
	port map(
		CLK_125MHZ => sys_clock, 
		CLK_MMC => CLK_MMC, 
		CLK_PLL => CLK_PLL, 
 
		reset => reset_par(6), 

		PAR_TEST_GPIO0_IN => PAR_TEST_GPIO6_OUT, 
		PAR_TEST_GPIO0_OUT => PAR_TEST_GPIO6_IN, 

		PMOD_JB_IN => PMOD_JB_IN_6, 
		PMOD_JB_OUT => PMOD_JB_OUT_6, 
		PMOD_JB_OE => PMOD_JB_OE_6, 
 
		PMOD_JC_IN => PMOD_JC_IN_6, 
		PMOD_JC_OUT => PMOD_JC_OUT_6, 
		PMOD_JC_OE => PMOD_JC_OE_6, 

		PMOD_JD_IN => PMOD_JD_IN_6, 
		PMOD_JD_OUT => PMOD_JD_OUT_6, 
		PMOD_JD_OE => PMOD_JD_OE_6, 

		PMOD_JE_IN => PMOD_JE_IN_6, 
		PMOD_JE_OUT => PMOD_JE_OUT_6, 
		PMOD_JE_OE => PMOD_JE_OE_6, 

		leds => LEDS_6, 

		RGB_LED => RGB_LED1_6, 
		RGB_LED2 => RGB_LED2_6
	);
	par7pm : par7
	port map(
		CLK_125MHZ => sys_clock, 
		CLK_MMC => CLK_MMC, 
		CLK_PLL => CLK_PLL, 

		uart_zynq_rxd => uart_zynq_rxd, 
		uart_zynq_txd => uart_zynq_txd, 
		reset => reset_par(7), 

		PAR_TEST_GPIO0_IN => PAR_TEST_GPIO7_OUT, 
		PAR_TEST_GPIO0_OUT => PAR_TEST_GPIO7_IN, 

		PMOD_JB_IN => PMOD_JB_IN_7, 
		PMOD_JB_OUT => PMOD_JB_OUT_7, 
		PMOD_JB_OE => PMOD_JB_OE_7, 
 
		PMOD_JC_IN => PMOD_JC_IN_7, 
		PMOD_JC_OUT => PMOD_JC_OUT_7, 
		PMOD_JC_OE => PMOD_JC_OE_7, 

		PMOD_JD_IN => PMOD_JD_IN_7, 
		PMOD_JD_OUT => PMOD_JD_OUT_7, 
		PMOD_JD_OE => PMOD_JD_OE_7, 

		PMOD_JE_IN => PMOD_JE_IN_7, 
		PMOD_JE_OUT => PMOD_JE_OUT_7, 
		PMOD_JE_OE => PMOD_JE_OE_7, 

		leds => LEDS_7, 

		RGB_LED => RGB_LED1_7, 
		RGB_LED2 => RGB_LED2_7
	);
 
 
	MUX0 : MUX
	port map(
		SYSCLK_125MHZ => sys_clock, 
		MUX_GPIO => MUX_GPIO, 
		RGB_LED1 => RGB_LED1, 
		RGB_LED2 => RGB_LED2, 
		LEDS => LEDS, 
 
		PMOD_JB_IN => PMOD_JB_IN, 
		PMOD_JB_OUT => PMOD_JB_OUT, 
		PMOD_JB_OE => PMOD_JB_OE, 
 
		PMOD_JC_IN => PMOD_JC_IN, 
		PMOD_JC_OUT => PMOD_JC_OUT, 
		PMOD_JC_OE => PMOD_JC_OE, 
 
		PMOD_JD_IN => PMOD_JD_IN, 
		PMOD_JD_OUT => PMOD_JD_OUT, 
		PMOD_JD_OE => PMOD_JD_OE, 
 
		PMOD_JE_IN => PMOD_JE_IN, 
		PMOD_JE_OUT => PMOD_JE_OUT, 
		PMOD_JE_OE => PMOD_JE_OE, 
 
		--par0
		PMOD_JB_IN_0 => PMOD_JB_IN_0, 
		PMOD_JB_OUT_0 => PMOD_JB_OUT_0, 
		PMOD_JB_OE_0 => PMOD_JB_OE_0, 
 
		PMOD_JC_IN_0 => PMOD_JC_IN_0, 
		PMOD_JC_OUT_0 => PMOD_JC_OUT_0, 
		PMOD_JC_OE_0 => PMOD_JC_OE_0, 
 
		PMOD_JD_IN_0 => PMOD_JD_IN_0, 
		PMOD_JD_OUT_0 => PMOD_JD_OUT_0, 
		PMOD_JD_OE_0 => PMOD_JD_OE_0, 
 
		PMOD_JE_IN_0 => PMOD_JE_IN_0, 
		PMOD_JE_OUT_0 => PMOD_JE_OUT_0, 
		PMOD_JE_OE_0 => PMOD_JE_OE_0, 
 
		RGB_LED1_0 => RGB_LED1_0, 
		RGB_LED2_0 => RGB_LED2_0, 
		LEDS_0 => LEDS_0, 
 
		--par1
		PMOD_JB_IN_1 => PMOD_JB_IN_1, 
		PMOD_JB_OUT_1 => PMOD_JB_OUT_1, 
		PMOD_JB_OE_1 => PMOD_JB_OE_1, 
 
		PMOD_JC_IN_1 => PMOD_JC_IN_1, 
		PMOD_JC_OUT_1 => PMOD_JC_OUT_1, 
		PMOD_JC_OE_1 => PMOD_JC_OE_1, 
 
		PMOD_JD_IN_1 => PMOD_JD_IN_1, 
		PMOD_JD_OUT_1 => PMOD_JD_OUT_1, 
		PMOD_JD_OE_1 => PMOD_JD_OE_1, 
 
		PMOD_JE_IN_1 => PMOD_JE_IN_1, 
		PMOD_JE_OUT_1 => PMOD_JE_OUT_1, 
		PMOD_JE_OE_1 => PMOD_JE_OE_1, 
 
		RGB_LED1_1 => RGB_LED1_1, 
		RGB_LED2_1 => RGB_LED2_1, 
		LEDS_1 => LEDS_1, 
		--par2
		PMOD_JB_IN_2 => PMOD_JB_IN_2, 
		PMOD_JB_OUT_2 => PMOD_JB_OUT_2, 
		PMOD_JB_OE_2 => PMOD_JB_OE_2, 
 
		PMOD_JC_IN_2 => PMOD_JC_IN_2, 
		PMOD_JC_OUT_2 => PMOD_JC_OUT_2, 
		PMOD_JC_OE_2 => PMOD_JC_OE_2, 
 
		PMOD_JD_IN_2 => PMOD_JD_IN_2, 
		PMOD_JD_OUT_2 => PMOD_JD_OUT_2, 
		PMOD_JD_OE_2 => PMOD_JD_OE_2, 
 
		PMOD_JE_IN_2 => PMOD_JE_IN_2, 
		PMOD_JE_OUT_2 => PMOD_JE_OUT_2, 
		PMOD_JE_OE_2 => PMOD_JE_OE_2, 
 
		RGB_LED1_2 => RGB_LED1_2, 
		RGB_LED2_2 => RGB_LED2_2, 
		LEDS_2 => LEDS_2, 
 
		--par3
		PMOD_JB_IN_3 => PMOD_JB_IN_3, 
		PMOD_JB_OUT_3 => PMOD_JB_OUT_3, 
		PMOD_JB_OE_3 => PMOD_JB_OE_3, 
 
		PMOD_JC_IN_3 => PMOD_JC_IN_3, 
		PMOD_JC_OUT_3 => PMOD_JC_OUT_3, 
		PMOD_JC_OE_3 => PMOD_JC_OE_3, 
 
		PMOD_JD_IN_3 => PMOD_JD_IN_3, 
		PMOD_JD_OUT_3 => PMOD_JD_OUT_3, 
		PMOD_JD_OE_3 => PMOD_JD_OE_3, 
 
		PMOD_JE_IN_3 => PMOD_JE_IN_3, 
		PMOD_JE_OUT_3 => PMOD_JE_OUT_3, 
		PMOD_JE_OE_3 => PMOD_JE_OE_3, 
 
		RGB_LED1_3 => RGB_LED1_3, 
		RGB_LED2_3 => RGB_LED2_3, 
		LEDS_3 => LEDS_3, 
 
		--par4
		PMOD_JB_IN_4 => PMOD_JB_IN_4, 
		PMOD_JB_OUT_4 => PMOD_JB_OUT_4, 
		PMOD_JB_OE_4 => PMOD_JB_OE_4, 
 
		PMOD_JC_IN_4 => PMOD_JC_IN_4, 
		PMOD_JC_OUT_4 => PMOD_JC_OUT_4, 
		PMOD_JC_OE_4 => PMOD_JC_OE_4, 
 
		PMOD_JD_IN_4 => PMOD_JD_IN_4, 
		PMOD_JD_OUT_4 => PMOD_JD_OUT_4, 
		PMOD_JD_OE_4 => PMOD_JD_OE_4, 
 
		PMOD_JE_IN_4 => PMOD_JE_IN_4, 
		PMOD_JE_OUT_4 => PMOD_JE_OUT_4, 
		PMOD_JE_OE_4 => PMOD_JE_OE_4, 
 
		RGB_LED1_4 => RGB_LED1_4, 
		RGB_LED2_4 => RGB_LED2_4, 
		LEDS_4 => LEDS_4, 
 
		--par5
		PMOD_JB_IN_5 => PMOD_JB_IN_5, 
		PMOD_JB_OUT_5 => PMOD_JB_OUT_5, 
		PMOD_JB_OE_5 => PMOD_JB_OE_5, 
 
		PMOD_JC_IN_5 => PMOD_JC_IN_5, 
		PMOD_JC_OUT_5 => PMOD_JC_OUT_5, 
		PMOD_JC_OE_5 => PMOD_JC_OE_5, 
 
		PMOD_JD_IN_5 => PMOD_JD_IN_5, 
		PMOD_JD_OUT_5 => PMOD_JD_OUT_5, 
		PMOD_JD_OE_5 => PMOD_JD_OE_5, 
 
		PMOD_JE_IN_5 => PMOD_JE_IN_5, 
		PMOD_JE_OUT_5 => PMOD_JE_OUT_5, 
		PMOD_JE_OE_5 => PMOD_JE_OE_5, 
 
		RGB_LED1_5 => RGB_LED1_5, 
		RGB_LED2_5 => RGB_LED2_5, 
		LEDS_5 => LEDS_5, 
 
		--par6
		PMOD_JB_IN_6 => PMOD_JB_IN_6, 
		PMOD_JB_OUT_6 => PMOD_JB_OUT_6, 
		PMOD_JB_OE_6 => PMOD_JB_OE_6, 
 
		PMOD_JC_IN_6 => PMOD_JC_IN_6, 
		PMOD_JC_OUT_6 => PMOD_JC_OUT_6, 
		PMOD_JC_OE_6 => PMOD_JC_OE_6, 
 
		PMOD_JD_IN_6 => PMOD_JD_IN_6, 
		PMOD_JD_OUT_6 => PMOD_JD_OUT_6, 
		PMOD_JD_OE_6 => PMOD_JD_OE_6, 
 
		PMOD_JE_IN_6 => PMOD_JE_IN_6, 
		PMOD_JE_OUT_6 => PMOD_JE_OUT_6, 
		PMOD_JE_OE_6 => PMOD_JE_OE_6, 
 
		RGB_LED1_6 => RGB_LED1_6, 
		RGB_LED2_6 => RGB_LED2_6, 
		LEDS_6 => LEDS_6, 
 
		--par7
		PMOD_JB_IN_7 => PMOD_JB_IN_7, 
		PMOD_JB_OUT_7 => PMOD_JB_OUT_7, 
		PMOD_JB_OE_7 => PMOD_JB_OE_7, 
 
		PMOD_JC_IN_7 => PMOD_JC_IN_7, 
		PMOD_JC_OUT_7 => PMOD_JC_OUT_7, 
		PMOD_JC_OE_7 => PMOD_JC_OE_7, 
 
		PMOD_JD_IN_7 => PMOD_JD_IN_7, 
		PMOD_JD_OUT_7 => PMOD_JD_OUT_7, 
		PMOD_JD_OE_7 => PMOD_JD_OE_7, 
 
		PMOD_JE_IN_7 => PMOD_JE_IN_7, 
		PMOD_JE_OUT_7 => PMOD_JE_OUT_7, 
		PMOD_JE_OE_7 => PMOD_JE_OE_7, 
 
		RGB_LED1_7 => RGB_LED1_7, 
		RGB_LED2_7 => RGB_LED2_7, 
		LEDS_7 => LEDS_7 
	);

 
	IOBUF0 : IOBUF
	port map(
		I => PMOD_JB_OUT(0), 
		O => PMOD_JB_IN(0), 
		T => PMOD_JB_OE(0), 
		IO => PMOD_JB(0)
	);

	IOBUF1 : IOBUF
	port map(
		I => PMOD_JB_OUT(1), 
		O => PMOD_JB_IN(1), 
		T => PMOD_JB_OE(1), 
		IO => PMOD_JB(1)
	);

	IOBUF2 : IOBUF
	port map(
		I => PMOD_JB_OUT(2), 
		O => PMOD_JB_IN(2), 
		T => PMOD_JB_OE(2), 
		IO => PMOD_JB(2)
	);

	IOBUF3 : IOBUF
	port map(
		I => PMOD_JB_OUT(3), 
		O => PMOD_JB_IN(3), 
		T => PMOD_JB_OE(3), 
		IO => PMOD_JB(3)
	);

	IOBUF4 : IOBUF
	port map(
		I => PMOD_JB_OUT(4), 
		O => PMOD_JB_IN(4), 
		T => PMOD_JB_OE(4), 
		IO => PMOD_JB(4)
	);

	IOBUF5 : IOBUF
	port map(
		I => PMOD_JB_OUT(5), 
		O => PMOD_JB_IN(5), 
		T => PMOD_JB_OE(5), 
		IO => PMOD_JB(5)
	);

	IOBUF6 : IOBUF
	port map(
		I => PMOD_JB_OUT(6), 
		O => PMOD_JB_IN(6), 
		T => PMOD_JB_OE(6), 
		IO => PMOD_JB(6)
	);

	IOBUF7 : IOBUF
	port map(
		I => PMOD_JB_OUT(7), 
		O => PMOD_JB_IN(7), 
		T => PMOD_JB_OE(7), 
		IO => PMOD_JB(7)
	);
	IOBUF0C : IOBUF
	port map(
		I => PMOD_JC_OUT(0), 
		O => PMOD_JC_IN(0), 
		T => PMOD_JC_OE(0), 
		IO => PMOD_JC(0)
	);

	IOBUF1C : IOBUF
	port map(
		I => PMOD_JC_OUT(1), 
		O => PMOD_JC_IN(1), 
		T => PMOD_JC_OE(1), 
		IO => PMOD_JC(1)
	);

	IOBUF2C : IOBUF
	port map(
		I => PMOD_JC_OUT(2), 
		O => PMOD_JC_IN(2), 
		T => PMOD_JC_OE(2), 
		IO => PMOD_JC(2)
	);

	IOBUF3C : IOBUF
	port map(
		I => PMOD_JC_OUT(3), 
		O => PMOD_JC_IN(3), 
		T => PMOD_JC_OE(3), 
		IO => PMOD_JC(3)
	);

	IOBUF4C : IOBUF
	port map(
		I => PMOD_JC_OUT(4), 
		O => PMOD_JC_IN(4), 
		T => PMOD_JC_OE(4), 
		IO => PMOD_JC(4)
	);

	IOBUF5C : IOBUF
	port map(
		I => PMOD_JC_OUT(5), 
		O => PMOD_JC_IN(5), 
		T => PMOD_JC_OE(5), 
		IO => PMOD_JC(5)
	);

	IOBUF6C : IOBUF
	port map(
		I => PMOD_JC_OUT(6), 
		O => PMOD_JC_IN(6), 
		T => PMOD_JC_OE(6), 
		IO => PMOD_JC(6)
	);

	IOBUF7C : IOBUF
	port map(
		I => PMOD_JC_OUT(7), 
		O => PMOD_JC_IN(7), 
		T => PMOD_JC_OE(7), 
		IO => PMOD_JC(7)
	);
	IOBUF0D : IOBUF
	port map(
		I => PMOD_JD_OUT(0), 
		O => PMOD_JD_IN(0), 
		T => PMOD_JD_OE(0), 
		IO => PMOD_JD(0)
	);

	IOBUF1D : IOBUF
	port map(
		I => PMOD_JD_OUT(1), 
		O => PMOD_JD_IN(1), 
		T => PMOD_JD_OE(1), 
		IO => PMOD_JD(1)
	);

	IOBUF2D : IOBUF
	port map(
		I => PMOD_JD_OUT(2), 
		O => PMOD_JD_IN(2), 
		T => PMOD_JD_OE(2), 
		IO => PMOD_JD(2)
	);

	IOBUF3D : IOBUF
	port map(
		I => PMOD_JD_OUT(3), 
		O => PMOD_JD_IN(3), 
		T => PMOD_JD_OE(3), 
		IO => PMOD_JD(3)
	);

	IOBUF4D : IOBUF
	port map(
		I => PMOD_JD_OUT(4), 
		O => PMOD_JD_IN(4), 
		T => PMOD_JD_OE(4), 
		IO => PMOD_JD(4)
	);

	IOBUF5D : IOBUF
	port map(
		I => PMOD_JD_OUT(5), 
		O => PMOD_JD_IN(5), 
		T => PMOD_JD_OE(5), 
		IO => PMOD_JD(5)
	);

	IOBUF6D : IOBUF
	port map(
		I => PMOD_JD_OUT(6), 
		O => PMOD_JD_IN(6), 
		T => PMOD_JD_OE(6), 
		IO => PMOD_JD(6)
	);

	IOBUF7D : IOBUF
	port map(
		I => PMOD_JD_OUT(7), 
		O => PMOD_JD_IN(7), 
		T => PMOD_JD_OE(7), 
		IO => PMOD_JD(7)
	);

	IOBUF0E : IOBUF
	port map(
		I => PMOD_JE_OUT(0), 
		O => PMOD_JE_IN(0), 
		T => PMOD_JE_OE(0), 
		IO => PMOD_JE(0)
	);

	IOBUF1E : IOBUF
	port map(
		I => PMOD_JE_OUT(1), 
		O => PMOD_JE_IN(1), 
		T => PMOD_JE_OE(1), 
		IO => PMOD_JE(1)
	);

	IOBUF2E : IOBUF
	port map(
		I => PMOD_JE_OUT(2), 
		O => PMOD_JE_IN(2), 
		T => PMOD_JE_OE(2), 
		IO => PMOD_JE(2)
	);

	IOBUF3E : IOBUF
	port map(
		I => PMOD_JE_OUT(3), 
		O => PMOD_JE_IN(3), 
		T => PMOD_JE_OE(3), 
		IO => PMOD_JE(3)
	);

	IOBUF4E : IOBUF
	port map(
		I => PMOD_JE_OUT(4), 
		O => PMOD_JE_IN(4), 
		T => PMOD_JE_OE(4), 
		IO => PMOD_JE(4)
	);

	IOBUF5E : IOBUF
	port map(
		I => PMOD_JE_OUT(5), 
		O => PMOD_JE_IN(5), 
		T => PMOD_JE_OE(5), 
		IO => PMOD_JE(5)
	);

	IOBUF6E : IOBUF
	port map(
		I => PMOD_JE_OUT(6), 
		O => PMOD_JE_IN(6), 
		T => PMOD_JE_OE(6), 
		IO => PMOD_JE(6)
	);

	IOBUF7E : IOBUF
	port map(
		I => PMOD_JE_OUT(7), 
		O => PMOD_JE_IN(7), 
		T => PMOD_JE_OE(7), 
		IO => PMOD_JE(7)
	);

end Behavioral;