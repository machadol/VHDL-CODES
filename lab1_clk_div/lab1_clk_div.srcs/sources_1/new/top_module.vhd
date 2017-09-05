library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top_module is
    Port (  
            reset   :  in STD_LOGIC;
            clk     :  in STD_LOGIC;
            sel     :  in STD_LOGIC_VECTOR(7 downto 0);
            led     : out STD_LOGIC_VECTOR(3 downto 0));
end top_module;

architecture Behavioral of top_module is

    component div_clk is
        Port(
             reset  :  in STD_LOGIC;
             clk    :  in STD_LOGIC;   
             outclk : out STD_LOGIC;
		     preset :  in STD_LOGIC_VECTOR(26 downto 0));
    end component;

    component mux_4x1 is
        Port(  
                sel   :  in STD_LOGIC_VECTOR(1 downto 0);
                i0    :  in STD_LOGIC_VECTOR(26 downto 0);
                i1    :  in STD_LOGIC_VECTOR(26 downto 0);
			    i2    :  in STD_LOGIC_VECTOR(26 downto 0);
			    i3    :  in STD_LOGIC_VECTOR(26 downto 0);
			    saida : out STD_LOGIC_VECTOR(26 downto 0));
    end component;

    constant preset05Hz : STD_LOGIC_VECTOR(26 downto 0) := "101111101011110000100000000";
    constant preset1Hz  : STD_LOGIC_VECTOR(26 downto 0) := "010111110101111000010000000";
    constant preset2Hz  : STD_LOGIC_VECTOR(26 downto 0) := "001011111010111100001000000";
    constant preset4Hz  : STD_LOGIC_VECTOR(26 downto 0) := "000101111101011110000100000";
    
    signal sel_1 : STD_LOGIC_VECTOR(1 downto 0) := sel(1 downto 0);
    signal sel_2 : STD_LOGIC_VECTOR(1 downto 0) := sel(3 downto 2);
    signal sel_3 : STD_LOGIC_VECTOR(1 downto 0) := sel(5 downto 4);
    signal sel_4 : STD_LOGIC_VECTOR(1 downto 0) := sel(7 downto 6);
    
    signal preset_1 : STD_LOGIC_VECTOR(26 downto 0);
    signal preset_2 : STD_LOGIC_VECTOR(26 downto 0);
    signal preset_3 : STD_LOGIC_VECTOR(26 downto 0);
    signal preset_4 : STD_LOGIC_VECTOR(26 downto 0);

begin

mymux_1: mux_4x1 
            port map (
            sel   => sel_1,   
            i0    => preset05Hz,  
            i1    => preset1Hz,  
            i2    => preset2Hz,  
            i3    => preset4Hz,  
            saida => preset_1);
             
mymux_2: mux_4x1 
            port map (
            sel   => sel_2,   
            i0    => preset05Hz,  
            i1    => preset1Hz,  
            i2    => preset2Hz,  
            i3    => preset4Hz,  
            saida => preset_2);
             
mymux_3: mux_4x1 
            port map (
            sel   => sel_3,   
            i0    => preset05Hz,  
            i1    => preset1Hz,  
            i2    => preset2Hz,  
            i3    => preset4Hz,  
            saida => preset_3);
             
mymux_4: mux_4x1 
            port map (
            sel   => sel_4,   
            i0    => preset05Hz,  
            i1    => preset1Hz,  
            i2    => preset2Hz,  
            i3    => preset4Hz,  
            saida => preset_4); 
            
clkdiv_1: div_clk
            port map (
            reset => reset,
            clk   => clk,
            outclk => led(0),
            preset => preset_1);            
            
clkdiv_2: div_clk
            port map (
            reset => reset,
            clk   => clk,
            outclk => led(1),
            preset => preset_2);            
                
clkdiv_3: div_clk
            port map (
            reset => reset,
            clk   => clk,
            outclk => led(2),
            preset => preset_3);            
                
clkdiv_4: div_clk
            port map (
            reset => reset,
            clk   => clk,
            outclk => led(3),
            preset => preset_4);            
      
end behavioral;