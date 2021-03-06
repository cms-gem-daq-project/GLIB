library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--! xilinx packages
library unisim;
use unisim.vcomponents.all;

--! system packages
library work;
use work.system_flash_sram_package.all;
use work.system_pcie_package.all;
use work.system_package.all;
use work.fmc_package.all;
use work.wb_package.all;
use work.ipbus.all;

--! user packages
use work.user_package.all;
use work.user_version_package.all;

entity user_logic is
port(
    --================================--
    -- USER MGT REFCLKs
    --================================--
    -- BANK_112(Q0):
    clk125_1_p                  : in std_logic;
    clk125_1_n                  : in std_logic;
    cdce_out0_p                 : in std_logic;
    cdce_out0_n                 : in std_logic;
    -- BANK_113(Q1):
    fmc2_clk0_m2c_xpoint2_p     : in std_logic;
    fmc2_clk0_m2c_xpoint2_n     : in std_logic;
    cdce_out1_p                 : in std_logic; -- GTX clock speed must be 160 MHz
    cdce_out1_n                 : in std_logic; -- GTX clock speed must be 160 MHz
    -- BANK_114(Q2):
    pcie_clk_p                  : in std_logic;
    pcie_clk_n                  : in std_logic;
    cdce_out2_p                 : in std_logic;
    cdce_out2_n                 : in std_logic;
    -- BANK_115(Q3):
    clk125_2_i                  : in std_logic;
    fmc1_gbtclk1_m2c_p          : in std_logic;
    fmc1_gbtclk1_m2c_n          : in std_logic;
    -- BANK_116(Q4):
    fmc1_gbtclk0_m2c_p          : in std_logic;
    fmc1_gbtclk0_m2c_n          : in std_logic;
    cdce_out3_p                 : in std_logic;
    cdce_out3_n                 : in std_logic;
    --================================--
    -- USER FABRIC CLOCKS
    --================================--
    xpoint1_clk3_p              : in std_logic;
    xpoint1_clk3_n              : in std_logic;
    ------------------------------------
    cdce_out4_p                 : in std_logic;
    cdce_out4_n                 : in std_logic;
    ------------------------------------
    amc_tclkb_o                 : out std_logic;
    ------------------------------------
    fmc1_clk0_m2c_xpoint2_p     : in std_logic;
    fmc1_clk0_m2c_xpoint2_n     : in std_logic;
    fmc1_clk1_m2c_p             : in std_logic;
    fmc1_clk1_m2c_n             : in std_logic;
    fmc1_clk2_bidir_p           : in std_logic;
    fmc1_clk2_bidir_n           : in std_logic;
    fmc1_clk3_bidir_p           : in std_logic;
    fmc1_clk3_bidir_n           : in std_logic;
    ------------------------------------
    fmc2_clk1_m2c_p             : in std_logic;
    fmc2_clk1_m2c_n             : in std_logic;
    --================================--
    -- GBT PHASE MONITORING MGT REFCLK
    --================================--
    cdce_out0_gtxe1_o           : out std_logic;
    cdce_out3_gtxe1_o           : out std_logic;
    --================================--
    -- AMC PORTS
    --================================--
    amc_port_tx_p               : out std_logic_vector(1 to 15);
    amc_port_tx_n               : out std_logic_vector(1 to 15);
    amc_port_rx_p               : in std_logic_vector(1 to 15);
    amc_port_rx_n               : in std_logic_vector(1 to 15);
    ------------------------------------
    amc_port_tx_out             : out std_logic_vector(17 to 20);
    amc_port_tx_in              : in std_logic_vector(17 to 20);
    amc_port_tx_de              : out std_logic_vector(17 to 20);
    amc_port_rx_out             : out std_logic_vector(17 to 20);
    amc_port_rx_in              : in std_logic_vector(17 to 20);
    amc_port_rx_de              : out std_logic_vector(17 to 20);
    --================================--
    -- SFP QUAD
    --================================--
    sfp_tx_p                    : out std_logic_vector(1 to 4);
    sfp_tx_n                    : out std_logic_vector(1 to 4);
    sfp_rx_p                    : in std_logic_vector(1 to 4);
    sfp_rx_n                    : in std_logic_vector(1 to 4);
    sfp_mod_abs                 : in std_logic_vector(1 to 4);
    sfp_rxlos                   : in std_logic_vector(1 to 4);
    sfp_txfault                 : in std_logic_vector(1 to 4);
    --================================--
    -- FMC1
    --================================--
    fmc1_tx_p                   : out std_logic_vector(1 to 4);
    fmc1_tx_n                   : out std_logic_vector(1 to 4);
    fmc1_rx_p                   : in std_logic_vector(1 to 4);
    fmc1_rx_n                   : in std_logic_vector(1 to 4);
    ------------------------------------
    fmc1_io_pin                 : inout fmc_io_pin_type;
    ------------------------------------
    fmc1_clk_c2m_p              : out std_logic_vector(0 to 1);
    fmc1_clk_c2m_n              : out std_logic_vector(0 to 1);
    fmc1_present_l              : in std_logic;
    --================================--
    -- FMC2
    --================================--
    fmc2_io_pin                 : inout fmc_io_pin_type;
    ------------------------------------
    fmc2_clk_c2m_p              : out std_logic_vector(0 to 1);
    fmc2_clk_c2m_n              : out std_logic_vector(0 to 1);
    fmc2_present_l              : in std_logic;
    --================================--
    -- SYSTEM GBE
    --================================--
    sys_eth_amc_p1_tx_p         : in std_logic;
    sys_eth_amc_p1_tx_n         : in std_logic;
    sys_eth_amc_p1_rx_p         : out std_logic;
    sys_eth_amc_p1_rx_n         : out std_logic;
    ------------------------------------
    user_mac_syncacqstatus_i    : in std_logic_vector(0 to 3);
    user_mac_serdes_locked_i    : in std_logic_vector(0 to 3);
    --================================--
    -- SYSTEM PCIe
    --================================--
    sys_pcie_mgt_refclk_o       : out std_logic;
    user_sys_pcie_dma_clk_i     : in std_logic;
    ------------------------------------
    sys_pcie_amc_tx_p           : in std_logic_vector(0 to 3);
    sys_pcie_amc_tx_n           : in std_logic_vector(0 to 3);
    sys_pcie_amc_rx_p           : out std_logic_vector(0 to 3);
    sys_pcie_amc_rx_n           : out std_logic_vector(0 to 3);
    ------------------------------------
    user_sys_pcie_slv_o         : out R_slv_to_ezdma2;
    user_sys_pcie_slv_i         : in R_slv_from_ezdma2;
    user_sys_pcie_dma_o         : out R_userDma_to_ezdma2_array  (1 to 7);
    user_sys_pcie_dma_i         : in R_userDma_from_ezdma2_array(1 to 7);
    user_sys_pcie_int_o         : out R_int_to_ezdma2;
    user_sys_pcie_int_i         : in R_int_from_ezdma2;
    user_sys_pcie_cfg_i         : in R_cfg_from_ezdma2;
    --================================--
    -- SRAMs
    --================================--
    user_sram_control_o         : out userSramControlR_array(1 to 2);
    user_sram_addr_o            : out array_2x21bit;
    user_sram_wdata_o           : out array_2x36bit;
    user_sram_rdata_i           : in array_2x36bit;
    ------------------------------------
    sram1_bwa                   : out std_logic;
    sram1_bwb                   : out std_logic;
    sram1_bwc                   : out std_logic;
    sram1_bwd                   : out std_logic;
    sram2_bwa                   : out std_logic;
    sram2_bwb                   : out std_logic;
    sram2_bwc                   : out std_logic;
    sram2_bwd                   : out std_logic;
    --================================--
    -- CLK CIRCUITRY
    --================================--
    fpga_clkout_o               : out std_logic;
    ------------------------------------
    sec_clk_o                   : out std_logic;
    ------------------------------------
    user_cdce_locked_i          : in std_logic;
    user_cdce_sync_done_i       : in std_logic;
    user_cdce_sel_o             : out std_logic;
    user_cdce_sync_o            : out std_logic;
    --================================--
    -- USER BUS
    --================================--
    wb_miso_o                   : out wb_miso_bus_array(0 to number_of_wb_slaves-1);
    wb_mosi_i                   : in wb_mosi_bus_array(0 to number_of_wb_slaves-1);
    ------------------------------------
    ipb_clk_i                   : in std_logic;
    ipb_miso_o                  : out ipb_rbus_array(0 to number_of_ipb_slaves-1);
    ipb_mosi_i                  : in ipb_wbus_array(0 to number_of_ipb_slaves-1);
    --================================--
    -- VARIOUS
    --================================--
    reset_i                     : in std_logic;
    user_clk125_i               : in std_logic;
    user_clk200_i               : in std_logic;
    ------------------------------------
    sn                          : in std_logic_vector(7 downto 0);
    -------------------------------------
    amc_slot_i                  : in std_logic_vector( 3 downto 0);
    mac_addr_o                  : out std_logic_vector(47 downto 0);
    ip_addr_o                   : out std_logic_vector(31 downto 0);
    ------------------------------------
    user_v6_led_o               : out std_logic_vector(1 to 2)
);
end user_logic;

