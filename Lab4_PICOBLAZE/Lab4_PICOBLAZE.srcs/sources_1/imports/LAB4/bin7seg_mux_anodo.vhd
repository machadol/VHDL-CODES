library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bin7seg_mux_anodo is
    Port ( 
           in12bits :  in  STD_LOGIC_VECTOR (11 downto 0);
           clock   :  in  STD_LOGIC;
           reset   :  in  STD_LOGIC;
		   anodo   : out  STD_LOGIC_VECTOR (3 downto 0);
           RES     : out  STD_LOGIC_VECTOR (7 downto 0));
end bin7seg_mux_anodo;

architecture Behavioral of bin7seg_mux_anodo is

	function to_bcd ( bin : STD_LOGIC_VECTOR(11 downto 0) ) return STD_LOGIC_VECTOR is
	   variable i : INTEGER:=0;
	   variable bcd  : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');
	   variable bint : STD_LOGIC_VECTOR(11 downto 0)  := bin;
	begin
		for i in 0 to 11 loop  
			bcd(15 downto 1) := bcd(14 downto 0);  --shifting the bits.
			bcd(0) := bint(11);
			bint(11 downto 1) := bint(10 downto 0);
			bint(0) :='0';

			if(i < 11 and bcd(3 downto 0) > "0100") then --add 3 if BCD digit is greater than 4.
				bcd(3 downto 0) := bcd(3 downto 0) + "0011";
			end if;

			if(i < 11 and bcd(7 downto 4) > "0100") then --add 3 if BCD digit is greater than 4.
				bcd(7 downto 4) := bcd(7 downto 4) + "0011";
			end if;

			if(i < 11 and bcd(11 downto 8) > "0100") then  --add 3 if BCD digit is greater than 4.
				bcd(11 downto 8) := bcd(11 downto 8) + "0011";
			end if;

			if(i < 11 and bcd(15 downto 12) > "0100") then  --add 3 if BCD digit is greater than 4.
				bcd(11 downto 8) := bcd(11 downto 8) + "0011";
			end if;
		end loop;
		return bcd;
	end to_bcd;

	signal s_anodo      : STD_LOGIC_VECTOR(4 downto 0)  := (others => '0');
	signal control      : STD_LOGIC_VECTOR(1 downto 0)  := (others => '0');
	signal numbcd_4bits : STD_LOGIC_VECTOR(3 downto 0)  := (others => '0');
	signal numbcd       : STD_LOGIC_VECTOR(15 downto 0) := (others => '0');

	signal preset_10Hz :STD_LOGIC_VECTOR(25 downto 0) := "00000000111110000100000000";
	signal count_10Hz  :STD_LOGIC_VECTOR(25 downto 0) := "00000000111110000100000000";

	component mux4to1 is
        Port ( 
               control :  in  STD_LOGIC_VECTOR (1 downto 0);
               in_a    :  in  STD_LOGIC_VECTOR (3 downto 0);
               in_b    :  in  STD_LOGIC_VECTOR (3 downto 0);
               in_c    :  in  STD_LOGIC_VECTOR (3 downto 0);
               in_d    :  in  STD_LOGIC_VECTOR (3 downto 0);
               outmux  : out  STD_LOGIC_VECTOR (3 downto 0));
    end component;

	component bin_7seg is
        Port(    
               BIN :  in STD_LOGIC_VECTOR(3 downto 0);
               RES : out STD_LOGIC_VECTOR(7 downto 0));
    end component;
	
begin

numbcd <= to_bcd(in12bits);

U1: mux4to1 port map(
		control => control,
		in_a    => numbcd(15 downto 12),
		in_b    => numbcd(11 downto 8),
		in_c    => numbcd(7 downto 4),
		in_d    => numbcd(3 downto 0),
		outmux  => numbcd_4bits);

U2: BIN_7SEG port map(
		BIN => numbcd_4bits,
		RES => RES);

process(reset,clock,preset_10Hz)
begin
	if reset='1' then
		control <= "00";
		s_anodo <= "11110";
		count_10Hz <= preset_10Hz;
	elsif rising_edge(clock) then
		if count_10Hz = "00000000000000000000000000" then
			if control = "11" then
				control <= "00";
				s_anodo <= "11110";
			else
				control <= control+'1';
				s_anodo <= s_anodo(3 downto 0) & '1';
			end if;
			
			count_10Hz <= preset_10Hz;
		else
			count_10Hz <= count_10Hz - '1';
		end if;
	end if;
end process;

anodo <= s_anodo(3 downto 0);

end Behavioral;
