library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4x1 is
    Port(
            sel   :  in STD_LOGIC_VECTOR(1 downto 0);
			i0    :  in STD_LOGIC_VECTOR(26 downto 0);
			i1    :  in STD_LOGIC_VECTOR(26 downto 0);
			i2    :  in STD_LOGIC_VECTOR(26 downto 0);
			i3    :  in STD_LOGIC_VECTOR(26 downto 0);
			saida : out STD_LOGIC_VECTOR(26 downto 0));
end mux_4x1;

architecture Behavioral of mux_4x1 is

begin
	
    with sel select
		saida <= i0 when "00",
				 i1 when "01",
				 i2 when "10",
				 i3 when others;
				 
end Behavioral;