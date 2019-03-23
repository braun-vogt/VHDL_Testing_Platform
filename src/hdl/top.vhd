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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY top IS
	PORT (
	    --user pmod
		PMOD_JB : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		PMOD_JC : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		PMOD_JD : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		PMOD_JE : INOUT STD_LOGIC_VECTOR(7 DOWNTO 0);
 
        --clk
		sys_clock : IN STD_LOGIC;
		
		--debug PROCESSOR
		btns_4bits_tri_i : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		leds_4bits_tri_io : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		
		--part RGB
		RGB_LED : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);

		DDR_addr : INOUT STD_LOGIC_VECTOR (14 DOWNTO 0);
		DDR_ba : INOUT STD_LOGIC_VECTOR (2 DOWNTO 0);
		DDR_cas_n : INOUT STD_LOGIC;
		DDR_ck_n : INOUT STD_LOGIC;
		DDR_ck_p : INOUT STD_LOGIC;
		DDR_cke : INOUT STD_LOGIC;
		DDR_cs_n : INOUT STD_LOGIC;
		DDR_dm : INOUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		DDR_dq : INOUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		DDR_dqs_n : INOUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		DDR_dqs_p : INOUT STD_LOGIC_VECTOR (3 DOWNTO 0);
		DDR_odt : INOUT STD_LOGIC;
		DDR_ras_n : INOUT STD_LOGIC;
		DDR_reset_n : INOUT STD_LOGIC;
		DDR_we_n : INOUT STD_LOGIC;
		FIXED_IO_ddr_vrn : INOUT STD_LOGIC;
		FIXED_IO_ddr_vrp : INOUT STD_LOGIC;
		FIXED_IO_mio : INOUT STD_LOGIC_VECTOR (53 DOWNTO 0);
		FIXED_IO_ps_clk : INOUT STD_LOGIC;
		FIXED_IO_ps_porb : INOUT STD_LOGIC;
		FIXED_IO_ps_srstb : INOUT STD_LOGIC
	);
END top;

