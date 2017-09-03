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
ExecStep $xv_path/bin/xsim mux_4x1_behav -key {Behavioral:sim_1:Functional:mux_4x1} -tclbatch mux_4x1.tcl -log simulate.log
