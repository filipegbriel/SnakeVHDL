library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.snake_package.all;

entity stimuli_fsm_step is
	generic
	(
		CLK_PERIOD		: TIME	:=  10ns
	);
	port
	(
		clk				: out STD_LOGIC;						--from system
		res				: out STD_LOGIC;						--from system
		fsm_m_start		: out STD_LOGIC;						--from fsm main
		cmp_food_flag	: out STD_LOGIC;						--from datapath/comparator module
		cmp_body_flag	: out STD_LOGIC;						--from datapath/comparator module
		sys_direction	: out direction						--from system
	);
end stimuli_fsm_step;

architecture test of stimuli_fsm_step is
	
	signal clk_s : STD_LOGIC;
	component clock_generator
		generic 
		(
			CLK_PERIOD		: TIME	:= 10ns
		);

		port 
		(	
			clk		: out STD_LOGIC
		);
	end component ;

begin

	clock: clock_generator
		port map
		(
			clk	=> clk_s
		);
	clk <=	clk_s;

	sim : process	
		procedure condition_set(fsm_m_start_val, cmp_food_flag_val, cmp_body_flag_val: in STD_LOGIC;
								sys_direction_val : in direction)	is
				begin
				fsm_m_start  	<= fsm_m_start_val;
				cmp_food_flag	<= cmp_food_flag_val;
				cmp_body_flag	<= cmp_body_flag_val;
				sys_direction	<= sys_direction_val;
				
				wait until rising_edge (clk_s);
		end procedure condition_set;

		procedure reset_activate is   
		begin
			wait until falling_edge(clk_s);
				res <= '1';
			wait for CLK_PERIOD;
				res <= '0';
		end procedure reset_activate;

	begin
		
		reset_activate;
		--teste da maquina de mealy
		condition_set('0', '0', '0', S_LEFT); --fsm_start --fica preso
		condition_set('1', '0', '0', S_LEFT); --fsm_start
		condition_set('0', '0', '0',  S_UP); --sys_direction
		condition_set('0', '1', '0', S_LEFT); --food
		condition_set('0', '0', '0',  S_UP); --volta ao ready
		condition_set('0', '0', '0', S_LEFT); --fica no ready
		condition_set('0', '0', '0', S_LEFT); --fica no ready
		
		condition_set('0', '0', '0', S_UP); --fica no ready
		condition_set('1', '0', '0', S_UP); --fsm_start
		condition_set('0', '0', '0', S_LEFT); --sys_direction
		condition_set('0', '1', '0', S_UP); --food
		condition_set('0', '0', '0', S_LEFT); --volta ao ready
		condition_set('0', '0', '0', S_UP); --fica no ready
		
		condition_set('1', '0', '0', S_UP); --fsm_start
		condition_set('0', '0', '0', S_LEFT); --sys_direction
		condition_set('0', '1', '0', S_UP); --food
		reset_activate;
		reset_activate;

	
	end process sim;
end architecture test;