library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_FSM1 is
end tb_FSM1;

architecture Behavioral of tb_FSM1 is
    
    component FSM1 is
        Port (
                clk   :  in STD_LOGIC;
                A     :  in STD_LOGIC;
                reset :  in STD_LOGIC;
                Z1    : out STD_LOGIC);
    end component;
    
    signal s_clk    : STD_LOGIC;
    signal s_A      : STD_LOGIC;
    signal s_reset  : STD_LOGIC := '0';
    signal s_Z1     : STD_LOGIC;
    
begin

UUT: FSM1 port map(
            clk   => s_clk,
            A     => s_A,
            reset => s_reset,
            Z1    => s_Z1);

clk:process
begin
    s_clk <= '0';
    wait for 10 ns;
    s_clk <= '1';
    wait for 10 ns;
end process;

process
begin
    
    s_A <= '0';
    wait for 40 ns;
    s_A <= '1';
    wait for 20 ns;
    s_A <= '0';
    wait for 60 ns;
    s_A <= '1';
    wait for 20 ns;
    s_A <= '0';
    wait for 20 ns;
end process;
end Behavioral;
