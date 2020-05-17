library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.snake_package.all;


entity tb_fsm_init is
end tb_fsm_init ;

architecture test of tb_fsm_init is

	component fsm_init is 
		port
		(
		clk						: in STD_LOGIC;						--from system
		res						: in STD_LOGIC;						--from system
		fsm_m_start				: in STD_LOGIC;						--from fsm main
		ofc_of_x				: in STD_LOGIC;						--from datapath/overflow module
		ofc_of_y				: in STD_LOGIC;						--from datapath/overflow module
		dp_ctrl 				: out datapath_ctrl_flags;			--to datapath
		fsm_m_done				: out STD_LOGIC						--to fsm main
		);
	end component;

	component stimuli_fsm_init is
		generic
		(
			CLK_PERIOD			: TIME	:=  10ns
		);
		port
		(
		clk						: out STD_LOGIC;			--from system
		res						: out STD_LOGIC;			--from system
		fsm_m_start				: out STD_LOGIC;			--from fsm main
		ofc_of_x				: out STD_LOGIC;			--from datapath/overflow module
		ofc_of_y				: out STD_LOGIC				--from datapath/overflow module
		);
	end component;
	
	signal fsm_m_start_wire		: STD_LOGIC;
	signal ofc_of_x_wire		: STD_LOGIC;
	signal ofc_of_y_wire		: STD_LOGIC;
	signal clk_wire		 		: STD_LOGIC;
	signal res_wire		 		: STD_LOGIC;
	signal dp_ctrl_wire			: datapath_ctrl_flags;
	signal fsm_m_done_wire 		: STD_LOGIC;
	
begin

	DUT: fsm_init
		port map
		(
			clk					=> clk_wire,
			res					=> res_wire,
			fsm_m_start			=> fsm_m_start_wire,
			ofc_of_x			=> ofc_of_x_wire,
			ofc_of_y			=> ofc_of_y_wire,
			dp_ctrl 			=> dp_ctrl_wire,
			fsm_m_done			=> fsm_m_done_wire
		);

	STIM: stimuli_fsm_init

		port map
		(
			clk					=> clk_wire,
			res					=> res_wire,
			fsm_m_start			=> fsm_m_start_wire,
			ofc_of_x			=> ofc_of_x_wire,
			ofc_of_y			=> ofc_of_y_wire
		);
end architecture test;