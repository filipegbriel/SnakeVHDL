library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use work.snake_package.all;

entity fsm_init is 
	port
	(
	clk				: in STD_LOGIC;						--from system
	res				: in STD_LOGIC;						--from system
	fsm_m_start		: in STD_LOGIC;						--from fsm main
	ofc_of_x		: in STD_LOGIC;						--from datapath/overflow module
	ofc_of_y		: in STD_LOGIC;						--from datapath/overflow module
	dp_ctrl 		: out datapath_ctrl_flags;			--to datapath
	fsm_m_done		: out STD_LOGIC						--to fsm main
	);
end fsm_init;

architecture arch of fsm_init is


-- SYMBOLIC ENCODED FSM STATES
type STATE_TYPE_INIT is (
    READY, RESET_ROW, JUMP_ROW, WRITE_HEAD
);

signal STATE, NEXT_STATE: STATE_TYPE_INIT;

-- Declarations of pre-registered internal signals

begin

------------------------------------
-- Next State Logic (combinatorial)
------------------------------------

upd_next_state:	process (fsm_m_start, ofc_of_x, ofc_of_y, STATE)
				begin
					case STATE is
						when READY		=> 	if(fsm_m_start = '1') then
												NEXT_STATE <= RESET_ROW;
											else
			    								NEXT_STATE <= READY;
											end if;
		
						when RESET_ROW	=> 	if(ofc_of_x = '1') then
												NEXT_STATE <= JUMP_ROW;
											else
			    								NEXT_STATE <= RESET_ROW;
											end if;
							
						when JUMP_ROW 	=> 	if(ofc_of_y = '1') then
												NEXT_STATE <= WRITE_HEAD;
											else
												NEXT_STATE <= RESET_ROW;
											end if;
															
						when WRITE_HEAD	=> 	NEXT_STATE <= READY;
											
							
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
upd_output:	process (STATE)
			begin
				case STATE is
					when READY		=> 	dp_ctrl	<= 	(	
													ng_one_gen		=> '0',
													ng_pos_neg		=> '0',
													alu_x_y			=> '0',
													alu_pass_calc	=> '1',
													rb_head_en		=> '0',
													rb_reg2_en	=> '0',
													rb_fifo_en		=> '0',
													rb_fifo_pop		=> '0',
													rb_out_sel		=> REG2_OUT,	
													cg_sel			=> BLANK,
													mem_w_e			=> '0'
													);
															
										fsm_m_done 	<= '0';					
			
					when RESET_ROW	=>  dp_ctrl 	<= 	(	
														ng_one_gen		=> '0',
														ng_pos_neg		=> '0',
														alu_x_y			=> '0',
														alu_pass_calc	=> '1',
														rb_head_en		=> '0',
														rb_reg2_en	=> '1',
														rb_fifo_en		=> '0',
														rb_fifo_pop		=> '0',
														rb_out_sel		=> REG2_OUT,
														cg_sel			=> BLANK,
														mem_w_e			=> '1'
														);
															
										fsm_m_done 	<= '0';	
						
					when JUMP_ROW 		=>  dp_ctrl 	<= 	(	
															ng_one_gen		=> '0',
															ng_pos_neg		=> '0',
															alu_x_y			=> '1',
															alu_pass_calc	=> '1',
															rb_head_en		=> '0',
															rb_reg2_en	=> '1',
															rb_fifo_en		=> '0',
															rb_fifo_pop		=> '0',
															rb_out_sel		=> REG2_OUT,
															cg_sel			=> BLANK,
															mem_w_e			=> '1'
															);
															
											fsm_m_done 	<= '0';	
			
					when WRITE_HEAD		=>  dp_ctrl 	<= 	(	
																ng_one_gen		=> '0',
																ng_pos_neg		=> '0',
																alu_x_y			=> '0',
																alu_pass_calc	=> '0',
																rb_head_en		=> '0',
																rb_reg2_en		=> '0',
																rb_fifo_en		=> '1',
																rb_fifo_pop		=> '0',
																rb_out_sel		=> HEAD_OUT,
																cg_sel			=> HEAD_RIGHT,
																mem_w_e			=> '1'
																);
															
										fsm_m_done 		<= '1';	
						
					
					when others		=> null;
			
				end case;
			end process;					
				
end arch;
