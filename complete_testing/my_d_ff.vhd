library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;


entity my_d_ff is
	port 
	( 	
		clk	: 	in std_logic;
		d	: 	in std_logic;
		q	: 	out std_logic
	);
	end my_d_ff;
	
architecture arch of my_d_ff is
begin
	process (clk)
	begin
		if (Rising_Edge(clk)) then
			q <= d;
		end if;
	end process;
end arch;