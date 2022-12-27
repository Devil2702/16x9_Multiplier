vlib work
vmap work work
vlog tb_top.sv
vsim -debugDB -voptargs=+acc work.tb_top
add wave -r sim:/tb_top/*
run -all
