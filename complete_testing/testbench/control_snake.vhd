--***************************************************************
--*																*
--*	Title	: Control Unit										*
--*	Design	: Snake Project										*
--*	Author	: Frederik Luehrs									*
--*	Email	: luehrs.fred@gmail.com								*
--*																*
--***************************************************************
--*																*
--*	Description :												*
--*																*
--***************************************************************

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.snake_package.all;

entity control_snake is 
	port
	(
	clk				: in STD_LOGIC;						--from system
	res				: in STD_LOGIC;						--from system
	sys_direction	: in direction;						--from system
	cnt_rdy			: in STD_LOGIC;						--from counter
	dp_flags		: in datapath_flags;				--from datapath
	dp_ctrl 		: out datapath_ctrl_flags;				--to datapath
	
	--TESTPORTS
	test_idle_state	: out STD_LOGIC;
	test_go_state	: out STD_LOGIC
	);
end control_snake;




architecture arch of control_snake is

--***********************************
--*	TYPE DECLARATIONS				*
--***********************************



--***********************************
--*	COMPONENT DECLARATIONS			*
--***********************************

-- check
component fsm_main
	port
	(
	clk				: in STD_LOGIC;
	res				: in STD_LOGIC;
	cnt_rdy			: in STD_LOGIC;
	cmp_food_flag	: in STD_LOGIC;
	fsm_i_done		: in STD_LOGIC;
	fsm_f_done		: in STD_LOGIC;
	fsm_s_done		: in STD_LOGIC;
	fsm_s_game_over	: in STD_LOGIC;
	con_sel			: out CONTROL_SELECT;
	fsm_i_start		: out STD_LOGIC;
	fsm_f_start		: out STD_LOGIC;
	fsm_s_start		: out STD_LOGIC
	);
end component;

-- check
component fsm_init
	port
	(
	clk			: in STD_LOGIC;
	res			: in STD_LOGIC;
	fsm_m_start	: in STD_LOGIC;
	ofc_of_x	: in STD_LOGIC;
	ofc_of_y	: in STD_LOGIC;
	dp_ctrl 	: out datapath_ctrl_flags;
	fsm_m_done	: out STD_LOGIC
	);
end component;

-- check
component fsm_food
	port
	(
	clk				: in STD_LOGIC;
	res				: in STD_LOGIC;
	fsm_m_start		: in STD_LOGIC;
	cmp_body_flag	: in STD_LOGIC;
	dp_ctrl 		: out datapath_ctrl_flags;
	fsm_m_done		: out STD_LOGIC
	);
end component;

-- check
component fsm_step
	port
	(
	clk				: in STD_LOGIC;
	res				: in STD_LOGIC;
	fsm_m_start		: in STD_LOGIC;
	cmp_food_flag	: in STD_LOGIC;
	cmp_body_flag	: in STD_LOGIC;
	sys_direction	: in direction;
	dp_ctrl 		: out datapath_ctrl_flags;
	fsm_m_done		: out STD_LOGIC;
	fsm_m_game_over	: out STD_LOGIC
	);
end component;


--***********************************
--*	INTERNAL SIGNAL DECLARATIONS	*
--***********************************

--signals from FSM_MAIN to sub FSMs
signal init_start_s		: STD_LOGIC;
signal food_start_s		: STD_LOGIC;
signal step_start_s		: STD_LOGIC;

--signals from sub FSMs to FSM_MAIN
signal init_done_s		: STD_LOGIC;
signal food_done_s		: STD_LOGIC;
signal step_done_s		: STD_LOGIC;
signal game_over_s		: STD_LOGIC;

--signals to control datapath control signals
signal select_fsm_s		: CONTROL_SELECT;
signal init_control_s	: datapath_ctrl_flags;
signal food_control_s	: datapath_ctrl_flags;
signal step_control_s	: datapath_ctrl_flags;



signal test_go_state_s	: STD_LOGIC	:='0';


begin

	--*******************************
	--*	COMPONENT INSTANTIATIONS	*
	--*******************************

	main:	fsm_main	port map
						(
						clk				=> clk,
						res				=> res,
						cnt_rdy			=> cnt_rdy,
						cmp_food_flag	=> dp_flags.cmp_food_flag,
						fsm_i_done		=> init_done_s,
						fsm_f_done		=> food_done_s,
						fsm_s_done		=> step_done_s,
						fsm_s_game_over	=> game_over_s,
						con_sel			=> select_fsm_s,
						fsm_i_start		=> init_start_s,
						fsm_f_start		=> food_start_s,
						fsm_s_start		=> step_start_s
						);

	init:	fsm_init	port map
						(
						clk			=> clk,
						res			=> res,
						fsm_m_start	=> init_start_s,
						ofc_of_x	=> dp_flags.ofc_of_x,
						ofc_of_y	=> dp_flags.ofc_of_y,
						dp_ctrl 	=> init_control_s,
						fsm_m_done	=> init_done_s
						);

	food:	fsm_food	port map
						(
						clk				=> clk,
						res				=> res,
						fsm_m_start		=> food_start_s,
						cmp_body_flag	=> dp_flags.cmp_body_flag,
						dp_ctrl 		=> food_control_s,
						fsm_m_done		=> food_done_s
						);

	step:	fsm_step	port map
						(
						clk				=> clk,
						res				=> res,
						fsm_m_start		=> step_start_s,
						cmp_food_flag	=> dp_flags.cmp_food_flag,
						cmp_body_flag	=> dp_flags.cmp_body_flag,
						sys_direction	=> sys_direction,
						dp_ctrl 		=> step_control_s,
						fsm_m_done		=> step_done_s,
						fsm_m_game_over	=> game_over_s
						);


	--*******************************
	--*	SIGNAL ASSIGNMENTS			*
	--*******************************
	with select_fsm_s select
		dp_ctrl	<=	init_control_s	when INIT_CON,
					food_control_s	when FOOD_CON,
					step_control_s	when STEP_CON;
	
	test_idle_state	<= (not init_start_s) and (not food_start_s) and (not step_start_s);
	test_go_state	<= game_over_s;
	--*******************************
	--*	PROCESS DEFINITIONS			*
	--*******************************
	process(game_over_s)
	begin
		if(game_over_s = '1') then
			test_go_state_s <= '1';
		end if;	
	end process;
end arch;