ARCHITECTURE Behavioral OF top IS

	COMPONENT bd_name_wrapper IS
		PORT (
			BUTTONS_tri_i : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			CLK_MMC : OUT STD_LOGIC_VECTOR (0 TO 0);
			CLK_PLL : OUT STD_LOGIC_VECTOR (0 TO 0);
			DDR_addr : INOUT STD_LOGIC_VECTOR (14 DOWNTO 0);
			DDR_ba : INOUT STD_LOGIC_VECTOR (2 DOWNTO 0);
			DDR_cas_n : INOUT STD_LOGIC;
			DDR_ck_n : INOUT STD_LOGIC;
			DDR_ck_p : INOUT STD_LOGIC;
			DDR_cke : INOUT STD_LOGIC;
			DDR_cs_n : INOUT STD_LOGIC;
			DDR_dm : INOUT STD_LOGIC_VECTOR (3 DOWNTO 0);
			DDR_dq : INOUT STD_LOGIC_VECTOR (31 DOWNTO 0);
			DDR_dqs_n : INOUT STD_LOGIC_VECTOR (3 DOWNTO 0);
			DDR_dqs_p : INOUT STD_LOGIC_VECTOR (3 DOWNTO 0);
			DDR_odt : INOUT STD_LOGIC;
			DDR_ras_n : INOUT STD_LOGIC;
			DDR_reset_n : INOUT STD_LOGIC;
			DDR_we_n : INOUT STD_LOGIC;
			FIXED_IO_ddr_vrn : INOUT STD_LOGIC;
			FIXED_IO_ddr_vrp : INOUT STD_LOGIC;
			FIXED_IO_mio : INOUT STD_LOGIC_VECTOR (53 DOWNTO 0);
			FIXED_IO_ps_clk : INOUT STD_LOGIC;
			FIXED_IO_ps_porb : INOUT STD_LOGIC;
			FIXED_IO_ps_srstb : INOUT STD_LOGIC;
			LED_tri_o : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
			UART_ZYNQ_rxd : IN STD_LOGIC;
			UART_ZYNQ_txd : OUT STD_LOGIC;
			par_gpio_i : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			par_gpio_o : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
			par_rst : OUT STD_LOGIC_VECTOR (0 TO 0);
			sys_clock : IN STD_LOGIC;
			IIC_ZYNQ_sda_i : IN STD_LOGIC;
			IIC_ZYNQ_sda_o : OUT STD_LOGIC;
			IIC_ZYNQ_sda_t : OUT STD_LOGIC;
			IIC_ZYNQ_scl_i : IN STD_LOGIC;
			IIC_ZYNQ_scl_o : OUT STD_LOGIC;
			IIC_ZYNQ_scl_t : OUT STD_LOGIC 
		);
	END COMPONENT;

	--gpio signals
	SIGNAL gpio_i : STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL gpio_o : STD_LOGIC_VECTOR (31 DOWNTO 0);
	SIGNAL par_rst : STD_LOGIC_VECTOR(0 DOWNTO 0);
	SIGNAL CLK_MMC : STD_LOGIC_VECTOR(0 DOWNTO 0);
	SIGNAL CLK_PLL : STD_LOGIC_VECTOR(0 DOWNTO 0);
 
	SIGNAL UART_ZYNQ_rxd : STD_LOGIC;
	SIGNAL UART_ZYNQ_txd : STD_LOGIC;
 
	SIGNAL IIC_ZYNQ_sda_i : STD_LOGIC;
	SIGNAL IIC_ZYNQ_sda_o : STD_LOGIC;
	SIGNAL IIC_ZYNQ_scl_i : STD_LOGIC;
	SIGNAL IIC_ZYNQ_scl_o : STD_LOGIC;
 

	COMPONENT BLANK IS
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
 
			UART_ZYNQ_rxd : IN STD_LOGIC;
			UART_ZYNQ_txd : OUT STD_LOGIC;

			GPIO_PART_Input : IN STD_LOGIC_VECTOR (31 DOWNTO 0);
			GPIO_PART_Output : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
 
			IIC_ZYNQ_sda_i : IN STD_LOGIC;
			IIC_ZYNQ_sda_o : OUT STD_LOGIC;
			IIC_ZYNQ_scl_i : IN STD_LOGIC;
			IIC_ZYNQ_scl_o : OUT STD_LOGIC
		);
	END COMPONENT;
 
	COMPONENT IOBUF IS
		PORT (
			I : IN STD_LOGIC;
			O : OUT STD_LOGIC;
			T : IN STD_LOGIC;
			IO : INOUT STD_LOGIC
		);
	END COMPONENT;
 
 
	SIGNAL PMOD_JB_IN : STD_LOGIC_VECTOR(7 DOWNTO 0); 
	SIGNAL PMOD_JB_OUT : STD_LOGIC_VECTOR(7 DOWNTO 0); 
	SIGNAL PMOD_JB_OE : STD_LOGIC_VECTOR(7 DOWNTO 0); 
	
	SIGNAL PMOD_JC_IN : STD_LOGIC_VECTOR(7 DOWNTO 0); 
    SIGNAL PMOD_JC_OUT : STD_LOGIC_VECTOR(7 DOWNTO 0); 
    SIGNAL PMOD_JC_OE : STD_LOGIC_VECTOR(7 DOWNTO 0); 
        
        
    SIGNAL PMOD_JD_IN : STD_LOGIC_VECTOR(7 DOWNTO 0); 
    SIGNAL PMOD_JD_OUT : STD_LOGIC_VECTOR(7 DOWNTO 0); 
    SIGNAL PMOD_JD_OE : STD_LOGIC_VECTOR(7 DOWNTO 0); 
            
            
    SIGNAL PMOD_JE_IN : STD_LOGIC_VECTOR(7 DOWNTO 0); 
    SIGNAL PMOD_JE_OUT : STD_LOGIC_VECTOR(7 DOWNTO 0); 
    SIGNAL PMOD_JE_OE : STD_LOGIC_VECTOR(7 DOWNTO 0); 
	
