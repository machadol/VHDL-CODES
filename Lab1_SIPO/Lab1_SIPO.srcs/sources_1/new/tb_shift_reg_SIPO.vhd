library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_shift_reg_SIPO is
end tb_shift_reg_SIPO;

architecture Behavioral of tb_shift_reg_SIPO is

    component shift_reg_SIPO is
        Generic(N : INTEGER := 8);
        Port (
                clk         :  in STD_LOGIC;         
                din         :  in STD_LOGIC;         
                reset_load  :  in STD_LOGIC;
                led         : buffer STD_LOGIC_VECTOR(7 downto 0);
                parallel_in :  in STD_LOGIC_VECTOR(7 downto 0)); 
    end component;    
    
    signal s_clk         : STD_LOGIC;
    signal s_din         : STD_LOGIC;
    signal s_reset_load  : STD_LOGIC;
    signal s_parallel_in : STD_LOGIC_VECTOR(7 downto 0);
    signal s_led         : STD_LOGIC_VECTOR(7 downto 0);
    
begin

uut: shift_reg_SIPO
        port map (
        clk          => s_clk,
        din          => s_din,
        reset_load   => s_reset_load,
        led          => s_led,
        parallel_in  => s_parallel_in);

clk:process
begin
    s_clk <= '0';
    wait for 10 ns;
    s_clk <= '1';
    wait for 10 ns;
end process;

shift_reg:process
begin

s_parallel_in <= "00000000"; s_reset_load <= '0'; s_din <= '0';
wait for 5 ns;
s_parallel_in <= "00101001"; s_reset_load <= '1'; s_din <= '1';
wait for 20 ns;
s_reset_load <= '0';
wait for 40 ns;

s_din <= '0';
wait for 120 ns;
s_din <= '1'; 
wait;

end process;

end Behavioral;