----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.03.2019 14:05:11
-- Design Name: 
-- Module Name: GPIO_TEST - Behavioral
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

entity GPIO_TEST is
  Port (    CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           PMOD_JB: inout STD_LOGIC_VECTOR(7 downto 0);
           PMOD_JC:inout STD_LOGIC_VECTOR(7 downto 0);
           PMOD_JD:inout STD_LOGIC_VECTOR(7 downto 0);
           PMOD_JE:inout STD_LOGIC_VECTOR(7 downto 0);
           RGB_LED : out STD_LOGIC_VECTOR (2 downto 0);
           GPIO_PART_Input : in STD_LOGIC_VECTOR ( 31 downto 0 );
           GPIO_PART_Output : out STD_LOGIC_VECTOR ( 31 downto 0 )); 
end GPIO_TEST;

architecture Behavioral of GPIO_TEST is

begin
Gpio_PART_output<=Gpio_Part_Input;
RGB_LED<=GPIO_PART_Input(2 downto 0);
end Behavioral;
