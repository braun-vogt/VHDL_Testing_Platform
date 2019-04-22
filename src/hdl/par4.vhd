----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.04.2019 22:58:39
-- Design Name: 
-- Module Name: par3 - Behavioral
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

entity par4 is
  Port (
  CLK_125MHZ : in STD_LOGIC;
           CLK_MMC : in STD_LOGIC_VECTOR ( 0 to 0 );
           CLK_PLL : in STD_LOGIC_VECTOR ( 0 to 0 );
           
           reset : in STD_LOGIC;
           
           PAR_TEST_GPIO0_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
           PAR_TEST_GPIO0_OUT : out STD_LOGIC_VECTOR ( 31 downto 0 );
           
           PMOD_JB_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
           PMOD_JB_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
           PMOD_JB_OE : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            
           PMOD_JC_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
           PMOD_JC_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
           PMOD_JC_OE : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
            
           PMOD_JD_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
           PMOD_JD_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
           PMOD_JD_OE : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
             
           PMOD_JE_IN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
           PMOD_JE_OUT : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
           PMOD_JE_OE : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);   
           
           leds : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
           
           RGB_LED : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
           RGB_LED2 : OUT STD_LOGIC_VECTOR (2 DOWNTO 0) );
end par4;

architecture Behavioral of par4 is

begin


end Behavioral;
