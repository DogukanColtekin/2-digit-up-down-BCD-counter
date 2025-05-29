LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;

entity count8 is
 port( D: in std_logic_vector(7 downto 0);
 Q: out std_logic_vector(7 downto 0);
 CLK, pload, u_count, d_count : in std_logic );
end count8;

ARCHITECTURE behavioral OF count8 IS

SIGNAL count : std_logic_vector (7 downto 0):= (others=>'0');
signal pload_prev : std_logic:= '0';
signal u_count_prev : std_logic:= '0';
signal d_count_prev : std_logic:= '0';

BEGIN

my_counter: PROCESS(CLK)

BEGIN
IF rising_edge(CLK) THEN
            
      IF (pload_prev = '1' AND pload = '0') THEN
                count <= D;
            
      ELSIF (u_count_prev = '0' AND u_count = '1') THEN
                count <= count + 1;
					 
      ELSIF (d_count_prev = '0' AND d_count = '1') THEN
                count <= count - 1;
      END IF;

pload_prev   <= pload;
u_count_prev <= u_count;
d_count_prev <= d_count;

END IF;

END PROCESS my_counter;

Q <= count;

END behavioral;