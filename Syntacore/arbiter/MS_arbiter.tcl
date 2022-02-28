transcript on

set designName src_calc
set moduleName arbiter
set projDir   /home/mboris/projectsVerilog/Syntacore/$moduleName


cd $projDir
vlib work

vlog ./${moduleName}.sv
vlog ./${moduleName}_tb.v

vsim -L work -lib work -t ns -voptargs="+acc" ${moduleName}_tb;

#quit -sim
#add wave -unsigned *

add wave -logic -unsigned sim:/${moduleName}_tb/grant
add wave -logic -unsigned sim:/${moduleName}_tb/ack
add wave -logic -unsigned sim:/${moduleName}_tb/rst
add wave -logic -unsigned sim:/${moduleName}_tb/req
#add wave -logic -unsigned sim:/${moduleName}_tb/pointer_req

configure wave -timelineunits ns
run -all
