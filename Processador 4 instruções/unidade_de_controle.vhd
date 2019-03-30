library ieee;
use ieee.std_logic_1164.all;

entity unidade_de_controle is
 port(clkUC: in std_logic;
		estado:out std_logic_vector(3 downto 0);
		U_SW: in std_logic_vector(7 downto 0);
		C_D_wrd,C_RF_s,C_RF_W_wr,C_RF_RA_rd,C_RF_RB_rd,C_alu_s0: out std_logic;
      C_D_addr: out std_logic_vector(7 downto 0);
      C_RF_RA_addr,C_RF_RB_addr,C_RF_W_addr: out std_logic_vector(3 downto 0)
 );
end entity;

architecture ckt of unidade_de_controle is

 component FSM is
	port(
		clk: in	std_logic;
		I: in	std_logic_vector(15 downto 0);
		F_SW: in std_logic_vector(7 downto 0);
		reset	 : in	std_logic;
		output	 : out	std_logic_vector(3 downto 0);
		PC_clr,IR_ld,PC_inc,I_rd,D_wrd,RF_s,RF_W_wr,RF_RA_rd,RF_RB_rd,alu_s0: out std_logic;
		D_addr: out std_logic_vector(7 downto 0);
		RF_RA_addr,RF_RB_addr,RF_W_addr: out std_logic_vector(3 downto 0));
 end component;

 component rom IS
	PORT(address: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		  clock: IN STD_LOGIC  := '1';
		  q: OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
 END component;
 
 component contador is
  port(clkcont,clrcont,En:in std_logic;
      cont:out std_logic_vector (3 downto 0));
 end component;
 
 component registrador16b is
  port(S_N: in std_logic_vector(15 downto 0);
      X: in std_logic_vector(1 downto 0);
		clockR: in std_logic;
		S_S: out std_logic_vector(15 downto 0));
end component;

signal C_PC_clr,C_IR_ld,C_PC_inc,C_I_rd: std_logic;
signal IR_data,data_ROM,C_addr_ROM,addr_ROM: std_logic_vector(15 downto 0);
 begin
PC: contador port map(
clkcont => clkUC,
clrcont => C_PC_clr,
En => C_PC_inc,
cont => addr_ROM(3 downto 0)); 

IR: registrador16b port map(
S_N => data_ROM,
X(0) => C_IR_ld,
X(1) =>'0',
clockR =>clkUC,
S_S => IR_data);

instruction: rom port map(
address =>addr_ROM(3 downto 0),
clock =>clkUC,
q =>data_ROM);

controle: FSM port map(
		clk =>clkUC,
		I =>IR_data,
		F_SW => U_SW,
		reset =>'0',
		output =>estado,
		PC_clr =>C_PC_clr,
		IR_ld =>C_IR_ld,
		PC_inc =>C_PC_inc,
		I_rd =>C_I_rd,
		D_wrd =>C_D_wrd,
		RF_s =>C_RF_s,
		RF_W_wr =>C_RF_W_wr,
		RF_RA_rd =>C_RF_RA_rd,
		RF_RB_rd=>C_RF_RB_rd,
		alu_s0=>C_alu_s0,
		D_addr =>C_D_addr,
		RF_RA_addr=>C_RF_RA_addr,
		RF_RB_addr=>C_RF_RB_addr,
		RF_W_addr=>C_RF_W_addr);
  
 end ckt;