-- Copyright (C) 1991-2014 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus II License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "10/05/2014 18:54:39"
                                                            
-- Vhdl Test Bench template for design  :  advance_door_mealy
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY advance_door_mealy_vhd_tst IS
END advance_door_mealy_vhd_tst;
ARCHITECTURE advance_door_mealy_arch OF advance_door_mealy_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL CLK : STD_LOGIC;
SIGNAL KEY : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL LEDG : STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL LEDR : STD_LOGIC;
SIGNAL RSET : STD_LOGIC;
COMPONENT advance_door_mealy
	PORT (
	CLK : IN STD_LOGIC;
	KEY : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	LEDG : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
	LEDR : OUT STD_LOGIC;
	RSET : IN STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : advance_door_mealy
	PORT MAP (
-- list connections between master ports and signals
	CLK => CLK,
	KEY => KEY,
	LEDG => LEDG,
	LEDR => LEDR,
	RSET => RSET
	);
	clk_signal: process
    begin
	 --------clOCK SIGNAL---------
        clk<='1';
		   wait for 10 ps;
		 --wait on clk, reset;
        clk<='0';
        wait for 10 ps;
		 --wait on clk, reset;
 end process;  
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
-- code that executes only once
	  ------CASE 1-------
    KEY<= "1111"; -- 
	 rset<='1';
	 wait for 50ps ;
	 rset<='0';
	 wait for 50ps ;
	 rset<='1'; 
	 wait for 50ps ;
    KEY<= "0001"; -- close door
	 wait for 50ps ; 
	 ------CASE 1-------
	  KEY<= "0100"; -- lock door
	 wait for 50ps ;
    ----------------------  
	  KEY<= "0010"; -- open door
	  wait for 50ps ;
    ---------------------- 
	  KEY<= "1000"; -- error
	  wait for 50ps ;
    ---------------------- 
	  KEY<= "1111"; -- error
	  wait for 50ps ;
	  ----------------------
	 rset<='0';
	 wait for 50ps ;
	 rset<='1'; 
WAIT;                                                       
END PROCESS init;                                           
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list  
WAIT;                                                        
END PROCESS always;                                          
END advance_door_mealy_arch;
