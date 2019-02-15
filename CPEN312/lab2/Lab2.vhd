library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Lab2 is 
	port
	(
	PB0, PB1 	: in STD_LOGIC;
	SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7, SW8, SW9	: in STD_LOGIC;
	HEX00, HEX01, HEX02, HEX03, HEX04, HEX05, HEX06 	: out STD_Logic;
	HEX10, HEX11, HEX12, HEX13, HEX14, HEX15, HEX16 	: out STD_Logic;
	HEX20, HEX21, HEX22, HEX23, HEX24, HEX25, HEX26 	: out STD_Logic;
	HEX30, HEX31, HEX32, HEX33, HEX34, HEX35, HEX36 	: out STD_Logic;
	HEX40, HEX41, HEX42, HEX43, HEX44, HEX45, HEX46		: out STD_Logic;
	HEX50, HEX51, HEX52, HEX53, HEX54, HEX55, HEX56 	: out STD_Logic;
	LED0, LED1, LED2, LED3, LED4, LED5, LED6, LED7, LED8, LED9		: out STD_Logic
	);
end Lab2;

architecture a of Lab2 is

	signal BinIn, ByteA, ByteB, SumBin, SumBCD : STD_LOGIC_VECTOR (7 downto 0);
	signal Cin : STD_LOGIC;
	
	component GetDisp7Bits is
		port
		(
		BinIn : in STD_LOGIC_VECTOR (7 downto 0);
		click		: in STD_LOGIC;
		H00, H01, H02, H03, H04, H05, H06 : out STD_LOGIC;
		H10, H11, H12, H13, H14, H15, H16: out STD_LOGIC;
		BinOut: Out STD_LOGIC_VECTOR (7 downto 0)
	);
	end component;
	
	component GetDisp7BitsBCD is
		port
		(
		BinIn : in STD_LOGIC_VECTOR (7 downto 0);
		click		: in STD_LOGIC;
		H00, H01, H02, H03, H04, H05, H06 : out STD_LOGIC;
		H10, H11, H12, H13, H14, H15, H16: out STD_LOGIC;
		BinOut: Out STD_LOGIC_VECTOR (7 downto 0)
	);
	end component;
	
	component BinAdder is
		port
		(
		byteA, byteB 	: in STD_LOGIC_VECTOR (7 downto 0);
		cin 				: in STD_LOGIC;
		sum				: out STD_LOGIC_VECTOR (7 downto 0);
		cout				: out STD_LOGIC;
		add				: in STD_LOGIC;
		isnegative		: out STD_LOGIC
		);
	end component;
	
--	component BCDAdder is
--		port
--		(
--		byteA, byteB 	: in STD_LOGIC_VECTOR (7 downto 0);
--		cin 				: in STD_LOGIC;
--		sum				: out STD_LOGIC_VECTOR (7 downto 0);
--		cout				: out STD_LOGIC;
--		add				: in STD_LOGIC;
--		isnegative		: out STD_LOGIC
--		);
--	end component;
	
	component BCDto7Seg is
		port
		(
		BinIn : in STD_LOGIC_VECTOR (7 downto 0);
		H00, H01, H02, H03, H04, H05, H06 : out STD_LOGIC;
		H10, H11, H12, H13, H14, H15, H16: out STD_LOGIC;
		overflow : out STD_LOGIC
		);
	end component;
		
	
