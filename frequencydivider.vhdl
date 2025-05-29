library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity freqdivider is
    Port (
        boardclk     : in  STD_LOGIC;
        enablesignal : out STD_LOGIC
    );
end freqdivider;

architecture Dataflow of freqdivider is
    signal counter      : unsigned(24 downto 0) := (others => '0');
    signal enable_reg   : STD_LOGIC := '0';
begin

    counter_logic: 
    process(boardclk)
    begin
        if rising_edge(boardclk) then
            if counter = 24999 then
                counter    <= (others => '0');
                enable_reg <= not enable_reg;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    enablesignal <= enable_reg;

end Dataflow;

