library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_FSM_Moore is
end tb_FSM_Moore;

architecture Behavioral of tb_FSM_Moore is

    component FSM_Moore is 
        Port (
                clk:  in STD_LOGIC;
                  A:  in STD_LOGIC;
              reset:  in STD_LOGIC;
                  Z: out STD_LOGIC
             );
    end component;     
    
    signal s_A, s_reset, s_clk, s_z: STD_LOGIC;
    
begin

UUT:FSM_Moore PORT MAP(clk     => s_clk, 
                         A     => s_A, 
                         reset => s_reset, 
                         Z     => s_z);
clk:process
begin
    s_clk <= '0';
    wait for 10 ns;
    s_clk <= '1';
    wait for 10 ns;
end process;

process
begin

    s_reset <= '1'; s_A <= '0';
    wait for 5 ns;        
    s_reset <= '0'; s_A <= '1';
--    wait for 5 ns;
    wait for 20 ns;
        
    s_A <= '0';
    wait for 40 ns;
    s_A <= '1';
    wait for 20 ns;
    s_A <= '0';
    wait;
--    s_A <= '0';
--    wait for 120 ns;
--    s_A <= '1';
--    wait for 40 ns;
--    s_A <= '0';
--    wait;


end process;
end Behavioral;
