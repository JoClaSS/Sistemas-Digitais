library ieee;
use ieee.std_logic_1164.all;

entity registrador16b is
 port(S_N: in std_logic_vector(15 downto 0);
      X: in std_logic_vector(1 downto 0);
		clockR: in std_logic;
		S_S: out std_logic_vector(15 downto 0)
 );
end entity;

architecture ckt of registrador16b is

 component muxregistrador is
  port(E00,E01,E10,E11: in std_logic_vector(15 downto 0);
      sel: in std_logic_vector(1 downto 0);
		Sm: out std_logic_vector(15 downto 0));
 end component;
 
 component FFD is
  port(clk,D,P,C:in std_logic;
		q:out std_logic);
 end component;

signal S_M,S_R: std_logic_vector(15 downto 0);
 begin
 
 bit00: FFD port map(clk =>clockR, D =>S_M(0),P=>'1',C =>'1',q =>S_R(0)); 
 bit01: FFD port map(clk =>clockR, D =>S_M(1),P=>'1',C =>'1',q =>S_R(1));
 bit02: FFD port map(clk =>clockR, D =>S_M(2),P=>'1',C =>'1',q =>S_R(2));
 bit03: FFD port map(clk =>clockR, D =>S_M(3),P=>'1',C =>'1',q =>S_R(3));
 bit04: FFD port map(clk =>clockR, D =>S_M(4),P=>'1',C =>'1',q =>S_R(4));
 bit05: FFD port map(clk =>clockR, D =>S_M(5),P=>'1',C =>'1',q =>S_R(5));
 bit06: FFD port map(clk =>clockR, D =>S_M(6),P=>'1',C =>'1',q =>S_R(6));
 bit07: FFD port map(clk =>clockR, D =>S_M(7),P=>'1',C =>'1',q =>S_R(7)); 
 bit08: FFD port map(clk =>clockR, D =>S_M(8),P=>'1',C =>'1',q =>S_R(8));
 bit09: FFD port map(clk =>clockR, D =>S_M(9),P=>'1',C =>'1',q =>S_R(9));
 bit10: FFD port map(clk =>clockR, D =>S_M(10),P=>'1',C =>'1',q =>S_R(10));
 bit11: FFD port map(clk =>clockR, D =>S_M(11),P=>'1',C =>'1',q =>S_R(11));
 bit12: FFD port map(clk =>clockR, D =>S_M(12),P=>'1',C =>'1',q =>S_R(12));
 bit13: FFD port map(clk =>clockR, D =>S_M(13),P=>'1',C =>'1',q =>S_R(13));
 bit14: FFD port map(clk =>clockR, D =>S_M(14),P=>'1',C =>'1',q =>S_R(14));
 bit15: FFD port map(clk =>clockR, D =>S_M(15),P=>'1',C =>'1',q =>S_R(15));

 
 multiplex: muxregistrador port map(
 E00 =>S_R,
 E01 =>S_N,
 E10 =>"0000000000000000",
 E11 =>"1111111111111111",
 sel =>X,
 Sm =>S_M
 );

 S_S <= S_R;
 end ckt;