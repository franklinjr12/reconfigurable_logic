onerror {quit -f}
vlib work
vlog -work work vhdl_test.vo
vlog -work work vhdl_test.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.vhdl_test_vlg_vec_tst
vcd file -direction vhdl_test.msim.vcd
vcd add -internal vhdl_test_vlg_vec_tst/*
vcd add -internal vhdl_test_vlg_vec_tst/i1/*
add wave /*
run -all
