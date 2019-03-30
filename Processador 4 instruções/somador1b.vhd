library ieee;
use ieee.std_logic_1164.all;

entity somador1b is
 port(A,B,Cin: in std_logic;
      S,Co: out std_logic);
end somador1b;

architecture ckt of somador1b is
 begin
  S <= (A xor B) xor Cin;
  Co <= (A and B) or (A and Cin) or (B and Cin);
end ckt; 