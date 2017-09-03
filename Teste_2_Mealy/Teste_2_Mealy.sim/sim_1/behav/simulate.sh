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
ExecStep $xv_path/bin/xsim tb_FSM_Mealy_behav -key {Behavioral:sim_1:Functional:tb_FSM_Mealy} -tclbatch tb_FSM_Mealy.tcl -view /home/lucas/Documents/UnB/Disciplinas/ED2/VHDL-codes/Teste_2_Mealy/tb_FSM_Mealy_behav.wcfg -log simulate.log
