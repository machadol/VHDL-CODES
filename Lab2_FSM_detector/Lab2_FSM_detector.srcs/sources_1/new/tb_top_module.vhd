library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_top_module is
end tb_top_module;

architecture Behavioral of tb_top_module is
    
    component top_module is
        Port (
                clk         :  in STD_LOGIC;
                rst_clk     :  in STD_LOGIC;
                rst_FSM     :  in STD_LOGIC;
                A           :  in STD_LOGIC;
                B           :  in STD_LOGIC;
                out_FSM1  : out STD_LOGIC;
                out_FSM2  : out STD_LOGIC;
                alarme      : out STD_LOGIC;
                led_clk     : out STD_LOGIC);
    end component;
    
    signal s_clk        : STD_LOGIC;
    signal s_rst_clk    : STD_LOGIC;
    signal s_rst_FSM    : STD_LOGIC;
    signal s_A          : STD_LOGIC;
    signal s_B          : STD_LOGIC;
    signal s_out_FSM1   : STD_LOGIC;
    signal s_out_FSM2   : STD_LOGIC;
    signal s_alarme     : STD_LOGIC;
    signal s_led_clk    : STD_LOGIC;
    constant clk_period : time := 10ns;    
begin

UUT: top_module port map (  clk       => s_clk, 
                            rst_clk   => s_rst_clk,    
                            rst_FSM   => s_rst_FSM,    
                            A         => s_A,          
                            B         => s_B, 
                            out_FSM1  => s_out_FSM1,  
                            out_FSM2  => s_out_FSM2,  
                            alarme    => s_alarme,    
                            led_clk   => s_led_clk);   

clk:process
begin
    s_clk <= '0';
    wait for clk_period / 2;
    s_clk <= '1'; 
    wait for clk_period / 2;
end process;

process
begin
    s_rst_FSM <= '1';
    s_rst_clk <= '1';
    s_A <= '0';
    s_B <= '0';
    wait for 10ns;
    
    s_rst_FSM <= '0';
    s_rst_clk <= '0';
    
    
    s_A <= '1';
    s_B <= '1';
    wait for 10ns;
    
    s_A <= '0';
    s_B <= '0';
    wait for 10ns;

    s_A <= '0';
    s_B <= '1';
    wait for 10ns;

    s_A <= '0';
    s_B <= '0';
    wait for 10ns;

    s_A <= '1';
    s_B <= '0';
    wait for 10ns;

    
    s_rst_FSM <= '1';   
    wait;
end process;

stop_simulation :process
begin
	wait for 70 ns; 
	assert false
	   report "END OF SIMULATION"
	       severity FAILURE;
end process ;
end Behavioral;