begin
	Cin <= '0';

	BinIn(0) <= SW0;
	BinIn(1) <= SW1;
	BinIn(2) <= SW2;
	BinIn(3) <= SW3;
	BinIn(4) <= SW4;
	BinIn(5) <= SW5;
	BinIn(6) <= SW6;
	BinIn(7) <= SW7;

	LED0<=SumBin(0);
	LED1<=SumBin(1);
	LED2<=SumBin(2);
	LED3<=SumBin(3);
	LED4<=SumBin(4);
	LED5<=SumBin(5);
	LED6<=SumBin(6);
	LED7<=SumBin(7);

	u1: GetDisp7Bits port map (H00=>HEX40, H01=>HEX41, H02=>HEX42, H03=>HEX43, H04=>HEX44, H05=>HEX45, H06=>HEX46, 
												H10=>HEX50, H11=>HEX51, H12=>HEX52, H13=>HEX53, H14=>HEX54, H15=>HEX55, H16=>HEX56, 
												BinIn=>BinIn, click=>PB1, BinOut=>ByteA);
	u2: GetDisp7Bits port map (H00=>HEX20, H01=>HEX21, H02=>HEX22, H03=>HEX23, H04=>HEX24, H05=>HEX25, H06=>HEX26, 
												H10=>HEX30, H11=>HEX31, H12=>HEX32, H13=>HEX33, H14=>HEX34, H15=>HEX35, H16=>HEX36, 
												BinIn=>BinIn, click=>PB0, BinOut=>ByteB);

	u3: BinAdder port map (byteA=>ByteA, byteB=>byteB, add=>SW9, sum=>SumBin, cout=>LED8, isnegative=>LED9, cin=>Cin); --BinAdder adjusted to not output LED if i can fix BCDadder logic
	
--	u4: BinAdder port map (byteA=>ByteA, byteB=>byteB, add=>SW9, sum=>SumBCD, cout=>LED8, isnegative=>LED9, cin=>Cin);
	
--	u4: BCDAdder port map (byteA=>ByteA, byteB=>byteB, add=>SW9, sum=>SumBCD, cout=>LED8, isnegative=>LED9, cin=>Cin);
	
	u5: BCDto7Seg port map (H00=>HEX00, H01=>HEX01, H02=>HEX02, H03=>HEX03, H04=>HEX04, H05=>HEX05, H06=>HEX06, 
									H10=>HEX10, H11=>HEX11, H12=>HEX12, H13=>HEX13, H14=>HEX14, H15=>HEX15, H16=>HEX16,  
									BinIn=>SumBin);
	
end a;





library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity GetBin is 
	port
	(
	BinIn : in STD_LOGIC_VECTOR (7 downto 0);
	click		: in STD_LOGIC;
	BinOut	: out STD_LOGIC_VECTOR (7 downto 0)
	);
end GetBin;	

	
architecture a of GetBin is
	signal state: STD_LOGIC_VECTOR (7 downto 0);
begin
	
	process (click)
	begin
		if (click = '0') then
        state <= BinIn;
		end if;
	end process;
	
	BinOut <= state;

end a;





library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity BCDto7Seg is
	port
	(
	BinIn : in STD_LOGIC_VECTOR (7 downto 0);
	H00, H01, H02, H03, H04, H05, H06 : out STD_LOGIC;
	H10, H11, H12, H13, H14, H15, H16: out STD_LOGIC;
	overflow : out STD_LOGIC
	);
end BCDto7Seg;

architecture a of BCDto7Seg is
	signal Hex0Temp, Hex1Temp: STD_LOGIC_VECTOR (0 to 6);
	
begin	
	H00 <= Hex0Temp(0);
	H01 <= Hex0Temp(1);
	H02 <= Hex0Temp(2);
	H03 <= Hex0Temp(3);
	H04 <= Hex0Temp(4);
	H05 <= Hex0Temp(5);
	H06 <= Hex0Temp(6);
	
	H10 <= Hex1Temp(0);
	H11 <= Hex1Temp(1);
	H12 <= Hex1Temp(2);
	H13 <= Hex1Temp(3);
	H14 <= Hex1Temp(4);
	H15 <= Hex1Temp(5);
	H16 <= Hex1Temp(6);
	
	process(BinIn) is
	begin
		case BinIn is
