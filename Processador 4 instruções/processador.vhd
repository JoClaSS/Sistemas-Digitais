library ieee;
use ieee.std_logic_1164.all;

 entity processador is
  port (clkP: in std_logic;
		  P_SW: in std_logic_vector(7 downto 0);
        PADATA,PBDATA,PSDATA,PRDATA: out std_logic_vector(15 downto 0);
		  S_D_addr: out std_logic_vector(7 downto 0);
		  S_alu_s0,S_RF_RB_rd,S_RF_w,S_RF_RA_rd,S_D_wrd: out std_logic;
		  operacao,S_RF_RB_addr,S_RF_RA_addr,S_RF_W_addr: out std_logic_vector(3 downto 0)
  );
 
 end entity;

 architecture ckt of processador is
 
 component unidade_de_controle is
  port(clkUC: in std_logic;
		estado:out std_logic_vector(3 downto 0);
		U_SW: in std_logic_vector(7 downto 0);
		C_D_wrd,C_RF_s,C_RF_W_wr,C_RF_RA_rd,C_RF_RB_rd,C_alu_s0: out std_logic;
      C_D_addr: out std_logic_vector(7 downto 0);
      C_RF_RA_addr,C_RF_RB_addr,C_RF_W_addr: out std_logic_vector(3 downto 0)
  );
 end component;

 component datapath is
  port(D_D_addr: in std_logic_vector(7 downto 0);
      D_RF_waddr,D_RF_RA_addr,D_RF_RB_addr: in std_logic_vector(3 downto 0);
		clkD,D_D_wrd,D_RF_s,D_RF_RB_rd,D_RF_RA_rd,D_RF_wr,D_alu_s0: in std_logic;
		S_RAM_data,S_RA_data,S_RB_data,S_SUM_data: out std_logic_vector(15 downto 0)
  );
 end component;
 
 signal P_D_wrd,P_RF_s,P_RF_RB_rd,P_RF_RA_rd,P_alu_s0,P_RF_W_wr: std_logic;
 signal P_RF_RA_addr,P_RF_RB_addr,P_RF_W_addr: std_logic_vector(3 downto 0);
 signal P_D_addr: std_logic_vector(7 downto 0);
 begin
 
 controlador: unidade_de_controle port map(
 clkUC => clkP,
 C_D_wrd =>P_D_wrd,
 C_D_addr =>P_D_addr,
 C_RF_s =>P_RF_s,
 C_RF_RA_addr =>P_RF_RA_addr,
 C_RF_RB_addr =>P_RF_RB_addr,
 C_RF_RA_rd =>P_RF_RA_rd,
 C_RF_RB_rd =>P_RF_RB_rd,
 C_RF_W_addr =>P_RF_W_addr,
 C_RF_W_wr =>P_RF_W_wr,
 C_alu_s0 =>P_alu_s0,
 estado =>operacao,
 U_SW => P_SW
 );

  processamento: datapath port map(
  D_D_addr =>P_D_addr,
  D_RF_waddr=>P_RF_W_addr,
  D_RF_RA_addr=>P_RF_RA_addr,
  D_RF_RB_addr=>P_RF_RB_addr,
  clkD=>clkP,
  D_D_wrd=>P_D_wrd, --ok
  D_RF_s=>P_RF_s, --ok
  D_RF_RB_rd=>P_RF_RB_rd,
  D_RF_RA_rd=>P_RF_RA_rd,
  D_RF_wr=>P_RF_W_wr, --ok
  D_alu_s0=>P_alu_s0, --ok
  S_RA_data=>PADATA,
  S_RB_data=>PBDATA,
  S_SUM_data=>PSDATA,
  S_RAM_data=>PRDATA
  );
  
S_D_addr<= P_D_addr;
S_RF_RB_addr <= P_RF_RB_addr;
S_RF_RA_addr <= P_RF_RA_addr;
S_RF_W_addr <= P_RF_W_addr; 
S_D_wrd <= P_D_wrd;
S_alu_s0 <= P_alu_s0;
S_RF_RB_rd <= P_RF_RB_rd;
S_RF_RA_rd <= P_RF_RA_rd;
S_RF_w <= P_RF_W_wr;
end ckt; 