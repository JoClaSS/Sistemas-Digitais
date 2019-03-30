library ieee;
use ieee.std_logic_1164.all;

entity enable is
 port(D: in std_logic_vector(3 downto 0);
      En: in std_logic;
		Door: out std_logic_vector(3 downto 0)
 );
end entity;

architecture ckt of enable is

 begin
 
 Door(0) <= D(0) and En;
 Door(1) <= D(1) and En;
 Door(2) <= D(2) and En;
 Door(3) <= D(3) and En;
 
end ckt;