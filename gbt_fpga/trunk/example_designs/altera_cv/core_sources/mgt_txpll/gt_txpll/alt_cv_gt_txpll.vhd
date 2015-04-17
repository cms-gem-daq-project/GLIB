-- megafunction wizard: %Cyclone V Transceiver PLL v13.1%
-- GENERATION: XML
-- alt_cv_gt_txpll.vhd

-- Generated using ACDS version 13.1 162 at 2014.04.07.22:32:01

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alt_cv_gt_txpll is
	port (
		pll_powerdown      : in  std_logic                     := '0';             --      pll_powerdown.pll_powerdown
		pll_refclk         : in  std_logic_vector(0 downto 0)  := (others => '0'); --         pll_refclk.pll_refclk
		pll_fbclk          : in  std_logic                     := '0';             --          pll_fbclk.pll_fbclk
		pll_clkout         : out std_logic;                                        --         pll_clkout.pll_clkout
		pll_locked         : out std_logic;                                        --         pll_locked.pll_locked
		fboutclk           : out std_logic_vector(0 downto 0);                     --           fboutclk.fboutclk
		hclk               : out std_logic_vector(0 downto 0);                     --               hclk.hclk
		reconfig_to_xcvr   : in  std_logic_vector(69 downto 0) := (others => '0'); --   reconfig_to_xcvr.reconfig_to_xcvr
		reconfig_from_xcvr : out std_logic_vector(45 downto 0)                     -- reconfig_from_xcvr.reconfig_from_xcvr
	);
end entity alt_cv_gt_txpll;

architecture rtl of alt_cv_gt_txpll is
	component av_xcvr_plls is
		generic (
			plls                                 : integer := 1;
			pll_type                             : string  := "CMU";
			pll_reconfig                         : integer := 0;
			refclks                              : integer := 1;
			reference_clock_frequency            : string  := "125.0 MHz";
			reference_clock_select               : string  := "0";
			output_clock_datarate                : string  := "";
			output_clock_frequency               : string  := "0 ps";
			feedback_clk                         : string  := "internal";
			sim_additional_refclk_cycles_to_lock : integer := 0;
			duty_cycle                           : integer := 50;
			phase_shift                          : string  := "0 ps";
			enable_hclk                          : integer := 0;
			enable_avmm                          : integer := 1;
			use_generic_pll                      : integer := 0;
			enable_mux                           : integer := 1
		);
		port (
			rst                : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- pll_powerdown
			refclk             : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- pll_refclk
			fbclk              : in  std_logic_vector(0 downto 0)  := (others => 'X'); -- pll_fbclk
			outclk             : out std_logic_vector(0 downto 0);                     -- pll_clkout
			locked             : out std_logic_vector(0 downto 0);                     -- pll_locked
			fboutclk           : out std_logic_vector(0 downto 0);                     -- fboutclk
			hclk               : out std_logic_vector(0 downto 0);                     -- hclk
			reconfig_to_xcvr   : in  std_logic_vector(69 downto 0) := (others => 'X'); -- reconfig_to_xcvr
			reconfig_from_xcvr : out std_logic_vector(45 downto 0)                     -- reconfig_from_xcvr
		);
	end component av_xcvr_plls;

	signal alt_cv_gt_txpll_inst_outclk : std_logic_vector(0 downto 0); -- port fragment
	signal alt_cv_gt_txpll_inst_locked : std_logic_vector(0 downto 0); -- port fragment

