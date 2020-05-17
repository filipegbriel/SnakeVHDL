library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.snake_package.all;


entity tb_fsm_step is
end tb_fsm_step;

architecture test of tb_fsm_step is

	component fsm_step is 
		port
		(
			clk				: in STD_LOGIC;						--from system
			res				: in STD_LOGIC;						--from system
			fsm_m_start		: in STD_LOGIC;						--from fsm main
			cmp_food_flag	: in STD_LOGIC;						--from datapath/comparator module
			cmp_body_flag	: in STD_LOGIC;						--from datapath/comparator module
			sys_direction	: in direction;						--from system
			dp_ctrl 		: out datapath_ctrl_flags;			--to datapath
			fsm_m_done		: out STD_LOGIC;					--to fsm main
			fsm_m_game_over	: out STD_LOGIC						--to fsm main
		);
	end component;

	component stimuli_fsm_step is
		generic
		(
			CLK_PERIOD			: TIME	:=  10ns
		);
		port
		(
			clk				: out STD_LOGIC;						--from system
			res				: out STD_LOGIC;						--from system
			fsm_m_start		: out STD_LOGIC;						--from fsm main
			cmp_food_flag	: out STD_LOGIC;						--from datapath/comparator module
			cmp_body_flag	: out STD_LOGIC;						--from datapath/comparator module
			sys_direction	: out direction							--from system
		);
	end component;
	
	signal cmp_food_flag_wire	:  STD_LOGIC;						--from datapath/comparator module
	signal cmp_body_flag_wire	:  STD_LOGIC;						--from datapath/comparator module
	signal sys_direction_wire	:  direction;						--from system
	signal fsm_m_game_over_wire	:  STD_LOGIC;						--to fsm main

	
	signal fsm_m_start_wire		: STD_LOGIC;
	signal clk_wire		 		: STD_LOGIC;
	signal res_wire		 		: STD_LOGIC;
	signal dp_ctrl_wire			: datapath_ctrl_flags;
	signal fsm_m_done_wire 		: STD_LOGIC;
	
begin

	DUT: fsm_step
		port map
		(
			clk					=> clk_wire,
			res					=> res_wire,
			fsm_m_start			=> fsm_m_start_wire,
			cmp_food_flag		=> cmp_food_flag_wire,
			cmp_body_flag		=> cmp_body_flag_wire,
			sys_direction		=> sys_direction_wire,
			dp_ctrl 			=> dp_ctrl_wire,
			fsm_m_done			=> fsm_m_done_wire,
			fsm_m_game_over		=> fsm_m_game_over_wire			
		);

	STIM: stimuli_fsm_step

		port map
		(
			clk					=> clk_wire,
			res					=> res_wire,
			fsm_m_start			=> fsm_m_start_wire,
			cmp_food_flag		=> cmp_food_flag_wire,
			cmp_body_flag		=> cmp_body_flag_wire,
			sys_direction		=> sys_direction_wire
		);
end architecture test;