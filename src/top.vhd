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
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( CLK100MHZ 	: in STD_LOGIC;
           reset 		: in STD_LOGIC;
           data 		: in STD_LOGIC;
           LED		: out STD_LOGIC_VECTOR (0 to 9));
end top;

architecture Behavioral of top is
    component dut is
        Port ( clk 		: in STD_LOGIC;
			   reset 	: in STD_LOGIC;
           	   data 	: in STD_LOGIC;
           	   count_en	: out STD_LOGIC);
    end component;
    
    component counter is
		Port ( clk 		: in STD_LOGIC;
			   reset 	: in STD_LOGIC;
			   EN 		: in STD_LOGIC;
			   count 	: out STD_LOGIC_VECTOR (0 to 9));
    end component;
    
    signal count_enable : STD_LOGIC;
begin
    
    dut_1 : dut port map(
        clk         => CLK100MHZ,
        reset       => reset,
        data        => data,
        count_en    => count_enable
    );
    
    counter_1 : counter port map(
        clk         => CLK100MHZ,
        reset       => reset,
        EN          => count_enable,
        count       => LED
    );
    
end Behavioral;
