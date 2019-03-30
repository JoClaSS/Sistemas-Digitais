library ieee;
use ieee.std_logic_1164.all;

entity contador is
 port(clkcont,clrcont,En:in std_logic;
      cont:out std_logic_vector (3 downto 0));
 end contador;
 
 architecture ckt of contador is
  
  component FFJK is
    port(clk,J,K,P,C:in std_logic;
      q:out std_logic);
  end component;
 
 signal c: std_logic_vector (3 downto 0);
 signal y: std_logic_vector (2 downto 0);
  begin
  
 y(0) <= '1' and c(0) and En;
 y(1) <= '1' and c(0) and c(1) and En ;
 y(2) <= '1' and c(0) and c(1) and c(2) and En;
 cont <= c;
  
 c1:FFJK port map(
   clk => clkcont ,
	J => En,
	K => En,
	P => '1',
	C => clrcont,
	q => c(0));
 
  c2:FFJK port map(
   clk => clkcont ,
	J => y(0),
	K => y(0),
	P => '1',
	C => clrcont,
	q => c(1));
	
  c3:FFJK port map(
   clk => clkcont ,
	J => y(1),
	K => y(1),
	P => '1',
	C => clrcont,
	q => c(2));
	
  c4:FFJK port map(
   clk => clkcont ,
	J => y(2),
	K => y(2),
	P => '1',
	C => clrcont,
	q => c(3));

	
end ckt;