-- Versão Funcionando
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SoC is
    Port (  
              clk :  in STD_LOGIC;
              rst :  in STD_LOGIC;
                x :  in STD_LOGIC_VECTOR (6 downto 0);
               an : out STD_LOGIC_VECTOR (3 downto 0);
              seg : out STD_LOGIC_VECTOR (7 downto 0);
            saida : out STD_LOGIC_VECTOR(11 downto 0));
end SoC;

architecture Behavioral of SoC is
    
    component kcpsm6 
    generic(                 
                             hwbuild : STD_LOGIC_VECTOR(7 downto 0) := X"00";
                    interrupt_vector : STD_LOGIC_VECTOR(11 downto 0) := X"3FF";
             scratch_pad_memory_size : integer := 64);
    port (                   
                             address : out STD_LOGIC_VECTOR(11 downto 0);
                         instruction :  in STD_LOGIC_VECTOR(17 downto 0);
                         bram_enable : out STD_LOGIC;
                             in_port :  in STD_LOGIC_VECTOR(7 downto 0);
                            out_port : out STD_LOGIC_VECTOR(7 downto 0);
                             port_id : out STD_LOGIC_VECTOR(7 downto 0);
                        write_strobe : out STD_LOGIC;
                      k_write_strobe : out STD_LOGIC;
                         read_strobe : out STD_LOGIC;
                           interrupt :  in STD_LOGIC;
                       interrupt_ack : out STD_LOGIC;
                               sleep :  in STD_LOGIC;
                               reset :  in STD_LOGIC;
                                 clk :  in STD_LOGIC);
    end component;
    
    component mult                             
        generic(    
                             C_FAMILY : string := "7S"; 
                    C_RAM_SIZE_KWORDS : integer := 2;
                 C_JTAG_LOADER_ENABLE : integer := 0);
        Port (      
                    address :  in STD_LOGIC_VECTOR(11 downto 0);
                instruction : out STD_LOGIC_VECTOR(17 downto 0);
                     enable :  in STD_LOGIC;
                        rdl : out STD_LOGIC;                    
                        clk :  in STD_LOGIC);
    end component;
      
    component somador                             
        generic(    
                             C_FAMILY : string := "7S"; 
                    C_RAM_SIZE_KWORDS : integer := 2;
                 C_JTAG_LOADER_ENABLE : integer := 0);
        Port (      
                    address : in STD_LOGIC_VECTOR(11 downto 0);
                instruction : out STD_LOGIC_VECTOR(17 downto 0);
                     enable : in STD_LOGIC;
                        rdl : out STD_LOGIC;                    
                        clk : in STD_LOGIC);
    end component;
      
    component shift                             
        generic(    
                             C_FAMILY : string := "7S"; 
                    C_RAM_SIZE_KWORDS : integer := 2;
                 C_JTAG_LOADER_ENABLE : integer := 0);
        Port (      
                    address : in STD_LOGIC_VECTOR(11 downto 0);
                instruction : out STD_LOGIC_VECTOR(17 downto 0);
                     enable : in STD_LOGIC;
                        rdl : out STD_LOGIC;                    
                        clk : in STD_LOGIC);
    end component;
    
    component bin7seg_mux_anodo is
        Port ( 
               in12bits :  in  STD_LOGIC_VECTOR (11 downto 0);
                clock   :  in  STD_LOGIC;
                reset   :  in  STD_LOGIC;
                anodo   : out  STD_LOGIC_VECTOR (3 downto 0);
                RES     : out  STD_LOGIC_VECTOR (7 downto 0));
    end component;

signal         address1 : STD_LOGIC_VECTOR(11 downto 0) :=(others => '0');
signal     instruction1 : STD_LOGIC_VECTOR(17 downto 0) :=(others => '0');
signal     bram_enable1 : STD_LOGIC := '0';
signal         in_port1 : STD_LOGIC_VECTOR(7 downto 0) :=(others => '0');
signal        out_port1 : STD_LOGIC_VECTOR(7 downto 0) :=(others => '0');
signal         port_id1 : STD_LOGIC_VECTOR(7 downto 0) :=(others => '0');
signal    write_strobe1 : STD_LOGIC := '0';
signal  k_write_strobe1 : STD_LOGIC := '0';
signal     read_strobe1 : STD_LOGIC := '0';
signal       interrupt1 : STD_LOGIC := '0';
signal   interrupt_ack1 : STD_LOGIC := '0';
signal    kcpsm6_sleep1 : STD_LOGIC := '0';
signal    kcpsm6_reset1 : STD_LOGIC := '0';
signal             rdl1 : STD_LOGIC := '0';

signal         address2 : STD_LOGIC_VECTOR(11 downto 0) :=(others => '0');
signal     instruction2 : STD_LOGIC_VECTOR(17 downto 0) :=(others => '0');
signal     bram_enable2 : STD_LOGIC := '0';
signal         in_port2 : STD_LOGIC_VECTOR(7 downto 0) :=(others => '0');
signal        out_port2 : STD_LOGIC_VECTOR(7 downto 0) :=(others => '0');
signal         port_id2 : STD_LOGIC_VECTOR(7 downto 0) :=(others => '0');
signal    write_strobe2 : STD_LOGIC := '0';
signal  k_write_strobe2 : STD_LOGIC := '0';
signal     read_strobe2 : STD_LOGIC := '0';
signal       interrupt2 : STD_LOGIC := '0';
signal   interrupt_ack2 : STD_LOGIC := '0';
signal    kcpsm6_sleep2 : STD_LOGIC := '0';
signal    kcpsm6_reset2 : STD_LOGIC := '0';
signal             rdl2 : STD_LOGIC := '0';

