transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/bvu1/Downloads/final_proj/InstructionMemory.vhd}
vcom -93 -work work {C:/Users/bvu1/Downloads/final_proj/PC.vhd}
vcom -93 -work work {C:/Users/bvu1/Downloads/final_proj/Processor.vhd}

