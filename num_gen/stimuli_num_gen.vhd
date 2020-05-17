library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stimuli_num_gen is
	generic
	(
		WIDTH:         NATURAL := 8;
		CLK_PERIOD		: TIME	:=  10ns
	);

	port
	(
		pos_neg			: out STD_LOGIC;
		one_num_gen		: out STD_LOGIC;
		clk		 		: out STD_LOGIC;
		res		 		: out STD_LOGIC
	);

end stimuli_num_gen;

architecture test of stimuli_num_gen is
	
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
		procedure condition_set(pos_neg_val, one_num_gen_val : in STD_LOGIC)	is
				begin
					pos_neg			<= pos_neg_val;
					one_num_gen		<= one_num_gen_val;
					
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
		
		condition_set('0', '0');
		condition_set('1', '0');
		condition_set('0', '1');
		condition_set('1', '1');
		
		reset_activate;
		condition_set('0', '0');
		reset_activate;
		condition_set('1', '0');
		reset_activate;
		condition_set('0', '1');
		reset_activate;
		condition_set('1', '1');
		
		reset_activate;
		
		condition_set('0', '1');
		condition_set('0', '1');
		condition_set('0', '1');
		condition_set('0', '1');
		condition_set('0', '1');
		condition_set('0', '1');
		condition_set('0', '1');
		condition_set('0', '1');
		condition_set('0', '1');
		condition_set('0', '1');
		condition_set('0', '1');
	
	end process sim;
end architecture test;