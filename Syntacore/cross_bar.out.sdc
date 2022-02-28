## Generated SDC file "cross_bar.out.sdc"

## Copyright (C) 2021  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and any partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details, at
## https://fpgasoftware.intel.com/eula.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 21.1.0 Build 842 10/21/2021 SJ Lite Edition"

## DATE    "Mon Feb 28 02:36:05 2022"

##
## DEVICE  "EP4CGX110DF31I7"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {slave_1_ack} -period 1.000 -waveform { 0.000 0.500 } [get_ports {slave_1_ack}]
create_clock -name {master_2_addr[31]} -period 1.000 -waveform { 0.000 0.500 } [get_ports {master_2_addr[31]}]
create_clock -name {master_1_addr[31]} -period 1.000 -waveform { 0.000 0.500 } [get_ports {master_1_addr[31]}]
create_clock -name {slave_2_ack} -period 1.000 -waveform { 0.000 0.500 } [get_ports {slave_2_ack}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {slave_2_ack}] -rise_to [get_clocks {slave_2_ack}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {slave_2_ack}] -fall_to [get_clocks {slave_2_ack}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {slave_2_ack}] -rise_to [get_clocks {slave_2_ack}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {slave_2_ack}] -fall_to [get_clocks {slave_2_ack}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {master_1_addr[31]}] -rise_to [get_clocks {slave_2_ack}]  0.040  
set_clock_uncertainty -rise_from [get_clocks {master_1_addr[31]}] -fall_to [get_clocks {slave_2_ack}]  0.040  
set_clock_uncertainty -rise_from [get_clocks {master_1_addr[31]}] -rise_to [get_clocks {slave_1_ack}]  0.040  
set_clock_uncertainty -rise_from [get_clocks {master_1_addr[31]}] -fall_to [get_clocks {slave_1_ack}]  0.040  
set_clock_uncertainty -fall_from [get_clocks {master_1_addr[31]}] -rise_to [get_clocks {slave_2_ack}]  0.040  
set_clock_uncertainty -fall_from [get_clocks {master_1_addr[31]}] -fall_to [get_clocks {slave_2_ack}]  0.040  
set_clock_uncertainty -fall_from [get_clocks {master_1_addr[31]}] -rise_to [get_clocks {slave_1_ack}]  0.040  
set_clock_uncertainty -fall_from [get_clocks {master_1_addr[31]}] -fall_to [get_clocks {slave_1_ack}]  0.040  
set_clock_uncertainty -rise_from [get_clocks {master_2_addr[31]}] -rise_to [get_clocks {slave_2_ack}]  0.040  
set_clock_uncertainty -rise_from [get_clocks {master_2_addr[31]}] -fall_to [get_clocks {slave_2_ack}]  0.040  
set_clock_uncertainty -rise_from [get_clocks {master_2_addr[31]}] -rise_to [get_clocks {slave_1_ack}]  0.040  
set_clock_uncertainty -rise_from [get_clocks {master_2_addr[31]}] -fall_to [get_clocks {slave_1_ack}]  0.040  
set_clock_uncertainty -fall_from [get_clocks {master_2_addr[31]}] -rise_to [get_clocks {slave_2_ack}]  0.040  
set_clock_uncertainty -fall_from [get_clocks {master_2_addr[31]}] -fall_to [get_clocks {slave_2_ack}]  0.040  
set_clock_uncertainty -fall_from [get_clocks {master_2_addr[31]}] -rise_to [get_clocks {slave_1_ack}]  0.040  
set_clock_uncertainty -fall_from [get_clocks {master_2_addr[31]}] -fall_to [get_clocks {slave_1_ack}]  0.040  
set_clock_uncertainty -rise_from [get_clocks {slave_1_ack}] -rise_to [get_clocks {slave_1_ack}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {slave_1_ack}] -fall_to [get_clocks {slave_1_ack}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {slave_1_ack}] -rise_to [get_clocks {slave_1_ack}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {slave_1_ack}] -fall_to [get_clocks {slave_1_ack}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************
