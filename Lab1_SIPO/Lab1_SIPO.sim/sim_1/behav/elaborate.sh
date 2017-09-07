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
ExecStep $xv_path/bin/xelab -wto 5f17a6f3e5a3433e994c81fe42e09e2a -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot tb_shift_reg_SIPO_behav xil_defaultlib.tb_shift_reg_SIPO -log elaborate.log
