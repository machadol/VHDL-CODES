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
ExecStep $xv_path/bin/xelab -wto bbf5753a43db4f238026d8ab3e2a1348 -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot tb_FSM_Mealy_behav xil_defaultlib.tb_FSM_Mealy -log elaborate.log
