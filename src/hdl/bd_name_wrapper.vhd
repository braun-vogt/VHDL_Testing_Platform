--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.4 (lin64) Build 2086221 Fri Dec 15 20:54:30 MST 2017
--Date        : Tue Mar 12 20:24:54 2019
--Host        : localhost.localdomain running 64-bit unknown
--Command     : generate_target bd_name_wrapper.bd
--Design      : bd_name_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity bd_name_wrapper is
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
end bd_name_wrapper;

architecture STRUCTURE of bd_name_wrapper is
  component bd_name is
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
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    LED_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    LED_tri_o : out STD_LOGIC_VECTOR ( 3 downto 0 );
    LED_tri_t : out STD_LOGIC_VECTOR ( 3 downto 0 );
    hdmi_ddc_sda_i : in STD_LOGIC;
    hdmi_ddc_sda_o : out STD_LOGIC;
    hdmi_ddc_sda_t : out STD_LOGIC;
    hdmi_ddc_scl_i : in STD_LOGIC;
    hdmi_ddc_scl_o : out STD_LOGIC;
    hdmi_ddc_scl_t : out STD_LOGIC;
    hdmi_in_hpd_led_tri_i : in STD_LOGIC;
    hdmi_in_hpd_led_tri_o : out STD_LOGIC;
    hdmi_in_hpd_led_tri_t : out STD_LOGIC;
    HDMI_OEN : out STD_LOGIC_VECTOR ( 0 to 0 );
    par_gpio_i : in STD_LOGIC_VECTOR ( 31 downto 0 );
    par_gpio_o : out STD_LOGIC_VECTOR ( 31 downto 0 );
    hdmi_out_clk_p : out STD_LOGIC;
    hdmi_out_clk_n : out STD_LOGIC;
    hdmi_out_data_p : out STD_LOGIC_VECTOR ( 2 downto 0 );
    hdmi_out_data_n : out STD_LOGIC_VECTOR ( 2 downto 0 );
    BUTTONS_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  end component bd_name;
  component IOBUF is
  port (
    I : in STD_LOGIC;
    O : out STD_LOGIC;
    T : in STD_LOGIC;
    IO : inout STD_LOGIC
  );
  end component IOBUF;
  signal LED_tri_i_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal LED_tri_i_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal LED_tri_i_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal LED_tri_i_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal LED_tri_io_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal LED_tri_io_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal LED_tri_io_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal LED_tri_io_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal LED_tri_o_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal LED_tri_o_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal LED_tri_o_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal LED_tri_o_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal LED_tri_t_0 : STD_LOGIC_VECTOR ( 0 to 0 );
  signal LED_tri_t_1 : STD_LOGIC_VECTOR ( 1 to 1 );
  signal LED_tri_t_2 : STD_LOGIC_VECTOR ( 2 to 2 );
  signal LED_tri_t_3 : STD_LOGIC_VECTOR ( 3 to 3 );
  signal hdmi_ddc_scl_i : STD_LOGIC;
  signal hdmi_ddc_scl_o : STD_LOGIC;
  signal hdmi_ddc_scl_t : STD_LOGIC;
  signal hdmi_ddc_sda_i : STD_LOGIC;
  signal hdmi_ddc_sda_o : STD_LOGIC;
  signal hdmi_ddc_sda_t : STD_LOGIC;
  signal hdmi_in_hpd_led_tri_i : STD_LOGIC;
  signal hdmi_in_hpd_led_tri_o : STD_LOGIC;
  signal hdmi_in_hpd_led_tri_t : STD_LOGIC;
begin
LED_tri_iobuf_0: component IOBUF
     port map (
      I => LED_tri_o_0(0),
      IO => LED_tri_io(0),
      O => LED_tri_i_0(0),
      T => LED_tri_t_0(0)
    );
LED_tri_iobuf_1: component IOBUF
     port map (
      I => LED_tri_o_1(1),
      IO => LED_tri_io(1),
      O => LED_tri_i_1(1),
      T => LED_tri_t_1(1)
    );
LED_tri_iobuf_2: component IOBUF
     port map (
      I => LED_tri_o_2(2),
      IO => LED_tri_io(2),
      O => LED_tri_i_2(2),
      T => LED_tri_t_2(2)
    );
