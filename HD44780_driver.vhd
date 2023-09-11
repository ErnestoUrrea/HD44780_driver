library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Entity and port definition
entity HD44780_driver is
	port (
		SW: in std_logic;
		clk: in std_logic;
		RS, E: out std_logic;
		DB: out std_logic_vector(7 downto 0));
end entity;

-- Arquitecture definition
architecture rtl of HD44780_driver is
	type estado is (E01, E02, E1, E2, E3, E4, E5, E6, E7, E8, E9, E10, E11, E12, E13, E14, E15, E16, E17, E18, E19, E20, E21, E22, E23, E24, E25, E26, S01, S02, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, S20, S21, S22, S23, S24, S25, S26);
	signal EDO_ACTUAL : estado := S01;
	signal EDO_SIG : estado := S01;
	
	begin
		-- Timer counter process
		process (clk)
			variable pulses: integer range 0 to 50000000;
		begin
			if rising_edge(clk) then
				if (pulses = 1000000) then
					pulses := 0;
					EDO_ACTUAL <= EDO_SIG;
				else
					pulses := pulses + 1;
				end if;
			end if;
		end process;
		
		-- State machine's state definitions
		process (EDO_ACTUAL)
		begin
			case EDO_ACTUAL is
			
				when E01 => -- Clear display
					DB <= "00000001";
					E <= '1';
					RS <= '0';
					EDO_SIG <= E02;
					
				when E02 => 
					E <= '0';
					EDO_SIG <= E1;
			
				when E1 => -- Sets operation mode
					DB <= "00111000"; 
					E <= '1';
					RS <= '0';
					EDO_SIG <= E2;
					
				when E2 =>
					E <= '0';
					EDO_SIG <= E3;
					
				when E3 => -- Turns on display and cursor
					DB <= "00001110";
					E <= '1';
					RS <= '0';
					EDO_SIG <= E4;
					
				when E4 =>
					E <= '0';
					EDO_SIG <= E5;
					
				when E5 => -- Increment mode
					DB <= "00000110";
					E <= '1';
					RS <= '0';
					EDO_SIG <= E6;
					
				when E6 =>
					E <= '0';
					EDO_SIG <= E7;
					
				when E7 => -- H
					DB <= "01001000";
					E <= '1';
					RS <= '1';
					EDO_SIG <= E8;
				
				when E8 =>
					E <= '0';
					EDO_SIG <= E9;
				
				when E9 => -- O
					DB <= "01001111";
					E <= '1';
					RS <= '1';
					EDO_SIG <= E10;
				
				when E10 =>
					E <= '0';
					EDO_SIG <= E11;
					
				when E11 => -- L
					DB <= "01001100";
					E <= '1';
					RS <= '1';
					EDO_SIG <= E12;
				
				when E12 =>
					E <= '0';
					EDO_SIG <= E13;
					
				when E13 => -- A
					DB <= "01000001";
					E <= '1';
					RS <= '1';
					EDO_SIG <= E14;
				
				when E14 =>
					E <= '0';
					EDO_SIG <= E15;
				
				when E15 => -- Next line
					DB <= "11000000";
					E <= '1';
					RS <= '0';
					EDO_SIG <= E16;
				
				when E16 =>
					E <= '0';
					EDO_SIG <= E17;
					
				when E17 => -- M
					DB <= "01001101";
					E <= '1';
					RS <= '1';
					EDO_SIG <= E18;
				
				when E18 =>
					E <= '0';
					EDO_SIG <= E19;
				
				when E19 => -- U
					DB <= "01010101";
					E <= '1';
					RS <= '1';
					EDO_SIG <= E20;
				
				when E20 =>
					E <= '0';
					EDO_SIG <= E21;
					
				when E21 => -- N
					DB <= "01001110";
					E <= '1';
					RS <= '1';
					EDO_SIG <= E22;
				
				when E22 =>
					E <= '0';
					EDO_SIG <= E23;
					
				when E23 => -- D
					DB <= "01000100";
					E <= '1';
					RS <= '1';
					EDO_SIG <= E24;
					
				when E24 =>
					E <= '0';
					EDO_SIG <= E25;
					
				when E25 => -- O
					DB <= "01001111";
					E <= '1';
					RS <= '1';
					EDO_SIG <= E26;
					
				when E26 => -- Change state
					E <= '0';
					EDO_SIG <= E26;
					if (sw = '1') then
						EDO_SIG <= S01;
					end if;
					
				when S01 => -- Clear display
					DB <= "00000001";
					E <= '1';
					RS <= '0';
					EDO_SIG <= S02;
					
				when S02 => 
					E <= '0';
					EDO_SIG <= S1;
			
				when S1 => -- Sets operation mode
					DB <= "00111000"; 
					
					E <= '1';
					RS <= '0';
					EDO_SIG <= S2;
					
				when S2 =>
					E <= '0';
					EDO_SIG <= S3;
					
				when S3 => -- Turns on display and cursor 
					DB <= "00001110";
					
					E <= '1';
					RS <= '0';
					EDO_SIG <= S4;
					
				when S4 =>
					E <= '0';
					EDO_SIG <= S5;
					
				when S5 => -- Increment mode
					DB <= "00000110";
					E <= '1';
					RS <= '0';
					EDO_SIG <= S6;
					
				when S6 =>
					E <= '0';
					EDO_SIG <= S7;
					
				when S7 => -- C
					DB <= "01000011";
					E <= '1';
					RS <= '1';
					EDO_SIG <= S8;
				
				when S8 =>
					E <= '0';
					EDO_SIG <= S9;
				
				when S9 => -- O
					DB <= "01001111";
					E <= '1';
					RS <= '1';
					EDO_SIG <= S10;
				
				when S10 =>
					E <= '0';
					EDO_SIG <= S11;
					
				when S11 => -- M
					DB <= "01001101";
					E <= '1';
					RS <= '1';
					EDO_SIG <= S12;
				
				when S12 =>
					E <= '0';
					EDO_SIG <= S13;
					
				when S13 => -- O
					DB <= "01001111";
					E <= '1';
					RS <= '1';
					EDO_SIG <= S14;
				
				when S14 =>
					E <= '0';
					EDO_SIG <= S15;
				
				when S15 => -- Next line
					DB <= "11000000";
					E <= '1';
					RS <= '0';
					EDO_SIG <= S16;
				
				when S16 =>
					E <= '0';
					EDO_SIG <= S17;
					
				when S17 => -- E
					DB <= "01000101";
					E <= '1';
					RS <= '1';
					EDO_SIG <= S18;
				
				when S18 =>
					E <= '0';
					EDO_SIG <= S19;
				
				when S19 => -- S
					DB <= "01010011";
					E <= '1';
					RS <= '1';
					EDO_SIG <= S20;
				
				when S20 =>
					E <= '0';
					EDO_SIG <= S21;
					
				when S21 => -- T
					DB <= "01010100";
					E <= '1';
					RS <= '1';
					EDO_SIG <= S22;
				
				when S22 =>
					E <= '0';
					EDO_SIG <= S23;
					
				when S23 => -- A
					DB <= "01000001";
					E <= '1';
					RS <= '1';
					EDO_SIG <= S24;
					
				when S24 =>
					E <= '0';
					EDO_SIG <= S25;
					
				when S25 => -- N
					DB <= "01001110";
					E <= '1';
					RS <= '1';
					EDO_SIG <= S26;
					
				when S26 => -- Change state
					E <= '0';
					EDO_SIG <= S26;
					if (sw = '0') then
						EDO_SIG <= E01;
					end if;
					
			end case;
		end process;

end architecture;
