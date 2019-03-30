library ieee;
use ieee.std_logic_1164.all;

entity somador16b is
 port(Cin0: in std_logic;
		A5,B5: in std_logic_vector(15 downto 0);
		S5: out std_logic_vector(15 downto 0));
end somador16b;

architecture ckt of somador16b is
signal S5S,C: std_logic_vector(15 downto 0);

component somador1b is
 port(A,B,Cin: in std_logic;
      S,Co: out std_logic);
end component;
begin

soma1: somador1b port map(A5(0),B5(0),Cin0,S5S(0),C(0));
soma2: somador1b port map(A5(1),B5(1),C(0),S5S(1),C(1));
soma3: somador1b port map(A5(2),B5(2),C(1),S5S(2),C(2));
soma4: somador1b port map(A5(3),B5(3),C(2),S5S(3),C(3));
soma5: somador1b port map(A5(4),B5(4),C(3),S5S(4),C(4));
soma6: somador1b port map(A5(5),B5(5),C(4),S5S(5),C(5));
soma7: somador1b port map(A5(6),B5(6),C(5),S5S(6),C(6));
soma8: somador1b port map(A5(7),B5(7),C(6),S5S(7),C(7));
soma9: somador1b port map(A5(8),B5(8),C(7),S5S(8),C(8));
soma10: somador1b port map(A5(9),B5(9),C(8),S5S(9),C(9));
soma11: somador1b port map(A5(10),B5(10),C(9),S5S(10),C(10));
soma12: somador1b port map(A5(11),B5(11),C(10),S5S(11),C(11));
soma13: somador1b port map(A5(12),B5(12),C(11),S5S(12),C(12));
soma14: somador1b port map(A5(13),B5(13),C(12),S5S(13),C(13));
soma15: somador1b port map(A5(14),B5(14),C(13),S5S(14),C(14));
soma16: somador1b port map(A5(15),B5(15),C(14),S5S(15),C(15));
S5 <= S5S;

end ckt;
      