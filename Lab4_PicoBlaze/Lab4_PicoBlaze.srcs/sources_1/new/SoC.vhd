library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SoC is
    Port ( 
           clk      :  in STD_LOGIC;
           rst      :  in STD_LOGIC;
           x        :  in STD_LOGIC_VECTOR (7 downto 0);
           saida    : out STD_LOGIC_VECTOR (11 downto 0));
end SoC;

architecture Behavioral of SoC is

    component kcpsm6 is
        generic(                 
                           hwbuild : std_logic_vector(7 downto 0) := X"00";
                  interrupt_vector : std_logic_vector(11 downto 0) := X"3FF";
           scratch_pad_memory_size : integer := 64);
        port (
                           address : out std_logic_vector(11 downto 0);
                       instruction : in std_logic_vector(17 downto 0);
                       bram_enable : out std_logic;
                           in_port : in std_logic_vector(7 downto 0);
                          out_port : out std_logic_vector(7 downto 0);
                           port_id : out std_logic_vector(7 downto 0);
                      write_strobe : out std_logic;
                    k_write_strobe : out std_logic;
                       read_strobe : out std_logic;
                         interrupt : in std_logic;
                     interrupt_ack : out std_logic;
                             sleep : in std_logic;
                             reset : in std_logic;
                               clk : in std_logic);
    end component;
    
    component somador is
        generic(             
                           C_FAMILY : string := "S7"; 
                  C_RAM_SIZE_KWORDS : integer := 2;
               C_JTAG_LOADER_ENABLE : integer := 0);
        Port ( 
                  address : in std_logic_vector(11 downto 0);
              instruction : out std_logic_vector(17 downto 0);
                   enable : in std_logic;
                      rdl : out std_logic;                    
                      clk : in std_logic);
    end component;
    
    component shift is
        generic(             
                           C_FAMILY : string := "S7"; 
                  C_RAM_SIZE_KWORDS : integer := 2;
               C_JTAG_LOADER_ENABLE : integer := 0);
        Port ( 
                  address : in std_logic_vector(11 downto 0);
              instruction : out std_logic_vector(17 downto 0);
                   enable : in std_logic;
                      rdl : out std_logic;                    
                      clk : in std_logic);
    end component;
    
    component mult is
        generic(
                           C_FAMILY : string := "S7"; 
                  C_RAM_SIZE_KWORDS : integer := 2;
               C_JTAG_LOADER_ENABLE : integer := 0);
        Port (      
                  address : in std_logic_vector(11 downto 0);
              instruction : out std_logic_vector(17 downto 0);
                   enable : in std_logic;
                      rdl : out std_logic;                    
                      clk : in std_logic);
    end component;
    
    signal         address1 : std_logic_vector(11 downto 0);
    signal     instruction1 : std_logic_vector(17 downto 0);
    signal     bram_enable1 : std_logic;
    signal         in_port1 : std_logic_vector(7 downto 0);
    signal        out_port1 : std_logic_vector(7 downto 0);
    signal         port_id1 : std_logic_vector(7 downto 0);
    signal    write_strobe1 : std_logic;
    signal  k_write_strobe1 : std_logic;
    signal     read_strobe1 : std_logic;
    signal       interrupt1 : std_logic;
    signal   interrupt_ack1 : std_logic;
    signal    kcpsm6_sleep1 : std_logic;
    signal    kcpsm6_reset  : std_logic;
    signal              rdl1 : std_logic;

    signal         address2 : std_logic_vector(11 downto 0);
    signal     instruction2 : std_logic_vector(17 downto 0);
    signal     bram_enable2 : std_logic;
    signal         in_port2 : std_logic_vector(7 downto 0);
    signal        out_port2 : std_logic_vector(7 downto 0);
    signal         port_id2 : std_logic_vector(7 downto 0);
    signal    write_strobe2 : std_logic;
    signal  k_write_strobe2 : std_logic;
    signal     read_strobe2 : std_logic;
    signal       interrupt2 : std_logic;
    signal   interrupt_ack2 : std_logic;
    signal    kcpsm6_sleep2 : std_logic;
    signal              rdl2 : std_logic;
    
    signal         address3 : std_logic_vector(11 downto 0);
    signal     instruction3 : std_logic_vector(17 downto 0);
    signal     bram_enable3 : std_logic;
    signal         in_port3 : std_logic_vector(7 downto 0);
    signal        out_port3 : std_logic_vector(7 downto 0);
    signal         port_id3 : std_logic_vector(7 downto 0);
    signal    write_strobe3 : std_logic;
    signal  k_write_strobe3 : std_logic;
    signal     read_strobe3 : std_logic;
    signal       interrupt3 : std_logic;
    signal   interrupt_ack3 : std_logic;
    signal    kcpsm6_sleep3 : std_logic;
    signal              rdl3 : std_logic;
    
    signal out_mult   : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
    signal out_soma   : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
    signal out_result : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
    

