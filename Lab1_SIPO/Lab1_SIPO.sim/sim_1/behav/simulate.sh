#!/bin/bash -f
xv_path="/opt/Xilinx/Vivado/2017.2"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim shift_reg_SIPO_behav -key {Behavioral:sim_1:Functional:shift_reg_SIPO} -tclbatch shift_reg_SIPO.tcl -view /home/lucas/Documents/UnB/Disciplinas/ED2/VHDL-CODES/Lab1_SIPO/tb_shift_reg_SIPO_behav.wcfg -log simulate.log
