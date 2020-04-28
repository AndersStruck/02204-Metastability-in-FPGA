library ieee;
use ieee.std_logic_1164.all;

-- 5 Ring Oscillator

entity ring_osc is
    port (ro_en : in std_logic;
            reset : in std_logic;
            ro_out : out std_logic);
end ring_osc;

architecture behavioral of ring_osc is
    signal delay : time := 0.5 ns;
    signal gate_out : std_logic_vector(5 downto 0) := (others => '0');

begin
    process
    begin
        gate_out(0) <= ro_en and gate_out(5);
        wait for delay;
        gate_out(1) <= not(gate_out(0));
        wait for delay;
        gate_out(2) <= not(gate_out(1));
        wait for delay;
        gate_out(3) <= not(gate_out(2));
        wait for delay;
        gate_out(4) <= not(gate_out(3));
        wait for delay;
        gate_out(5) <= not(gate_out(4));
        wait for delay;
        ro_out <= gate_out(5);
    end process;

end behavioral;