begin

U1: kcpsm6
    generic map ( hwbuild => X"00", 
                  interrupt_vector => X"3FF",
                  scratch_pad_memory_size => 64)
    port map(      address => address1,
               instruction => instruction1,
               bram_enable => bram_enable1,
                   port_id => port_id1,
              write_strobe => write_strobe1,
            k_write_strobe => k_write_strobe1,
                  out_port => out_port1,
               read_strobe => read_strobe1,
                   in_port => in_port1,
                 interrupt => interrupt1,
             interrupt_ack => interrupt_ack1,
                     sleep => kcpsm6_sleep1,
                     reset => kcpsm6_reset,
                       clk => clk);

U2: kcpsm6
    generic map ( hwbuild => X"00", 
                  interrupt_vector => X"3FF",
                  scratch_pad_memory_size => 64)
    port map(      address => address2,
               instruction => instruction2,
               bram_enable => bram_enable2,
                   port_id => port_id2,
              write_strobe => write_strobe2,
            k_write_strobe => k_write_strobe2,
                  out_port => out_port2,
               read_strobe => read_strobe2,
                   in_port => in_port2,
                 interrupt => interrupt2,
             interrupt_ack => interrupt_ack2,
                     sleep => kcpsm6_sleep2,
                     reset => kcpsm6_reset,
                       clk => clk);

U3: kcpsm6
    generic map ( hwbuild => X"00", 
                  interrupt_vector => X"3FF",
                  scratch_pad_memory_size => 64)
    port map(      address => address3,
               instruction => instruction3,
               bram_enable => bram_enable3,
                   port_id => port_id3,
              write_strobe => write_strobe3,
            k_write_strobe => k_write_strobe3,
                  out_port => out_port3,
               read_strobe => read_strobe3,
                   in_port => in_port3,
                 interrupt => interrupt3,
             interrupt_ack => interrupt_ack3,
                     sleep => kcpsm6_sleep3,
                     reset => kcpsm6_reset,
                       clk => clk);

Program_rom1: mult                    
    generic map(             C_FAMILY => "7S",
                    C_RAM_SIZE_KWORDS => 2,   
                 C_JTAG_LOADER_ENABLE => 1)    
    port map(      address => address1,      
               instruction => instruction1,
                    enable => bram_enable1,
                       rdl => rdl1,
                       clk => clk);

Program_rom2: somador                    
    generic map(             C_FAMILY => "7S",
                    C_RAM_SIZE_KWORDS => 2,   
                 C_JTAG_LOADER_ENABLE => 0)    
    port map(      address => address2,      
               instruction => instruction2,
                    enable => bram_enable2,
                       rdl => rdl2,
                       clk => clk);

Program_rom3: shift
    generic map(             C_FAMILY => "7S",   
                    C_RAM_SIZE_KWORDS => 2,      
                 C_JTAG_LOADER_ENABLE => 0)       
    port map(      address => address3,      
               instruction => instruction3,
                    enable => bram_enable3,
                       rdl => rdl3,
                       clk => clk);

kcpsm6_reset <= rdl1 or rdl2 or rdl3 or rst;

    process(clk)
    begin
        if rising_edge(clk) then
            if    port_id1(1 downto 0) = "01" then in_port1 <= x;
            elsif port_id2(1 downto 0) = "01" then in_port2 <= out_mult(7 downto 0);
            elsif port_id3(1 downto 0) = "01" then in_port3 <= out_soma(7 downto 0);
            elsif port_id3(1 downto 0) = "10" then in_port3 <= "0000" & out_soma(11 downto 8);
            end if;
        end if;
    end process;
    
    process(clk)
    begin
        if rising_edge(clk) then
            if port_id1(1 downto 0) = "11" and write_strobe1='1'    then out_mult(7 downto 0) <= out_port1;
            elsif port_id1(1 downto 0) = "10"  and write_strobe1='1' then out_mult(3 downto 0) <= out_port1(3 downto 0);
            elsif port_id2(1 downto 0) = "10"  and write_strobe1='1' then out_soma(7 downto 0) <= out_port1;
            elsif port_id2(1 downto 0) = "11"  and write_strobe1='1' then out_soma(3 downto 0) <= out_port1(3 downto 0);
            elsif port_id3(1 downto 0) = "11"  and write_strobe1='1' then out_result(3 downto 0) <= out_port1(3 downto 0);
            elsif port_id3(2 downto 0) = "100" and write_strobe1='1' then out_result(7 downto 0) <= out_port1;
            end if;
        end if;
    end process;

saida <= out_result;

end Behavioral;
