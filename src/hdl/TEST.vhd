----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.03.2019 11:13:14
-- Design Name: 
-- Module Name: TEST - Behavioral
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

entity TEST is
--  Port (entity GPIO_TEST is
  Port (    CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           PMOD_JB: inout STD_LOGIC_VECTOR(7 downto 0);
           PMOD_JC:inout STD_LOGIC_VECTOR(7 downto 0);
           PMOD_JD:inout STD_LOGIC_VECTOR(7 downto 0);
           PMOD_JE:inout STD_LOGIC_VECTOR(7 downto 0);
           RGB_LED : out STD_LOGIC_VECTOR (2 downto 0);
           GPIO_PART_Input : in STD_LOGIC_VECTOR ( 31 downto 0 );
           GPIO_PART_Output : out STD_LOGIC_VECTOR ( 31 downto 0 ) );
end TEST;

architecture Behavioral of TEST is
signal zhl : integer :=0;
signal teiler :integer:=0;
begin
process(CLK,rst)
begin
    if(rst='1') then
    zhl<=0;
    teiler<=0;
    elsif(rising_edge(CLK)) then
        teiler<=teiler+1;
        if(teiler=125000000) then
            zhl<=zhl+1;
            if(zhl>32) then
                zhl<=0;
            end if;
        end if;

        GPIO_PART_OUTput<=std_logic_vector(to_unsigned(zhl,32));
        RGB_LED<=GPIO_PART_INput(2 downto 0);
    end if;
end process;
end Behavioral;