--			when "00000000" => Hex1Temp <= "1111111"; Hex0Temp <= "0000001";
--			when "00000001" => Hex1Temp <= "1111111"; Hex0Temp <= "1001111";
--			when "00000010" => Hex1Temp <= "1111111"; Hex0Temp <= "0010010";
--			when "00000011" => Hex1Temp <= "1111111"; Hex0Temp <= "0000110";
--			when "00000100" => Hex1Temp <= "1111111"; Hex0Temp <= "1001100";
--			when "00000101" => Hex1Temp <= "1111111"; Hex0Temp <= "0100100";
--			when "00000110" => Hex1Temp <= "1111111"; Hex0Temp <= "0100000";
--			when "00000111" => Hex1Temp <= "1111111"; Hex0Temp <= "0001111";
--			when "00001000" => Hex1Temp <= "1111111"; Hex0Temp <= "0000000";
--			when "00001001" => Hex1Temp <= "1111111"; Hex0Temp <= "0001100";
--			when "00010000" => Hex1Temp <= "1001111"; Hex0Temp <= "0100000";
--			when "00010001" => Hex1Temp <= "1001111"; Hex0Temp <= "0001111";
--			when "00010010" => Hex1Temp <= "1001111"; Hex0Temp <= "0000000";
--			when "00010011" => Hex1Temp <= "1001111"; Hex0Temp <= "0001100";
--			when "00010100" => Hex1Temp <= "0010010"; Hex0Temp <= "0000001";
--			when "00010101" => Hex1Temp <= "0010010"; Hex0Temp <= "1001111";
--			when "00010110" => Hex1Temp <= "0010010"; Hex0Temp <= "0010010";
--			when "00010111" => Hex1Temp <= "0010010"; Hex0Temp <= "0000110";
--			when "00011000" => Hex1Temp <= "0010010"; Hex0Temp <= "1001100";
--			when "00011001" => Hex1Temp <= "0010010"; Hex0Temp <= "0100100";
--			when "00100000" => Hex1Temp <= "0000110"; Hex0Temp <= "0010010";
--			when "00100001" => Hex1Temp <= "0000110"; Hex0Temp <= "0000110";
--			when "00100010" => Hex1Temp <= "0000110"; Hex0Temp <= "1001100";
--			when "00100011" => Hex1Temp <= "0000110"; Hex0Temp <= "0100100";
--			when "00100100" => Hex1Temp <= "0000110"; Hex0Temp <= "0100000";
--			when "00100101" => Hex1Temp <= "0000110"; Hex0Temp <= "0001111";
--			when "00100110" => Hex1Temp <= "0000110"; Hex0Temp <= "0000000";
--			when "00100111" => Hex1Temp <= "0000110"; Hex0Temp <= "0001100";
--			when "00101000" => Hex1Temp <= "1001100"; Hex0Temp <= "0000001";
--			when "00101001" => Hex1Temp <= "1001100"; Hex0Temp <= "1001111";
--			when "00110000" => Hex1Temp <= "1001100"; Hex0Temp <= "0000000";
--			when "00110001" => Hex1Temp <= "1001100"; Hex0Temp <= "0001100";
--			when "00110010" => Hex1Temp <= "0100100"; Hex0Temp <= "0000001";
--			when "00110011" => Hex1Temp <= "0100100"; Hex0Temp <= "1001111";
--			when "00110100" => Hex1Temp <= "0100100"; Hex0Temp <= "0010010";
--			when "00110101" => Hex1Temp <= "0100100"; Hex0Temp <= "0000110";
--			when "00110110" => Hex1Temp <= "0100100"; Hex0Temp <= "1001100";
--			when "00110111" => Hex1Temp <= "0100100"; Hex0Temp <= "0100100";
--			when "00111000" => Hex1Temp <= "0100100"; Hex0Temp <= "0100000";
--			when "00111001" => Hex1Temp <= "0100100"; Hex0Temp <= "0001111";
--			when "01000000" => Hex1Temp <= "0100000"; Hex0Temp <= "1001100";
--			when "01000001" => Hex1Temp <= "0100000"; Hex0Temp <= "0100100";
--			when "01000010" => Hex1Temp <= "0100000"; Hex0Temp <= "0100000";
--			when "01000011" => Hex1Temp <= "0100000"; Hex0Temp <= "0001111";
--			when "01000100" => Hex1Temp <= "0100000"; Hex0Temp <= "0000000";
--			when "01000101" => Hex1Temp <= "0100000"; Hex0Temp <= "0001100";
--			when "01000110" => Hex1Temp <= "0001111"; Hex0Temp <= "0000001";
--			when "01000111" => Hex1Temp <= "0001111"; Hex0Temp <= "1001111";
--			when "01001000" => Hex1Temp <= "0001111"; Hex0Temp <= "0010010";
--			when "01001001" => Hex1Temp <= "0001111"; Hex0Temp <= "0000110";
--			when "01010000" => Hex1Temp <= "0000000"; Hex0Temp <= "0000001";
--			when "01010001" => Hex1Temp <= "0000000"; Hex0Temp <= "1001111";
--			when "01010010" => Hex1Temp <= "0000000"; Hex0Temp <= "0010010";
--			when "01010011" => Hex1Temp <= "0000000"; Hex0Temp <= "0000110";
--			when "01010100" => Hex1Temp <= "0000000"; Hex0Temp <= "1001100";
--			when "01010101" => Hex1Temp <= "0000000"; Hex0Temp <= "0100100";
--			when "01010110" => Hex1Temp <= "0000000"; Hex0Temp <= "0100000";
--			when "01010111" => Hex1Temp <= "0000000"; Hex0Temp <= "0001111";
--			when "01011000" => Hex1Temp <= "0000000"; Hex0Temp <= "0000000";
--			when "01011001" => Hex1Temp <= "0000000"; Hex0Temp <= "0001100";
--			when "01100000" => Hex1Temp <= "0001100"; Hex0Temp <= "0100000";
--			when "01100001" => Hex1Temp <= "0001100"; Hex0Temp <= "0001111";
--			when "01100010" => Hex1Temp <= "0001100"; Hex0Temp <= "0000000";
--			when "01100011" => Hex1Temp <= "0001100"; Hex0Temp <= "0001100";
--			when others => Hex0Temp <= "1111110"; Hex1Temp <= "1111110";
			when "00000000" => Hex1Temp <= "1111111"; Hex0Temp <= "0000001";
			when "00000001" => Hex1Temp <= "1111111"; Hex0Temp <= "1001111";
			when "00000010" => Hex1Temp <= "1111111"; Hex0Temp <= "0010010";
			when "00000011" => Hex1Temp <= "1111111"; Hex0Temp <= "0000110";
			when "00000100" => Hex1Temp <= "1111111"; Hex0Temp <= "1001100";
			when "00000101" => Hex1Temp <= "1111111"; Hex0Temp <= "0100100";
			when "00000110" => Hex1Temp <= "1111111"; Hex0Temp <= "0100000";
			when "00000111" => Hex1Temp <= "1111111"; Hex0Temp <= "0001111";
			when "00001000" => Hex1Temp <= "1111111"; Hex0Temp <= "0000000";
			when "00001001" => Hex1Temp <= "1111111"; Hex0Temp <= "0001100";
			when "00001010" => Hex1Temp <= "1001111"; Hex0Temp <= "0000001";
			when "00001011" => Hex1Temp <= "1001111"; Hex0Temp <= "1001111";
			when "00001100" => Hex1Temp <= "1001111"; Hex0Temp <= "0010010";
			when "00001101" => Hex1Temp <= "1001111"; Hex0Temp <= "0000110";
			when "00001110" => Hex1Temp <= "1001111"; Hex0Temp <= "1001100";
			when "00001111" => Hex1Temp <= "1001111"; Hex0Temp <= "0100100";
			when "00010000" => Hex1Temp <= "1001111"; Hex0Temp <= "0100000";
			when "00010001" => Hex1Temp <= "1001111"; Hex0Temp <= "0001111";
			when "00010010" => Hex1Temp <= "1001111"; Hex0Temp <= "0000000";
			when "00010011" => Hex1Temp <= "1001111"; Hex0Temp <= "0001100";
			when "00010100" => Hex1Temp <= "0010010"; Hex0Temp <= "0000001";
			when "00010101" => Hex1Temp <= "0010010"; Hex0Temp <= "1001111";
			when "00010110" => Hex1Temp <= "0010010"; Hex0Temp <= "0010010";
			when "00010111" => Hex1Temp <= "0010010"; Hex0Temp <= "0000110";
			when "00011000" => Hex1Temp <= "0010010"; Hex0Temp <= "1001100";
			when "00011001" => Hex1Temp <= "0010010"; Hex0Temp <= "0100100";
			when "00011010" => Hex1Temp <= "0010010"; Hex0Temp <= "0100000";
			when "00011011" => Hex1Temp <= "0010010"; Hex0Temp <= "0001111";
			when "00011100" => Hex1Temp <= "0010010"; Hex0Temp <= "0000000";
			when "00011101" => Hex1Temp <= "0010010"; Hex0Temp <= "0001100";
			when "00011110" => Hex1Temp <= "0000110"; Hex0Temp <= "0000001";
			when "00011111" => Hex1Temp <= "0000110"; Hex0Temp <= "1001111";
			when "00100000" => Hex1Temp <= "0000110"; Hex0Temp <= "0010010";
			when "00100001" => Hex1Temp <= "0000110"; Hex0Temp <= "0000110";
			when "00100010" => Hex1Temp <= "0000110"; Hex0Temp <= "1001100";
			when "00100011" => Hex1Temp <= "0000110"; Hex0Temp <= "0100100";
			when "00100100" => Hex1Temp <= "0000110"; Hex0Temp <= "0100000";
			when "00100101" => Hex1Temp <= "0000110"; Hex0Temp <= "0001111";
			when "00100110" => Hex1Temp <= "0000110"; Hex0Temp <= "0000000";
			when "00100111" => Hex1Temp <= "0000110"; Hex0Temp <= "0001100";
			when "00101000" => Hex1Temp <= "1001100"; Hex0Temp <= "0000001";
			when "00101001" => Hex1Temp <= "1001100"; Hex0Temp <= "1001111";
			when "00101010" => Hex1Temp <= "1001100"; Hex0Temp <= "0010010";
			when "00101011" => Hex1Temp <= "1001100"; Hex0Temp <= "0000110";
			when "00101100" => Hex1Temp <= "1001100"; Hex0Temp <= "1001100";
			when "00101101" => Hex1Temp <= "1001100"; Hex0Temp <= "0100100";
			when "00101110" => Hex1Temp <= "1001100"; Hex0Temp <= "0100000";
			when "00101111" => Hex1Temp <= "1001100"; Hex0Temp <= "0001111";
			when "00110000" => Hex1Temp <= "1001100"; Hex0Temp <= "0000000";
			when "00110001" => Hex1Temp <= "1001100"; Hex0Temp <= "0001100";
			when "00110010" => Hex1Temp <= "0100100"; Hex0Temp <= "0000001";
			when "00110011" => Hex1Temp <= "0100100"; Hex0Temp <= "1001111";
			when "00110100" => Hex1Temp <= "0100100"; Hex0Temp <= "0010010";
			when "00110101" => Hex1Temp <= "0100100"; Hex0Temp <= "0000110";
			when "00110110" => Hex1Temp <= "0100100"; Hex0Temp <= "1001100";
			when "00110111" => Hex1Temp <= "0100100"; Hex0Temp <= "0100100";
			when "00111000" => Hex1Temp <= "0100100"; Hex0Temp <= "0100000";
			when "00111001" => Hex1Temp <= "0100100"; Hex0Temp <= "0001111";
			when "00111010" => Hex1Temp <= "0100100"; Hex0Temp <= "0000000";
			when "00111011" => Hex1Temp <= "0100100"; Hex0Temp <= "0001100";
			when "00111100" => Hex1Temp <= "0100000"; Hex0Temp <= "0000001";
			when "00111101" => Hex1Temp <= "0100000"; Hex0Temp <= "1001111";
			when "00111110" => Hex1Temp <= "0100000"; Hex0Temp <= "0010010";
			when "00111111" => Hex1Temp <= "0100000"; Hex0Temp <= "0000110";
			when "01000000" => Hex1Temp <= "0100000"; Hex0Temp <= "1001100";
			when "01000001" => Hex1Temp <= "0100000"; Hex0Temp <= "0100100";
			when "01000010" => Hex1Temp <= "0100000"; Hex0Temp <= "0100000";
			when "01000011" => Hex1Temp <= "0100000"; Hex0Temp <= "0001111";
			when "01000100" => Hex1Temp <= "0100000"; Hex0Temp <= "0000000";
			when "01000101" => Hex1Temp <= "0100000"; Hex0Temp <= "0001100";
			when "01000110" => Hex1Temp <= "0001111"; Hex0Temp <= "0000001";
			when "01000111" => Hex1Temp <= "0001111"; Hex0Temp <= "1001111";
			when "01001000" => Hex1Temp <= "0001111"; Hex0Temp <= "0010010";
			when "01001001" => Hex1Temp <= "0001111"; Hex0Temp <= "0000110";
			when "01001010" => Hex1Temp <= "0001111"; Hex0Temp <= "1001100";
			when "01001011" => Hex1Temp <= "0001111"; Hex0Temp <= "0100100";
			when "01001100" => Hex1Temp <= "0001111"; Hex0Temp <= "0100000";
			when "01001101" => Hex1Temp <= "0001111"; Hex0Temp <= "0001111";
			when "01001110" => Hex1Temp <= "0001111"; Hex0Temp <= "0000000";
			when "01001111" => Hex1Temp <= "0001111"; Hex0Temp <= "0001100";
			when "01010000" => Hex1Temp <= "0000000"; Hex0Temp <= "0000001";
			when "01010001" => Hex1Temp <= "0000000"; Hex0Temp <= "1001111";
			when "01010010" => Hex1Temp <= "0000000"; Hex0Temp <= "0010010";
			when "01010011" => Hex1Temp <= "0000000"; Hex0Temp <= "0000110";
			when "01010100" => Hex1Temp <= "0000000"; Hex0Temp <= "1001100";
			when "01010101" => Hex1Temp <= "0000000"; Hex0Temp <= "0100100";
			when "01010110" => Hex1Temp <= "0000000"; Hex0Temp <= "0100000";
			when "01010111" => Hex1Temp <= "0000000"; Hex0Temp <= "0001111";
			when "01011000" => Hex1Temp <= "0000000"; Hex0Temp <= "0000000";
			when "01011001" => Hex1Temp <= "0000000"; Hex0Temp <= "0001100";
			when "01011010" => Hex1Temp <= "0001100"; Hex0Temp <= "0000001";
			when "01011011" => Hex1Temp <= "0001100"; Hex0Temp <= "1001111";
			when "01011100" => Hex1Temp <= "0001100"; Hex0Temp <= "0010010";
			when "01011101" => Hex1Temp <= "0001100"; Hex0Temp <= "0000110";
			when "01011110" => Hex1Temp <= "0001100"; Hex0Temp <= "1001100";
			when "01011111" => Hex1Temp <= "0001100"; Hex0Temp <= "0100100";
			when "01100000" => Hex1Temp <= "0001100"; Hex0Temp <= "0100000";
			when "01100001" => Hex1Temp <= "0001100"; Hex0Temp <= "0001111";
			when "01100010" => Hex1Temp <= "0001100"; Hex0Temp <= "0000000";
			when "01100011" => Hex1Temp <= "0001100"; Hex0Temp <= "0001100";
			when others => Hex0Temp <= "1111110"; Hex1Temp <= "1111110";
		end case;
		
		if (BinIn >= "0") and (BinIn < "1100100") then
			overflow <= '0';
		else
			overflow <= '1';
		end if;		
	end process;
