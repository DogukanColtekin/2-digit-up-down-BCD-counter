library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity freqdivider_tb is
end freqdivider_tb;

architecture Behavioral of freqdivider_tb is

    -- Component Declaration
    component freqdivider
        Port (
            boardclk     : in  STD_LOGIC;
            enablesignal : out STD_LOGIC
        );
    end component;

    -- Signals
    signal tb_clk          : STD_LOGIC := '0';
    signal tb_enablesignal : STD_LOGIC;

    constant CLK_PERIOD : time := 10 ns;  -- 100 MHz => 10 ns period

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: freqdivider
        port map (
            boardclk     => tb_clk,
            enablesignal => tb_enablesignal
        );

    -- Clock generation (100 MHz)
    clk_process : process
    begin
        while now < 20 ms loop  -- simulate for 20 milliseconds (expect ~2 full enable cycles)
            tb_clk <= '0';
            wait for CLK_PERIOD / 2;
            tb_clk <= '1';
            wait for CLK_PERIOD / 2;
        end loop;
        wait;
    end process;

end Behavioral;