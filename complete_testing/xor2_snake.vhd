Library IEEE;
use IEEE.STD_LOGIC_1164.all;

ENTITY xor2_snake IS
	PORT( x, y: IN STD_LOGIC;
		    z: OUT STD_LOGIC);
END xor2_snake;

ARCHITECTURE dataflow OF xor2_snake IS

BEGIN 
	z <= x XOR y;
END dataflow;