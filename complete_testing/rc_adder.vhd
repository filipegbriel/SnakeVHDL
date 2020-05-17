Library IEEE;
use ieee.STD_LOGIC_1164.all;

entity rc_adder is
	generic
	(
	WIDTH : integer := 32
	);
	
	port
	(
	a_i, b_i	: 	in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	c_i	:	in STD_LOGIC;
	z_o 		: 	out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	c_o	:	out STD_LOGIC
	);
	
end rc_adder;

architecture arch of rc_adder is

	component full_adder
	  port 
	  (
	  a_in	:	in STD_LOGIC;
	  b_in	:	in STD_LOGIC;
	  c_in	:	in STD_LOGIC;
	  z_out	:	out STD_LOGIC;
	  c_out	:	out STD_LOGIC
	  );
	end component;

	signal cout_s	: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	signal z_s		: STD_LOGIC_VECTOR(WIDTH-1 downto 0);


begin

		fa_init: 	full_adder	port map
								(
								a_in	=> a_i(0),
								b_in	=> b_i(0),
								c_in	=> c_i,
								z_out	=> z_s(0),
								c_out	=> cout_s(0)
								);

	gen_fas:	for I in 1 to WIDTH-2 generate
				fa:	full_adder	port map
								(
								a_in	=> a_i(i),
								b_in	=> b_i(i),
								c_in	=> cout_s(i-1),
								z_out	=> z_s(i),
								c_out	=> cout_s(i)
								);
	end generate;

		fa_last: 	full_adder	port map
								(
								a_in	=> a_i(WIDTH-1),
								b_in	=> b_i(WIDTH-1),
								c_in	=> cout_s(WIDTH-2),
								z_out	=> z_s(WIDTH-1),
								c_out	=> cout_s(WIDTH-1)
								);

		 z_o <= z_s;
		 c_o <= cout_s(WIDTH-1);

end arch;