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
ExecStep $xv_path/bin/xsim tb_shift_reg_SIPO_behav -key {Behavioral:sim_1:Functional:tb_shift_reg_SIPO} -tclbatch tb_shift_reg_SIPO.tcl -log simulate.log
