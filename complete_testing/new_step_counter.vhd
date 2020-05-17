--***************************************************************
--*
--*   Version with 2 counters: 1) slower cnt_rdy for FSM steps ; 
--*       2) faster cnt_button_rdy for button control.
--*
--***************************************************************
--*																*
--*	Title	:	Step Counter									*
--*	Design	:	snake_hw										*
--*	Author	:	Frederik Luehrs									*
--*	Email	:	luehrs.fred@gmail.com							*
--*																*
--***************************************************************
--*																*
--*	Description :												*
--*																*
--***************************************************************
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;


entity step_counter is 
	generic
	(
	COUNT_MAX	: positive	:= 100
	);

	port
	(
	clk		: in STD_LOGIC;
	clr		: in STD_LOGIC;
	cnt_rdy	: out STD_LOGIC;
	cnt_button_rdy	: out STD_LOGIC
	);
end step_counter;


architecture arch of step_counter is

--***********************************
--*	TYPE DECLARATIONS				*
--***********************************

--***********************************
--*	COMPONENT DECLARATIONS			*
--***********************************

--***********************************
--*	INTERNAL SIGNAL DECLARATIONS	*
--***********************************
signal cnt_s	: UNSIGNED (31 downto 0)	:= to_unsigned(0, 32);
signal cnt_button_s	: UNSIGNED (31 downto 0)	:= to_unsigned(0, 32);

begin

	--*******************************
	--*	COMPONENT INSTANTIATIONS	*
	--*******************************

	--*******************************
	--*	SIGNAL ASSIGNMENTS			*
	--*******************************
	
	cnt_rdy	<= 	'1' when (cnt_s = COUNT_MAX) else
				'0';	
	cnt_button_rdy	<= 	'1' when (cnt_button_s = (COUNT_MAX/20)) else
				'0';	
	
	--*******************************
	--*	PROCESS DEFINITIONS			*
	--*******************************
				
	--increment counter each cycle
	--reset if max reached or clr is set
	process(clk)
	begin
		if clk'event and clk = '1' then
			if(clr = '1') then
				cnt_s <= to_unsigned(0, cnt_s'length);
				cnt_button_s <= to_unsigned(0, cnt_button_s'length);				
			elsif(cnt_s = COUNT_MAX) then
				cnt_s <= to_unsigned(0, cnt_s'length);
				cnt_button_s <= to_unsigned(0, cnt_button_s'length);
				elsif(cnt_button_s = COUNT_MAX/20) then
					cnt_button_s <= to_unsigned(0, cnt_button_s'length);
				else
					cnt_button_s <= cnt_button_s + 1;	
					cnt_s <= cnt_s + 1;						
			end if;
		end if;
	end process;

end arch;
