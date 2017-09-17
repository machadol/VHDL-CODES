library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_top_module is
end tb_top_module;

architecture Behavioral of tb_top_module is
    
    component top_module is
        Port (
                clk      :  in STD_LOGIC;
                ready    :  in STD_LOGIC;
                rw       :  in STD_LOGIC;
                rst      :  in STD_LOGIC;
                cs       :  in STD_LOGIC;
                addr     :  in STD_LOGIC_VECTOR(3 downto 0);
                data_in  :  in STD_LOGIC_VECTOR(7 downto 0);
                data_out : out STD_LOGIC_VECTOR(7 downto 0));
    end component;
    
    signal s_clk      : STD_LOGIC;
    signal s_ready    : STD_LOGIC;
    signal s_rw       : STD_LOGIC;
    signal s_rst      : STD_LOGIC;
    signal s_cs       : STD_LOGIC;
    signal s_addr     : STD_LOGIC_VECTOR(3 downto 0);
    signal s_data_in  : STD_LOGIC_VECTOR(7 downto 0);
    signal s_data_out : STD_LOGIC_VECTOR(7 downto 0);
    
begin

UUT: top_module 
        port map (
        clk      => s_clk,
        ready    => s_ready,
        rw       => s_rw,
        rst      => s_rst,
        cs       => s_cs,
        addr     => s_addr,
        data_in  => s_data_in,
        data_out => s_data_out);
   
myclk:process
begin
    s_clk <= '0';
    wait for 10 ns;
    s_clk <= '1';
    wait for 10 ns;
end process;

ram_controller:process
begin
s_cs  <= '1';
s_rst <= '0';
s_ready <= '0';
s_rw    <= '0';
s_data_in <= "00000000";
s_addr    <= "0000";
wait for 5 ns;

-- Escrevendo matrícula 15/0137303 na forma 01 50 13 73 03 
-- cada par de dígito em um endereço.
s_ready <= '1';
s_rw    <= '0';
s_data_in <= "00000001";
s_addr    <= "0000";
wait for 35 ns;

s_ready <= '0';
s_data_in <= "01010000";
s_addr    <= "0001";
wait for 20 ns;

s_data_in <= "00010011";
s_addr    <= "0010";
wait for 20 ns;

s_data_in <= "01110011";
s_addr    <= "0011";
wait for 20 ns;

s_data_in <= "00000011";
s_addr    <= "0100";
wait for 20 ns;
-- Lendo matrícula
s_addr  <= "0000";
s_ready <= '1';
s_rw    <= '1';
wait for 35 ns;
s_ready    <= '0';
wait for 20 ns;
s_addr  <= "0001";
wait for 20 ns;
s_addr  <= "0010";
wait for 20 ns;
s_addr  <= "0011";
wait for 20 ns;
s_addr  <= "0100";
wait for 20 ns;

end process;

stop_simulation :process
begin
	wait for 250 ns; 
	assert false
	   report "END OF SIMULATION"
	       severity FAILURE;
end process ;

end Behavioral;