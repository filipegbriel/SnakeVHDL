--***************************************************************
--*
--*   Version with new assigments for board buttons (from left to rigth): 
--*       1) LEFT; 
--*       2) DOWN;
--*       3) UP; 
--*       4) RIGHT.
--*
--**************************************************
--*															   *
--*	Title	:												   *
--*	Design	:											   *
--*	Author	:												* 
--*	Email	:													*
--*																*
--**************************************************
--*																*
--*	Description :											*	*
--*																*
--**************************************************
library IEEE;
use IEEE.std_logic_1164.all;
use work.snake_package.all;

entity button_handler is
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
end button_handler;


architecture arch of button_handler is

--***********************************
--*	TYPE DECLARATIONS				*
--***********************************



--***********************************
--*	COMPONENT DECLARATIONS			*
--***********************************


--***********************************
--*	INTERNAL SIGNAL DECLARATIONS	*
--***********************************
signal sys_direction_s		: direction;
signal direction_sync_s		: direction;


begin

	--*******************************
	--*	COMPONENT INSTANTIATIONS	*
	--*******************************


	--*******************************
	--*	SIGNAL ASSIGNMENTS			*
	--*******************************
	
	direction_sync <= direction_sync_s;

	
	
	--*******************************
	--*	PROCESS DEFINITIONS			*
	--*******************************
	
	process(sys_direction)
	begin
		case sys_direction is
		

			when "0001"	=>	sys_direction_s <= S_RIGHT;
								
			when "0010"	=>	sys_direction_s <= S_UP;
								
			when "0100"	=>	sys_direction_s <= S_DOWN;
			
			when "1000"	=>	sys_direction_s <= S_LEFT;
							
			when others => sys_direction_s <= direction_sync_s; -- if the user dont assign anything it should keep last direction...
			
			--when others => null ;
			
		end case;	
	end process;
				

	process(clk)
	begin
		if clk'event and clk = '1' then
			if(res = '1') then
				direction_sync_s	<= S_RIGHT; -- reset direction is RIGHT
				step_jumper_sync	<= '0';
			elsif(load_regs = '1') then
				
				-- This series of conditionals will protect the snake from going backwards
				if(direction_sync_s = S_RIGHT) then
					if(sys_direction_s = S_LEFT) then
						direction_sync_s <= direction_sync_s;
					else
						direction_sync_s <= sys_direction_s;
					end if;
				end if;
				
				if(direction_sync_s = S_LEFT) then
					if(sys_direction_s = S_RIGHT) then
						direction_sync_s <= direction_sync_s;
					else
						direction_sync_s <= sys_direction_s;
					end if;
				end if;
				
				if(direction_sync_s = S_DOWN) then
					if(sys_direction_s = S_UP) then
						direction_sync_s <= direction_sync_s;
					else
						direction_sync_s <= sys_direction_s;
					end if;
				end if;
				
				if(direction_sync_s = S_UP) then
					if(sys_direction_s = S_DOWN) then
						direction_sync_s <= direction_sync_s;
					else
						direction_sync_s <= sys_direction_s;
					end if;
				end if;
				
				step_jumper_sync	<= sys_step_jumper;
			end if;
		end if;
	end process;

end arch;