begin

	alt_cv_gt_txpll_inst : component av_xcvr_plls
		generic map (
			plls                                 => 1,
			pll_type                             => "CMU",
			pll_reconfig                         => 0,
			refclks                              => 1,
			reference_clock_frequency            => "120.0 MHz",
			reference_clock_select               => "0",
			output_clock_datarate                => "4800 Mbps",
			output_clock_frequency               => "0 ps",
			feedback_clk                         => "internal",
			sim_additional_refclk_cycles_to_lock => 0,
			duty_cycle                           => 50,
			phase_shift                          => "0 ps",
			enable_hclk                          => 0,
			enable_avmm                          => 1,
			use_generic_pll                      => 0,
			enable_mux                           => 1
		)
		port map (
			rst(0)             => pll_powerdown,               --      pll_powerdown.pll_powerdown
			refclk(0 downto 0) => pll_refclk(0 downto 0),      --         pll_refclk.pll_refclk
			fbclk(0)           => pll_fbclk,                   --          pll_fbclk.pll_fbclk
			outclk             => alt_cv_gt_txpll_inst_outclk, --         pll_clkout.pll_clkout
			locked             => alt_cv_gt_txpll_inst_locked, --         pll_locked.pll_locked
			fboutclk           => fboutclk,                    --           fboutclk.fboutclk
			hclk               => hclk,                        --               hclk.hclk
			reconfig_to_xcvr   => reconfig_to_xcvr,            --   reconfig_to_xcvr.reconfig_to_xcvr
			reconfig_from_xcvr => reconfig_from_xcvr           -- reconfig_from_xcvr.reconfig_from_xcvr
		);

	pll_locked <= alt_cv_gt_txpll_inst_locked(0);

	pll_clkout <= alt_cv_gt_txpll_inst_outclk(0);

end architecture rtl; -- of alt_cv_gt_txpll
-- Retrieval info: <?xml version="1.0"?>
--<!--
--	Generated by Altera MegaWizard Launcher Utility version 1.0
--	************************************************************
--	THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
--	************************************************************
--	Copyright (C) 1991-2014 Altera Corporation
--	Any megafunction design, and related net list (encrypted or decrypted),
--	support information, device programming or simulation file, and any other
--	associated documentation or information provided by Altera or a partner
--	under Altera's Megafunction Partnership Program may be used only to
--	program PLD devices (but not masked PLD devices) from Altera.  Any other
--	use of such megafunction design, net list, support information, device
--	programming or simulation file, or any other related documentation or
--	information is prohibited for any other purpose, including, but not
--	limited to modification, reverse engineering, de-compiling, or use with
--	any other silicon devices, unless such use is explicitly licensed under
--	a separate agreement with Altera or a megafunction partner.  Title to
--	the intellectual property, including patents, copyrights, trademarks,
--	trade secrets, or maskworks, embodied in any such megafunction design,
--	net list, support information, device programming or simulation file, or
--	any other related documentation or information provided by Altera or a
--	megafunction partner, remains with Altera, the megafunction partner, or
--	their respective licensors.  No other licenses, including any licenses
--	needed under any third party's intellectual property, are provided herein.
---->
-- Retrieval info: <instance entity-name="altera_xcvr_pll_cv" version="13.1" >
-- Retrieval info: 	<generic name="device_family" value="Cyclone V" />
-- Retrieval info: 	<generic name="pll_reconfig" value="0" />
-- Retrieval info: 	<generic name="refclks" value="1" />
-- Retrieval info: 	<generic name="feedback_clk" value="internal" />
-- Retrieval info: 	<generic name="gui_pll_reconfig_pll0_pll_type" value="CMU" />
-- Retrieval info: 	<generic name="gui_pll_reconfig_pll0_data_rate" value="4800 Mbps" />
-- Retrieval info: 	<generic name="gui_pll_reconfig_pll0_refclk_freq" value="120.0 MHz" />
-- Retrieval info: 	<generic name="gui_pll_reconfig_pll0_refclk_sel" value="0" />
-- Retrieval info: 	<generic name="gui_pll_reconfig_pll0_clk_network" value="x1" />
-- Retrieval info: </instance>
-- IPFS_FILES : alt_cv_gt_txpll.vho
-- RELATED_FILES: alt_cv_gt_txpll.vhd, altera_xcvr_functions.sv, av_xcvr_h.sv, av_xcvr_plls.sv, av_reconfig_bundle_to_xcvr.sv, av_xcvr_avmm_csr.sv, alt_xcvr_resync.sv
