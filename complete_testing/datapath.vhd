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
use work.snake_package.all;

entity datapath is 
	generic
	(
	COR_WIDTH		: NATURAL	:= 3
	);

	port
	(
	clk			: in STD_LOGIC;									--from system
	res				: in STD_LOGIC;									--from system
	mem_b_addr		: in STD_LOGIC_VECTOR(2*COR_WIDTH-1 downto 0);	--from vga interface module
	ctrl_ctrl 		: in datapath_ctrl_flags;								--to datapath
	mem_b_data		: out STD_LOGIC_VECTOR(7 downto 0);				--to vga interface module
	ctrl_flags		: out datapath_flags							--to control unit
	);
end datapath;


architecture arch of datapath is

--***********************************
--*	TYPE DECLARATIONS				*
--***********************************

constant WIDTH : natural := 2*COR_WIDTH + 2;



--***********************************
--*	COMPONENT DECLARATIONS			*
--***********************************

component num_gen is
	generic
	(
	WIDTH	: natural := 8
	);
	
	port
	(	
	clk			: in STD_LOGIC;
	res			: in STD_LOGIC;
	pos_neg			: in STD_LOGIC;
	one_num_gen		: in STD_LOGIC;
	number			: out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
	);
end component;

component reg
	generic
	(
	WIDTH	: natural  := 8
	);
	
   port
   (
   clk  : in  STD_LOGIC;
   clr  : in  STD_LOGIC;
   load : in  STD_LOGIC;
   d   	: in  STD_LOGIC_VECTOR(WIDTH-1 downto 0);
   q	: out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
   );
end component;

component reg_bank
	generic
	(
	WIDTH		: NATURAL	:= 8
	);

	port
	(
	clk			: in STD_LOGIC;
	res			: in STD_LOGIC;
	ofc_address	: in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	load_head	: in STD_LOGIC;
	load_reg2	: in STD_LOGIC;
	load_fifo	: in STD_LOGIC;
	fifo_pop	: in STD_LOGIC;
	out_sel		: in RB_SEL;
	alu_out		: out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end component;	

component alu
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
	fsm_food_active	: in STD_LOGIC;    -- included to make x mask inactive during random generation of food 
	ofc_result		: out STD_LOGIC_VECTOR(WIDTH-1 downto 0)
	);
end component;

component overflow_correction
	generic
	(
	WIDTH		: NATURAL	:= 8
	);

	port
	(
	from_alu			: in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	ofc_result		: out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
	ctrl_of_x		: out STD_LOGIC;
	ctrl_of_y		: out STD_LOGIC
	);
end component;

component code_gen is 
	port
	(
	ctrl_code_sel	: in CODE;
	mem_code_w		: out STD_LOGIC_VECTOR(7 downto 0)
	);
end component;

