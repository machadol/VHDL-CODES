library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clk_div is
    Generic (preset: STD_LOGIC_VECTOR(26 downto 0) :=  "010111110101111000010000000");
    Port (
             clk  :  in STD_LOGIC;
           reset  :  in STD_LOGIC;
           outclk : out STD_LOGIC);
end clk_div;

architecture Behavioral of clk_div is
    
    signal count   : STD_LOGIC_VECTOR(26 downto 0) := (others => '0');
    signal clk_aux : STD_LOGIC;
    
begin

process(clk,reset)
begin
    if RISING_EDGE(clk) then
        if reset='1' then
            count   <= (others=> '0');
            clk_aux <= '0';
        elsif count=preset then 
            clk_aux <= not clk_aux;
            count <= (others => '0');
        else 
            count <= count + '1';
        end if;
    end if;
end process;

    outclk <= clk_aux;
    
end Behavioral;