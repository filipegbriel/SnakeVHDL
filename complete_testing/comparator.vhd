--***************************************************************
--*																*
--*	Title	:	Comparator									*
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
use work.snake_package.all;

entity comparator is 
	port
	(
	mem_a_read	: in STD_LOGIC_VECTOR(7 downto 0);
	food_flag	: out STD_LOGIC;
	body_flag	: out STD_LOGIC
	);
end comparator;


architecture arch of comparator is

--***********************************
--*	TYPE DECLARATIONS				*
--***********************************

--***********************************
--*	COMPONENT DECLARATIONS			*
--***********************************

--***********************************
--*	INTERNAL SIGNAL DECLARATIONS	*
--***********************************

begin

	--*******************************
	--*	COMPONENT INSTANTIATIONS	*
	--*******************************

	--*******************************
	--*	SIGNAL ASSIGNMENTS			*
	--*******************************
	
	--bit (7) indicates food
	food_flag	<= 	mem_a_read(7);	
	
	--bit (4) is set for all bodyparts
	body_flag	<= 	mem_a_read(4);
					
	--*******************************
	--*	PROCESS DEFINITIONS			*
	--*******************************

end arch;
