library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity div_clk is
	Generic (preset : STD_LOGIC_VECTOR(26 downto 0):= (others=>'0'));
	Port (  
	       reset  :  in STD_LOGIC;
		   clk    :  in STD_LOGIC;
		   outclk : out STD_LOGIC);
end div_clk;

architecture Behavioral of div_clk is

	signal count  : STD_LOGIC_VECTOR(26 downto 0) := (others=>'0');
	signal clkaux : STD_LOGIC := '0';

begin

process(clk, reset)
begin
    if rising_edge(clk) then
	   if reset='1' then
	       count <= (others=>'0');
		   clkaux <= '0';
	   elsif count=preset then
	       clkaux <= not clkaux;
	       count <= (others=>'0');
	   else
	       count <= count + '1';
	   end if;
    end if;
end process;

outclk <= clkaux;

end Behavioral;