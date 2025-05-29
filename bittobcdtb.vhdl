library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_bittobcd is

end tb_bittobcd;

architecture behavior of tb_bittobcd is

    
    component bittobcd
        Port(
            binary_in : in STD_LOGIC_VECTOR(7 downto 0);
            bcd_out   : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    
    signal binary_in : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal bcd_out   : STD_LOGIC_VECTOR(7 downto 0);

begin

    uut: bittobcd
        Port map (
            binary_in => binary_in,
            bcd_out   => bcd_out
        );

    stim_proc: process
    begin
       
        binary_in <= "00000000";
        wait for 10 ns;

        
        binary_in <= "00001001";
        wait for 10 ns;

    
        binary_in <= "00001100"; 
        wait for 10 ns;

  
        binary_in <= "00101101"; 
        wait for 10 ns;

        binary_in <= "01100011";  
        wait for 10 ns;

        wait;
    end process;

end behavior;