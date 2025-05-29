library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bittobcd is
    Port (
        binary_in : in STD_LOGIC_VECTOR(7 downto 0);
        bcd_out : out std_logic_vector(7 downto 0)
    );
end bittobcd;



architecture Behavioral of bittobcd is
begin
    process(binary_in)
        variable bitsholder : STD_LOGIC_VECTOR(19 downto 0);
    begin
        bitsholder := (others => '0');
        bitsholder(7 downto 0) := binary_in;

        for i in 0 to 7 loop
            if bitsholder(19 downto 16) > "0100" then
                bitsholder(19 downto 16) := bitsholder(19 downto 16) + "0011";
            end if;
            if bitsholder(15 downto 12) > "0100" then
                bitsholder(15 downto 12) := bitsholder(15 downto 12) + "0011";
            end if;
            if bitsholder(11 downto 8) > "0100" then
                bitsholder(11 downto 8) := bitsholder(11 downto 8) + "0011";
            end if;
            bitsholder := bitsholder(18 downto 0) & '0';
        end loop;

        bcd_out <= bitsholder(15 downto 8);  -- 2 BCD digits
    end process;
end Behavioral;