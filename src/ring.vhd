  ----------------------------------------------------------------------------------
-- Author: Anders Struck - s143217@student.dtu.dk
-- Author: Jacob Jessen - s153427@student.dtu.dk
-- 
-- Create Date: 21.04.2020
-- Design Name: 
-- Module Name: Ring Oscilator
-- Project Name: 02204 Design of Asynchronous circuits - Metastability testing in FPGA
-- Description: Ring oscilator used to generate uncorrolated data for testing in the DUT module.
-- 
-- Git reposotory:
-- https://github.com/AndersStruck/02204-Metastability-in-FPGA
--
-- Revision:
-- Revision 0.01 - 21.04.2020 - File Created
-- Revision 0.10 - 21.04.2020 - First implementation
-- Revision 0.20 - 04.05.2020 - Changed to for-generate method for generating the delay LUTS
-- 
----------------------------------------------------------------------------------
-- The Unisim Library is used to define Xilinx primitives. It is also used during
-- simulation. The source can be viewed at %XILINX%\vhdl\src\unisims\unisim_VCOMP.vhd
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library unisim;
use unisim.vcomponents.all;

entity ring_osc is
	generic (
   			LUTS 	: Natural := 10);		-- neutral = 0 to Integer'high
  	port(   ro_out 	: out std_logic;
            reset 	: in std_logic   );
end ring_osc;

architecture low_level_definition of ring_osc is
	signal ring_delay	: std_logic_vector(LUTS downto 0);
	signal resetn 		: std_logic;
	
	-- The following constants are defined to allow for
	--   equation-based INIT specification for a LUT2.
	constant I0 : BIT_VECTOR(3 downto 0) := X"A";
	constant I1 : BIT_VECTOR(3 downto 0) := X"C";
	
	-- Attributes to stop delay logic from being optimised.
	attribute KEEP : string; 
	attribute KEEP of ring_delay 		: signal is "true";
	attribute DONT_TOUCH : string;
	attribute DONT_TOUCH of ring_delay 	: signal is "true";

begin
	resetn <= NOT reset;
	-- The Ring oscilator is generated from the generic LUTS
	delay_generator:
   	for i in 0 to LUTS-1 generate
      	begin
        delay: LUT2 generic map (
		INIT => I1 AND I0)
		port map( 	I0 	=> resetn,
					I1 	=> ring_delay(i),
			 		O 	=> ring_delay(i+1) );
   	end generate;
   	-- A not component is used as the last element in the ring
	ring_delay(0) <= not ring_delay(LUTS);
	ro_out <= ring_delay(0);
end low_level_definition;