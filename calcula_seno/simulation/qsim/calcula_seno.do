onerror {quit -f}
vlib work
vlog -work work calcula_seno.vo
vlog -work work calcula_seno.vt
vsim -novopt -c -t 1ps -L cycloneiv_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.calcula_seno_vlg_vec_tst
vcd file -direction calcula_seno.msim.vcd
vcd add -internal calcula_seno_vlg_vec_tst/*
vcd add -internal calcula_seno_vlg_vec_tst/i1/*
add wave /*
run -all
