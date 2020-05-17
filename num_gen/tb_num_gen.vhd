library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity tb_num_gen is

	GENERIC 
	(	
		WIDTH	: natural := 8 
	);
	port
	(
		number : out std_logic_vector(WIDTH-1 downto 0)
	);
end tb_num_gen ;

architecture test of tb_num_gen is

	component num_gen is
		generic
		(
			WIDTH	: natural := 8;
			SIZE 	: NATURAL 	:= 12			
		);
		
		port
		(
			pos_neg			: in STD_LOGIC;
			one_num_gen		: in STD_LOGIC;
			clock, res 		: in STD_LOGIC;
			number			: out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
		);
	end component;

	component stimuli_num_gen is
		generic
		(
			WIDTH			: NATURAL := 8;
			CLK_PERIOD		: TIME	:=  10ns
		);

		port
		(
			pos_neg			: out STD_LOGIC;
			one_num_gen		: out STD_LOGIC;
			clk		 		: out STD_LOGIC;
			res		 		: out STD_LOGIC
		);
	end component;
	
	signal pos_neg_wire			: STD_LOGIC;
	signal one_num_gen_wire		: STD_LOGIC;
	signal clk_wire		 		: STD_LOGIC;
	signal res_wire		 		: STD_LOGIC;
	
begin

	DUT: num_gen
		generic map
		(
			WIDTH 	=> 8,
			SIZE  	=> 12			
		)
		
		port map
		(
			pos_neg			=> 	pos_neg_wire,
			one_num_gen		=> 	one_num_gen_wire,
			clock 			=> 	clk_wire,
			res 			=> 	res_wire,
			number			=> 	number
		);

	STIM: stimuli_num_gen
		generic map
		(
			WIDTH		=> 8,
			CLK_PERIOD 	=>  10ns
		)

		port map
		(
			pos_neg			=> 	pos_neg_wire,
			one_num_gen		=>	one_num_gen_wire,
			clk 			=> 	clk_wire,
			res 			=> 	res_wire
		);
end architecture test;