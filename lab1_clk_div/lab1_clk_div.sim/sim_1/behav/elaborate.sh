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
ExecStep $xv_path/bin/xelab -wto 51c26e32525b47cfb8f18171fea88407 -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot mux_4x1_behav xil_defaultlib.mux_4x1 -log elaborate.log