end a;





library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity GetDisp7Bits is
	port
	(
	BinIn : in STD_LOGIC_VECTOR (7 downto 0);
	click		: in STD_LOGIC;
	H00, H01, H02, H03, H04, H05, H06 : out STD_LOGIC;
	H10, H11, H12, H13, H14, H15, H16: out STD_LOGIC;
	BinOut: Out STD_LOGIC_VECTOR (7 downto 0)
	);
end GetDisp7Bits;

architecture a of GetDisp7Bits is

	signal binTemp : STD_LOGIC_VECTOR (7 downto 0);

	component GetBin is 
		port
		(
		BinIn : in STD_LOGIC_VECTOR (7 downto 0);
		click		: in STD_LOGIC;
		BinOut	: out STD_LOGIC_VECTOR (7 downto 0)
		);
	end component;	
	
	component BCDto7Seg is
		port
		(
		BinIn : in STD_LOGIC_VECTOR (7 downto 0);
		H00, H01, H02, H03, H04, H05, H06 : out STD_LOGIC;
		H10, H11, H12, H13, H14, H15, H16 : out STD_LOGIC
		);
	end component;
	
begin
	BinOut <= BinTemp;
	u1: GetBin port map(BinIn=>BinIn,click=>click,BinOut=>binTemp);
	u2: BCDto7Seg port map(H00=>H00, H01=>H01, H02=>H02, H03=>H03, H04=>H04, H05=>H05, H06=>H06, 
									H10=>H10, H11=>H11, H12=>H12, H13=>H13, H14=>H14, H15=>H15, H16=>H16, 
									BinIn=>binTemp);
