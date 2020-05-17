library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;


entity step_counter is 
	generic
	(
	COUNT_MAX	: positive	:= 1000
	);

	port
	(
	clk		: in STD_LOGIC;
	clr		: in STD_LOGIC;
	cnt_rdy	: out STD_LOGIC;
	cnt_button_rdy	: out STD_LOGIC
	);
end step_counter;


architecture arch of step_counter is

signal cnt_s	: UNSIGNED (31 downto 0)	:= to_unsigned(0, 32);
signal cnt_button_s	: UNSIGNED (31 downto 0)	:= to_unsigned(0, 32);

begin
	
--	cnt_rdy	<= 	'1' when (cnt_s = COUNT_MAX - 1) else
--				'0';	
--	cnt_button_rdy	<= 	'1' when (cnt_button_s = (COUNT_MAX/500) - 1) else
--				'0';	
			
	--increment counter each cycle
	--reset if max reached or clr is set
	process(clk)
	begin
		if clk'event and clk = '1' then
			if(clr = '1') then
				cnt_s <= to_unsigned(0, cnt_s'length);
				cnt_button_s <= to_unsigned(0, cnt_button_s'length);
				cnt_rdy <= '0';
				cnt_button_rdy <= '0';
				
			elsif(cnt_s = COUNT_MAX) then
				cnt_s <= to_unsigned(0, cnt_s'length);
				cnt_button_s <= to_unsigned(0, cnt_button_s'length);
				cnt_rdy <= '1';
				cnt_button_rdy <= '0';
				
			elsif(cnt_button_s = (COUNT_MAX/20)) then
				cnt_button_s <= to_unsigned(0, cnt_button_s'length);
				cnt_rdy <= '0';
				cnt_button_rdy <= '1';
				cnt_s <= cnt_s + 1;	
				
			else
				cnt_s <= cnt_s + 1;	
				cnt_button_s <= cnt_button_s + 1;
				cnt_rdy <= '0';
				cnt_button_rdy <= '0';				
				
			end if;
		end if;
	end process;

end arch;
