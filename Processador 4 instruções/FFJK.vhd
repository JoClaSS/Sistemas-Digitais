library ieee;
use ieee.std_logic_1164.all;

entity FFJK is
 port(clk,J,K,P,C:in std_logic;
   q:out std_logic);
end FFJK;

architecture ckt of FFJK is

signal qS: std_logic;

begin

 process(clk,P,C)
 begin
  if P='0' then qS<='1';
  elsif C='0' then qS<='0';
  elsif clk='1' and clk'event then
   if J='1' and K='1' then qS <= not qS;
   elsif J='1' and K='0' then qS<='1';
   elsif J='0' and K='1' then qS<='0';
    end if;
  end if;
 end process;
 q<=qS;
end ckt;