BEGIN
	    IOBUF0 : IOBUF
	    PORT MAP(
		I => PMOD_JB_OUT(0), 
		O => PMOD_JB_IN(0), 
		T => PMOD_JB_OE(0), 
		IO => PMOD_JB(0));
		
		IOBUF1 : IOBUF PORT MAP(
		I => PMOD_JB_OUT(1), 
		O => PMOD_JB_IN(1), 
		T => PMOD_JB_OE(1), 
		IO => PMOD_JB(1));
		
		IOBUF2 : IOBUF PORT MAP(
		I => PMOD_JB_OUT(2), 
		O => PMOD_JB_IN(2), 
		T => PMOD_JB_OE(2), 
		IO => PMOD_JB(2));
		
		IOBUF3 : IOBUF PORT MAP(
		I => PMOD_JB_OUT(3), 
		O => PMOD_JB_IN(3), 
		T => PMOD_JB_OE(3), 
		IO => PMOD_JB(3));
		
		IOBUF4 : IOBUF PORT MAP(
		I => PMOD_JB_OUT(4), 
		O => PMOD_JB_IN(4), 
		T => PMOD_JB_OE(4), 
		IO => PMOD_JB(4));
		
		IOBUF5 : IOBUF PORT MAP(
		I => PMOD_JB_OUT(5), 
		O => PMOD_JB_IN(5), 
		T => PMOD_JB_OE(5), 
		IO => PMOD_JB(5));
		
		IOBUF6 : IOBUF PORT MAP(
		I => PMOD_JB_OUT(6), 
		O => PMOD_JB_IN(6), 
		T => PMOD_JB_OE(6), 
		IO => PMOD_JB(6));
		
		IOBUF7 : IOBUF PORT MAP(
        I => PMOD_JB_OUT(7), 
        O => PMOD_JB_IN(7), 
        T => PMOD_JB_OE(7), 
        IO => PMOD_JB(7));
        
        
            IOBUF0C : IOBUF
                PORT MAP(
                I => PMOD_JC_OUT(0), 
                O => PMOD_JC_IN(0), 
                T => PMOD_JC_OE(0), 
                IO => PMOD_JC(0));
                
                IOBUF1C : IOBUF PORT MAP(
                I => PMOD_JC_OUT(1), 
                O => PMOD_JC_IN(1), 
                T => PMOD_JC_OE(1), 
                IO => PMOD_JC(1));
                
                IOBUF2C : IOBUF PORT MAP(
                I => PMOD_JC_OUT(2), 
                O => PMOD_JC_IN(2), 
                T => PMOD_JC_OE(2), 
                IO => PMOD_JC(2));
                
                IOBUF3C : IOBUF PORT MAP(
                I => PMOD_JC_OUT(3), 
                O => PMOD_JC_IN(3), 
                T => PMOD_JC_OE(3), 
                IO => PMOD_JC(3));
                
                IOBUF4C : IOBUF PORT MAP(
                I => PMOD_JC_OUT(4), 
                O => PMOD_JC_IN(4), 
                T => PMOD_JC_OE(4), 
                IO => PMOD_JC(4));
                
                IOBUF5C : IOBUF PORT MAP(
                I => PMOD_JC_OUT(5), 
                O => PMOD_JC_IN(5), 
                T => PMOD_JC_OE(5), 
                IO => PMOD_JC(5));
                
                IOBUF6C : IOBUF PORT MAP(
                I => PMOD_JC_OUT(6), 
                O => PMOD_JC_IN(6), 
                T => PMOD_JC_OE(6), 
                IO => PMOD_JC(6));
                
                IOBUF7C : IOBUF PORT MAP(
                I => PMOD_JC_OUT(7), 
                O => PMOD_JC_IN(7), 
                T => PMOD_JC_OE(7), 
                IO => PMOD_JC(7));
        

            IOBUF0D : IOBUF
                PORT MAP(
                I => PMOD_JD_OUT(0), 
                O => PMOD_JD_IN(0), 
                T => PMOD_JD_OE(0), 
                IO => PMOD_JD(0));
                
                IOBUF1D : IOBUF PORT MAP(
                I => PMOD_JD_OUT(1), 
                O => PMOD_JD_IN(1), 
                T => PMOD_JD_OE(1), 
                IO => PMOD_JD(1));
                
                IOBUF2D : IOBUF PORT MAP(
                I => PMOD_JD_OUT(2), 
                O => PMOD_JD_IN(2), 
                T => PMOD_JD_OE(2), 
                IO => PMOD_JD(2));
                
                IOBUF3D : IOBUF PORT MAP(
                I => PMOD_JD_OUT(3), 
                O => PMOD_JD_IN(3), 
                T => PMOD_JD_OE(3), 
                IO => PMOD_JD(3));
                
                IOBUF4D : IOBUF PORT MAP(
                I => PMOD_JD_OUT(4), 
                O => PMOD_JD_IN(4), 
                T => PMOD_JD_OE(4), 
                IO => PMOD_JD(4));
                
                IOBUF5D : IOBUF PORT MAP(
                I => PMOD_JD_OUT(5), 
                O => PMOD_JD_IN(5), 
                T => PMOD_JD_OE(5), 
                IO => PMOD_JD(5));
                
                IOBUF6D : IOBUF PORT MAP(
                I => PMOD_JD_OUT(6), 
                O => PMOD_JD_IN(6), 
                T => PMOD_JD_OE(6), 
                IO => PMOD_JD(6));
                
                IOBUF7D : IOBUF PORT MAP(
                I => PMOD_JD_OUT(7), 
                O => PMOD_JD_IN(7), 
                T => PMOD_JD_OE(7), 
                IO => PMOD_JD(7));
        
                    IOBUF0E : IOBUF
                    PORT MAP(
                    I => PMOD_JE_OUT(0), 
                    O => PMOD_JE_IN(0), 
                    T => PMOD_JE_OE(0), 
                    IO => PMOD_JE(0));
                    
                    IOBUF1E : IOBUF PORT MAP(
                    I => PMOD_JE_OUT(1), 
                    O => PMOD_JE_IN(1), 
                    T => PMOD_JE_OE(1), 
                    IO => PMOD_JE(1));
                    
                    IOBUF2E : IOBUF PORT MAP(
                    I => PMOD_JE_OUT(2), 
                    O => PMOD_JE_IN(2), 
                    T => PMOD_JE_OE(2), 
                    IO => PMOD_JE(2));
                    
                    IOBUF3E : IOBUF PORT MAP(
                    I => PMOD_JE_OUT(3), 
                    O => PMOD_JE_IN(3), 
                    T => PMOD_JE_OE(3), 
                    IO => PMOD_JE(3));
                    
                    IOBUF4E : IOBUF PORT MAP(
                    I => PMOD_JE_OUT(4), 
                    O => PMOD_JE_IN(4), 
                    T => PMOD_JE_OE(4), 
                    IO => PMOD_JE(4));
                    
                    IOBUF5E : IOBUF PORT MAP(
                    I => PMOD_JE_OUT(5), 
                    O => PMOD_JE_IN(5), 
                    T => PMOD_JE_OE(5), 
                    IO => PMOD_JE(5));
                    
                    IOBUF6E : IOBUF PORT MAP(
                    I => PMOD_JE_OUT(6), 
                    O => PMOD_JE_IN(6), 
                    T => PMOD_JE_OE(6), 
                    IO => PMOD_JE(6));
                    
                    IOBUF7E : IOBUF PORT MAP(
                    I => PMOD_JE_OUT(7), 
                    O => PMOD_JE_IN(7), 
                    T => PMOD_JE_OE(7), 
                    IO => PMOD_JE(7));
            
            

        
 
		par : BLANK PORT MAP(
		CLK_mmc => CLK_MMC(0), 
		CLK_PLL => CLK_PLL(0), 
		rst => par_rst(0), 
 
		RGB_LED => RGB_LED, 
		GPIO_PART_Input => gpio_o, 
		GPIO_PART_Output => gpio_i, 
 
		--PMOD_JB=>PMOD_JB,
 
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

 
		UART_ZYNQ_rxd => UART_ZYNQ_txd, 
		UART_ZYNQ_txd => UART_ZYNQ_rxd, 
 
		IIC_ZYNQ_sda_i => IIC_ZYNQ_sda_o, 
		IIC_ZYNQ_sda_o => IIC_ZYNQ_sda_i, 
		IIC_ZYNQ_scl_i => IIC_ZYNQ_scl_o, 
		IIC_ZYNQ_scl_o => IIC_ZYNQ_scl_i
	);

	blockd : bd_name_wrapper
	PORT MAP(
		--test pins
		BUTTONS_tri_i => btns_4bits_tri_i, 
		LED_tri_o => leds_4bits_tri_io, 
		sys_clock => sys_clock, 
		DDR_addr => DDR_addr, 
		DDR_ba => DDR_ba, 
		DDR_cas_n => DDR_cas_n, 
		DDR_ck_n => DDR_ck_n, 
		DDR_ck_p => DDR_ck_p, 
		DDR_cke => DDR_cke, 
		DDR_cs_n => DDR_cs_n, 
		DDR_dm => DDR_dm, 
		DDR_dq => DDR_dq, 
		DDR_dqs_n => DDR_dqs_n, 
		DDR_dqs_p => DDR_dqs_p, 
		DDR_odt => DDR_odt, 
		DDR_ras_n => DDR_ras_n, 
		DDR_reset_n => DDR_reset_n, 
		DDR_we_n => DDR_we_n, 

		FIXED_IO_ddr_vrn => FIXED_IO_ddr_vrn, 
		FIXED_IO_ddr_vrp => FIXED_IO_ddr_vrp, 
		FIXED_IO_mio => FIXED_IO_mio, 
		FIXED_IO_ps_clk => FIXED_IO_ps_clk, 
		FIXED_IO_ps_porb => FIXED_IO_ps_porb, 
		FIXED_IO_ps_srstb => FIXED_IO_ps_srstb, 

		--gpio par
		par_gpio_o => gpio_o, 
		par_gpio_i => gpio_i, 

		--reset par
		par_rst => par_rst, 
		CLK_MMC(0) => CLK_MMC(0), 
		CLK_PLL(0) => CLK_PLL(0), 
 
		--uart
		UART_ZYNQ_rxd => UART_ZYNQ_rxd, 
		UART_ZYNQ_txd => UART_ZYNQ_txd, 
 
		--iic
		IIC_ZYNQ_sda_i => IIC_ZYNQ_sda_i, 
		IIC_ZYNQ_sda_o => IIC_ZYNQ_sda_o, 
		IIC_ZYNQ_scl_i => IIC_ZYNQ_scl_i, 
		IIC_ZYNQ_scl_o => IIC_ZYNQ_scl_o 
	);
END Behavioral;