component mem
	PORT
	(
	address_a		: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
	address_b		: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
	byteena_a		: IN STD_LOGIC_VECTOR (0 DOWNTO 0) :=  (OTHERS => '1');
	clock			: IN STD_LOGIC  := '1';
	data_a			: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	data_b			: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	wren_a			: IN STD_LOGIC  := '0';
	wren_b			: IN STD_LOGIC  := '0';
	q_a				: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	q_b				: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
end component;

component comparator
	port
	(
	mem_a_read	: in STD_LOGIC_VECTOR(7 downto 0);
	food_flag	: out STD_LOGIC;
	body_flag	: out STD_LOGIC
	);
end component;

--***********************************
--*	INTERNAL SIGNAL DECLARATIONS	*
--***********************************
signal ng_2_alu_s		: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
signal rb_2_alu_s		: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
signal alu_2_ofc_s		: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
signal ofc_2_rb_s		: STD_LOGIC_VECTOR(WIDTH-1 downto 0);

signal mem_a_en			: STD_LOGIC_VECTOR (0 downto 0);
signal mem_a_data_w_s	: STD_LOGIC_VECTOR (7 downto 0);
signal mem_a_addr_s, mem_a_addr_1_s, mem_a_addr_2_s, mem_a_addr_2_mem		: STD_LOGIC_VECTOR (WIDTH-3 downto 0);
signal mem_a_read_s		: STD_LOGIC_VECTOR (7 downto 0);
signal fsm_food_active_s : STD_LOGIC;

begin

	--*******************************
	--*	COMPONENT INSTANTIATIONS	*
	--*******************************

	n_g:	 num_gen			generic map
								(
								WIDTH	=> WIDTH
								)
								
								port map
								(
								clk			=> clk,
								res			=>  res,
								pos_neg		=> ctrl_ctrl.ng_pos_neg,
								one_num_gen	=> ctrl_ctrl.ng_one_gen,
								number		=> ng_2_alu_s
								);


	reg_delay1:		reg		generic map
						(
						WIDTH	=> 6
						)
						
						port map
						(
						clk		=> clk,
						clr		=> res,
						load		=> '1',
						d		=> mem_a_addr_s,
						q		=> mem_a_addr_1_s
						);

	reg_delay2:		reg		generic map
						(
						WIDTH	=> 6
						)
						
						port map
						(
						clk		=> clk,
						clr		=> res,
						load		=> '1',
						d		=> mem_a_addr_1_s,
						q		=> mem_a_addr_2_s
						);
						
	rb:		reg_bank			generic map
								(
								WIDTH	=> WIDTH
								)

								port map
								(
								clk			=> clk,
								res			=> res,
								ofc_address	=> ofc_2_rb_s,
								load_head	=> ctrl_ctrl.rb_head_en,
								load_reg2	=> ctrl_ctrl.rb_reg2_en,
								load_fifo	=> ctrl_ctrl.rb_fifo_en,
								fifo_pop	=> ctrl_ctrl.rb_fifo_pop,
								out_sel		=> ctrl_ctrl.rb_out_sel,
								alu_out		=> rb_2_alu_s
								);
	
	
	alu_un:	alu generic map
								(
								WIDTH	=> WIDTH
								)

								port map
								(
								op_first		=> ng_2_alu_s,
								rb_op			=> rb_2_alu_s,
								ctrl_x_y		=> ctrl_ctrl.alu_x_y,
								ctrl_pass_calc	=> ctrl_ctrl.alu_pass_calc,
								fsm_food_active => fsm_food_active_s,
								ofc_result		=> alu_2_ofc_s
								);

	ofc:	overflow_correction	generic map
								(
								WIDTH	=> WIDTH
								)

								port map
								(
								from_alu	=> alu_2_ofc_s,
								ofc_result	=> ofc_2_rb_s,
								ctrl_of_x	=> ctrl_flags.ofc_of_x,
								ctrl_of_y	=> ctrl_flags.ofc_of_y 
								);

	c_g:	code_gen 			port map
								(
								ctrl_code_sel	=> ctrl_ctrl.cg_sel,
								mem_code_w		=> mem_a_data_w_s
								);

	mem_un: mem	port map
								(
								address_a	=> mem_a_addr_2_mem,
								address_b	=> mem_b_addr,
								byteena_a	=> mem_a_en,
								clock		=> clk,
								data_a		=> mem_a_data_w_s,
								data_b		=> (others => '0'),
								wren_a		=> ctrl_ctrl.mem_w_e,
								wren_b		=> '0',
								q_a			=> mem_a_read_s,
								q_b			=> mem_b_data
								);
	
	cmp:	comparator			port map
								(
								mem_a_read	=> mem_a_read_s,
								food_flag	=> ctrl_flags.cmp_food_flag,
								body_flag	=> ctrl_flags.cmp_body_flag
								);

	
	--*******************************
	--*	SIGNAL ASSIGNMENTS			*
	--*******************************
	
	fsm_food_active_s <= '1' when (ctrl_ctrl.cg_sel=FOOD) else '0';
	
	-- cut off the overflowbits (msb of every coordinate)
	mem_a_addr_s <= ofc_2_rb_s(WIDTH-2 downto WIDTH/2) & ofc_2_rb_s(WIDTH/2-2 downto 0);
	
	mem_a_en <= "1";

	mem_a_addr_2_mem <= mem_a_addr_2_s when (ctrl_ctrl.mem_w_e='1' and ctrl_ctrl.cg_sel=FOOD) else mem_a_addr_s;
	--*******************************
	--*	PROCESS DEFINITIONS			*
	--*******************************
	
end arch;

