Library IEEE;
use IEEE.STD_LOGIC_1164.all;

ENTITY or2_snake IS
	PORT( x, y: IN STD_LOGIC;
		    z: OUT STD_LOGIC);
END or2_snake;

ARCHITECTURE dataflow OF or2_snake IS

BEGIN 
	z <= y OR x;
END dataflow;




