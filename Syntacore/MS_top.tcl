transcript on

set projectName Syntacore
set designName top
set moduleName top
set projDir   /home/mboris/projectsVerilog/$projectName


cd $projDir
vlib work


vlog  ./${designName}.sv
vlog  ./${moduleName}_tb.sv


vlog ./Muxes/Mux_masters.sv
vlog ./Muxes/Mux_slaves.sv
vlog ./arbiter/arbiter.sv

vlog ./test/masters.sv
vlog ./test/slaves.sv



vsim -L work -lib work -t 100ps -voptargs="+acc" ${moduleName}_tb;

#quit -sim
#add wave -unsigned *

add wave -logic -unsigned sim:/${moduleName}_tb/master_1_addr
add wave -logic -unsigned sim:/${moduleName}_tb/master_2_addr
add wave -logic -unsigned sim:/${moduleName}_tb/slave_1_addr
add wave -logic -unsigned sim:/${moduleName}_tb/slave_2_addr
add wave -logic -unsigned sim:/${moduleName}_tb/master_1_req
add wave -logic -unsigned sim:/${moduleName}_tb/master_2_req
add wave -logic -unsigned sim:/${moduleName}_tb/arb_slave_1_req 
add wave -logic -unsigned sim:/${moduleName}_tb/arb_to_slave_1  
add wave -logic -unsigned sim:/${moduleName}_tb/arb_slave_2_req 
add wave -logic -unsigned sim:/${moduleName}_tb/arb_to_slave_2  
add wave -logic -unsigned sim:/${moduleName}_tb/slave_1_req
add wave -logic -unsigned sim:/${moduleName}_tb/slave_2_req
add wave -logic -unsigned sim:/${moduleName}_tb/master_1_cmd
add wave -logic -unsigned sim:/${moduleName}_tb/master_2_cmd
add wave -logic -unsigned sim:/${moduleName}_tb/slave_1_cmd
add wave -logic -unsigned sim:/${moduleName}_tb/slave_2_cmd
add wave -logic -unsigned sim:/${moduleName}_tb/master_1_wdata
add wave -logic -unsigned sim:/${moduleName}_tb/master_2_wdata
add wave -logic -unsigned sim:/${moduleName}_tb/slave_1_wdata
add wave -logic -unsigned sim:/${moduleName}_tb/slave_2_wdata


add wave -logic -unsigned sim:/${moduleName}_tb/master_1_ack
add wave -logic -unsigned sim:/${moduleName}_tb/master_2_ack
add wave -logic -unsigned sim:/${moduleName}_tb/slave_1_ack
add wave -logic -unsigned sim:/${moduleName}_tb/slave_2_ack


add wave -logic -unsigned sim:/${moduleName}_tb/master_1_rdata
add wave -logic -unsigned sim:/${moduleName}_tb/master_2_rdata
add wave -logic -unsigned sim:/${moduleName}_tb/rst
add wave -logic -unsigned sim:/${moduleName}_tb/clk
  add wave -logic -unsigned sim:/${moduleName}_tb/addr


configure wave -timelineunits ns
run -all
