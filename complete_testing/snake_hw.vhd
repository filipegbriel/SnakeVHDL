--***************************************************************
--*														        *
--*	Title	   :	snake_hw									*
--*	Design	   :	snake_hw									*
--***************************************************************
--*																*
--*	Description :	Top entity of the project					*
--*																*
--***************************************************************
library IEEE;
use IEEE.std_logic_1164.all;
use work.snake_package.all;

entity snake_hw is 
	generic
	(
	COR_WIDTH		: NATURAL	:= 3	--Width of one coordinate space addresing ( square of (2 ^ COR_WIDTH) x (2 ^ COR_WIDTH) )
	);

	port
	(
	clk				 : in STD_LOGIC;
	res				 : in STD_LOGIC;
	sys_direction	 : in STD_LOGIC_VECTOR (3 downto 0);
	sys_step_jumper  : in STD_LOGIC;
	step_jumper_sync : out STD_LOGIC;
	
	--TESTPINS
	test_mem_b_addr	: in STD_LOGIC_VECTOR(2*(COR_WIDTH)-1 downto 0);	--from vga interface module								--from vga interface module
	test_idle_state	: out STD_LOGIC;
	test_go_state	: out STD_LOGIC;
	test_mem_b_data	: out STD_LOGIC_VECTOR(7 downto 0)				--to vga interface module
	);
end snake_hw;


architecture arch of snake_hw is

--***********************************
--*	TYPE DECLARATIONS				*
--***********************************



--***********************************
--*	COMPONENT DECLARATIONS			*
--***********************************

component control_snake 
	port
	(
	clk				: in STD_LOGIC;
	res				: in STD_LOGIC;
	sys_direction	: in direction;
	cnt_rdy			: in STD_LOGIC;
	dp_flags		: in datapath_flags;
	dp_ctrl 		: out datapath_ctrl_flags;
		
	--TESTPORTS
	test_idle_state	: out STD_LOGIC;
	test_go_state	: out STD_LOGIC
	);
end component;

component datapath
	generic
	(
	COR_WIDTH		: NATURAL	:= 3
	);

	port
	(
	clk		    	: in STD_LOGIC;									--from system
	res				: in STD_LOGIC;									--from system
	mem_b_addr		: in STD_LOGIC_VECTOR(2*(COR_WIDTH)-1 downto 0);	--from vga interface module
	ctrl_ctrl 		: in datapath_ctrl_flags;						--to datapath
	mem_b_data		: out STD_LOGIC_VECTOR(7 downto 0);				--to vga interface module
	ctrl_flags		: out datapath_flags							--to control unit
	);
end component;

component step_counter 
	port
	(
	clk		: in STD_LOGIC;
	clr		: in STD_LOGIC;
	cnt_rdy	: out STD_LOGIC;
	cnt_button_rdy	: out STD_LOGIC
	);
end component;

component button_handler
	port
	(
	clk					: in STD_LOGIC;
	res					: in STD_LOGIC;
	load_regs			: in STD_LOGIC;
	sys_direction		: in STD_LOGIC_VECTOR(3 downto 0);
	sys_step_jumper		: in STD_LOGIC;
	direction_sync		: out direction;
	step_jumper_sync	: out STD_LOGIC
	);
end component;

--***********************************
--*	INTERNAL SIGNAL DECLARATIONS	*
--***********************************

--to control unit
signal sys_direction_synched_s		: direction;
signal sys_step_jumper_synched_s	: STD_LOGIC;
signal cnt_rdy_s					: STD_LOGIC;
signal cnt_button_rdy_s             : STD_LOGIC;

signal dp_ctrl_s					: datapath_ctrl_flags;
signal dp_flags_s					: datapath_flags;

signal mem_b_addr_s					: STD_LOGIC_VECTOR(2*(COR_WIDTH)-1 downto 0);
signal mem_b_data_s					: STD_LOGIC_VECTOR(7 downto 0);
signal vga_if_clk_s					: STD_LOGIC;


begin

	--*******************************
	--*	COMPONENT INSTANTIATIONS	*
	--*******************************

	cntrl_unit:	control_snake	port map
								(
								clk				=> clk,
								res				=> res,
								sys_direction	=> sys_direction_synched_s,
								cnt_rdy			=> cnt_rdy_s,
								dp_flags		=> dp_flags_s,
								dp_ctrl			=> dp_ctrl_s,
									
								--TESTPORTS
								test_idle_state	=> test_idle_state,
								test_go_state	=> test_go_state
								);
	
	
	step_cnt:	step_counter 	
							
								port map
								(
								clk		=> clk,
								clr		=> res,
								cnt_rdy	=> cnt_rdy_s,
								cnt_button_rdy => cnt_button_rdy_s
								);
								
	dp_dummy: 	datapath		generic map
								(
								COR_WIDTH	=> COR_WIDTH
								)

								port map
								(
								clk		    => clk,
								res			=> res,
								mem_b_addr	=> mem_b_addr_s,
								ctrl_ctrl 	=> dp_ctrl_s,
								mem_b_data	=> mem_b_data_s,
								ctrl_flags	=> dp_flags_s
								);
								
								
	bh:			button_handler	port map
								(
								clk					=> clk,
								res					=> res,
								load_regs			=> cnt_button_rdy_s,
								sys_direction		=> sys_direction,
								sys_step_jumper		=> sys_step_jumper,
								direction_sync		=> sys_direction_synched_s,
								step_jumper_sync	=> step_jumper_sync
								);
							
	--*******************************
	--*	SIGNAL ASSIGNMENTS			*
	--*******************************
	
	--TESTPINS ASSIGNMENTS
	mem_b_addr_s	<= test_mem_b_addr;	
	test_mem_b_data	<= mem_b_data_s;
	
	--*******************************
	--*	PROCESS DEFINITIONS			*
	--*******************************
	
end arch;
