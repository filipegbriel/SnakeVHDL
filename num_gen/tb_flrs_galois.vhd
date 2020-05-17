library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity tb_flrs_galois is

	GENERIC 
	(	
		CLK_PERIOD		: TIME		:=  10 ns;
		SIZE 			: NATURAL 	:=  12
	);
	--depois tem que tirar aqui
	port
	(
		res : in std_logic;
		func :out std_logic_vector(0 to SIZE-1)
	);
end tb_flrs_galois ;

architecture test of tb_flrs_galois is

	component FLSR is
		generic
		(
			SIZE 			: NATURAL 	:= 12;
			COEFICIENTS		: UNSIGNED	:= b"100000110011";
			SEED 			: UNSIGNED 	:= b"111111111111"
		);
			
		port
		(	
			clk				: in STD_LOGIC;
			res				: in STD_LOGIC;
			function_out 	: out STD_LOGIC_VECTOR (SIZE-1 downto 0)
		);	
	end component;
	
	component clock_generator is
		generic 
		(
			CLK_PERIOD	: TIME	:= 10 ns
		);

		port 
		(	
			clk			: out STD_LOGIC
		);
	end component ;

	signal clk_s		: STD_LOGIC :='0';

begin

	DUT: FLSR 
		generic map
		(
			SIZE 		=> SIZE,
			COEFICIENTS	=> b"100000110011",
			--SEED 		=> b"111111111111" 
			SEED 		=> b"011001111101"
							
		)
		port map
		(
			clk				=> clk_s,
			res				=> res,
			function_out 	=> func
		);
	
	stim : clock_generator
		generic map 
		( 
			CLK_PERIOD => CLK_PERIOD
		)
		port map
		(
			clk				=> clk_s
		);

end architecture test;