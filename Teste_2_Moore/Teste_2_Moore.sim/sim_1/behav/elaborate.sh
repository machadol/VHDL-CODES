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
ExecStep $xv_path/bin/xelab -wto 6b81f63f4bd5440fac2e960310930b2a -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot tb_FSM_Moore_behav xil_defaultlib.tb_FSM_Moore -log elaborate.log
