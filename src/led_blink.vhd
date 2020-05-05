----------------------------------------------------------------------------------
-- Author: Anders Struck - s143217@student.dtu.dk
-- Author: Jacob Jessen - s153427@student.dtu.dk
-- 
-- Create Date: 03.05.2020
-- Design Name: 
-- Module Name: led_blink
-- Project Name: 02204 Design of Asynchronous circuits - Metastability testing in FPGA
-- Description: The status led blinker is used to indicate that the system is running.
-- 				The period of the LED, is set using the count_max generic.
-- 
-- Git reposotory:
-- https://github.com/AndersStruck/02204-Metastability-in-FPGA
--
-- Revision:
-- Revision 0.01 - 03.05.2020 - File Created
-- Revision 0.10 - 04.05.2020 - First implementation
-- Revision 0.20 - 04.05.2020 - Changed reset to active low
-- Revision 0.50 - 04.05.2020 - Changed period of blink to match the 100MHz clock
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity led_blink is
    Port ( clk	   	: in STD_LOGIC;
           resetn	: in STD_LOGIC;
           blink	: out STD_LOGIC);
end led_blink;

architecture Behavioral of led_blink is
    constant max_count : natural := 100000000; 
begin

    process(clk,resetn) 
        variable count : natural range 0 to max_count;
    begin
        if resetn='0' then
            count := 0;
            blink <= '1';
        elsif rising_edge(clk) then
            if count < max_count then
            	count := count + 1;
            else
                blink <= '1';
                count := 0;
            end if;
            if count < max_count/2 then
					blink <= '1';
			else
					blink <= '0';
			end if;
        end if;
    end process;

end Behavioral;
