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
ExecStep $xv_path/bin/xsim tb_FSM_Moore_behav -key {Behavioral:sim_1:Functional:tb_FSM_Moore} -tclbatch tb_FSM_Moore.tcl -view /home/lucas/Documents/UnB/Disciplinas/ED2/VHDL-codes/Teste_2_Moore/tb_FSM_Moore_behav.wcfg -log simulate.log
