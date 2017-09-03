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
        Generic (preset : std_logic_vector(26 downto 0):= (others=>'0'));
        Port(
             reset  :  in STD_LOGIC;
             clk    :  in STD_LOGIC;   
             outclk : out STD_LOGIC);         
    end component;

    component mux_4x1 is
        Port (
                sel   :  in STD_LOGIC_VECTOR(1 downto 0);
    			i0    :  in STD_LOGIC;
                i1    :  in STD_LOGIC;
                i2    :  in STD_LOGIC;
                i3    :  in STD_LOGIC;
                saida : out STD_LOGIC);
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
    
    signal s_i0 : STD_LOGIC;
    signal s_i1 : STD_LOGIC;
    signal s_i2 : STD_LOGIC;
    signal s_i3 : STD_LOGIC;
    
begin

            
clkdiv05hz: div_clk
            generic map (preset => preset05Hz)           
            port map (
            reset => reset,
            clk => clk,
            outclk => s_i0);
            
clkdiv1hz: div_clk
            generic map(preset => preset1Hz)
            port map (
            reset => reset,
            clk => clk,
            outclk => s_i1);           

clkdiv2hz: div_clk
            generic map (preset => preset2Hz)           
            port map (
            reset => reset,
            clk => clk,
            outclk => s_i2);

clkdiv4hz: div_clk
            generic map (preset => preset4Hz)           
            port map (
            reset => reset,
            clk => clk,
            outclk => s_i3);
         
mymux_1: mux_4x1 
            port map (
            sel   => sel(1 downto 0),   
            i0    => s_i0,
            i1    => s_i1,
            i2    => s_i2,
            i3    => s_i3,  
            saida => led(0));              
         
mymux_2: mux_4x1 
            port map (
            sel   => sel(3 downto 2),   
            i0    => s_i0,
            i1    => s_i1,
            i2    => s_i2,
            i3    => s_i3,  
            saida => led(1));              
         
mymux_3: mux_4x1 
            port map (
            sel   => sel(5 downto 4),   
            i0    => s_i0,
            i1    => s_i1,
            i2    => s_i2,
            i3    => s_i3,  
            saida => led(2));              
         
mymux_4: mux_4x1 
            port map (
            sel   => sel(7 downto 6),   
            i0    => s_i0,
            i1    => s_i1,
            i2    => s_i2,
            i3    => s_i3,  
            saida => led(3));              

                  
end behavioral;

























