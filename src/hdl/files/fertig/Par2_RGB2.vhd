----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.04.2019 14:40:51
-- Design Name: 
-- Module Name: Par2_RGB2 - Behavioral
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

entity Par2_RGB2 is
 Port (
                CLK_125MHZ : in STD_LOGIC;
            
                CLK_PLL : in STD_LOGIC_VECTOR ( 0 to 0 );
                
                reset : in STD_LOGIC;
                
                PAR_TEST_GPIO0_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
                PAR_TEST_GPIO0_OUT : out STD_LOGIC_VECTOR ( 31 downto 0 );
                
                 
                PMOD_JC_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
                PMOD_JC_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
                PMOD_JC_OE : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
                 
             
                
                RGB_LED2 : OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
  );
end Par2_RGB2;

architecture Behavioral of Par2_RGB2 is

begin

  PAR_TEST_GPIO0_OUT<=PAR_TEST_GPIO0_IN;
  RGB_LED2<=PAR_TEST_GPIO0_IN(2 downto 0);

end Behavioral;
