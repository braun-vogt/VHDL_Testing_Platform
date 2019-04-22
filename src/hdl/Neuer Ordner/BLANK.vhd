----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 11.03.2019 20:58:37
-- Design Name:
-- Module Name: BLANK - Behavioral
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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY BLANK IS
	PORT (
                CLK_MMC : IN STD_LOGIC;
                CLK_PLL : IN STD_LOGIC;
                RST : IN STD_LOGIC;
     
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
                    
           
                RGB_LED : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                RGB_LED2 : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
                
                UART_ZYNQ_rxd : in STD_LOGIC;
                UART_ZYNQ_txd : out STD_LOGIC;
     
                GPIO_PART_Input : in STD_LOGIC_VECTOR (31 DOWNTO 0);
                GPIO_PART_Output : out STD_LOGIC_VECTOR (31 DOWNTO 0);
                
                IIC_ZYNQ_sda_i : in STD_LOGIC;
                IIC_ZYNQ_sda_o : out STD_LOGIC;
                IIC_ZYNQ_scl_i : in STD_LOGIC;
                IIC_ZYNQ_scl_o : out STD_LOGIC
	);
END BLANK;

ARCHITECTURE Behavioral OF BLANK IS
BEGIN
	PROCESS (clk_mmc,CLK_PLL, RST)
	BEGIN
		IF (RST = '1') THEN
		ELSIF (rising_edge(clk_mmc)) THEN
			if(GPIO_part_input /= "00001111000011110000111100001111")then
			     GPIO_PART_Output<=PMOD_JB_in&PMOD_JC_in&PMOD_JD_in&PMOD_JE_in;
			     --GPIO_PART_OUTPUT<=GPIO_PART_INPUT;
			     
			end if;
			UART_ZYNQ_txd<=UART_ZYNQ_rxd;
            IIC_ZYNQ_sda_o<=IIC_ZYNQ_sda_i;
            IIC_ZYNQ_scl_o<=IIC_ZYNQ_scl_i;
			RGB_LED<=GPIO_PART_Input(2 downto 0);
			
		END IF;
	END PROCESS;

	PMOD_JB_out <= gpio_part_input(7 downto 0)  when (GPIO_part_input="00001111000011110000111100001111") else(others=>'Z');
	PMOD_JB_oe <= gpio_part_input(7 downto 0)  when (GPIO_part_input="00001111000011110000111100001111") else (others=>'Z');
	
	PMOD_JC_out <= gpio_part_input(7 downto 0)  when (GPIO_part_input="00001111000011110000111100001111") else (others=>'Z');
	PMOD_JC_oe <= gpio_part_input(7 downto 0) when (GPIO_part_input="00001111000011110000111100001111") else (others=>'Z');
	
	PMOD_JD_out<= gpio_part_input(7 downto 0)  when (GPIO_part_input="00001111000011110000111100001111") else (others=>'Z');
	PMOD_JE_oe <= gpio_part_input(7 downto 0)  when (GPIO_part_input="00001111000011110000111100001111") else (others=>'Z');


END Behavioral;