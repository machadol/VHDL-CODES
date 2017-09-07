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
ExecStep $xv_path/bin/xsim tb_top_module_behav -key {Behavioral:sim_1:Functional:tb_top_module} -tclbatch tb_top_module.tcl -view /home/lucas/Documents/UnB/Disciplinas/ED2/VHDL-CODES/Teste_5_RAM/tb_top_module_behav.wcfg -log simulate.log
