onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLK /snake_testbench/clk_s
add wave -noupdate -label RESET /snake_testbench/res_s
add wave -noupdate -label DIRECTION /snake_testbench/dut/sys_direction_synched_s
add wave -noupdate /snake_testbench/sys_direction_s
add wave -noupdate -label STEP_READY /snake_testbench/dut/cntrl_unit/cnt_rdy
add wave -noupdate -group REG_BANK -label REG_HEAD -radix hexadecimal /snake_testbench/dut/dp_dummy/rb/reg_head/q
add wave -noupdate -group REG_BANK -label REG2 -radix hexadecimal /snake_testbench/dut/dp_dummy/rb/reg_2/q
add wave -noupdate -group REG_BANK -label RB_IN -radix hexadecimal /snake_testbench/dut/dp_dummy/ofc_2_rb_s
add wave -noupdate -group MEM_A -label DATA_WRITE -radix hexadecimal /snake_testbench/dut/dp_dummy/mem_un/data_a
add wave -noupdate -group MEM_A -color Gray90 -label CODE_SEL /snake_testbench/dut/cntrl_unit/dp_ctrl.cg_sel
add wave -noupdate -group MEM_A -label ADDRESS -radix octal /snake_testbench/dut/dp_dummy/mem_un/address_a
add wave -noupdate -group MEM_A -label W_EN /snake_testbench/dut/dp_dummy/mem_un/wren_a
add wave -noupdate -group MEM_A -label READ /snake_testbench/dut/dp_dummy/mem_un/q_a
add wave -noupdate -group {CONTROL SIGNALS} -group NUMBER_GEN_CTRL -color Gray90 -label ONE_GEN /snake_testbench/dut/cntrl_unit/dp_ctrl.ng_one_gen
add wave -noupdate -group {CONTROL SIGNALS} -group NUMBER_GEN_CTRL -color Gray90 -label POS_NEG /snake_testbench/dut/cntrl_unit/dp_ctrl.ng_pos_neg
add wave -noupdate -group {CONTROL SIGNALS} -group NUMBER_GEN_CTRL -color Gray90 -label 1_3 /snake_testbench/dut/cntrl_unit/dp_ctrl.ng_one_three
add wave -noupdate -group {CONTROL SIGNALS} -expand -group ALU_CTRL -color Gray90 -label X_Y /snake_testbench/dut/cntrl_unit/dp_ctrl.alu_x_y
add wave -noupdate -group {CONTROL SIGNALS} -expand -group ALU_CTRL -color Gray90 -label PASS_CALC /snake_testbench/dut/cntrl_unit/dp_ctrl.alu_pass_calc
add wave -noupdate -group {CONTROL SIGNALS} -expand -group REG_BANK_CTRL -color Gray90 -label LOAD_HEAD /snake_testbench/dut/cntrl_unit/dp_ctrl.rb_head_en
add wave -noupdate -group {CONTROL SIGNALS} -expand -group REG_BANK_CTRL -color Gray90 -label LOAD_REG2 /snake_testbench/dut/cntrl_unit/dp_ctrl.rb_reg2_en
add wave -noupdate -group {CONTROL SIGNALS} -expand -group REG_BANK_CTRL -color Gray90 -label LOAD_FIFO /snake_testbench/dut/cntrl_unit/dp_ctrl.rb_fifo_en
add wave -noupdate -group {CONTROL SIGNALS} -expand -group REG_BANK_CTRL -color Gray90 -label POP_FIFO /snake_testbench/dut/cntrl_unit/dp_ctrl.rb_fifo_pop
add wave -noupdate -group {CONTROL SIGNALS} -expand -group REG_BANK_CTRL -color Gray90 -label RB_OUT /snake_testbench/dut/cntrl_unit/dp_ctrl.rb_out_sel
add wave -noupdate -group {CONTROL SIGNALS} -expand -group CODE_GEN_CTRL -color Gray90 -label CODE_SEL /snake_testbench/dut/cntrl_unit/dp_ctrl.cg_sel
add wave -noupdate -group {CONTROL SIGNALS} -group MEM_CTRL -color Gray90 -label MEM_W_EN /snake_testbench/dut/cntrl_unit/dp_ctrl.mem_w_e
add wave -noupdate -group FLAGS -color Gray70 -label X_OVERFLOW /snake_testbench/dut/cntrl_unit/dp_flags.ofc_of_x
add wave -noupdate -group FLAGS -color Gray70 -label Y_OVERFLOW /snake_testbench/dut/cntrl_unit/dp_flags.ofc_of_y
add wave -noupdate -group FLAGS -color Gray70 -label FOOD /snake_testbench/dut/cntrl_unit/dp_flags.cmp_food_flag
add wave -noupdate -group FLAGS -color Gray70 -label BODY /snake_testbench/dut/cntrl_unit/dp_flags.cmp_body_flag
add wave -noupdate -expand -group STATE_MACHINES -color {Medium Violet Red} -label MAIN /snake_testbench/dut/cntrl_unit/main/STATE
add wave -noupdate -expand -group STATE_MACHINES -group INIT -color {Cadet Blue} -label INIT_START /snake_testbench/dut/cntrl_unit/main/fsm_i_start
add wave -noupdate -expand -group STATE_MACHINES -group INIT -color {Cadet Blue} -label INIT /snake_testbench/dut/cntrl_unit/init/STATE
add wave -noupdate -expand -group STATE_MACHINES -group INIT -color {Cadet Blue} -label INIT_DONE /snake_testbench/dut/cntrl_unit/main/fsm_i_done
add wave -noupdate -expand -group STATE_MACHINES -group FOOD -color {Cadet Blue} -label FOOD_START /snake_testbench/dut/cntrl_unit/main/fsm_f_start
add wave -noupdate -expand -group STATE_MACHINES -group FOOD -color {Cadet Blue} -label FOOD /snake_testbench/dut/cntrl_unit/food/STATE
add wave -noupdate -expand -group STATE_MACHINES -group FOOD -color {Cadet Blue} -label FOOD_DONE /snake_testbench/dut/cntrl_unit/main/fsm_f_done
add wave -noupdate -expand -group STATE_MACHINES -expand -group STEP -color {Cadet Blue} -label STEP_START /snake_testbench/dut/cntrl_unit/main/fsm_s_start
add wave -noupdate -expand -group STATE_MACHINES -expand -group STEP -color {Cadet Blue} -label STEP /snake_testbench/dut/cntrl_unit/step/STATE
add wave -noupdate -expand -group STATE_MACHINES -expand -group STEP -color {Cadet Blue} -label STEP_DONE /snake_testbench/dut/cntrl_unit/main/fsm_s_done
add wave -noupdate -expand -group STATE_MACHINES -expand -group STEP -color {Cadet Blue} -label FOUND_FOOD /snake_testbench/dut/cntrl_unit/main/cmp_food_flag
add wave -noupdate -expand -group STATE_MACHINES -expand -group STEP -color {Cadet Blue} -label GAME_OVER /snake_testbench/dut/cntrl_unit/main/fsm_s_game_over
add wave -noupdate -expand -group MONITOR -color Pink -label PRINT_RDY /snake_testbench/mon/print_rdy
add wave -noupdate -expand -group MONITOR -color Pink -label ADDRESS -radix octal /snake_testbench/mon/mem_b_addr
add wave -noupdate -expand -group MONITOR -color Pink -label DATA /snake_testbench/mon/mem_b_data
add wave -noupdate -expand -group MONITOR -color Pink -label STR_DATA -radix ascii /snake_testbench/mon/str_of_field_s
add wave -noupdate -expand -group MONITOR -color Pink -label {PRINT_RDY
} /snake_testbench/mon/print_rdy_delay_s
add wave -noupdate -expand -group MONITOR -color Pink -label PRINT_DONE /snake_testbench/mon/print_done_delay_s
add wave -noupdate -expand -group MONITOR -color Pink -label LINE_WRITTEN /snake_testbench/mon/written_s
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {979383 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 332
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {4939801 ps} {4979366 ps}
run 10000 ns