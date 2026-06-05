radix hex 

force opA_t x"00000005"
force opB_t x"0000000A"
force ctrl_t 2#00#
run 
force opA_t x"00000003"
force opB_t x"00000001"
force ctrl_t 2#01#
run
force opA_t x"FFFFFFFF"
force opB_t x"0000000F"
force ctrl_t 2#10#
run
force opA_t x"0000000F"
force opB_t x"000000F0"
force ctrl_t 2#11#
run
force opA_t x"F0F0F0F0"
force opB_t x"0F0F0F0F"
force ctrl_t 2#10#
run
