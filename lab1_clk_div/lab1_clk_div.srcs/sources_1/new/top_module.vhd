library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top_module is
    Port (  
            reset   :  in STD_LOGIC;
            clk     :  in STD_LOGIC;
            sel     :  in STD_LOGIC_VECTOR (3 downto 0);
            led     : out STD_LOGIC);
end top_module;

architecture Behavioral of top_module is

component divisor_clk is
    Generic (preset : std_logic_vector(26 downto 0):= (others=>'0'));
    Port(
         reset  :  in STD_LOGIC;
         clk    :  in STD_LOGIC;   
         outclk : out STD_LOGIC);         
end component;

component mux_4x1 is
	Port (
	        sel   :  in STD_LOGIC_VECTOR(1 downto 0);
			am    :  in STD_LOGIC_VECTOR (26 downto 0);
			bm    :  in STD_LOGIC_VECTOR (26 downto 0);
			cm    :  in STD_LOGIC_VECTOR (26 downto 0);
			dm    :  in STD_LOGIC_VECTOR (26 downto 0);
			saida : out STD_LOGIC_VECTOR (26 downto 0));
end component;

signal count1Hz : STD_LOGIC_VECTOR(26 downto 0) := (others=>'0');
signal clk1Hz : STD_LOGIC := '0';
constant preset1Hz : STD_LOGIC_VECTOR(26 downto 0) := "010111110101111000010000000";

signal count05Hz : STD_LOGIC_VECTOR(26 downto 0) := (others=>'0');
signal clk05Hz : STD_LOGIC := '0';
constant preset05Hz : STD_LOGIC_VECTOR(26 downto 0) := "101111101011110000100000000";
                                                        
signal count2Hz : STD_LOGIC_VECTOR(26 downto 0) := (others=>'0');
signal clk2Hz : STD_LOGIC := '0';
constant preset2Hz : STD_LOGIC_VECTOR(26 downto 0) := "001011111010111100001000000";

signal count4Hz : STD_LOGIC_VECTOR(26 downto 0) := (others=>'0');
signal clk4Hz : STD_LOGIC := '0';
constant preset4Hz : STD_LOGIC_VECTOR(26 downto 0) := "000101111101011110000100000";


signal muxout : STD_LOGIC_VECTOR(26 downto 0) := (others => '0');
signal sel_clk : STD_LOGIC_VECTOR(1 downto 0);

begin


clkdiv1hz: divisor_clk
            generic map(preset => muxout)
            port map (
            reset => reset,
            clk => clk,
            outclk => led);
            
clkdiv05hz: divisor_clk
            generic map (preset => muxout)           
            port map (
            reset => reset,
            clk => clk,
            outclk => led);
            

clkdiv2hz: divisor_clk
            generic map (preset => muxout)           
            port map (
            reset => reset,
            clk => clk,
            outclk => led);

clkdiv4hz: divisor_clk
            generic map (preset => muxout)           
            port map (
            reset => reset,
            clk => clk,
            outclk => led);

            
mymux: mux_4x1
            port map(
            sel => sel_clk,
            am => preset1Hz,
            bm => preset05Hz,
            cm => preset2Hz,
            dm => preset4Hz,
            saida => muxout);
                  
end behavioral;