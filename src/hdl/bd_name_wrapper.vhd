--Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2017.4 (lin64) Build 2086221 Fri Dec 15 20:54:30 MST 2017
--Date        : Tue Apr 16 22:24:38 2019
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
    CLK_125MHZ : out STD_LOGIC_VECTOR ( 0 to 0 );
    CLK_MMC : out STD_LOGIC_VECTOR ( 0 to 0 );
    CLK_PLL : out STD_LOGIC_VECTOR ( 0 to 0 );
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
    PAR_TEST_GPIO0_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO0_OUT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO1_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO1_OUT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO2_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO2_OUT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO3_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO3_OUT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO4_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO4_OUT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO5_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO5_OUT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO6_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO6_OUT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO7_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO7_OUT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    UART_ZYNQ_rxd : in STD_LOGIC;
    UART_ZYNQ_txd : out STD_LOGIC;
    reset_par : out STD_LOGIC_VECTOR ( 15 downto 0 );
    sys_clock : in STD_LOGIC
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
    UART_ZYNQ_txd : out STD_LOGIC;
    UART_ZYNQ_rxd : in STD_LOGIC;
    sys_clock : in STD_LOGIC;
    CLK_MMC : out STD_LOGIC_VECTOR ( 0 to 0 );
    CLK_PLL : out STD_LOGIC_VECTOR ( 0 to 0 );
    reset_par : out STD_LOGIC_VECTOR ( 15 downto 0 );
    CLK_125MHZ : out STD_LOGIC_VECTOR ( 0 to 0 );
    PAR_TEST_GPIO0_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO0_OUT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO1_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO2_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO3_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO4_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO5_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO6_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO7_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO1_OUT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO2_OUT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO3_OUT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO5_OUT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO6_OUT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO7_OUT : out STD_LOGIC_VECTOR ( 31 downto 0 );
    PAR_TEST_GPIO4_OUT : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );
  end component bd_name;
begin
bd_name_i: component bd_name
     port map (
      CLK_125MHZ(0) => CLK_125MHZ(0),
      CLK_MMC(0) => CLK_MMC(0),
      CLK_PLL(0) => CLK_PLL(0),
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
      PAR_TEST_GPIO0_IN(31 downto 0) => PAR_TEST_GPIO0_IN(31 downto 0),
      PAR_TEST_GPIO0_OUT(31 downto 0) => PAR_TEST_GPIO0_OUT(31 downto 0),
      PAR_TEST_GPIO1_IN(31 downto 0) => PAR_TEST_GPIO1_IN(31 downto 0),
      PAR_TEST_GPIO1_OUT(31 downto 0) => PAR_TEST_GPIO1_OUT(31 downto 0),
      PAR_TEST_GPIO2_IN(31 downto 0) => PAR_TEST_GPIO2_IN(31 downto 0),
      PAR_TEST_GPIO2_OUT(31 downto 0) => PAR_TEST_GPIO2_OUT(31 downto 0),
      PAR_TEST_GPIO3_IN(31 downto 0) => PAR_TEST_GPIO3_IN(31 downto 0),
      PAR_TEST_GPIO3_OUT(31 downto 0) => PAR_TEST_GPIO3_OUT(31 downto 0),
      PAR_TEST_GPIO4_IN(31 downto 0) => PAR_TEST_GPIO4_IN(31 downto 0),
      PAR_TEST_GPIO4_OUT(31 downto 0) => PAR_TEST_GPIO4_OUT(31 downto 0),
      PAR_TEST_GPIO5_IN(31 downto 0) => PAR_TEST_GPIO5_IN(31 downto 0),
      PAR_TEST_GPIO5_OUT(31 downto 0) => PAR_TEST_GPIO5_OUT(31 downto 0),
      PAR_TEST_GPIO6_IN(31 downto 0) => PAR_TEST_GPIO6_IN(31 downto 0),
      PAR_TEST_GPIO6_OUT(31 downto 0) => PAR_TEST_GPIO6_OUT(31 downto 0),
      PAR_TEST_GPIO7_IN(31 downto 0) => PAR_TEST_GPIO7_IN(31 downto 0),
      PAR_TEST_GPIO7_OUT(31 downto 0) => PAR_TEST_GPIO7_OUT(31 downto 0),
      UART_ZYNQ_rxd => UART_ZYNQ_rxd,
      UART_ZYNQ_txd => UART_ZYNQ_txd,
      reset_par(15 downto 0) => reset_par(15 downto 0),
      sys_clock => sys_clock
    );
end STRUCTURE;
