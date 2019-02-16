--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
--Date        : Sat Feb 16 17:19:18 2019
--Host        : LAPTOP-68Q60KTV running 64-bit major release  (build 9200)
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
    clk_i : in std_logic;
    RGB_LED : out std_logic_vector(2 downto 0);
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
    LED_tri_o : out STD_LOGIC_VECTOR ( 3 downto 0 );
    TMDS_clk_n : out STD_LOGIC;
    TMDS_clk_p : out STD_LOGIC;
    TMDS_data_n : out STD_LOGIC_VECTOR ( 2 downto 0 );
    TMDS_data_p : out STD_LOGIC_VECTOR ( 2 downto 0 );
    hdmi_ddc_scl_io : inout STD_LOGIC;
    hdmi_ddc_sda_io : inout STD_LOGIC;
    hdmi_in_hpd_led_tri_io : inout STD_LOGIC
  );
end bd_name_wrapper;

architecture STRUCTURE of bd_name_wrapper is

    component top is
    Port ( CLK : in STD_LOGIC;
           RST : in STD_LOGIC;
           RGB_LED : out STD_LOGIC_VECTOR (2 downto 0));
end component;

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
    TMDS_clk_p : out STD_LOGIC;
    TMDS_clk_n : out STD_LOGIC;
    TMDS_data_p : out STD_LOGIC_VECTOR ( 2 downto 0 );
    TMDS_data_n : out STD_LOGIC_VECTOR ( 2 downto 0 );
    hdmi_in_hpd_led_tri_i : in STD_LOGIC;
    hdmi_in_hpd_led_tri_o : out STD_LOGIC;
    hdmi_in_hpd_led_tri_t : out STD_LOGIC;
    hdmi_ddc_sda_i : in STD_LOGIC;
    hdmi_ddc_sda_o : out STD_LOGIC;
    hdmi_ddc_sda_t : out STD_LOGIC;
    hdmi_ddc_scl_i : in STD_LOGIC;
    hdmi_ddc_scl_o : out STD_LOGIC;
    hdmi_ddc_scl_t : out STD_LOGIC;
    LED_tri_o : out STD_LOGIC_VECTOR ( 3 downto 0 );
    BUTTONS_tri_i : in STD_LOGIC_VECTOR ( 3 downto 0 );
    HDMI_OEN : out STD_LOGIC_VECTOR ( 0 to 0 )
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
      LED_tri_o(3 downto 0) => LED_tri_o(3 downto 0),
      TMDS_clk_n => TMDS_clk_n,
      TMDS_clk_p => TMDS_clk_p,
      TMDS_data_n(2 downto 0) => TMDS_data_n(2 downto 0),
      TMDS_data_p(2 downto 0) => TMDS_data_p(2 downto 0),
      hdmi_ddc_scl_i => hdmi_ddc_scl_i,
      hdmi_ddc_scl_o => hdmi_ddc_scl_o,
      hdmi_ddc_scl_t => hdmi_ddc_scl_t,
      hdmi_ddc_sda_i => hdmi_ddc_sda_i,
      hdmi_ddc_sda_o => hdmi_ddc_sda_o,
      hdmi_ddc_sda_t => hdmi_ddc_sda_t,
      hdmi_in_hpd_led_tri_i => hdmi_in_hpd_led_tri_i,
      hdmi_in_hpd_led_tri_o => hdmi_in_hpd_led_tri_o,
      hdmi_in_hpd_led_tri_t => hdmi_in_hpd_led_tri_t
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
pardes : component top
    port map(clk=>clk_i,rst=>'1',RGB_LED=>RGB_LED);
end STRUCTURE;