LED_tri_iobuf_3: component IOBUF
     port map (
      I => LED_tri_o_3(3),
      IO => LED_tri_io(3),
      O => LED_tri_i_3(3),
      T => LED_tri_t_3(3)
    );
bd_name_i: component bd_name
     port map (
      BUTTONS_tri_i(3 downto 0) => BUTTONS_tri_i(3 downto 0),
      DDR_addr(14 downto 0) => DDR_addr(14 downto 0),
      DDR_ba(2 downto 0) => DDR_ba(2 downto 0),
      DDR_cas_n => DDR_cas_n,
      DDR_ck_n => DDR_ck_n,
      DDR_ck_p => DDR_ck_p,
      DDR_cke => DDR_cke,
      DDR_cs_n => DDR_cs_n,
      DDR_dm(3 downto 0) => DDR_dm(3 downto 0),
      DDR_dq(31 downto 0) => DDR_dq(31 downto 0),
      DDR_dqs_n(3 downto 0) => DDR_dqs_n(3 downto 0),
      DDR_dqs_p(3 downto 0) => DDR_dqs_p(3 downto 0),
      DDR_odt => DDR_odt,
      DDR_ras_n => DDR_ras_n,
      DDR_reset_n => DDR_reset_n,
      DDR_we_n => DDR_we_n,
      FIXED_IO_ddr_vrn => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp => FIXED_IO_ddr_vrp,
      FIXED_IO_mio(53 downto 0) => FIXED_IO_mio(53 downto 0),
      FIXED_IO_ps_clk => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
      HDMI_OEN(0) => HDMI_OEN(0),
      LED_tri_i(3) => LED_tri_i_3(3),
      LED_tri_i(2) => LED_tri_i_2(2),
      LED_tri_i(1) => LED_tri_i_1(1),
      LED_tri_i(0) => LED_tri_i_0(0),
      LED_tri_o(3) => LED_tri_o_3(3),
      LED_tri_o(2) => LED_tri_o_2(2),
      LED_tri_o(1) => LED_tri_o_1(1),
      LED_tri_o(0) => LED_tri_o_0(0),
      LED_tri_t(3) => LED_tri_t_3(3),
      LED_tri_t(2) => LED_tri_t_2(2),
      LED_tri_t(1) => LED_tri_t_1(1),
      LED_tri_t(0) => LED_tri_t_0(0),
      hdmi_ddc_scl_i => hdmi_ddc_scl_i,
      hdmi_ddc_scl_o => hdmi_ddc_scl_o,
      hdmi_ddc_scl_t => hdmi_ddc_scl_t,
      hdmi_ddc_sda_i => hdmi_ddc_sda_i,
      hdmi_ddc_sda_o => hdmi_ddc_sda_o,
      hdmi_ddc_sda_t => hdmi_ddc_sda_t,
      hdmi_in_hpd_led_tri_i => hdmi_in_hpd_led_tri_i,
      hdmi_in_hpd_led_tri_o => hdmi_in_hpd_led_tri_o,
      hdmi_in_hpd_led_tri_t => hdmi_in_hpd_led_tri_t,
      hdmi_out_clk_n => hdmi_out_clk_n,
      hdmi_out_clk_p => hdmi_out_clk_p,
      hdmi_out_data_n(2 downto 0) => hdmi_out_data_n(2 downto 0),
      hdmi_out_data_p(2 downto 0) => hdmi_out_data_p(2 downto 0),
      par_gpio_i(31 downto 0) => par_gpio_i(31 downto 0),
      par_gpio_o(31 downto 0) => par_gpio_o(31 downto 0)
    );
hdmi_ddc_scl_iobuf: component IOBUF
     port map (
      I => hdmi_ddc_scl_o,
      IO => hdmi_ddc_scl_io,
      O => hdmi_ddc_scl_i,
      T => hdmi_ddc_scl_t
    );
hdmi_ddc_sda_iobuf: component IOBUF
     port map (
      I => hdmi_ddc_sda_o,
      IO => hdmi_ddc_sda_io,
      O => hdmi_ddc_sda_i,
      T => hdmi_ddc_sda_t
    );
hdmi_in_hpd_led_tri_iobuf: component IOBUF
     port map (
      I => hdmi_in_hpd_led_tri_o,
      IO => hdmi_in_hpd_led_tri_io,
      O => hdmi_in_hpd_led_tri_i,
      T => hdmi_in_hpd_led_tri_t
    );
end STRUCTURE;
