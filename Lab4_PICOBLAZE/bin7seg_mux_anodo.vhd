----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:10:18 05/02/2013 
-- Design Name: 
-- Module Name:    bin7seg_mux_anodo - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bin7seg_mux_anodo is
    Port ( in8bits : in  STD_LOGIC_VECTOR (7 downto 0);
           clock   : in  STD_LOGIC;
           reset   : in  STD_LOGIC;
			  anodo   : out  STD_LOGIC_VECTOR (3 downto 0);
           RES     : out  STD_LOGIC_VECTOR (7 downto 0));
end bin7seg_mux_anodo;

architecture Behavioral of bin7seg_mux_anodo is


	function to_bcd ( bin : std_logic_vector(7 downto 0) ) return std_logic_vector is
	variable i : integer:=0;
	variable bcd : std_logic_vector(11 downto 0) := (others => '0');
	variable bint : std_logic_vector(7 downto 0) := bin;

	begin
		for i in 0 to 7 loop  -- repeating 8 times.
			bcd(11 downto 1) := bcd(10 downto 0);  --shifting the bits.
			bcd(0) := bint(7);
			bint(7 downto 1) := bint(6 downto 0);
			bint(0) :='0';

			if(i < 7 and bcd(3 downto 0) > "0100") then --add 3 if BCD digit is greater than 4.
				bcd(3 downto 0) := bcd(3 downto 0) + "0011";
			end if;

			if(i < 7 and bcd(7 downto 4) > "0100") then --add 3 if BCD digit is greater than 4.
				bcd(7 downto 4) := bcd(7 downto 4) + "0011";
			end if;

			if(i < 7 and bcd(11 downto 8) > "0100") then  --add 3 if BCD digit is greater than 4.
				bcd(11 downto 8) := bcd(11 downto 8) + "0011";
			end if;
		
		end loop;
		
		return bcd;
	end to_bcd;

	signal s_anodo : std_logic_vector(4 downto 0) := (others => '0');
	signal control : std_logic_vector(1 downto 0) := (others => '0');
	signal numbcd_4bits : std_logic_vector(3 downto 0) := (others => '0');
	signal numbcd : std_logic_vector(11 downto 0) := (others => '0');

	signal preset_10Hz : std_logic_vector(25 downto 0) := "00000000111110000100000000";
	signal count_10Hz  : std_logic_vector(25 downto 0) := "00000000111110000100000000";

	component mux3to1
   port (  control :  in STD_LOGIC_VECTOR (1 downto 0);
           in_a    :  in STD_LOGIC_VECTOR (3 downto 0);
           in_b    :  in STD_LOGIC_VECTOR (3 downto 0);
           in_c    :  in STD_LOGIC_VECTOR (3 downto 0);
           outmux  : out STD_LOGIC_VECTOR (3 downto 0));
	end component;

	component BIN_7SEG
	port 	( BIN :  in std_logic_vector(3 downto 0);
		     RES : out std_logic_vector(7 downto 0));
	end component;
	
begin

numbcd <= to_bcd(in8bits);

uut1: mux3to1 port map(
		control => control,
		in_a    => numbcd(11 downto 8),
		in_b    => numbcd(7 downto 4),
		in_c    => numbcd(3 downto 0),
		outmux  => numbcd_4bits);

uut2: BIN_7SEG port map(
		BIN => numbcd_4bits,
		RES => RES);


process(reset,clock)
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
