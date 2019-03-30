library ieee;
use ieee.std_logic_1164.all;


entity FSM is
	port(
		clk: in	std_logic;
		I: in	std_logic_vector(15 downto 0);
		F_SW: in std_logic_vector(7 downto 0);
		reset	 : in	std_logic;
		output	 : out	std_logic_vector(3 downto 0);
		PC_clr,IR_ld,PC_inc,I_rd,D_wrd,RF_s,RF_W_wr,RF_RA_rd,RF_RB_rd,alu_s0: out std_logic;
		D_addr: out std_logic_vector(7 downto 0);
		RF_RA_addr,RF_RB_addr,RF_W_addr: out std_logic_vector(3 downto 0)
	);
end entity;

architecture rtl of FSM is

	-- Build an enumerated type for the state machine
	type state_type is (init, fetch, decoder , load, storage , add, load2, storage2, add2,halt);

	-- Register to hold the current state
	signal state   : state_type;

begin

	-- Logic to advance to the next state
	process (clk, reset)
	begin
		if reset = '1' then
			state <= init;
		elsif (rising_edge(clk)) then
			case state is
				when init=> state <= fetch;
				when fetch=> state <= decoder;
				when decoder=>
					if I(15 downto 12) = "0000" then
						state <= load;
					elsif I(15 downto 12) = "0001" then 
					   state <= storage;
					elsif I(15 downto 12) = "0010" then 
					   state <= add;
					elsif I(15 downto 12) = "0100" then 
					   state <= halt;
					else 
					   state <= init;
					end if;
				when load => state <= load2;
				when storage => state <= storage2;
				when add => state <= add2;
				when load2 => state <= fetch;
				when storage2 => state <= fetch;
				when add2 => state <= fetch;
				when halt => state <= halt;
			end case;
		end if;
	end process;

	-- Output depends solely on the current state
	process (state)
	begin
		case state is
			when init =>
				output <= "0000";
			when fetch =>
				output <= "0001";
			when decoder =>
				output <= "0010";
			when load =>
				output <= "0011";
			when load2 => 
			 output <= "0011";
		   when storage => 
			 output <= "0100";
			when storage2 => 
			 output <= "0100";
			when add => 
			 output <= "0101";
			when add2 => 
			 output <= "0101";
			when halt => 
			 output <= "0110";		
		end case;
	end process;
PC_clr <= '0' when state = init else '1'; --clear incrementador
I_rd <= '1' when state = fetch else '0';  --leitor da rom
PC_inc <= '1' when state = fetch else '0'; -- +1 no incrementador
IR_ld <= '1' when state = fetch else '0'; -- carregar a intrução
with state select
 D_addr <= I(7 downto 0) when load,  -- endereço da ram
           I(7 downto 0) when load2,
           I(7 downto 0) when storage,
			  I(7 downto 0) when storage2,
			  F_SW when halt,
			  unaffected when others;
 D_wrd <= '1' when state = storage2 else '0'; -- escrita '1' leitura '0' da ram
 with state select 
  RF_s <= '1' when load, -- seletor do mux
          '0' when add,
			 '0' when add2,
			 unaffected when others;
with state select
  RF_W_addr <= I(11 downto 8) when load2, -- endereço de escrita do banco A
					I(11 downto 8) when add2,
               "0000" when others;
with state select					
  RF_W_wr <= '1' when load2,  -- habilitar escrita no banco
				 '1' when add2,
				 '0' when others;
with state select    --endereço de leitura do banco A
  RF_RA_addr <= I(11 downto 8) when storage,
					 I(11 downto 8) when storage2,
                I(7 downto 4) when add,
					 I(7 downto 4) when add2,
				 "0000" when others;
 with state select 
  RF_RA_rd <= '1' when storage,
				'1' when storage2,-- habilitador de leitura do banco A
              '1' when add,
				  '0' when others;
with state select
  RF_RB_addr <= I(3 downto 0) when add,
				    I(3 downto 0) when add2,
					 "0000" when others; -- endereço de leitura do banco B 
  RF_RB_rd <= '1' when state = add else '0'; -- habilitador de leitura do banco B
with state select
  alu_s0 <= '1' when add2,
            '0' when others;  -- habilitador de soma
end rtl;
