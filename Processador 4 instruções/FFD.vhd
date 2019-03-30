library ieee;
use ieee.std_logic_1164.all;

entity FFD is
	port(clk,D,P,C:in std_logic;
		q:out std_logic);
end FFD;
architecture ckt of FFD is

signal qS:std_logic;

begin 
	process(clk,P,C)
	begin
	if P = '0' then qS <= '1';
	elsif C='0' then qS<='0';
	elsif clk='1' and clk'event then
		qS<=D;
	end if;
	end process;
	q<=qS;
end ckt;