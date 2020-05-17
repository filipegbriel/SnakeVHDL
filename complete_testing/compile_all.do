vcom -reportprogress 300 -work work snake_package.vhd
vcom -reportprogress 300 -work work address_counter.vhd
vcom -reportprogress 300 -work work alu.vhd
vcom -reportprogress 300 -work work button_handler.vhd
vcom -reportprogress 300 -work work code_gen.vhd
vcom -reportprogress 300 -work work comparator.vhd
vcom -reportprogress 300 -work work d_ff.vhd
vcom -reportprogress 300 -work work flsr_galois.vhd
vcom -reportprogress 300 -work work fsm_init.vhd
vcom -reportprogress 300 -work work fsm_food.vhd
vcom -reportprogress 300 -work work fsm_step.vhd
vcom -reportprogress 300 -work work fsm_main.vhd
vcom -reportprogress 300 -work work map_monitor.vhd
vcom -reportprogress 300 -work work mem.vhd
vcom -reportprogress 300 -work work mux.vhd
vcom -reportprogress 300 -work work num_gen.vhd
vcom -reportprogress 300 -work work overflow_correction.vhd
vcom -reportprogress 300 -work work reg.vhd
vcom -reportprogress 300 -work work snake_stimuli.vhd
vcom -reportprogress 300 -work work step_counter.vhd
vcom -reportprogress 300 -work work fifo_1.vhd
vcom -reportprogress 300 -work work reg_bank.vhd
vcom -reportprogress 300 -work work datapath.vhd
vcom -reportprogress 300 -work work control_snake.vhd
vcom -reportprogress 300 -work work snake_hw.vhd

vsim -gui -voptargs=+acc  work.snake_testbench
run_sim_1.do