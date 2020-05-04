----------------------------------------------------------------------------------
-- Author: Anders Struck - s143217@student.dtu.dk
-- Author: Jacob Jessen - s153427@student.dtu.dk
-- 
-- Create Date: 21.04.2020
-- Design Name: 
-- Module Name: counter
-- Project Name: 02204 Design of Asynchronous circuits - Metastability testing in FPGA
-- Description: The counter increments by one every time EN is high.
-- 
-- Git reposotory:
-- https://github.com/AndersStruck/02204-Metastability-in-FPGA
--
-- Revision:
-- Revision 0.01 - 21.04.2020 - File Created
-- Revision 0.10 - 21.04.2020 - First implementation
-- Revision 0.50 - 04.05.2020 - Changed to 16 bit counter.
-- Revision 0.80 - 04.05.2020 - Added overflow indicator.
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity counter is
	generic (
   			BITS 	: Integer := 16);
    Port ( 	clk		: in STD_LOGIC;
           	resetn	: in STD_LOGIC;
           	EN		: in STD_LOGIC;
           	overflow: out STD_LOGIC;
           	count	: out STD_LOGIC_VECTOR (BITS-1 downto 0));
end counter;

architecture Behavioral of counter is
    signal val, reg : unsigned(BITS-1 downto 0);
    signal overFl	: std_logic;
begin
    count   <= std_logic_vector(reg);
    val     <= reg + 1;
    overflow <= overFl;
    process(clk,resetn) begin
        if resetn='0' then
            reg <= (others => '0');
            overFl <= '0';
        elsif rising_edge(clk) then
        	overFl 	<= overFl;
            if EN='1' then
            	reg <= val;
            	if val = 0 then
            		overFl <= '1';
                end if;
            end if;
        end if;
    end process;

end Behavioral;