architecture user_logic_arch of user_logic is

    -- Global signals

    signal gtx_clk              : std_logic := '0';

    -- External signals

    signal ext_sbit             : std_logic := '0';

    -- GTX signals

    signal rx_error             : std_logic_vector(3 downto 0) := (others => '0');
    signal rx_kchar             : std_logic_vector(7 downto 0) := (others => '0');
    signal rx_data              : std_logic_vector(63 downto 0) := (others => '0');
    signal tx_kchar             : std_logic_vector(7 downto 0) := (others => '0');
    signal tx_data              : std_logic_vector(63 downto 0) := (others => '0');

    -- Registers requests

    signal request_write        : array32(127 downto 0) := (others => (others => '0'));
    signal request_tri          : std_logic_vector(127 downto 0) := (others => '0');
    signal request_read         : array32(127 downto 0) := (others => (others => '0'));

    -- Trigger

    signal empty_trigger_fifo   : std_logic := '0';
    signal sbit_configuration   : std_logic_vector(2 downto 0) := (others => '0');

    component amc13_top is
      Port ( TTC_CLK_p  : in  STD_LOGIC;
             TTC_CLK_n  : in  STD_LOGIC;
             TTC_data_p : in  STD_LOGIC;
             TTC_data_n : in  STD_LOGIC;
             TTC_CLK   : out  STD_LOGIC;
             TTCready  : out  STD_LOGIC;
             L1Accept  : out  STD_LOGIC;
             BCntRes   : out  STD_LOGIC;
             EvCntRes  : out  STD_LOGIC;
             SinErrStr : out  STD_LOGIC;
             DbErrStr  : out  STD_LOGIC;
             BrcstStr  : out  STD_LOGIC;
             Brcst     : out  STD_LOGIC_VECTOR (7 downto 2));
    end component amc13_top;

    --AMC13 signal def !! fix the indentation 
    signal BCntRes   : STD_LOGIC;
    signal EvCntRes  : STD_LOGIC;
    signal SinErrStr : STD_LOGIC;
    signal DbErrStr  : STD_LOGIC;
    signal Brcst     : STD_LOGIC_VECTOR(5 downto 0);
    signal BrcstStr  : STD_LOGIC;
    signal Brcst_r   : STD_LOGIC;
    signal Brcst4_r  : STD_LOGIC;

    signal TTCready	: STD_LOGIC;
    signal L1ACCEPT	: STD_LOGIC;
    signal L1ACCEPT_r	: STD_LOGIC;
    signal cdce_clkout4 : STD_LOGIC;

