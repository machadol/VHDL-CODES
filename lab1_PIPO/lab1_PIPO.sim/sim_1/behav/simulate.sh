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
ExecStep $xv_path/bin/xsim shift_reg_PIPO_behav -key {Behavioral:sim_1:Functional:shift_reg_PIPO} -tclbatch shift_reg_PIPO.tcl -log simulate.log
