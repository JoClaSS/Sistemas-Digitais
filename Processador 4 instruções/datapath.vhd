LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity datapath is
port( D_D_addr: in std_logic_vector(7 downto 0);
      D_RF_waddr,D_RF_RA_addr,D_RF_RB_addr: in std_logic_vector(3 downto 0);
		clkD,D_D_wrd,D_RF_s,D_RF_RB_rd,D_RF_RA_rd,D_RF_wr,D_alu_s0: in std_logic;
		S_RAM_data,S_RA_data,S_RB_data,S_SUM_data: out std_logic_vector(15 downto 0)
);
end entity;


architecture ckt of datapath is 

component register_bank is 
	port(
	rdata: out std_logic_vector(15 downto 0);
	wdata: in  std_logic_vector(15 downto 0);
	waddr,raddr: in  std_logic_vector(3  downto 0);
	wr,rd,clk,clr: in  std_logic
	);
end component;

component alu is 
  port(A_sum,B_sum: in std_logic_vector(15 downto 0);
       alu_en: in std_logic;
		 S_sum: out std_logic_vector(15 downto 0)
  );
end component;

component ram2 IS
	PORT(clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		rdaddress		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wraddress		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren		: IN STD_LOGIC  := '0';
		q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END component;

component muxregistrador is
  port(E00,E01,E10,E11: in std_logic_vector(15 downto 0);
      sel: in std_logic_vector(1 downto 0);
		Sm: out std_logic_vector(15 downto 0)
  );
 end component;
 
 signal RA_data,RB_data,S_mux,R_data,S_data: std_logic_vector(15 downto 0);
begin

memoriaD: ram2 port map(
clock =>clkD,
data =>RA_data,
rdaddress=>D_D_addr,
wraddress=>D_D_addr,
wren=>D_D_wrd,
q=>R_data);

bankA: register_bank port map(
wr =>D_RF_wr,
rd =>D_RF_RA_rd, 
clk=>clkD,
clr =>'1',
waddr =>D_RF_waddr,
raddr =>D_RF_RA_addr,
wdata =>S_mux,
rdata =>RA_data);

bankB: register_bank port map(
wr =>D_RF_wr,
rd =>D_RF_RB_rd, 
clk=>clkD,
clr =>'1',
waddr =>D_RF_waddr,
raddr =>D_RF_RB_addr,
wdata =>S_mux,
rdata =>RB_data);

operations: alu port map(
A_sum=>RA_data,
B_sum=>RB_data,
alu_en=>D_alu_s0,
S_sum => S_data
);

mux: muxregistrador port map(
E00 =>S_data,
E01 =>R_data,
E10 =>"0000000000000000" ,
E11 =>"0000000000000000" ,
sel(0) => D_RF_s,
sel(1) => '0',
Sm => S_mux
);
S_RAM_data <= R_data;
S_RA_data <= RA_Data;
S_RB_data <= RB_data;
S_SUM_data <= S_data;
end ckt;