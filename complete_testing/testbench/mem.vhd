LIBRARY ieee;
USE ieee.std_logic_1164.all;

LIBRARY altera_mf;
USE altera_mf.all;

ENTITY mem IS
	PORT
	(
		address_a		: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		address_b		: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		byteena_a		: IN STD_LOGIC_VECTOR (0 DOWNTO 0) :=  (OTHERS => '1');
		clock			: IN STD_LOGIC  := '1';
		data_a			: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data_b			: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		enable			: IN STD_LOGIC  := '1';
		wren_a			: IN STD_LOGIC  := '0';
		wren_b			: IN STD_LOGIC  := '0';
		q_a				: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		q_b				: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
END mem;


ARCHITECTURE SYN OF mem IS

	SIGNAL sub_wire0	: STD_LOGIC_VECTOR (7 DOWNTO 0);
	SIGNAL sub_wire1	: STD_LOGIC_VECTOR (7 DOWNTO 0);



	COMPONENT altsyncram
	GENERIC (
		address_reg_b		: STRING;
		byte_size		: NATURAL;
		clock_enable_input_a		: STRING;
		clock_enable_input_b		: STRING;
		clock_enable_output_a		: STRING;
		clock_enable_output_b		: STRING;
		indata_reg_b		: STRING;
		intended_device_family		: STRING;
		lpm_type		: STRING;
		numwords_a		: NATURAL;
		numwords_b		: NATURAL;
		operation_mode		: STRING;
		outdata_aclr_a		: STRING;
		outdata_aclr_b		: STRING;
		outdata_reg_a		: STRING;
		outdata_reg_b		: STRING;
		power_up_uninitialized		: STRING;
		read_during_write_mode_mixed_ports		: STRING;
		widthad_a		: NATURAL;
		widthad_b		: NATURAL;
		width_a		: NATURAL;
		width_b		: NATURAL;
		width_byteena_a		: NATURAL;
		width_byteena_b		: NATURAL;
		wrcontrol_wraddress_reg_b		: STRING
	);
	PORT (
			byteena_a	: IN STD_LOGIC_VECTOR (0 DOWNTO 0);
			clock0	: IN STD_LOGIC ;
			wren_a	: IN STD_LOGIC ;
			address_b	: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
			clocken0	: IN STD_LOGIC ;
			data_b	: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			q_a	: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
			wren_b	: IN STD_LOGIC ;
			address_a	: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
			data_a	: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			q_b	: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
	END COMPONENT;

BEGIN
	q_a    <= sub_wire0(7 DOWNTO 0);
	q_b    <= sub_wire1(7 DOWNTO 0);

	altsyncram_component : altsyncram
	GENERIC MAP (
		address_reg_b => "CLOCK0",
		byte_size => 8,
		clock_enable_input_a => "NORMAL",
		clock_enable_input_b => "NORMAL",
		clock_enable_output_a => "NORMAL",
		clock_enable_output_b => "NORMAL",
		indata_reg_b => "CLOCK0",
		intended_device_family => "Cyclone II",
		lpm_type => "altsyncram",
		numwords_a => 64,
		numwords_b => 64,
		operation_mode => "BIDIR_DUAL_PORT",
		outdata_aclr_a => "NONE",
		outdata_aclr_b => "NONE",
		outdata_reg_a => "CLOCK0",
		outdata_reg_b => "CLOCK0",
		power_up_uninitialized => "FALSE",
		read_during_write_mode_mixed_ports => "OLD_DATA",
		widthad_a => 6,
		widthad_b => 6,
		width_a => 8,
		width_b => 8,
		width_byteena_a => 1,
		width_byteena_b => 1,
		wrcontrol_wraddress_reg_b => "CLOCK0"
	)
	PORT MAP (
		byteena_a => byteena_a,
		clock0 => clock,
		wren_a => wren_a,
		address_b => address_b,
		clocken0 => enable,
		data_b => data_b,
		wren_b => wren_b,
		address_a => address_a,
		data_a => data_a,
		q_a => sub_wire0,
		q_b => sub_wire1
	);



END SYN;

-- ============================================================
-- CNX file retrieval info
-- ============================================================
-- Retrieval info: PRIVATE: ADDRESSSTALL_A NUMERIC "0"
-- Retrieval info: PRIVATE: ADDRESSSTALL_B NUMERIC "0"
-- Retrieval info: PRIVATE: BYTEENA_ACLR_A NUMERIC "0"
-- Retrieval info: PRIVATE: BYTEENA_ACLR_B NUMERIC "0"
-- Retrieval info: PRIVATE: BYTE_ENABLE_A NUMERIC "1"
-- Retrieval info: PRIVATE: BYTE_ENABLE_B NUMERIC "0"
-- Retrieval info: PRIVATE: BYTE_SIZE NUMERIC "8"
-- Retrieval info: PRIVATE: BlankMemory NUMERIC "1"
-- Retrieval info: PRIVATE: CLOCK_ENABLE_INPUT_A NUMERIC "1"
-- Retrieval info: PRIVATE: CLOCK_ENABLE_INPUT_B NUMERIC "1"
-- Retrieval info: PRIVATE: CLOCK_ENABLE_OUTPUT_A NUMERIC "1"
-- Retrieval info: PRIVATE: CLOCK_ENABLE_OUTPUT_B NUMERIC "1"
-- Retrieval info: PRIVATE: CLRdata NUMERIC "0"
-- Retrieval info: PRIVATE: CLRq NUMERIC "0"
-- Retrieval info: PRIVATE: CLRrdaddress NUMERIC "0"
-- Retrieval info: PRIVATE: CLRrren NUMERIC "0"
-- Retrieval info: PRIVATE: CLRwraddress NUMERIC "0"
-- Retrieval info: PRIVATE: CLRwren NUMERIC "0"
-- Retrieval info: PRIVATE: Clock NUMERIC "0"
-- Retrieval info: PRIVATE: Clock_A NUMERIC "0"
-- Retrieval info: PRIVATE: Clock_B NUMERIC "0"
-- Retrieval info: PRIVATE: ECC NUMERIC "0"
-- Retrieval info: PRIVATE: IMPLEMENT_IN_LES NUMERIC "0"
-- Retrieval info: PRIVATE: INDATA_ACLR_B NUMERIC "0"
-- Retrieval info: PRIVATE: INDATA_REG_B NUMERIC "1"
-- Retrieval info: PRIVATE: INIT_FILE_LAYOUT STRING "PORT_A"
-- Retrieval info: PRIVATE: INIT_TO_SIM_X NUMERIC "0"
-- Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
-- Retrieval info: PRIVATE: JTAG_ENABLED NUMERIC "0"
-- Retrieval info: PRIVATE: JTAG_ID STRING "NONE"
-- Retrieval info: PRIVATE: MAXIMUM_DEPTH NUMERIC "0"
-- Retrieval info: PRIVATE: MEMSIZE NUMERIC "512"
-- Retrieval info: PRIVATE: MEM_IN_BITS NUMERIC "0"
-- Retrieval info: PRIVATE: MIFfilename STRING ""
-- Retrieval info: PRIVATE: OPERATION_MODE NUMERIC "3"
-- Retrieval info: PRIVATE: OUTDATA_ACLR_B NUMERIC "0"
-- Retrieval info: PRIVATE: OUTDATA_REG_B NUMERIC "1"
-- Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "0"
-- Retrieval info: PRIVATE: READ_DURING_WRITE_MODE_MIXED_PORTS NUMERIC "1"
-- Retrieval info: PRIVATE: READ_DURING_WRITE_MODE_PORT_A NUMERIC "3"
-- Retrieval info: PRIVATE: READ_DURING_WRITE_MODE_PORT_B NUMERIC "3"
-- Retrieval info: PRIVATE: REGdata NUMERIC "1"
-- Retrieval info: PRIVATE: REGq NUMERIC "1"
-- Retrieval info: PRIVATE: REGrdaddress NUMERIC "0"
-- Retrieval info: PRIVATE: REGrren NUMERIC "0"
-- Retrieval info: PRIVATE: REGwraddress NUMERIC "1"
-- Retrieval info: PRIVATE: REGwren NUMERIC "1"
-- Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
-- Retrieval info: PRIVATE: USE_DIFF_CLKEN NUMERIC "0"
-- Retrieval info: PRIVATE: UseDPRAM NUMERIC "1"
-- Retrieval info: PRIVATE: VarWidth NUMERIC "0"
-- Retrieval info: PRIVATE: WIDTH_READ_A NUMERIC "8"
-- Retrieval info: PRIVATE: WIDTH_READ_B NUMERIC "8"
-- Retrieval info: PRIVATE: WIDTH_WRITE_A NUMERIC "8"
-- Retrieval info: PRIVATE: WIDTH_WRITE_B NUMERIC "8"
-- Retrieval info: PRIVATE: WRADDR_ACLR_B NUMERIC "0"
-- Retrieval info: PRIVATE: WRADDR_REG_B NUMERIC "1"
-- Retrieval info: PRIVATE: WRCTRL_ACLR_B NUMERIC "0"
-- Retrieval info: PRIVATE: enable NUMERIC "1"
-- Retrieval info: PRIVATE: rden NUMERIC "0"
-- Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
-- Retrieval info: CONSTANT: ADDRESS_REG_B STRING "CLOCK0"
-- Retrieval info: CONSTANT: BYTE_SIZE NUMERIC "8"
-- Retrieval info: CONSTANT: CLOCK_ENABLE_INPUT_A STRING "NORMAL"
-- Retrieval info: CONSTANT: CLOCK_ENABLE_INPUT_B STRING "NORMAL"
-- Retrieval info: CONSTANT: CLOCK_ENABLE_OUTPUT_A STRING "NORMAL"
-- Retrieval info: CONSTANT: CLOCK_ENABLE_OUTPUT_B STRING "NORMAL"
-- Retrieval info: CONSTANT: INDATA_REG_B STRING "CLOCK0"
-- Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
-- Retrieval info: CONSTANT: LPM_TYPE STRING "altsyncram"
-- Retrieval info: CONSTANT: NUMWORDS_A NUMERIC "64"
-- Retrieval info: CONSTANT: NUMWORDS_B NUMERIC "64"
-- Retrieval info: CONSTANT: OPERATION_MODE STRING "BIDIR_DUAL_PORT"
-- Retrieval info: CONSTANT: OUTDATA_ACLR_A STRING "NONE"
-- Retrieval info: CONSTANT: OUTDATA_ACLR_B STRING "NONE"
-- Retrieval info: CONSTANT: OUTDATA_REG_A STRING "CLOCK0"
-- Retrieval info: CONSTANT: OUTDATA_REG_B STRING "CLOCK0"
-- Retrieval info: CONSTANT: POWER_UP_UNINITIALIZED STRING "FALSE"
-- Retrieval info: CONSTANT: READ_DURING_WRITE_MODE_MIXED_PORTS STRING "OLD_DATA"
-- Retrieval info: CONSTANT: WIDTHAD_A NUMERIC "6"
-- Retrieval info: CONSTANT: WIDTHAD_B NUMERIC "6"
-- Retrieval info: CONSTANT: WIDTH_A NUMERIC "8"
-- Retrieval info: CONSTANT: WIDTH_B NUMERIC "8"
-- Retrieval info: CONSTANT: WIDTH_BYTEENA_A NUMERIC "1"
-- Retrieval info: CONSTANT: WIDTH_BYTEENA_B NUMERIC "1"
-- Retrieval info: CONSTANT: WRCONTROL_WRADDRESS_REG_B STRING "CLOCK0"
-- Retrieval info: USED_PORT: address_a 0 0 6 0 INPUT NODEFVAL "address_a[5..0]"
-- Retrieval info: USED_PORT: address_b 0 0 6 0 INPUT NODEFVAL "address_b[5..0]"
-- Retrieval info: USED_PORT: byteena_a 0 0 1 0 INPUT VCC "byteena_a[0..0]"
-- Retrieval info: USED_PORT: clock 0 0 0 0 INPUT VCC "clock"
-- Retrieval info: USED_PORT: data_a 0 0 8 0 INPUT NODEFVAL "data_a[7..0]"
-- Retrieval info: USED_PORT: data_b 0 0 8 0 INPUT NODEFVAL "data_b[7..0]"
-- Retrieval info: USED_PORT: enable 0 0 0 0 INPUT VCC "enable"
-- Retrieval info: USED_PORT: q_a 0 0 8 0 OUTPUT NODEFVAL "q_a[7..0]"
-- Retrieval info: USED_PORT: q_b 0 0 8 0 OUTPUT NODEFVAL "q_b[7..0]"
-- Retrieval info: USED_PORT: wren_a 0 0 0 0 INPUT GND "wren_a"
-- Retrieval info: USED_PORT: wren_b 0 0 0 0 INPUT GND "wren_b"
-- Retrieval info: CONNECT: @address_a 0 0 6 0 address_a 0 0 6 0
-- Retrieval info: CONNECT: @address_b 0 0 6 0 address_b 0 0 6 0
-- Retrieval info: CONNECT: @byteena_a 0 0 1 0 byteena_a 0 0 1 0
-- Retrieval info: CONNECT: @clock0 0 0 0 0 clock 0 0 0 0
-- Retrieval info: CONNECT: @clocken0 0 0 0 0 enable 0 0 0 0
-- Retrieval info: CONNECT: @data_a 0 0 8 0 data_a 0 0 8 0
-- Retrieval info: CONNECT: @data_b 0 0 8 0 data_b 0 0 8 0
-- Retrieval info: CONNECT: @wren_a 0 0 0 0 wren_a 0 0 0 0
-- Retrieval info: CONNECT: @wren_b 0 0 0 0 wren_b 0 0 0 0
-- Retrieval info: CONNECT: q_a 0 0 8 0 @q_a 0 0 8 0
-- Retrieval info: CONNECT: q_b 0 0 8 0 @q_b 0 0 8 0
-- Retrieval info: GEN_FILE: TYPE_NORMAL mem_2_port.vhd TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL mem_2_port.inc FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL mem_2_port.cmp TRUE
-- Retrieval info: GEN_FILE: TYPE_NORMAL mem_2_port.bsf FALSE
-- Retrieval info: GEN_FILE: TYPE_NORMAL mem_2_port_inst.vhd FALSE
-- Retrieval info: LIB_FILE: altera_mf
