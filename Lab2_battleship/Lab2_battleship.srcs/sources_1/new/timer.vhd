library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity timer is
    Port (
            clk     : in STD_LOGIC;
            rst     : in STD_LOGIC;
            timeout : out STD_LOGIC);
end timer;

architecture Behavioral of timer is
    
    signal count: INTEGER RANGE 0 to 9;

begin
 
process(clk, rst)
begin
    if RISING_EDGE(clk) then
        if rst = '1' then
            count <= 0;
        elsif count = 9 then
            count <= 0;
            timeout <= '1';
        else 
            count <= count + 1;
        end if;
    end if;        
end process;

end Behavioral;