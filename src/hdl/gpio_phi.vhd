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
  Port (    	                  
         
                RGB_LED2 : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);

                GPIO_PART_Input : in STD_LOGIC_VECTOR (5 DOWNTO 3);
                GPIO_PART_Output : out STD_LOGIC_VECTOR (5 DOWNTO 3)); 
end GPIO_TEST;

architecture Behavioral of GPIO_TEST is

begin
Gpio_PART_output<=Gpio_Part_Input;
RGB_LED2<=GPIO_PART_Input(5 downto 3);

end Behavioral;
