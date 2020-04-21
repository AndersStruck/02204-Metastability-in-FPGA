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
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity counter is
    Port ( clk      : in STD_LOGIC;
           reset    : in STD_LOGIC;
           EN       : in STD_LOGIC;
           count    : out STD_LOGIC_VECTOR (0 to 9));
end counter;

architecture Behavioral of counter is
    signal val, reg : unsigned(0 to 9);
    
begin
    count   <= std_logic_vector(reg);
    val     <= reg + 1;
    
    process(clk,reset) begin
        if reset='1' then
            reg <= (others => '0');
        elsif rising_edge(clk) then
            if EN='1' then
                reg <= val;
            end if;
        end if;
    end process;

end Behavioral;
