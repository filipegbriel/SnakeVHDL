library IEEE;
use IEEE.std_logic_1164.all;
use work.snake_package.all;

entity code_gen is 
	port
	(
	ctrl_code_sel	: in CODE;
	mem_code_w		: out STD_LOGIC_VECTOR(7 downto 0)
	);
end code_gen;


architecture arch of code_gen is
begin

	mem_code_w <= CODE_VECTORS(ctrl_code_sel);

end arch;
