LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY testbench IS
	GENERIC(
      period: TIME := 10 ns);
END testbench;


ARCHITECTURE structure OF testbench IS
	COMPONENT top is
    Port ( CLK100MHZ  	: in STD_LOGIC;
           reset		: in STD_LOGIC;
           r_osc		: out STD_LOGIC;
           LED      	: out STD_LOGIC_VECTOR (0 to 9));
	end COMPONENT;
	
	-- Internal clock signal
	SIGNAL clk, reset: std_logic;
	SIGNAL LED: STD_LOGIC_VECTOR(9 downto 0);
	SIGNAL r_osc : STD_LOGIC;
BEGIN
    -- assert reset, note that reset is active high
    reset <= '1', '0' after 10 ns;
    
	-- Clock generation (simulation use only)
    PROCESS
    BEGIN
        clk <= '1', '0' AFTER period/2;
        WAIT FOR period;
    END PROCESS;

    top_1  : top PORT MAP ( CLK100MHZ => clk,
						   reset 	=> reset,
						   r_osc  	=> r_osc,
						   LED		=> LED );
		
	END structure;
