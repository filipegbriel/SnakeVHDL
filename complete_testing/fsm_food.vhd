-------------------------------------------------------------------------------
--
-- Title       : fsm_food
-- Design      : Snake
-- Author      : Frederik Luhrs
--
-------------------------------------------------------------------------------
--
-- Description : 	FSM to generate a new food on the map. It finds a free spot
--					and updates the map (memory)
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.snake_package.all;

entity fsm_food is 
	port
	(
	clk				: in STD_LOGIC;						--from system
	res				: in STD_LOGIC;						--from system
	fsm_m_start		: in STD_LOGIC;						--from fsm main
	cmp_body_flag	: in STD_LOGIC;						--from datapath/comparator module
	dp_ctrl 		: out datapath_ctrl_flags;				--to datapath
	fsm_m_done		: out STD_LOGIC						--to fsm main
	);
end fsm_food;


architecture arch of fsm_food is

-- SYMBOLIC ENCODED FSM STATES
type STATE_TYPE_FOOD is (
    READY, GEN_NUM, FOOD_OK
);

signal STATE, NEXT_STATE: STATE_TYPE_FOOD;

-- Declarations of pre-registered internal signals

begin

------------------------------------
-- Next State Logic (combinatorial)
------------------------------------

upd_next_state:	process (fsm_m_start, cmp_body_flag, STATE)
				begin
					case STATE is
					
					-- each new random number form GEN_NUM is added to what is registered in reg_head (first time) and reg2 (every new attempt)
					
						when READY		=> 	if(fsm_m_start = '1') then
												NEXT_STATE <= GEN_NUM;
											else
			    								NEXT_STATE <= READY;
											end if;
		
							
						when GEN_NUM	=> 	if(cmp_body_flag = '0') then 
												NEXT_STATE <= FOOD_OK;
											else
												NEXT_STATE <= GEN_NUM;
											end if;    

						when FOOD_OK	=> 	NEXT_STATE <= READY;

						when others		=> null;
				
					end case;
				end process;
				
------------------------------------
-- Current State Logic (sequential)
------------------------------------
upd_state:	process (clk)
				begin
					if clk'event and clk = '1' then
						if(res = '1')	then
							STATE <= READY;
						else
							STATE <= NEXT_STATE;
						end if;
					end if;
				end process;


------------------------------------
-- OUTPUT Logic (combinatorial)
------------------------------------
upd_output:	process (cmp_body_flag, STATE)
			begin
				case STATE is
					when READY	=> 	dp_ctrl 	<= 	(	
													ng_one_gen		=> '1',
													ng_pos_neg		=> '0',
													alu_x_y			=> '0',
													alu_pass_calc	=> '1',
													rb_head_en		=> '0',
													rb_reg2_en	=> '0',
													rb_fifo_en		=> '0',
													rb_fifo_pop		=> '0',
													rb_out_sel		=> HEAD_OUT,	
													--  the value registered in reg_head is added to the generated random_number when READY is activated
													cg_sel			=> FOOD,
													mem_w_e			=> '0'
													);
														
									fsm_m_done 		<= '0';					
			
					when GEN_NUM => dp_ctrl 	<= 	(	
													ng_one_gen		=> '1',
													ng_pos_neg		=> '0',
													alu_x_y			=> '0',
													alu_pass_calc	=> '1',
													rb_head_en		=> '0',
													rb_reg2_en	=> '1',
													rb_fifo_en		=> '0',
													rb_fifo_pop		=> '0',
													rb_out_sel		=> REG2_OUT,
													--  the value registered in reg2 is added to the generated random_number
													cg_sel			=> FOOD,
													mem_w_e			=> '0'
													);
														
									fsm_m_done 		<= '0';	
						


						when FOOD_OK	=> 	dp_ctrl 	<= 	(	
														ng_one_gen		=> '0',
														ng_pos_neg		=> '0',
														alu_x_y			=> '1',
														alu_pass_calc	=> '0',
														rb_head_en		=> '0',
														rb_reg2_en	=> '0',
														rb_fifo_en		=> '0',
														rb_fifo_pop		=> '0',
														rb_out_sel		=> REG2_OUT,
														cg_sel			=> FOOD,
														mem_w_e			=> '1'
														);
														
										fsm_m_done 		<= '1';	
									
					when others		=> null;
			
				end case;
			end process;					
				
end arch;
