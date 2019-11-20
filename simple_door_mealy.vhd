-- Company: TEIS AB
-- Engineer: Jasim Abbasi
-- Create Date: 2014 sep 28
-- Design Name: simple_door_mealy
-- Target Devices: ALTERA Cyclone IV EP4CE115F29C7
-- Tool versions: Quartus v11 and ModelSim
-- Description:
-- -- Description: -- 
---Reset pin address :
---Key(0-1) address: AB28, AC28
---clk pin address: Y2
---LEDG(leds) PIN Address: G19,F19
LIBRARY ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity simple_door_mealy is
    port
       (
         CLK: in std_logic; -- Clock signal
			RSET: in std_logic; --reset signal
         KEY: in std_logic_vector(1 downto 0); -- Input keys
         LEDG: out std_logic_vector(1 downto 0) -- output key
	     );
end entity;
 architecture model of simple_door_mealy is
type STATE_TYPE is (oppen, close);
signal current_state,next_state: STATE_TYPE;
signal state: STATE_TYPE;
begin
clk_reset: PROCESS (rset,clk)
   BEGIN
     IF (rset='0') THEN
          state<= oppen;
     ELSIF rising_edge(clk) THEN
       case state is
         when oppen =>
           if(KEY = "10") then
            state<= close;
       end if;
	    when close =>
           if KEY = "01" then
             state<= oppen;
           end if;
			  when others=>
			   state<= oppen;
      end case ;
		end if;
	--end if;
 end process;
 process(state,key)
   begin
   case state is
    when oppen=>
	  if(KEY = "01" or KEY = "11")then
     LEDG<="01";
	   else
		LEDG<="10";
		end if;
     when close=>
	  if(KEY = "10" or KEY = "11") then
      LEDG<="10";
		else
		LEDG<="01";
		end if;
      end case;
  end process;
 end model;