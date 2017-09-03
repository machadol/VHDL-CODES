library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_4x1 is
	Port (  
	        sel   :  in STD_LOGIC_VECTOR(1 downto 0);
			am    :  in STD_LOGIC_VECTOR (26 downto 0);
			bm    :  in STD_LOGIC_VECTOR (26 downto 0);
			cm    :  in STD_LOGIC_VECTOR (26 downto 0);
			dm    :  in STD_LOGIC_VECTOR (26 downto 0);
			saida : out STD_LOGIC_VECTOR (26 downto 0));
end mux_4x1;

architecture Behavioral of mux_4x1 is

begin
	
    with sel select
		saida <= am when "00",
				 bm when "01",
				 cm when "10",
				 dm when others;
end Behavioral;