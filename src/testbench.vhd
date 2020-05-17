  ----------------------------------------------------------------------------------
-- Author: Anders Struck - s143217@student.dtu.dk
-- Author: Jacob Jessen - s153427@student.dtu.dk
-- 
-- Create Date: 21.04.2020
-- Design Name: 
-- Module Name: Testbench
-- Project Name: 02204 Design of Asynchronous circuits - Metastability testing in FPGA
-- Description: Top level module.
-- 
-- Git reposotory:
-- https://github.com/AndersStruck/02204-Metastability-in-FPGA
--
-- Revision:
-- Revision 0.01 - 21.04.2020 - File Created
-- Revision 0.10 - 21.04.2020 - First implementation
-- Revision 0.20 - 04.05.2020 - Changed reset to be active low
-- Revision 0.30 - 04.05.2020 - Updated top component with status output
-- Revision 0.50 - 12.05.2020 - Changed Endian of LEDS
-- 
----------------------------------------------------------------------------------
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
           resetn		: in STD_LOGIC;
           r_osc		: out STD_LOGIC;
           status		: out STD_LOGIC;
           LED      	: out STD_LOGIC_VECTOR ( 15 downto 0));
	end COMPONENT;
	
	-- Internal clock signal
	SIGNAL clk, resetn: std_logic;
	SIGNAL LED: STD_LOGIC_VECTOR ( 15 downto 0);
	SIGNAL r_osc, status : STD_LOGIC;
BEGIN
    -- assert reset, note that reset is active low
    resetn <= '0', '1' after 10 ns;
    
	-- Clock generation (simulation use only)
    PROCESS
    BEGIN
        clk <= '1', '0' AFTER period/2;
        WAIT FOR period;
    END PROCESS;

    top_1  : top PORT MAP ( CLK100MHZ 	=> clk,
						   resetn 		=> resetn,
						   r_osc  		=> r_osc,
						   status		=> status,
						   LED			=> LED);
	END structure;
