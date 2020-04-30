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
-- 
----------------------------------------------------------------------------------
-- The Unisim Library is used to define Xilinx primitives. It is also used during
-- simulation. The source can be viewed at %XILINX%\vhdl\src\unisims\unisim_VCOMP.vhd
--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library unisim;
use unisim.vcomponents.all;
--
------------------------------------------------------------------------------------
--
-- Main Entity for ring_osc
--
entity ring_osc is
  port(   ro_out : out std_logic;
            reset : in std_logic   );
  end ring_osc;
--
------------------------------------------------------------------------------------
--
-- Start of Main Architecture for ring_osc
--     
architecture low_level_definition of ring_osc is
--
------------------------------------------------------------------------------------
--
-- Signals used in RING_OSC
--
------------------------------------------------------------------------------------
--
signal ring_delay1      : std_logic;
signal ring_delay2      : std_logic;
signal ring_delay3      : std_logic;
signal ring_delay4      : std_logic;
signal ring_delay5      : std_logic;
signal ring_delay6      : std_logic;
signal ring_invert      : std_logic;
signal toggle           : std_logic;
signal clk_div2         : std_logic;

signal resetn : std_logic;

-- The following constants are defined to allow for
--   equation-based INIT specification for a LUT2.
constant I0 : BIT_VECTOR(3 downto 0) := X"A";
constant I1 : BIT_VECTOR(3 downto 0) := X"C";

--
-- Attributes to stop delay logic from being optimised.
--
attribute KEEP : string; 
attribute KEEP of ring_delay1 		: signal is "true"; 
attribute KEEP of ring_delay2 		: signal is "true"; 
attribute KEEP of ring_delay3 		: signal is "true"; 
attribute KEEP of ring_delay4 		: signal is "true"; 
attribute KEEP of ring_delay5 		: signal is "true"; 
attribute KEEP of ring_delay6 		: signal is "true";
attribute KEEP of ring_invert 		: signal is "true";
--
-- Attributes to stop delay logic from being optimised.
--
attribute DONT_TOUCH : string;
attribute DONT_TOUCH of ring_delay1 : signal is "true";
attribute DONT_TOUCH of ring_delay2 : signal is "true";
attribute DONT_TOUCH of ring_delay3 : signal is "true";
attribute DONT_TOUCH of ring_delay4 : signal is "true";
attribute DONT_TOUCH of ring_delay5 : signal is "true";
attribute DONT_TOUCH of ring_delay6 : signal is "true";
attribute DONT_TOUCH of ring_invert : signal is "true";
--
------------------------------------------------------------------------------------
--    
-- Circuit description
--
------------------------------------------------------------------------------------
--    
begin
	ro_out <= ring_invert;
	resetn <= NOT reset;

	--
	--Ring oscillator is formed of 5 levels of logic of which one is an inverter.
	--
	
	delay1_lut: LUT2 generic map (
		INIT => I1 AND I0)
		port map( 	I0 	=> resetn,
					I1 	=> ring_invert,
			 		O 	=> ring_delay1 );
	
	delay2_lut: LUT2 generic map (
		INIT => I1 AND I0)
		port map( 	I0 	=> resetn,
					I1 	=> ring_delay1,
			 		O 	=> ring_delay2 );
	
	delay3_lut: LUT2 generic map (
		INIT => I1 AND I0) 
		port map( 	I0 	=> resetn,
					I1 	=> ring_delay2,
			 		O 	=> ring_delay3 );
	
	delay4_lut: LUT2 generic map (
		INIT => I1 AND I0)
		port map( 	I0 	=> resetn,
					I1	=> ring_delay3,
				 	O 	=> ring_delay4 );
	
	
	delay5_lut: LUT2 generic map (
		INIT => I1 AND I0)
		port map( 	I0 	=> resetn,
					I1 	=> ring_delay4,
			 		O 	=> ring_delay5 );
			 
	delay6_lut: LUT2 generic map (
		INIT => I1 AND I0)
		port map( 	I0 	=> resetn,
					I1 	=> ring_delay5,
					O 	=> ring_delay6 );
	
	ring_invert <= not ring_delay6;
	
end low_level_definition;