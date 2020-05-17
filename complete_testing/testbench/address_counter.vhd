library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity address_counter is
   generic
   (
   WIDTH	: natural	:= 6
   );
   
   port
   	(
 	clk		: in std_logic;
 	res		: in std_logic;
	addr	: out std_logic_vector(WIDTH-1 downto 0);
	cnt_done: out std_logic
	);
end address_counter;
 
architecture Behavioral of address_counter is
   signal temp	: unsigned (WIDTH-1 downto 0) := to_unsigned(0, WIDTH);
	
begin   

	addr <= std_logic_vector(temp);

	process(clk)
	begin
		if clk'event and clk = '1' then
			if(res = '1')	then
				temp		<= to_unsigned(0, WIDTH);
				cnt_done	<= '0';
			elsif(temp = 63) then
				cnt_done	<= '1';
			else
				temp <= temp + 1;
			end if;
        end if;
    end process;

end Behavioral;