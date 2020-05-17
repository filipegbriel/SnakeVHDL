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


entity snake_testbench is 
end snake_testbench;


architecture arch of snake_testbench is

--***********************************
--*	TYPE DECLARATIONS				*
--***********************************



--***********************************
--*	COMPONENT DECLARATIONS			*
--***********************************

component snake_stimuli
	port
	(
	clk				: out STD_LOGIC;
	res				: out STD_LOGIC;
	sys_direction	: out STD_LOGIC_VECTOR (3 downto 0);
	sys_step_jumper	: out STD_LOGIC
	--PINS TO VGA
	);
end component;

component snake_hw
	generic
	(
	COR_WIDTH		: NATURAL	:= 4	--Width of one coordinate
	);

	port
	(
	clk				: in STD_LOGIC;
	res				: in STD_LOGIC;
	sys_direction	: in STD_LOGIC_VECTOR (3 downto 0);
	sys_step_jumper	: in STD_LOGIC;

	--TESTPINS
	test_mem_b_addr	: in STD_LOGIC_VECTOR(2*COR_WIDTH-1 downto 0);	--from vga interface module							--from vga interface module
	test_idle_state	: out STD_LOGIC;
	test_go_state	: out STD_LOGIC;
	test_mem_b_data	: out STD_LOGIC_VECTOR(7 downto 0)				--to vga interface module
	);
end component;

component map_monitor
	generic
	(
	COR_WIDTH		: NATURAL	:= 3;
	log_file		: string	:= "res.log"
	);

	port
	(
	mon_clk		: in STD_LOGIC;
	print_rdy	: in STD_LOGIC;
	game_over	: in STD_LOGIC;
	mem_b_data	: in STD_LOGIC_VECTOR(7 downto 0);				--to vga interface module
	mem_b_addr	: out STD_LOGIC_VECTOR(5 downto 0)	--from vga interface module
	);
end component;

--***********************************
--*	INTERNAL SIGNAL DECLARATIONS	*
--***********************************
signal clk_s			: STD_LOGIC;
signal res_s			: STD_LOGIC;
signal sys_direction_s	: STD_LOGIC_VECTOR (3 downto 0);
signal sys_step_jumper_s: STD_LOGIC;


signal test_mem_b_addr_s	: STD_LOGIC_VECTOR(5 downto 0);
signal test_mem_b_data_s	: STD_LOGIC_VECTOR(7 downto 0);
signal test_idle_state_s	: STD_LOGIC;
signal test_go_state_s		: STD_LOGIC;


begin

	--*******************************
	--*	COMPONENT INSTANTIATIONS	*
	--*******************************

	tb:		snake_stimuli	port map
							(
							clk				=> clk_s,
							res				=> res_s,
							sys_direction	=> sys_direction_s,
							sys_step_jumper	=> sys_step_jumper_s
							);

	dut:	snake_hw		generic map
							(
							COR_WIDTH	=> 3
							)

							port map
							(
							clk				=> clk_s,
							res				=> res_s,
							sys_direction	=> sys_direction_s,
							sys_step_jumper	=> sys_step_jumper_s,
							
								--TESTPINS
							test_mem_b_addr	=> test_mem_b_addr_s,
							test_idle_state	=> test_idle_state_s,
							test_go_state	=> test_go_state_s,
							test_mem_b_data	=> test_mem_b_data_s
							);

	mon:	map_monitor		generic map
							(
							COR_WIDTH	=> 3,
							log_file	=> "X:\psi3451\snake\completo\1_testbench\map_record.txt"
							)

							port map
							(
							mon_clk		=> clk_s,
							print_rdy	=> test_idle_state_s,
							game_over	=> test_go_state_s,
							mem_b_data	=> test_mem_b_data_s,
							mem_b_addr	=> test_mem_b_addr_s
							);

							
	--*******************************
	--*	SIGNAL ASSIGNMENTS			*
	--*******************************
	
	--*******************************
	--*	PROCESS DEFINITIONS			*
	--*******************************
	
end arch;
