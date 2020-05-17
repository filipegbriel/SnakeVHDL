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
constant LF : std_logic_vector(3 downto 0):= "1000"; -- left
constant UP : std_logic_vector(3 downto 0):= "0010"; -- up
constant DW : std_logic_vector(3 downto 0):= "0100"; -- down

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
		wait for 50 ns;
	end process;

	process
begin
	
		sys_direction <= RT;		
		
		res <= '1';
		wait for 100 ns;
		res <= '0';
		
		sys_direction <= RT;
		wait for 11200 ns;
		sys_direction <= NO;
		--o jogo começou
		--12100
		wait for 12000 ns;
		wait for 12000 ns;
		wait for 12000 ns;
		wait for 12000 ns;
		wait for 12000 ns;
		wait for 12000 ns;
		wait for 12000 ns;
		sys_direction <= DW;
		wait for 12000 ns;
		wait for 12000 ns;
		wait for 12000 ns;
		wait for 12000 ns;
		wait for 12000 ns;
		sys_direction <= RT;
		wait for 12000 ns;
		sys_direction <= UP;
		wait for 12000 ns;
		wait for 12000 ns;
		wait for 12000 ns;
		wait for 12000 ns;
		wait for 12000 ns;
		sys_direction <= RT;
		wait for 12000 ns;
		wait for 12000 ns;
		wait for 12000 ns;
		wait for 12000 ns;
		wait for 12000 ns;
		wait for 12000 ns;
		wait for 12000 ns;
		sys_direction <= DW;
		wait for 12000 ns;
		wait for 12000 ns;
		wait;
	end process;
end arch;
