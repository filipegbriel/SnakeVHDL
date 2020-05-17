library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity FLSR is
	generic
	(
		SIZE 			: NATURAL 	:= 12; 
		COEFICIENTS		: UNSIGNED	:= b"100000110011"; -- x^0 -----> x^12 
		SEED 			: UNSIGNED 	:= b"111111111111"
	);
	
	--***************************************
	--**			ATENCAO					*
	--** APESAR DE X0 ESTAR NA FUNCAO, SEU  *
	--** COEFICIENTE PRECISA SER DESCONSID  *
	--** ERADO. ELE JA FOI IMPLEMENTADO FI	*
	--** SICAMENTE NO CIRCUITO, NO CODIGO.	*
	--***************************************
	
	port
	(	
		clk				: in STD_LOGIC;
		res				: in STD_LOGIC;
		function_out 	: out STD_LOGIC_VECTOR (SIZE-1 downto 0)
	);	
end FLSR;

architecture arch of FLSR is

	component my_d_ff is
	port 
	( 	
		clk	: 	in std_logic;
		d	: 	in std_logic;
		q	: 	out std_logic
	);
	end component;

	
	component my_mux is
	port 
	(
		SEL : in  STD_LOGIC;
		A   : in  STD_LOGIC;
		B   : in  STD_LOGIC;
		X   : out STD_LOGIC
	);
	end component;

	
	signal ff_d 		: std_logic_vector (SIZE-1 downto 0);
	signal ff_q		 	: std_logic_vector (SIZE-1 downto 0);
	signal ff_xor		: std_logic_vector (SIZE-1 downto 0);
	signal ff_seed		: std_logic_vector (SIZE-1 downto 0);
		
begin
	
	G1: for i in 0 to SIZE-1 generate
				
		--**************************************************************
		--***						COMO FUNCIONA:					 ***
		--***	DIVIDE-SE O PROBLEMA EM 2: SHIFT-REGISTER E FEEDBACK ***
		--***	SHIFT-REGISTER: ORGANIZA OS FF EM CASCATA			 ***
		--***	FEEDBACK: ESCOLHE SE O FF(i) DEVE RECEBER O XOR 	 ***		
		--**************************************************************
			
		--**************************************************************
		--***						SHIFT-REGISTER					 ***			
		--**************************************************************
		
			ff: my_d_ff port map 
			(
				clk => clk,
				d 	=> ff_d(i),
				q	=> ff_q(i)
			);
				
		--**************************************************************
		--***						LINEAR FEEDBACK					 ***			
		--**************************************************************		
		
		
		ff_xor(i) <= ff_seed(i) xor ff_seed(SIZE-1);
		
		--SE FOR PARTE DO POLINOMIO, SERA REALIMENTADO
		--SE NAO FOR PARTE DO POLINOMIO, NAO SERA REALIMENTADO
		
		G2: if (i < SIZE-1) generate
			
			mux_xor_or_q: my_mux port map
			(
				SEL 	=> COEFICIENTS(i),
				A 		=> ff_xor(i), 	 --selecionado se 1
				B		=> ff_seed(i),   --selecionado se 0
				X		=> ff_d(i+1)
			);		
		
		end generate G2;

		ff_d(0) <= ff_seed(SIZE-1); --FEEDBACK	
		function_out(i) <= ff_seed(i);
		
		--PARA IMPLEMENTAR UMA SEMENTE DIFERENTE DE 0xFFF:
		
		mux_seed_or_q: my_mux port map
		(
			SEL 	=> res,
			A 		=> SEED(SIZE-1 - i),  		--selecionado se 1
			B		=> ff_q(i),  		--selecionado se 0
			X		=> ff_seed(i)
		);	
	end generate G1;
end arch;
