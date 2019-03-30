library ieee;
use ieee.std_logic_1164.all;

entity muxregistrador is
  port(E00,E01,E10,E11: in std_logic_vector(15 downto 0);
      sel: in std_logic_vector(1 downto 0);
		Sm: out std_logic_vector(15 downto 0)
  );
 end entity;
 
 architecture ckt of muxregistrador is
  begin
  with sel select 
    Sm <= E00 when "00",
	       E01 when "01",
			 E10 when "10",
			 E11 when "11";
 end ckt;
 