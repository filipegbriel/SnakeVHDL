library IEEE; 
use IEEE.STD_LOGIC_1164.all; 

package snake_package is 
	
	type direction is 	
	(
	S_LEFT,
	S_RIGHT,
	S_UP,
	S_DOWN
	);
	
	
	type CONTROL_SELECT is
	(
	INIT_CON,
	FOOD_CON,
	STEP_CON
	);
	  
  
	attribute enum_encoding : string; -- user defined	
	type RB_SEL is	(
					HEAD_OUT,
					REG2_OUT,
					FIFO_OUT
					);
	attribute enum_encoding of RB_SEL : type is "00 01 10";
	
	
	type CODE is 	(
					BLANK,
					HEAD_UP,
					HEAD_DOWN,
					HEAD_RIGHT,
					HEAD_LEFT,
					S_BODY,
					FOOD
					);

	constant BLANK_VEC		: STD_LOGIC_VECTOR(7 downto 0) := "00000000";
	constant HEAD_UP_VEC	: STD_LOGIC_VECTOR(7 downto 0) := "00010001";
	constant HEAD_DOWN_VEC	: STD_LOGIC_VECTOR(7 downto 0) := "00010010";
	constant HEAD_RIGHT_VEC	: STD_LOGIC_VECTOR(7 downto 0) := "00010100";
	constant HEAD_LEFT_VEC	: STD_LOGIC_VECTOR(7 downto 0) := "00011000";
	constant BODY_VEC		: STD_LOGIC_VECTOR(7 downto 0) := "00010000";
	constant FOOD_VEC		: STD_LOGIC_VECTOR(7 downto 0) := "10000000";
  	   
	type CODE_BITS is array (CODE) of STD_LOGIC_VECTOR(7 downto 0);
	constant CODE_VECTORS	: CODE_BITS	:= (BLANK_VEC, HEAD_UP_VEC, HEAD_DOWN_VEC, HEAD_RIGHT_VEC, HEAD_LEFT_VEC, BODY_VEC, FOOD_VEC);
					
	type datapath_ctrl_flags is
	record
		ng_one_gen		: STD_LOGIC;
		ng_pos_neg		: STD_LOGIC;
		alu_x_y			: STD_LOGIC;
		alu_pass_calc	: STD_LOGIC;
		rb_head_en		: STD_LOGIC;
		rb_reg2_en		: STD_LOGIC;
		rb_fifo_en		: STD_LOGIC;
		rb_fifo_pop		: STD_LOGIC;
		rb_out_sel		: RB_SEL;
		cg_sel			: CODE;
		mem_w_e			: STD_LOGIC;
	end record;
	
	type datapath_flags is
	record
		ofc_of_x		: STD_LOGIC;
		ofc_of_y		: STD_LOGIC;
		cmp_food_flag	: STD_LOGIC;
		cmp_body_flag	: STD_LOGIC;
	end record;
	
	function rand_num(width : NATURAL) return std_logic_vector;
	
end snake_package ; 


package body snake_package  is 

function rand_num(width : NATURAL) return std_logic_vector is
  variable res_v : std_logic_vector(WIDTH - 1 downto 0);
begin
  res_v := (others => '0');
--	for i in 1 to WIDTH/ 2 loop
--    res_v(2 * i - 1) := '1';
--  end loop;
  return res_v;
end function;


end snake_package ; 