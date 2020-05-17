Library IEEE;
use IEEE.STD_LOGIC_1164.all;


ENTITY and2222 IS
	GENERIC(t_and : time := 2 ns);
	PORT( x, y: IN STD_LOGIC;
		    z: OUT STD_LOGIC);
END and2222;

ARCHITECTURE dataflow OF and2222 IS

BEGIN 
	z <= x AND y AFTER t_and;
END dataflow;

Library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity full_adder_2 is
	port
	(
	a_in, b_in, c_in		:	in STD_LOGIC;
	z_o, c_o		:	out STD_LOGIC
	);
	
end full_adder_2;


architecture structural of full_adder_2 is

	COMPONENT and2222 
		GENERIC (t_and: time := 2 ns);
		PORT (x, y: IN STD_LOGIC;
			    z   : OUT STD_LOGIC);
	END COMPONENT;
	
	COMPONENT xor2
		GENERIC (t_xor: time := 4 ns);
		PORT (x, y: IN STD_LOGIC;
			    z: OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT or3_other
		GENERIC (t_or: time := 4 ns);
		PORT (w, x, y: IN STD_LOGIC;
			    z: OUT STD_LOGIC);
	END COMPONENT;  
  
signal aux_xor, aux_and_1, aux_and_2, aux_and_3	: STD_LOGIC;

begin

	XOR_2: xor2 GENERIC MAP (10 ns) PORT MAP (x=>c_in ,y=>aux_xor ,z=>z_o ); 
     	XOR_1: xor2 GENERIC MAP (10 ns) PORT MAP (y=>b_in, z=>aux_xor, x=>a_in); 
     	AND_1: and2222 GENERIC MAP (10 ns) PORT MAP (a_in, b_in, aux_and_1); 
     	AND_2: and2222 GENERIC MAP (10 ns) PORT MAP (a_in ,c_in, aux_and_2); 
	OR_3: or3_other GENERIC MAP (10 ns) PORT MAP (aux_and_1, aux_and_2 ,y=>aux_and_3, z=>c_o ); 
	AND_3: and2222 GENERIC MAP (10 ns) PORT MAP (x=>b_in ,y=>c_in ,z=>aux_and_3 ); 


end structural;

Library IEEE;
use IEEE.STD_LOGIC_1164.all;



ENTITY xor2 IS
	GENERIC(t_xor : time := 4 ns);
	PORT( x, y: IN STD_LOGIC;
		    z: OUT STD_LOGIC);
END xor2;

ARCHITECTURE dataflow OF xor2 IS

BEGIN 
	z <= x XOR y AFTER t_xor;
END dataflow;

Library IEEE;
use IEEE.STD_LOGIC_1164.all;



ENTITY or3_other IS
	GENERIC(t_or : time := 4 ns);
	PORT( w, x, y: IN STD_LOGIC;
		    z: OUT STD_LOGIC);
END or3_other;

ARCHITECTURE dataflow OF or3_other IS

BEGIN 
	z <= w OR x OR y AFTER t_or;
END dataflow;

Library IEEE;
use IEEE.STD_LOGIC_1164.all;



entity rc_adder is
	generic
	(
	WIDTH	: natural := 4
	);
	port
	(
	a_i			:	in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
	b_i			:	in STD_LOGIC_VECTOR (WIDTH-1 downto 0);
	c_i			:	in STD_LOGIC;
	z_o		:	out STD_LOGIC_VECTOR (WIDTH-1 downto 0);
	c_o			:	out STD_LOGIC
	);
	
end rc_adder;


architecture structural of rc_adder is

component full_adder_2 is
	port
	(
	a_in, b_in, c_in		:	in STD_LOGIC;
	z_o, c_o			:	out STD_LOGIC
	);
	
end component;

signal tmp 		: STD_LOGIC_VECTOR (WIDTH-1 downto 0);
signal c_tmp 	: STD_LOGIC_VECTOR (WIDTH-1 downto 0);

begin
		ADD_0: full_adder_2 port map  
		(
			a_in => a_i(0), 
			b_in => b_i(0), 
			c_in => c_i, 		
			z_o  => tmp(0), 
			c_o  => c_tmp(0)
		);
		
	G1: for i in 1 to WIDTH-1 generate 
	
		ADD_i: full_adder_2 port map  
		(
			a_in => a_i(i), 
			b_in => b_i(i), 
			c_in => c_tmp(i-1), 		
			z_o  => tmp(i), 
			c_o  => c_tmp(i)
		);
	
	end generate G1;
	
	z_o <= tmp;
	c_o <= c_tmp(WIDTH-1);
	
end structural;

