--***************************************************************
--*																*
--*	Title	:													*
--*	Design	:													*
--*	Author	:													*
--*	Email	:													*
--*																*
--***************************************************************
--*																*
--*	Description :												*
--*																*
--***************************************************************
library IEEE;
use IEEE.std_logic_1164.all;


entity snake_stimuli is 
	port
	(
	clk		: out STD_LOGIC;
	res		: out STD_LOGIC;
	sys_direction	: out STD_LOGIC_VECTOR (3 downto 0);
	sys_step_jumper	: out STD_LOGIC
	--PINS TO VGA
	);
end snake_stimuli;


architecture arch of snake_stimuli is

--***********************************
--*	TYPE DECLARATIONS				*
--***********************************
-- define some constants to help in the snake path test
constant NO : std_logic_vector(3 downto 0):= "0000"; -- no direction selected
constant RT : std_logic_vector(3 downto 0):= "0001"; -- right
constant LF : std_logic_vector(3 downto 0):= "0010"; -- left
constant UP : std_logic_vector(3 downto 0):= "0100"; -- up
constant DW : std_logic_vector(3 downto 0):= "1000"; -- down

--***********************************
--*	COMPONENT DECLARATIONS			*
--***********************************

--***********************************
--*	INTERNAL SIGNAL DECLARATIONS	*
--***********************************
signal clk_s	: STD_LOGIC	:= '0';


begin

	--*******************************
	--*	COMPONENT INSTANTIATIONS	*
	--*******************************
	
	--*******************************
	--*	SIGNAL ASSIGNMENTS			*
	--*******************************
	
	
	clk	<= clk_s;
	
	--*******************************
	--*	PROCESS DEFINITIONS			*
	--*******************************
	
	--basic process
	process
	begin
		clk_s <= not clk_s;
		wait for 1 ns;
	end process;

	process
	begin
	
		sys_direction <= RT;
		sys_step_jumper <= '0';
		
		
		res <= '1';
		wait for 10 ns;
		res <= '0';
		
		sys_direction <= NO;

		wait for 300 ns;
		
		sys_direction <= RT;
		
		wait for 200 ns;
		sys_direction <= DW;
		
		wait for 200 ns;
		sys_direction <= LF;

		
		-- the end is near
		wait for 200 ns;
		sys_direction <= UP;

		wait for 1000 ns;
		res <= '1';
		wait for 10 ns;
		res <= '0';
		
		-- test if it can go back
		wait for 100 ns;
		sys_direction <= LF;

                -- ok, run to the right (reset direction)
		wait for 100 ns;
		sys_direction <= RT;

                -- test bottom up overflow
		wait for 100 ns;
		sys_direction <= DW;
		wait for 200 ns;
		sys_direction <= NO;
                wait for 160 ns;

                -- test left overflow
		sys_direction <= LF;
                wait for 240 ns;

                -- test up overflow
                sys_direction <= UP;
		
		wait;
		
	end process;
	
	
end arch;
