--***************************************************************
--*
--*   Version with mask (00..00-01..11) for -1 operation in x,
--*     avoiding interference in y
--*
--***************************************************************
--*																*
--*	Title	:													*
--*	Design	:													*
--*	Author	:													*
--*	Email	:													*
--*																*
--***************************************************************
--*																*
--*	Description :												*
--*																*
--***************************************************************
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.snake_package.all;



entity alu is 
	generic
	(
	WIDTH		: NATURAL	:= 8
	);

	port
	(
	op_first		: in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	rb_op			: in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	ctrl_x_y		: in STD_LOGIC;
	ctrl_pass_calc	: in STD_LOGIC;
	cg_sel_alu		: in CODE;
	alu_result		: out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end alu;



architecture with_RCA of alu is

--***********************************
--*	COMPONENT DECLARATIONS			*
--***********************************

component rc_adder
	generic
	(
	WIDTH : integer := 32
	);
	
	port
	(
	a_i, b_i	: in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	c_i			: in STD_LOGIC;
	z_o 		: out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	c_o			: out STD_LOGIC
	);
end component;

--***********************************
--*	INTERNAL SIGNAL DECLARATIONS	*
--***********************************
signal shift_op_s			: unsigned(WIDTH-1 downto 0); 
signal mask_y_for_x_numbers	: std_logic_vector(WIDTH-1 downto 0); 
signal result_s				: std_logic_vector(WIDTH-1 downto 0); 

signal carry_out_s		: STD_LOGIC;

begin


--	mask_y_for_x_numbers <= std_logic_vector(to_unsigned(-1, WIDTH) sll (WIDTH/2-1)) XOR std_logic_vector(to_unsigned(-1, WIDTH));
	
	mask_y_for_x_numbers <= std_logic_vector(to_signed(-1, WIDTH)) when cg_sel_alu = FOOD else
							std_logic_vector(to_signed(-1, WIDTH) sll (WIDTH/2-1)) XOR std_logic_vector(to_signed(-1, WIDTH));
	
	--*******************************
	--*	COMPONENT INSTANTIATIONS	*
	--*******************************

	add:	rc_adder	generic map
						(
						WIDTH	=> WIDTH
						)
						
						port map
						(
						a_i			=> std_logic_vector(shift_op_s),
						b_i			=> rb_op,
						c_i			=> '0',
						z_o 		=> result_s,
						c_o			=> carry_out_s
						);
	
	--*******************************
	--*	SIGNAL ASSIGNMENTS			*
	--*******************************
	
	shift_op_s	<=	unsigned(op_first) sll WIDTH/2 	when (ctrl_x_y = '1') else
					unsigned(op_first AND mask_y_for_x_numbers ) 			when (ctrl_x_y = '0') else
					(others => 'X');
	alu_result	<=	rb_op							when (ctrl_pass_calc = '0') else
					result_s						when (ctrl_pass_calc = '1') else
					(others => 'X');
	
	--*******************************
	--*	PROCESS DEFINITIONS			*
	--*******************************
	

end with_RCA;

