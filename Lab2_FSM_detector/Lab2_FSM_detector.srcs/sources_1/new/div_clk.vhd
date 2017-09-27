library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity div_clk is
    Generic(preset : STD_LOGIC_VECTOR(27 downto 0) := "1011111010111100001000000000");
    Port ( 
            rst    :  in STD_LOGIC;
            clk    :  in STD_LOGIC; 
            outclk : out STD_LOGIC);
end div_clk;

architecture Behavioral of div_clk is
    
    signal count   : STD_LOGIC_VECTOR(27 downto 0) := (others=>'0');
    signal clk_aux : STD_LOGIC := '0';
    
begin

process(clk,rst)
begin
    if RISING_EDGE(clk) then
        if rst = '1' then
            count   <= (others=>'0');
            clk_aux <= '0';
        elsif count = preset then
            count   <= (others=>'0'); 
            clk_aux <= not clk_aux;
        else 
            count <= count + 1;    
        end if; 
    end if;
end process;

outclk <= clk_aux;

end Behavioral;
