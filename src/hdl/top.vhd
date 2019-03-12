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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           PMOD_JB: inout STD_LOGIC_VECTOR(7 downto 0);
           PMOD_JC:inout STD_LOGIC_VECTOR(7 downto 0);
           PMOD_JD:inout STD_LOGIC_VECTOR(7 downto 0);
           PMOD_JE:inout STD_LOGIC_VECTOR(7 downto 0);
           RGB_LED : out STD_LOGIC_VECTOR (2 downto 0);
   
               BUTTONS_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
               DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
               DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
               DDR_cas_n : inout STD_LOGIC;
               DDR_ck_n : inout STD_LOGIC;
               DDR_ck_p : inout STD_LOGIC;
               DDR_cke : inout STD_LOGIC;
               DDR_cs_n : inout STD_LOGIC;
               DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
               DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
               DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
               DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
               DDR_odt : inout STD_LOGIC;
               DDR_ras_n : inout STD_LOGIC;
               DDR_reset_n : inout STD_LOGIC;
               DDR_we_n : inout STD_LOGIC;
               FIXED_IO_ddr_vrn : inout STD_LOGIC;
               FIXED_IO_ddr_vrp : inout STD_LOGIC;
               FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
               FIXED_IO_ps_clk : inout STD_LOGIC;
               FIXED_IO_ps_porb : inout STD_LOGIC;
               FIXED_IO_ps_srstb : inout STD_LOGIC;
               HDMI_OEN : out STD_LOGIC_VECTOR ( 0 to 0 );
               LED_tri_io : inout STD_LOGIC_VECTOR ( 3 downto 0 );
               hdmi_ddc_scl_io : inout STD_LOGIC;
               hdmi_ddc_sda_io : inout STD_LOGIC;
               hdmi_in_hpd_led_tri_io : inout STD_LOGIC;
               hdmi_out_clk_n : out STD_LOGIC;
               hdmi_out_clk_p : out STD_LOGIC;
               hdmi_out_data_n : out STD_LOGIC_VECTOR ( 2 downto 0 );
               hdmi_out_data_p : out STD_LOGIC_VECTOR ( 2 downto 0 )
           );
end top;

architecture Behavioral of top is

component bd_name_wrapper is
  port (
    BUTTONS_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
      DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
      DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
      DDR_cas_n : inout STD_LOGIC;
      DDR_ck_n : inout STD_LOGIC;
      DDR_ck_p : inout STD_LOGIC;
      DDR_cke : inout STD_LOGIC;
      DDR_cs_n : inout STD_LOGIC;
      DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
      DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
      DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
      DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
      DDR_odt : inout STD_LOGIC;
      DDR_ras_n : inout STD_LOGIC;
      DDR_reset_n : inout STD_LOGIC;
      DDR_we_n : inout STD_LOGIC;
      FIXED_IO_ddr_vrn : inout STD_LOGIC;
      FIXED_IO_ddr_vrp : inout STD_LOGIC;
      FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
      FIXED_IO_ps_clk : inout STD_LOGIC;
      FIXED_IO_ps_porb : inout STD_LOGIC;
      FIXED_IO_ps_srstb : inout STD_LOGIC;
      HDMI_OEN : out STD_LOGIC_VECTOR ( 0 to 0 );
      LED_tri_io : inout STD_LOGIC_VECTOR ( 3 downto 0 );
      hdmi_ddc_scl_io : inout STD_LOGIC;
      hdmi_ddc_sda_io : inout STD_LOGIC;
      hdmi_in_hpd_led_tri_io : inout STD_LOGIC;
      hdmi_out_clk_n : out STD_LOGIC;
      hdmi_out_clk_p : out STD_LOGIC;
      hdmi_out_data_n : out STD_LOGIC_VECTOR ( 2 downto 0 );
      hdmi_out_data_p : out STD_LOGIC_VECTOR ( 2 downto 0 );
      par_gpio_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
      par_gpio_o : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
end component;

signal gpio_i :STD_LOGIC_VECTOR ( 31 downto 0 ) :=(others=>'0');
signal gpio_o :STD_LOGIC_VECTOR ( 31 downto 0 );

component BLANK is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           PMOD_JB: inout STD_LOGIC_VECTOR(7 downto 0);
           PMOD_JC:inout STD_LOGIC_VECTOR(7 downto 0);
           PMOD_JD:inout STD_LOGIC_VECTOR(7 downto 0);
           PMOD_JE:inout STD_LOGIC_VECTOR(7 downto 0);
           RGB_LED : out STD_LOGIC_VECTOR (2 downto 0);
           GPIO_PART_Input : in STD_LOGIC_VECTOR ( 31 downto 0 );
           GPIO_PART_Output : out STD_LOGIC_VECTOR ( 31 downto 0 ));
end component;

begin

 par:BLANK port map(CLK=>clk,rst=>rst,RGB_LED=>RGB_LED,GPIO_PART_Input=>gpio_o,GPIO_PART_Output=>gpio_i);
blockd : bd_name_wrapper port map(
        BUTTONS_tri_i=>BUTTONS_tri_i,
        DDR_addr=>DDR_addr,
        DDR_ba=>DDR_ba,
        DDR_cas_n=>DDR_cas_n,
        DDR_ck_n=>DDR_ck_n,
        DDR_ck_p=>DDR_ck_p,
        DDR_cke=>DDR_cke,
        DDR_cs_n=>DDR_cs_n,
        DDR_dm=>DDR_dm,
        DDR_dq=>DDR_dq,
        DDR_dqs_n=>DDR_dqs_n,
        DDR_dqs_p=>DDR_dqs_p,
        DDR_odt=>DDR_odt,
        DDR_ras_n=>DDR_ras_n,
        DDR_reset_n=> DDR_reset_n,
        DDR_we_n=>DDR_we_n,
        FIXED_IO_ddr_vrn=>FIXED_IO_ddr_vrn,
        FIXED_IO_ddr_vrp=>FIXED_IO_ddr_vrp,
        FIXED_IO_mio=>FIXED_IO_mio,
        FIXED_IO_ps_clk=>FIXED_IO_ps_clk,
        FIXED_IO_ps_porb=>FIXED_IO_ps_porb,
        FIXED_IO_ps_srstb=>FIXED_IO_ps_srstb,
        HDMI_OEN=>HDMI_OEN,
        LED_tri_io=>LED_tri_io,
        hdmi_out_clk_n=>hdmi_out_clk_n,
        hdmi_out_data_p=>hdmi_out_data_p,
        hdmi_out_clk_p =>hdmi_out_clk_p,
        hdmi_out_data_n =>hdmi_out_data_n,
        hdmi_ddc_scl_io=>hdmi_ddc_scl_io,
        hdmi_ddc_sda_io=>hdmi_ddc_sda_io,
        hdmi_in_hpd_led_tri_io=>hdmi_in_hpd_led_tri_io,
        par_gpio_o=>gpio_o,
        par_gpio_i=>gpio_i);--last change
               
end Behavioral;
