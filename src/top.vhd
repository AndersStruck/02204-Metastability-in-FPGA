  ----------------------------------------------------------------------------------
-- Author: Anders Struck - s143217@student.dtu.dk
-- Author: Jacob Jessen - s153427@student.dtu.dk
-- 
-- Create Date: 21.04.2020
-- Design Name: 
-- Module Name: top level module
-- Project Name: 02204 Design of Asynchronous circuits - Metastability testing in FPGA
-- Description: Top level module.
-- 
-- Git reposotory:
-- https://github.com/AndersStruck/02204-Metastability-in-FPGA
--
-- Revision:
-- Revision 0.01 - 21.04.2020 - File Created
-- Revision 0.10 - 21.04.2020 - First implementation
-- Revision 0.20 - 03.05.2020 - Added With Ring Oscilator
-- Revision 0.30 - 04.05.2020 - Added status LED
-- Revision 0.50 - 04.05.2020 - Changed reset level to active low.
--							  - Changed ENDIAN of LEDs.
--							  - Added counter overflow indicator
-- Revision 0.90 - 12.05.2020 - Added the clock output
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( CLK100MHZ: in STD_LOGIC;
           resetn   : in STD_LOGIC;
           r_osc	: out STD_LOGIC;
           status	: out STD_LOGIC;
           count_ovf: out STD_LOGIC;
           clk_out	: out STD_LOGIC;
           LED      : out STD_LOGIC_VECTOR ( 15 downto 0));
end top;

architecture Behavioral of top is
  	signal Ring_oscilator    : STD_LOGIC;
  	signal count_enable, clk : STD_LOGIC;
	
	component led_blink is
    	Port ( 	clk	   	: in STD_LOGIC;
           		resetn	: in STD_LOGIC;
           		blink	: out STD_LOGIC);
	end component;
  	component ring_osc is
  		generic (
   				LUTS 	: Natural := 10);
   		Port (  resetn  : in std_logic;
            	ro_out  : out std_logic);
  	end component;
  	component clk_wiz_0 is
        Port (  clk_in1 : in STD_LOGIC;
                resetn  : in STD_LOGIC;
                clk_out : out STD_LOGIC;
                locked  : out STD_LOGIC);
    end component;
    component dut is
        Port (  clk   	: in STD_LOGIC;
                resetn  : in STD_LOGIC;
                data  	: in STD_LOGIC;
                count_en: out STD_LOGIC);
    end component;
    component counter is
		generic (
   				BITS 	: Integer := 16);
    	Port ( 	clk		: in STD_LOGIC;
           		resetn	: in STD_LOGIC;
           		EN		: in STD_LOGIC;
           		overflow: out STD_LOGIC;
           		count	: out STD_LOGIC_VECTOR (BITS-1 downto 0));
    end component;
begin
  	r_osc <= Ring_oscilator;
  	clk_out <= clk;
    clk_1 : clk_wiz_0 port map(
        clk_in1     => CLK100MHZ,
        resetn     	=> resetn,
        clk_out     => clk,
        locked      => open
    );

    ring_1 : ring_osc port map(
        resetn      => resetn,
        ro_out      => Ring_oscilator
    );
    
    dut_1 : dut port map(
        clk         => clk,
        resetn      => resetn,
        data        => Ring_oscilator,
        count_en    => count_enable
    );
    
    counter_1 : counter port map(
        clk         => clk,
        resetn      => resetn,
        EN          => count_enable,
        overflow	=> count_ovf,
        count       => LED
    );
    
    status_1: led_blink port map(
    	clk 		=> CLK100MHZ,
    	resetn 		=> resetn,
    	blink		=> status
    );
    
end Behavioral;