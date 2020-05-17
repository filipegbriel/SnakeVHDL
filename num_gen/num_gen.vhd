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
use IEEE.numeric_std.all;


entity num_gen is
	generic
	(
		WIDTH	: natural := 8; --tamanho dos vetores
		SIZE 	: NATURAL 	:= 12
	);
	
	port
	(
		pos_neg			: in STD_LOGIC;
		one_num_gen		: in STD_LOGIC;
		clock, res 		: in STD_LOGIC;
		number			: out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
	);
	
end num_gen;


architecture arch of num_gen is

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

signal pos_neg_s	: STD_LOGIC_VECTOR (WIDTH-1 downto 0);
signal one_gen_s	: STD_LOGIC_VECTOR (WIDTH-1 downto 0);
signal rand_num		: STD_LOGIC_VECTOR (WIDTH-1 downto 0);
signal pseudo_num   : STD_LOGIC_VECTOR (SIZE-1 downto 0); 


begin
	
	rand: FLSR 
		generic map
		(
			SIZE 		=> SIZE,
			COEFICIENTS	=> b"100000110011",
			SEED 		=> b"111111111111"
							
		)
		port map
		(
			clk				=> clock,
			res				=> res,
			function_out 	=> pseudo_num
		);
	
	rand_num(7) <= '0';
	rand_num(6) <= pseudo_num(5);
	rand_num(5) <= pseudo_num(4);
	rand_num(4) <= pseudo_num(3);
	rand_num(3) <= '0';
	rand_num(2) <= pseudo_num(2);
	rand_num(1) <= pseudo_num(1);
	rand_num(0) <= pseudo_num(0);


	pos_neg_s	<=	std_logic_vector (to_unsigned(1, pos_neg_s'length))		when (pos_neg = '0') else	
					std_logic_vector (to_signed(-1, pos_neg_s'length))		when (pos_neg = '1') else
																			(others => 'X' );
	
	one_gen_s	<=	pos_neg_s												when (one_num_gen = '0') else
					rand_num												when (one_num_gen = '1') else
																			(others => 'X' );

	number		<= 	one_gen_s ;
	
	
end arch;