end a;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity BinAdder is
	port
	(
	byteA, byteB 	: in STD_LOGIC_VECTOR (7 downto 0);
	cin 				: in STD_LOGIC;
	sum				: out STD_LOGIC_VECTOR (7 downto 0);
	cout				: out STD_LOGIC;
	add				: in STD_LOGIC;
	isnegative		: out STD_LOGIC
	);
end BinAdder;

architecture a of BinAdder is
	signal sumtemp : STD_LOGIC_VECTOR (8 downto 0);
	signal sumtemptemp : STD_LOGIC_VECTOR (8 downto 0);
	signal byteBtemp : STD_LOGIC_VECTOR (8 downto 0);
begin
	process(byteA, byteB, cin, add)
	begin
		if (add = '0') then  --addition
			byteBtemp <= '0' & byteB;
			sumtemp <= ('0' & byteA) + byteBtemp + ("00000000" & cin);
			isnegative <= '0'; -- positive
		else --subtraction
			byteBtemp <= ('0' & (NOT byteB)) + '1';
			sumtemptemp <= ('0' & byteA) + byteBtemp + ("00000000" & cin); 
			if (sumtemptemp(8) = '0' and sumtemptemp(7 downto 0) /= "00000000") then
				sumtemp <= NOT (('0' & byteA) + byteBtemp + ("00000000" & cin)) + '1'; 
				isnegative <= '1'; --negative
			else
				sumtemp <= ('0' & byteA) + byteBtemp + ("00000000" & cin); 
				isnegative <= '0'; -- positive
			end if;
			sumtemp(8) <= '0';
		end if;
		cout <= sumtemp(8);
		sum <= sumtemp(7 downto 0);
	end process;