signal         address3 : STD_LOGIC_VECTOR(11 downto 0) :=(others => '0');
signal     instruction3 : STD_LOGIC_VECTOR(17 downto 0) :=(others => '0');
signal     bram_enable3 : STD_LOGIC := '0';
signal         in_port3 : STD_LOGIC_VECTOR(7 downto 0) :=(others => '0');
signal        out_port3 : STD_LOGIC_VECTOR(7 downto 0) :=(others => '0');
signal         port_id3 : STD_LOGIC_VECTOR(7 downto 0) :=(others => '0');
signal    write_strobe3 : STD_LOGIC := '0';
signal  k_write_strobe3 : STD_LOGIC := '0';
signal     read_strobe3 : STD_LOGIC := '0';
signal       interrupt3 : STD_LOGIC := '0';
signal   interrupt_ack3 : STD_LOGIC := '0';
signal    kcpsm6_sleep3 : STD_LOGIC := '0';
signal    kcpsm6_reset3 : STD_LOGIC := '0';
signal             rdl3 : STD_LOGIC := '0';

signal         out_mult  : STD_LOGIC_VECTOR(11 downto 0);
signal         out_soma  : STD_LOGIC_VECTOR(11 downto 0);
signal         out_shift : STD_LOGIC_VECTOR(11 downto 0);

begin

kcpsm6_reset1 <= rdl1 or rst;
kcpsm6_reset2 <= rdl2 or rst;
kcpsm6_reset3 <= rdl3 or rst;

processor1: kcpsm6
    generic map (                 hwbuild => X"00", 
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
                     reset => kcpsm6_reset1,
                       clk => clk);
                       
processor2: kcpsm6
    generic map (                 hwbuild => X"00", 
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
                     reset => kcpsm6_reset2,
                       clk => clk);

processor3: kcpsm6
    generic map (                 hwbuild => X"00", 
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
                     reset => kcpsm6_reset3,
                       clk => clk);

program_rom1: mult
    generic map(             C_FAMILY => "7S",
                    C_RAM_SIZE_KWORDS => 2,   
                 C_JTAG_LOADER_ENABLE => 0)    
    port map(      address => address1,      
               instruction => instruction1,
                    enable => bram_enable1,
                       rdl => rdl1,
                       clk => clk);

program_rom2: somador
    generic map(             C_FAMILY => "7S",   
                    C_RAM_SIZE_KWORDS => 2,      
                 C_JTAG_LOADER_ENABLE => 0)       
    port map(      address => address2,      
               instruction => instruction2,
                    enable => bram_enable2,
                       rdl => rdl2,
                       clk => clk);

program_rom3: shift
    generic map(             C_FAMILY => "7S",   
                    C_RAM_SIZE_KWORDS => 2,      
                 C_JTAG_LOADER_ENABLE => 0)       
    port map(      address => address3,      
               instruction => instruction3,
                    enable => bram_enable3,
                       rdl => rdl3,
                       clk => clk);

inputs:process(clk)
begin
    if RISING_EDGE(clk) then
        if port_id1(1 downto 0) = "01" and read_strobe1='1' then in_port1 <= "00" & x(5 downto 0);           end if; 

        if port_id2(1 downto 0) = "10" and read_strobe2='1' then in_port2 <= out_mult(7 downto 0);           end if;
        if port_id2(1 downto 0) = "01" and read_strobe2='1' then in_port2 <= "0000" & out_mult(11 downto 8); end if;

        if port_id3(1 downto 0) = "10" and read_strobe3='1' then in_port3 <= out_soma(7 downto 0);           end if;
        if port_id3(1 downto 0) = "01" and read_strobe3='1' then in_port3 <= "0000" & out_soma(11 downto 8); end if;        
        if port_id3(2 downto 0) = "101" and read_strobe3='1' then in_port3 <= "0000000" & x(6); end if;        
    end if;
end process;
 
outputs:process(clk)
begin
    if RISING_EDGE(clk) then
        if port_id1(1 downto 0) = "10"  and write_strobe1='1' then out_mult(7 downto 0) <= out_port1;                 end if; -- LSB 
        if port_id1(1 downto 0) = "11"  and write_strobe1='1' then out_mult(11 downto 8) <= out_port1(3 downto 0);    end if; -- MSB 
        
        if port_id2(1 downto 0) = "11"  and write_strobe2='1' then out_soma(7 downto 0) <= out_port2;                end if; -- LSB
        if port_id2(2 downto 0) = "100" and write_strobe2='1' then out_soma(11 downto 8) <= out_port2(3 downto 0);   end if; -- MSB

        if port_id3(1 downto 0) = "11"  and write_strobe3='1' then out_shift(7 downto 0) <= out_port3;               end if; -- LSB
        if port_id3(2 downto 0) = "100" and write_strobe3='1' then out_shift(11 downto 8) <= out_port3(3 downto 0);  end if; -- MSB
    end if;
end process;                       

saida <= out_shift;

decoder: bin7seg_mux_anodo 
            port map (  in12bits => out_soma,
                         clock   => clk,
                         reset   => rst,
                         anodo   => an,
                         RES     => seg);
end Behavioral;