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
ExecStep $xv_path/bin/xelab -wto 5fa68e35b77343a1a46467fe404f8c8f -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot tb_shift_reg_PIPO_behav xil_defaultlib.tb_shift_reg_PIPO -log elaborate.log
