-- Company: TEIS AB
-- Engineer: Jasim Abbasi
-- Create Date: 2014 sep 28
-- Design Name: ROM
-- Target Devices: ALTERA Cyclone IV EP4CE115F29C7
-- Tool versions: Quartus v11 and ModelSim
-- Description:
---Reset pin address :Y23
---Key(0-3) address: AB28, AC28,AC27,AD27
---clk pin address: Y2
---LEDG(leds) PIN Address: G19,F19
---LEDR(leds):G19
---Reset: AB27  
LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity advance_door_mealy is
    port
       (
         CLK: in std_logic; -- Clk
			RSET: in std_logic;-- Reset signal
         KEY: in std_logic_vector(3 downto 0); -- input keys
         LEDG: out std_logic_vector(2 downto 0);-- outputs
		   LEDR :out std_logic---- output
	     );
end advance_door_mealy;
 architecture model of advance_door_mealy is
type STATE_TYPE is (error, oppen, close,lock);
signal state: STATE_TYPE;
--variable TMP : std_logic;
begin
clk_reset: PROCESS (rset,clk)
   BEGIN
     IF (rset='0') THEN
        state<= oppen;
   ELSIF rising_edge(clk) THEN
   case state is
        when oppen =>
		   if(KEY = "0001") then
            state<= close;
				LEDG<="010";
				LEDR <='0';
			elsif(KEY = "1000") then
		       state<= error; 
				 LEDG<="000";
				 LEDR <='1';
         else
         state <= oppen;
			LEDG<="001";
			LEDR <='0';
         end if;
	    when close =>
          if(KEY = "0100") then
            state<=lock;
				LEDG<="100";
				LEDR <='0';
			elsif(KEY = "0010") then
		       state<= oppen; 
				 LEDG<="001";
				 LEDR <='0';
         else
         state <= close;
			LEDG<="010";
			LEDR <='0';
         end if;
		when lock =>
		    if(KEY = "0001") then
            state<= close;
				LEDG<="010";
				LEDR <='0';
			elsif(KEY = "1000") then
		       state<= error; 
				 LEDG<="000";
				 LEDR <='1';
         else
         state <= lock;
			LEDG<="100";
			LEDR <='0';
         end if;
		 when error =>
		       LEDG<="000";
	           LEDR<='1';
			when others =>	
			        LEDG<="111";
      end case ;
	end if;
 end process;
 end model;