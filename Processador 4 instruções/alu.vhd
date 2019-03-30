LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity alu is 
  port(A_sum,B_sum: in std_logic_vector(15 downto 0);
       alu_en: in std_logic;
		 S_sum: out std_logic_vector(15 downto 0)
  );
end entity;

architecture ckt of alu is 

component somador16b is
 port(Cin0: in std_logic;
		A5,B5: in std_logic_vector(15 downto 0);
		S5: out std_logic_vector(15 downto 0));
end component;

signal doorA,doorB: std_logic_vector(15 downto 0);
begin 

with alu_en select
  doorA <= A_sum when '1',
			"0000000000000000" when others;
with alu_en select
  doorB <= B_sum when '1',
         "0000000000000000" when others;

soma:somador16b port map(
A5 => doorA,
B5 => doorB,
cin0 => '0',
S5 => S_Sum);	
	
end ckt;
	