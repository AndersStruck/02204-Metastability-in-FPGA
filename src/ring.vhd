-- Library declarations
--
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

--
-- Attributes to stop delay logic from being optimised.
--
attribute KEEP : string; 
attribute KEEP of ring_delay1 : signal is "true"; 
attribute KEEP of ring_delay2 : signal is "true"; 
attribute KEEP of ring_delay3 : signal is "true"; 
attribute KEEP of ring_delay4 : signal is "true"; 
attribute KEEP of ring_delay5 : signal is "true"; 
attribute KEEP of ring_delay6 : signal is "true";
--
------------------------------------------------------------------------------------
--
-- Attributes to define LUT contents during implementation for primitives not 
-- contained within generate loops. In each case the information is repeated
-- in the generic map for functional simulation
--
attribute INIT : string; 
attribute INIT of div2_lut              : label is "1"; 
attribute INIT of delay1_lut            : label is "4"; 
attribute INIT of delay2_lut            : label is "4"; 
attribute INIT of delay3_lut            : label is "4"; 
attribute INIT of delay4_lut            : label is "4"; 
attribute INIT of delay5_lut            : label is "4"; 
attribute INIT of delay6_lut            : label is "4"; 

attribute INIT of invert_lut            : label is "B"; 
--
------------------------------------------------------------------------------------
--    
-- Circuit description
--
------------------------------------------------------------------------------------
--    
begin
  --
  --Output is the ring oscillator divided by 2 to provide a square wave.
  --
  ro_out <= ring_invert;

  resetn <= NOT reset;

  --
  --Ring oscillator is formed of 5 levels of logic of which one is an inverter.
  --

  delay1_lut: LUT2
  
    generic map (INIT => X"4")
  
  port map( I0 => resetn,
            I1 => ring_invert,
             O => ring_delay1 );

  delay2_lut: LUT2
  
    generic map (INIT => X"4")
  
  port map( I0 => resetn,
            I1 => ring_delay1,
             O => ring_delay2 );

  delay3_lut: LUT2
  
    generic map (INIT => X"4")
  
  port map( I0 => resetn,
            I1 => ring_delay2,
             O => ring_delay3 );

  delay4_lut: LUT2
  
    generic map (INIT => X"4")
  
  port map( I0 => resetn,
            I1 => ring_delay3,
             O => ring_delay4 );


  delay5_lut: LUT2
  
    generic map (INIT => X"4")
  
  port map( I0 => resetn,
            I1 => ring_delay4,
             O => ring_delay5 );
             
  delay6_lut: LUT2
             
               generic map (INIT => X"4")
             
             port map( I0 => resetn,
                       I1 => ring_delay5,
                        O => ring_delay6 );             
             
  invert_lut: LUT2
  
    generic map (INIT => X"B")
  
  port map( I0 => resetn,
            I1 => ring_delay6,
             O => ring_invert );


end low_level_definition;