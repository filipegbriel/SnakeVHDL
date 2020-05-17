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


entity reg_bank is 
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
end reg_bank;


architecture arch of reg_bank is

--***********************************
--*	TYPE DECLARATIONS				*
--***********************************

--***********************************
--*	COMPONENT DECLARATIONS			*
--***********************************

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

component fifo_1
	port
	(
	clock		: IN STD_LOGIC ;
	data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	rdreq		: IN STD_LOGIC ;
	sclr		: IN STD_LOGIC ;
	wrreq		: IN STD_LOGIC ;
	empty		: OUT STD_LOGIC ;
	q			: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
	usedw		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
end component;

--***********************************
--*	INTERNAL SIGNAL DECLARATIONS	*
--***********************************
signal head_out_s	: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
signal reg2_out_s	: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
signal fifo_out_s	: STD_LOGIC_VECTOR(WIDTH-1 downto 0);
signal fifo_empty_s	: STD_LOGIC;

begin

	--*******************************
	--*	COMPONENT INSTANTIATIONS	*
	--*******************************

	reg_head:	reg		generic map
						(
						WIDTH	=> WIDTH
						)
						
						port map
						(
						   clk => clk,
						   clr => res,
						   load =>load_head,
						   d => ofc_address,  	
						   q => head_out_s 	
						);
	

	reg_2:		reg		generic map
						(
						WIDTH	=> WIDTH
						)
						
						port map
						(
						   clk => clk,
						   clr => res,
						   load =>load_reg2,
						   d => ofc_address,	
						   q => reg2_out_s 	
						);

	fifo:	fifo_1 port map
						(
						clock		=>  clk,
						data		=> ofc_address,
						rdreq		=>  fifo_pop,
						sclr		=>  res,
						wrreq		=> load_fifo,
						empty		=> open,
						q			=> fifo_out_s,
						usedw		=> open
						);
						
	--*******************************
	--*	SIGNAL ASSIGNMENTS			*
	--*******************************
	
	alu_out	<= 	head_out_s	when (out_sel = HEAD_OUT) else
				reg2_out_s	when (out_sel = REG2_OUT) else
				fifo_out_s	when (out_sel = FIFO_OUT) else
				(others => 'X');
	
	--*******************************
	--*	PROCESS DEFINITIONS			*
	--*******************************

end arch;
