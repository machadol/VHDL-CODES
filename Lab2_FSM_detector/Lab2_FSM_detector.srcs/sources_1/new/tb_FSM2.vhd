library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_FSM2 is
end tb_FSM2;

architecture Behavioral of tb_FSM2 is
    
    component FSM2 is
        Port (
                clk   :  in STD_LOGIC;
                B     :  in STD_LOGIC;
                reset :  in STD_LOGIC;
                Z2    : out STD_LOGIC);
    end component;
    
    signal s_clk    : STD_LOGIC;
    signal s_B      : STD_LOGIC;
    signal s_reset  : STD_LOGIC := '0';
    signal s_Z2     : STD_LOGIC;
    
begin

UUT: FSM2 port map(
            clk   => s_clk,
            B     => s_B,
            reset => s_reset,
            Z2    => s_Z2);

clk:process
begin
    s_clk <= '0';
    wait for 10 ns;
    s_clk <= '1';
    wait for 10 ns;
end process;

process
begin
    
    s_B <= '0';
    wait for 40 ns;
    s_B <= '1';
    wait for 20 ns;
    s_B <= '0';
    wait for 20 ns;
    s_B <= '1';
    wait for 20 ns;
    s_B <= '0';
    wait for 60 ns;
    s_B <= '1';
    wait for 20 ns;
end process;
end Behavioral;
