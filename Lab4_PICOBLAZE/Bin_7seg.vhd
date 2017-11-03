-- Conversor binário para 7 segmentos

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity BIN_7SEG is
port 	(	
	BIN : in std_logic_vector(3 downto 0);
	RES : out std_logic_vector(7 downto 0)
	);
end BIN_7SEG;

architecture CONV of BIN_7SEG is

begin

process(BIN)
begin
	case BIN is
		when "0000" =>
			RES <= "11000000";
		when "0001" =>
			RES <= "11111001";
		when "0010" =>
			RES <= "10100100";
		when "0011" =>
			RES <= "10110000";
		when "0100" =>
			RES <= "10011001";
		when "0101" =>
			RES <= "10010010";
		when "0110" =>
			RES <= "10000010";
		when "0111" =>
			RES <= "11111000";
		when "1000" =>
			RES <= "10000000";
		when "1001" =>
			RES <= "10010000";
		when "1010" =>
			RES <= "10001000";
		when "1011" =>
			RES <= "10000011";
		when "1100" =>
			RES <= "11000110";
		when "1101" =>
			RES <= "10100001";
		when "1110" =>
			RES <= "10000110";
		when "1111" =>
			RES <= "10001110";
		when others =>
			RES <= "11111111";
	end case;
end process;

end CONV;
