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
ExecStep $xv_path/bin/xelab -wto 0764efa82eac4c298c191138746b3e5f -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L secureip --snapshot tb_top_module_behav xil_defaultlib.tb_top_module -log elaborate.log