end a;

--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.std_logic_unsigned.all;
--use ieee.numeric_std.all;
--
--entity BCDAdder is
--	port
--	(
--	byteA, byteB 	: in STD_LOGIC_VECTOR (7 downto 0);
--	cin 				: in STD_LOGIC;
--	sum				: out STD_LOGIC_VECTOR (7 downto 0);
--	cout				: out STD_LOGIC;
--	add				: in STD_LOGIC;
--	isnegative		: out STD_LOGIC
--	);
--end BCDAdder;
--
--architecture a of BCDAdder is
--	signal sumtemp : STD_LOGIC_VECTOR (8 downto 0);
--	signal sumtemptemp : STD_LOGIC_VECTOR (8 downto 0);
--	signal byteBtemp : STD_LOGIC_VECTOR (8 downto 0);
--	
--	signal byteA_temp : STD_LOGIC_VECTOR (7 downto 0);
--	signal byteB_temp : STD_LOGIC_VECTOR (7 downto 0);
--	
--	shared variable bcd00 : natural; 
--	shared variable bcd01 : natural; 
--	shared variable bcd10 : natural; 
--	shared variable bcd11 : natural; 
--	shared variable bcdA : natural;
--	shared variable bcdB : natural;
--	
--	signal sum_temp_full : STD_LOGIC_VECTOR (8 downto 0);
--	signal sum_temp_one : STD_LOGIC_VECTOR (8 downto 0);
--	signal sum_temp_ten : STD_LOGIC_VECTOR (8 downto 0);
--begin
--	process(byteA, byteB, cin, add)
--	begin
--		bcd00:=to_integer(unsigned(byteA (3 downto 0)));
--		bcd01:=to_integer(unsigned(byteA (7 downto 4)));
--		bcd10:=to_integer(unsigned(byteB (3 downto 0)));
--		bcd11:=to_integer(unsigned(byteB (7 downto 4)));
--		bcdA:=bcd01*10+bcd00;
--		bcdB:=bcd10*10+bcd10;
--		
--		byteA_temp<=to_unsigned(bcdA, 8);
--		byteB_temp<=to_unsigned(bcdB, 8);
--		
--		if (add = '0') then  --addition
--			byteBtemp <= '0' & byteB_temp;
--			sumtemp <= ('0' & byteA_temp) + byteBtemp + ("00000000" & cin);
--			isnegative <= '0'; -- positive
--		else --subtraction
--			byteBtemp <= ('0' & (NOT byteB_temp)) + '1';
--			sumtemptemp <= ('0' & byteA_temp) + byteBtemp + ("00000000" & cin); 
--			if (sumtemptemp(8) = '0' and sumtemptemp(7 downto 0) /= "00000000") then
--				sumtemp <= NOT (('0' & byteA_temp) + byteBtemp + ("00000000" & cin)) + '1'; 
--				isnegative <= '1'; --negative
--			else
--				sumtemp <= ('0' & byteA_temp) + byteBtemp + ("00000000" & cin); 
--				isnegative <= '0'; -- positive
--			end if;
--			sumtemp(8) <= '0';
--		end if;
--		
--		cout <= sumtemp(8);
--		sum_temp_full <= sumtemp(7 downto 0);
--		sum_temp_one <= sum_temp_full rem "00001010";
--		sum_temp_ten <= to_unsigned(to_integer(unsigned(sum_temp_full - sum_temp_one))/10, 8);
--		sum <= sum_temp_ten(3 downto 0) & sum_temp_one(3 downto 0);
--		
--	end process;
--end a;


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity GetBinbcd is 
	port
	(
	Digit1, Digit2 : in STD_LOGIC_VECTOR (3 downto 0);
	click		: in STD_LOGIC;
	BinOut	: out STD_LOGIC_VECTOR (7 downto 0)
	);
