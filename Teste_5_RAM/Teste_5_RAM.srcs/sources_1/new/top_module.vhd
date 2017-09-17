library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_module is
   Port (
                clk      :  in STD_LOGIC;
                ready    :  in STD_LOGIC;
                rw       :  in STD_LOGIC;
                rst      :  in STD_LOGIC;
                cs       :  in STD_LOGIC;
                addr     :  in STD_LOGIC_VECTOR(3 downto 0);
                data_in  :  in STD_LOGIC_VECTOR(7 downto 0);
                data_out : out STD_LOGIC_VECTOR(7 downto 0));
end top_module;

architecture Behavioral of top_module is

    component RAM is
        Port ( 
                clk      :  in STD_LOGIC;
                we       :  in STD_LOGIC;                    
                addr     :  in STD_LOGIC_VECTOR(3 downto 0); 
                data_in  :  in STD_LOGIC_VECTOR(7 downto 0); 
                cs       :  in STD_LOGIC;
                oe_b     :  in STD_LOGIC;
                data_out : out STD_LOGIC_VECTOR(7 downto 0));
    end component;
    
    component RAM_controller is
        Port (
                clk   :  in STD_LOGIC;
                ready :  in STD_LOGIC;
                rw    :  in STD_LOGIC;
                rst   :  in STD_LOGIC;
                we    : out STD_LOGIC;
                oe_b  : out STD_LOGIC);
    end component;
    
    signal s_we   : STD_LOGIC;
    signal s_oe_b : STD_LOGIC;
    
begin

myCONTROLLER: RAM_controller
                port map (
                clk   => clk,
                ready => ready,
                rw    => rw,     
                rst   => rst,
                we    => s_we,    
                oe_b  => s_oe_b);
myRAM: RAM
        port map ( 
            clk      => clk,
            we       => s_we,                 
            addr     => addr, 
            data_in  => data_in, 
            cs       => cs,
            oe_b     => s_oe_b,
            data_out => data_out);

end Behavioral;