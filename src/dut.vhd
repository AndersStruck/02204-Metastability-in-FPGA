----------------------------------------------------------------------------------
-- Author: Anders Struck - s143217@student.dtu.dk
-- Author: Jacob Jessen - s153427@student.dtu.dk
-- 
-- Create Date: 21.04.2020
-- Design Name: 
-- Module Name: dut - Device under test
-- Project Name: 02204 Design of Asynchronous circuits - Metastability testing in FPGA
-- Description: The decice under test for metastability is labeled 'dut'. 
--              count_en will be high for one clock cycle if 'dut' was metastable when d3 was clocked on the falling edge of clk.
-- 
-- Git reposotory:
-- https://github.com/AndersStruck/02204-Metastability-in-FPGA
--
-- Revision:
-- Revision 0.01 - 21.04.2020 - File Created
-- Revision 0.10 - 21.04.2020 - First implementation
-- Revision 0.50 - 04.05.2020 - Changed reset to active low.
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity dut is
    Port ( clk 		: in STD_LOGIC;
           resetn 	: in STD_LOGIC;
           data 	: in STD_LOGIC;
           count_en	: out STD_LOGIC);
end dut;

architecture Behavioral of dut is
    signal dut, d2, d3, d4, d4_next : STD_LOGIC;
begin
    
    d4_next <= d2 XOR d3;
    count_en <= d4;
    process( clk, resetn ) begin
        if resetn='0' then
            dut         <= '0';
            d2      	<= '0';
        elsif rising_edge(clk) then
            dut         <= data;
            d2          <= dut;
        end if;
    end process;
    
    process( clk, resetn ) begin
        if resetn='0' then
            d3      	<= '0';
            d4          <= '0';
        elsif falling_edge(clk) then
            d3          <= dut;
            d4          <= d4_next;
        end if;
    end process;

end Behavioral;
