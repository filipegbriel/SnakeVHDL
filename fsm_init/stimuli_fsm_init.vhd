library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.snake_package.all;

entity stimuli_fsm_init is
	generic
	(
		CLK_PERIOD		: TIME	:=  10ns
	);
	port
	(
	clk				: out STD_LOGIC;					--from system
	res				: out STD_LOGIC;					--from system
	fsm_m_start		: out STD_LOGIC;					--from fsm main
	ofc_of_x		: out STD_LOGIC;					--from datapath/overflow module
	ofc_of_y		: out STD_LOGIC 					--from datapath/overflow module
	);
end stimuli_fsm_init;

architecture test of stimuli_fsm_init is
	
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
		procedure condition_set(fsm_m_start_val, ofc_of_x_val, ofc_of_y_val : in STD_LOGIC)	is
				begin
				fsm_m_start  <= fsm_m_start_val;
				ofc_of_x	 <= ofc_of_x_val;
				ofc_of_y	 <= ofc_of_y_val;
				
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
		
		condition_set('0', '0', '0');

	
	end process sim;
end architecture test;