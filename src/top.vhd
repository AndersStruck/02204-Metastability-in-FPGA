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
-- Revision 0.20 - 04.05.2020 - Added With Ring Oscilator
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( CLK100MHZ: in STD_LOGIC;
           reset    : in STD_LOGIC;
           r_osc	: out STD_LOGIC;
           LED      : out STD_LOGIC_VECTOR (0 to 9));
end top;

architecture Behavioral of top is
  	signal Ring_oscilator    : STD_LOGIC;
  	signal count_enable, clk : STD_LOGIC;

  	component ring_osc is
  		generic (
   				LUTS 	: Natural := 4);
   		port (  reset   : in std_logic;
            	ro_out  : out std_logic);
  	end component;
  	component clk_wiz_0 is
        Port (  clk_in1 : in STD_LOGIC;
                reset   : in STD_LOGIC;
                clk_out : out STD_LOGIC;
                locked  : out STD_LOGIC);
    end component;
    component dut is
        Port (  clk   	: in STD_LOGIC;
                reset   : in STD_LOGIC;
                data  	: in STD_LOGIC;
                count_en: out STD_LOGIC);
    end component;
    component counter is
    Port (  	clk   	: in STD_LOGIC;
            	reset   : in STD_LOGIC;
            	EN      : in STD_LOGIC;
            	count   : out STD_LOGIC_VECTOR (0 to 9));
    end component;
begin
  	r_osc <= Ring_oscilator;
  
    clk_1 : clk_wiz_0 port map(
        clk_in1     => CLK100MHZ,
        reset     	=> reset,
        clk_out     => clk,
        locked      => open
    );

    ring_1 : ring_osc port map(
        reset       => reset,
        ro_out      => Ring_oscilator
    );
    
    dut_1 : dut port map(
        clk         => clk,
        reset       => reset,
        data        => Ring_oscilator,
        count_en    => count_enable
    );
    
    counter_1 : counter port map(
        clk         => clk,
        reset       => reset,
        EN          => count_enable,
        count       => LED
    );
    
end Behavioral;