end GetBinbcd;	

	
architecture a of GetBinbcd is
	signal state: STD_LOGIC_VECTOR (7 downto 0);
begin
	
	process (click)
	begin
		if (click = '0') then
			state <= "00000000";
			if (Digit1 < "1010") and (Digit2 < "1010") then
				state <= (Digit1*"1010") + Digit2;
			end if;
		end if;
	end process;
	
	BinOut <= state;

end a;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity GetDisp7BitsBCD is
	port
	(
	BinIn : in STD_LOGIC_VECTOR (7 downto 0);
	click		: in STD_LOGIC;
	H00, H01, H02, H03, H04, H05, H06 : out STD_LOGIC;
	H10, H11, H12, H13, H14, H15, H16: out STD_LOGIC;
	BinOut: Out STD_LOGIC_VECTOR (7 downto 0)
	);
end GetDisp7BitsBCD;

architecture a of GetDisp7BitsBCD is

	signal binTemp : STD_LOGIC_VECTOR (7 downto 0);

	component GetBinbcd is 
		port
		(
		Digit1, Digit2 : in STD_LOGIC_VECTOR (3 downto 0);
		click		: in STD_LOGIC;
		BinOut	: out STD_LOGIC_VECTOR (7 downto 0)
		);
	end component;	
	
	component BCDto7Seg is
		port
		(
		BinIn : in STD_LOGIC_VECTOR (7 downto 0);
		H00, H01, H02, H03, H04, H05, H06 : out STD_LOGIC;
		H10, H11, H12, H13, H14, H15, H16 : out STD_LOGIC
		);
	end component;
	
begin
	BinOut <= BinTemp;
	u1: GetBinbcd port map(Digit1=>BinIn(7 downto 4), Digit2=>BinIn(3 downto 0) ,click=>click,BinOut=>binTemp);
	u2: BCDto7Seg port map(H00=>H00, H01=>H01, H02=>H02, H03=>H03, H04=>H04, H05=>H05, H06=>H06, 
									H10=>H10, H11=>H11, H12=>H12, H13=>H13, H14=>H14, H15=>H15, H16=>H16, 
									BinIn=>binTemp);
end a;