begin

    --ip_addr_o <= x"c0a80073";  -- c0a80073 = 192.168.0.115 -- 898A7392 = 137.138.115.146
    --mac_addr_o <= x"080030F100A0";  -- 08:00:30:F1:00:A0
    
    ip_addr_o <= x"c0a800a" & amc_slot_i;  -- 192.168.0.[160:175]
    mac_addr_o <= x"080030F100a" & amc_slot_i;  -- 08:00:30:F1:00:0[A0:AF]     
    
    --user_v6_led_o(1) <= '0';
    --user_v6_led_o(2) <= '1';

    fmc1_io_pin.la_p(10) <= ext_sbit;

    --================================--
    -- GTX
    --================================--

    gtx_wrapper_inst : entity work.gtx_wrapper
    port map(
        gtx_clk_o       => gtx_clk,
        reset_i         => reset_i,
        rx_error_o      => rx_error,
        rx_kchar_o      => rx_kchar,
        rx_data_o       => rx_data,
        rx_n_i          => sfp_rx_n,
        rx_p_i          => sfp_rx_p,
        tx_kchar_i      => tx_kchar,
        tx_data_i       => tx_data,
        tx_n_o          => sfp_tx_n,
        tx_p_o          => sfp_tx_p,
        gtp_refclk_n_i  => cdce_out1_n,
        gtp_refclk_p_i  => cdce_out1_p
    );

    --================================--
    -- Tracking links
    --================================--

    link_tracking_1_inst : entity work.link_tracking
    port map(
        gtx_clk_i       => gtx_clk,
        ipb_clk_i       => ipb_clk_i,
        reset_i         => reset_i,
        rx_error_i      => rx_error(1),
        rx_kchar_i      => rx_kchar(3 downto 2),
        rx_data_i       => rx_data(31 downto 16),
        tx_kchar_o      => tx_kchar(3 downto 2),
        tx_data_o       => tx_data(31 downto 16),
        ipb_vi2c_i      => ipb_mosi_i(ipb_vi2c_1),
        ipb_vi2c_o      => ipb_miso_o(ipb_vi2c_1),
        ipb_track_i     => ipb_mosi_i(ipb_track_1),
        ipb_track_o     => ipb_miso_o(ipb_track_1),
        ipb_regs_i      => ipb_mosi_i(ipb_regs_1),
        ipb_regs_o      => ipb_miso_o(ipb_regs_1),
        ipb_info_i      => ipb_mosi_i(ipb_info_1),
        ipb_info_o      => ipb_miso_o(ipb_info_1),
        request_write_o => request_write,
        request_tri_o   => request_tri,
        request_read_i  => request_read
    );

    --================================--
    -- Trigger links
    --================================--

    link_trigger_inst : entity work.link_trigger
    port map(
        gtx_clk_i       => gtx_clk,
        ipb_clk_i       => ipb_clk_i,
        reset_i         => reset_i,
        rx_error_i      => rx_error(3),
        rx_kchar_i      => rx_kchar(7 downto 6),
        rx_data_i       => rx_data(63 downto 48),
        tx_kchar_o      => tx_kchar(7 downto 6),
        tx_data_o       => tx_data(63 downto 48),
        ipb_trigger_i   => ipb_mosi_i(ipb_trigger),
        ipb_trigger_o   => ipb_miso_o(ipb_trigger),
        fifo_reset_i    => empty_trigger_fifo,
        sbit_config_i   => sbit_configuration,
        ext_sbit_o      => ext_sbit
    );

    --TTC/TTT signal handling 	
    -- from ngFEC_logic.vhd (HCAL)
    amc13: amc13_top
      Port map( TTC_CLK_p  => cdce_out4_p,
                TTC_CLK_n  => cdce_out4_n,
                TTC_data_p => amc_port_rx_p(3),
                TTC_data_n => amc_port_rx_n(3),
                TTC_CLK    => cdce_clkout4,
                TTCready   => TTCready,
--                TTCready   => OPEN,
--                TTCready   => user_v6_led_o(2),
                L1Accept   => L1ACCEPT,
                BCntRes    => BCntRes,
                EvCntRes   => EvCntRes, 
                SinErrStr  => SinErrStr,
                DbErrStr   => DbErrStr,
                BrcstStr   => BrcstStr,
                Brcst      => Brcst);

    process(cdce_clkout4) is
	   variable clk_count: unsigned(31 downto 0);
		variable led: STD_LOGIC;
		variable blink_length: integer := 20_000_000;
		variable l1a: STD_LOGIC;
    begin
      if (rising_edge(cdce_clkout4)) then
		  if (l1a = '0') then -- when we have L1A we'll stay with LED on for longer
  		    if (TTCready = '1') then -- blink slowly when TTC is ready
			   blink_length := 20_000_000;
		    else -- blink fast when TTC is not ready
			   blink_length := 5_000_000;
		    end if;
		  end if;
		  
		  if (L1ACCEPT = '1') then -- check L1ACCEPT signal and set our l1a flag to true
		    l1a := '1';
			 clk_count := (others => '0'); -- restart the counter
			 blink_length := 80_000_000;   -- wait 2sec
			 led := '1';                   -- light up the LED
		  end if;
		  
        clk_count := clk_count + 1;
		  if (clk_count > blink_length) then
		    clk_count := (others => '0');
			 led := not led;
			 l1a := '0';
		  end if;
		  user_v6_led_o(2) <= led;
	   end if;
    end process;
    --TTC counters for debugging
    -- from ngFEC_logic.vhd--signal_check : process ( reset_i,cdce_clkout4,Brcst(6), Brcst(0),regs_to_wb(16), QIE_reset_counter, BrcstStr ) is
    -- from ngFEC_logic.vhd--  variable led: STD_LOGIC;
    -- from ngFEC_logic.vhd--  variable led2: STD_LOGIC;
    -- from ngFEC_logic.vhd--
    -- from ngFEC_logic.vhd--begin
    -- from ngFEC_logic.vhd--  
    -- from ngFEC_logic.vhd--  if reset_i = '1' then
    -- from ngFEC_logic.vhd--    led := '0';
    -- from ngFEC_logic.vhd--    led2 := '0';
    -- from ngFEC_logic.vhd--    Brcst_r <= '0';
    -- from ngFEC_logic.vhd--    Brcst4_r <= '0';
    -- from ngFEC_logic.vhd--    QIE_reset_counter	<= x"00000000";
    -- from ngFEC_logic.vhd--    SinErr_counter <= x"00000000";
    -- from ngFEC_logic.vhd--    DbErr_counter<= x"00000000";
    -- from ngFEC_logic.vhd--    BCnt<= x"00000000";
    -- from ngFEC_logic.vhd--    EvCnt<= x"00000000";
    -- from ngFEC_logic.vhd--  elsif rising_edge(cdce_clkout4) then
    -- from ngFEC_logic.vhd--    if Brcst(4) = '1' and Brcst4_r = '0' then
    -- from ngFEC_logic.vhd--      led := not led;
    -- from ngFEC_logic.vhd--    end if;
    -- from ngFEC_logic.vhd--    
    -- from ngFEC_logic.vhd--    Brcst4_r <= Brcst(4);	
    -- from ngFEC_logic.vhd--    user_v6_led_o(1) <= led;
    -- from ngFEC_logic.vhd--    
    -- from ngFEC_logic.vhd--    if Brcst(0) = '1' and BrcstStr = '1' then
    -- from ngFEC_logic.vhd--      led2 := not led2;
    -- from ngFEC_logic.vhd--      QIE_reset_counter <= QIE_reset_counter + 1;
    -- from ngFEC_logic.vhd--    end if;
    -- from ngFEC_logic.vhd--    --Single Err Counter 
    -- from ngFEC_logic.vhd--    if SinErrStr = '1' then
    -- from ngFEC_logic.vhd--      SinErr_counter <= SinErr_counter + 1;
    -- from ngFEC_logic.vhd--    end if;
    -- from ngFEC_logic.vhd--    --Double err counter
    -- from ngFEC_logic.vhd--    if DbErrStr = '1' then
    -- from ngFEC_logic.vhd--      DbErr_counter <= DbErr_counter + 1;
    -- from ngFEC_logic.vhd--    end if;
    -- from ngFEC_logic.vhd--    -- Bunch counter
    -- from ngFEC_logic.vhd--    if BCntRes = '1' then 
    -- from ngFEC_logic.vhd--      BCnt <= BCnt +1;
    -- from ngFEC_logic.vhd--    end if;
    -- from ngFEC_logic.vhd--    --event counter
    -- from ngFEC_logic.vhd--    if EvCntRes = '1' then 
    -- from ngFEC_logic.vhd--      EvCnt <= EvCnt +1;
    -- from ngFEC_logic.vhd--    end if;
    -- from ngFEC_logic.vhd--    user_v6_led_o(2) <= led2; 
    -- from ngFEC_logic.vhd--    Brcst_r <= Brcst(0);
    -- from ngFEC_logic.vhd--    regs_to_wb(32)	<= QIE_reset_counter;
    -- from ngFEC_logic.vhd--    regs_to_wb(7)  <= DbErr_counter;
    -- from ngFEC_logic.vhd--    regs_to_wb(8)	<= SinErr_counter;
    -- from ngFEC_logic.vhd--    regs_to_wb(10)	<= BCnt;
    -- from ngFEC_logic.vhd--    regs_to_wb(11)	<= EvCnt;
    -- from ngFEC_logic.vhd--  end if;
    -- from ngFEC_logic.vhd--end process;

    --================================--
    -- Register mapping
    --================================--

    -- Empty trigger fifo

    empty_trigger_fifo <= request_tri(0);

    -- S Bits configuration : 0 -- read / write _ Controls the Sbits to send to the TDC

    sbit_configuration_reg : entity work.reg port map(fabric_clk_i => ipb_clk_i, reset_i => reset_i, wbus_i => request_write(1), wbus_t => request_tri(1), rbus_o => request_read(1));
    sbit_configuration <= request_read(1)(2 downto 0);


end user_logic_arch;
