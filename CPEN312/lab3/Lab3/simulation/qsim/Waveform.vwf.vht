-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "02/01/2019 19:59:31"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          lab3
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY lab3_vhd_vec_tst IS
END lab3_vhd_vec_tst;
ARCHITECTURE lab3_arch OF lab3_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL CLOCK_50 : STD_LOGIC;
SIGNAL HEX00 : STD_LOGIC;
SIGNAL HEX01 : STD_LOGIC;
SIGNAL HEX02 : STD_LOGIC;
SIGNAL HEX03 : STD_LOGIC;
SIGNAL HEX04 : STD_LOGIC;
SIGNAL HEX05 : STD_LOGIC;
SIGNAL HEX06 : STD_LOGIC;
SIGNAL HEX10 : STD_LOGIC;
SIGNAL HEX11 : STD_LOGIC;
SIGNAL HEX12 : STD_LOGIC;
SIGNAL HEX13 : STD_LOGIC;
SIGNAL HEX14 : STD_LOGIC;
SIGNAL HEX15 : STD_LOGIC;
SIGNAL HEX16 : STD_LOGIC;
SIGNAL HEX20 : STD_LOGIC;
SIGNAL HEX21 : STD_LOGIC;
SIGNAL HEX22 : STD_LOGIC;
SIGNAL HEX23 : STD_LOGIC;
SIGNAL HEX24 : STD_LOGIC;
SIGNAL HEX25 : STD_LOGIC;
SIGNAL HEX26 : STD_LOGIC;
SIGNAL HEX30 : STD_LOGIC;
SIGNAL HEX31 : STD_LOGIC;
SIGNAL HEX32 : STD_LOGIC;
SIGNAL HEX33 : STD_LOGIC;
SIGNAL HEX34 : STD_LOGIC;
SIGNAL HEX35 : STD_LOGIC;
SIGNAL HEX36 : STD_LOGIC;
SIGNAL HEX40 : STD_LOGIC;
SIGNAL HEX41 : STD_LOGIC;
SIGNAL HEX42 : STD_LOGIC;
SIGNAL HEX43 : STD_LOGIC;
SIGNAL HEX44 : STD_LOGIC;
SIGNAL HEX45 : STD_LOGIC;
SIGNAL HEX46 : STD_LOGIC;
SIGNAL HEX50 : STD_LOGIC;
SIGNAL HEX51 : STD_LOGIC;
SIGNAL HEX52 : STD_LOGIC;
SIGNAL HEX53 : STD_LOGIC;
SIGNAL HEX54 : STD_LOGIC;
SIGNAL HEX55 : STD_LOGIC;
SIGNAL HEX56 : STD_LOGIC;
SIGNAL LED0 : STD_LOGIC;
SIGNAL LED1 : STD_LOGIC;
SIGNAL LED2 : STD_LOGIC;
SIGNAL LED3 : STD_LOGIC;
SIGNAL LED4 : STD_LOGIC;
SIGNAL LED5 : STD_LOGIC;
SIGNAL LED6 : STD_LOGIC;
SIGNAL LED7 : STD_LOGIC;
SIGNAL LED8 : STD_LOGIC;
SIGNAL LED9 : STD_LOGIC;
SIGNAL PB0 : STD_LOGIC;
SIGNAL PB1 : STD_LOGIC;
SIGNAL PB2 : STD_LOGIC;
SIGNAL PB3 : STD_LOGIC;
SIGNAL SW0 : STD_LOGIC;
SIGNAL SW1 : STD_LOGIC;
SIGNAL SW2 : STD_LOGIC;
SIGNAL SW3 : STD_LOGIC;
SIGNAL SW4 : STD_LOGIC;
SIGNAL SW5 : STD_LOGIC;
SIGNAL SW6 : STD_LOGIC;
SIGNAL SW7 : STD_LOGIC;
SIGNAL SW8 : STD_LOGIC;
SIGNAL SW9 : STD_LOGIC;
COMPONENT lab3
	PORT (
	CLOCK_50 : IN STD_LOGIC;
	HEX00 : OUT STD_LOGIC;
	HEX01 : OUT STD_LOGIC;
	HEX02 : OUT STD_LOGIC;
	HEX03 : OUT STD_LOGIC;
	HEX04 : OUT STD_LOGIC;
	HEX05 : OUT STD_LOGIC;
	HEX06 : OUT STD_LOGIC;
	HEX10 : OUT STD_LOGIC;
	HEX11 : OUT STD_LOGIC;
	HEX12 : OUT STD_LOGIC;
	HEX13 : OUT STD_LOGIC;
	HEX14 : OUT STD_LOGIC;
	HEX15 : OUT STD_LOGIC;
	HEX16 : OUT STD_LOGIC;
	HEX20 : OUT STD_LOGIC;
	HEX21 : OUT STD_LOGIC;
	HEX22 : OUT STD_LOGIC;
	HEX23 : OUT STD_LOGIC;
	HEX24 : OUT STD_LOGIC;
	HEX25 : OUT STD_LOGIC;
	HEX26 : OUT STD_LOGIC;
	HEX30 : OUT STD_LOGIC;
	HEX31 : OUT STD_LOGIC;
	HEX32 : OUT STD_LOGIC;
	HEX33 : OUT STD_LOGIC;
	HEX34 : OUT STD_LOGIC;
	HEX35 : OUT STD_LOGIC;
	HEX36 : OUT STD_LOGIC;
	HEX40 : OUT STD_LOGIC;
	HEX41 : OUT STD_LOGIC;
	HEX42 : OUT STD_LOGIC;
	HEX43 : OUT STD_LOGIC;
	HEX44 : OUT STD_LOGIC;
	HEX45 : OUT STD_LOGIC;
	HEX46 : OUT STD_LOGIC;
	HEX50 : OUT STD_LOGIC;
	HEX51 : OUT STD_LOGIC;
	HEX52 : OUT STD_LOGIC;
	HEX53 : OUT STD_LOGIC;
	HEX54 : OUT STD_LOGIC;
	HEX55 : OUT STD_LOGIC;
	HEX56 : OUT STD_LOGIC;
	LED0 : OUT STD_LOGIC;
	LED1 : OUT STD_LOGIC;
	LED2 : OUT STD_LOGIC;
	LED3 : OUT STD_LOGIC;
	LED4 : OUT STD_LOGIC;
	LED5 : OUT STD_LOGIC;
	LED6 : OUT STD_LOGIC;
	LED7 : OUT STD_LOGIC;
	LED8 : OUT STD_LOGIC;
	LED9 : OUT STD_LOGIC;
	PB0 : IN STD_LOGIC;
	PB1 : IN STD_LOGIC;
	PB2 : IN STD_LOGIC;
	PB3 : IN STD_LOGIC;
	SW0 : IN STD_LOGIC;
	SW1 : IN STD_LOGIC;
	SW2 : IN STD_LOGIC;
	SW3 : IN STD_LOGIC;
	SW4 : IN STD_LOGIC;
	SW5 : IN STD_LOGIC;
	SW6 : IN STD_LOGIC;
	SW7 : IN STD_LOGIC;
	SW8 : IN STD_LOGIC;
	SW9 : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : lab3
	PORT MAP (
-- list connections between master ports and signals
	CLOCK_50 => CLOCK_50,
	HEX00 => HEX00,
	HEX01 => HEX01,
	HEX02 => HEX02,
	HEX03 => HEX03,
	HEX04 => HEX04,
	HEX05 => HEX05,
	HEX06 => HEX06,
	HEX10 => HEX10,
	HEX11 => HEX11,
	HEX12 => HEX12,
	HEX13 => HEX13,
	HEX14 => HEX14,
	HEX15 => HEX15,
	HEX16 => HEX16,
	HEX20 => HEX20,
	HEX21 => HEX21,
	HEX22 => HEX22,
	HEX23 => HEX23,
	HEX24 => HEX24,
	HEX25 => HEX25,
	HEX26 => HEX26,
	HEX30 => HEX30,
	HEX31 => HEX31,
	HEX32 => HEX32,
	HEX33 => HEX33,
	HEX34 => HEX34,
	HEX35 => HEX35,
	HEX36 => HEX36,
	HEX40 => HEX40,
	HEX41 => HEX41,
	HEX42 => HEX42,
	HEX43 => HEX43,
	HEX44 => HEX44,
	HEX45 => HEX45,
	HEX46 => HEX46,
	HEX50 => HEX50,
	HEX51 => HEX51,
	HEX52 => HEX52,
	HEX53 => HEX53,
	HEX54 => HEX54,
	HEX55 => HEX55,
	HEX56 => HEX56,
	LED0 => LED0,
	LED1 => LED1,
	LED2 => LED2,
	LED3 => LED3,
	LED4 => LED4,
	LED5 => LED5,
	LED6 => LED6,
	LED7 => LED7,
	LED8 => LED8,
	LED9 => LED9,
	PB0 => PB0,
	PB1 => PB1,
	PB2 => PB2,
	PB3 => PB3,
	SW0 => SW0,
	SW1 => SW1,
	SW2 => SW2,
	SW3 => SW3,
	SW4 => SW4,
	SW5 => SW5,
	SW6 => SW6,
	SW7 => SW7,
	SW8 => SW8,
	SW9 => SW9
	);

-- CLOCK_50
t_prcs_CLOCK_50: PROCESS
BEGIN
	CLOCK_50 <= '0';
WAIT;
END PROCESS t_prcs_CLOCK_50;
END lab3_arch;
