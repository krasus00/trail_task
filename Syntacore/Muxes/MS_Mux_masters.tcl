transcript on

set projectName Syntacore
set designName Muxes
set moduleName Mux_masters
set projDir   /home/mboris/projectsVerilog/$projectName/$designName


cd $projDir
vlib work

vlog ./${moduleName}.sv
vlog ./${moduleName}_tb.sv

vsim -L work -lib work -t 100ps -voptargs="+acc" ${moduleName}_tb;

#quit -sim
#add wave -unsigned *

add wave -logic -unsigned sim:/${moduleName}_tb/arb_master_req
add wave -logic -unsigned sim:/${moduleName}_tb/master_cmd
add wave -logic -unsigned sim:/${moduleName}_tb/master_wdata
add wave -logic -unsigned sim:/${moduleName}_tb/slave_ack
add wave -logic -unsigned sim:/${moduleName}_tb/slave_rdata
add wave -logic -unsigned sim:/${moduleName}_tb/slave_req
add wave -logic -unsigned sim:/${moduleName}_tb/slave_addr
add wave -logic -unsigned sim:/${moduleName}_tb/slave_addr
add wave -logic -unsigned sim:/${moduleName}_tb/slave_cmd
add wave -logic -unsigned sim:/${moduleName}_tb/slave_wdata
add wave -logic -unsigned sim:/${moduleName}_tb/master_ack
add wave -logic -unsigned sim:/${moduleName}_tb/master_rdata
add wave -logic -unsigned sim:/${moduleName}_tb/rst



configure wave -timelineunits ns
run -all
