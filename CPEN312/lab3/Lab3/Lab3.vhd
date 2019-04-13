library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity lab3 is 
	port
	(
	PB0, PB1, PB2, PB3 	: in STD_LOGIC;
	CLOCK_50					: in STD_LOGIC;
	SW0, SW1, SW2, SW3, SW4, SW5, SW6, SW7, SW8, SW9	: in STD_LOGIC;
	HEX00, HEX01, HEX02, HEX03, HEX04, HEX05, HEX06 	: out STD_Logic;
	HEX10, HEX11, HEX12, HEX13, HEX14, HEX15, HEX16 	: out STD_Logic;
	HEX20, HEX21, HEX22, HEX23, HEX24, HEX25, HEX26 	: out STD_Logic;
	HEX30, HEX31, HEX32, HEX33, HEX34, HEX35, HEX36 	: out STD_Logic;
	HEX40, HEX41, HEX42, HEX43, HEX44, HEX45, HEX46		: out STD_Logic;
	HEX50, HEX51, HEX52, HEX53, HEX54, HEX55, HEX56 	: out STD_Logic
	);
end lab3;

architecture test of lab3 is	
	signal zap : STD_LOGIC_VECTOR (9 downto 0) := "0000000000";
	signal sec, min, hour, BinIn : STD_LOGIC_VECTOR(7 downto 0);
	
	component clock is
		port
			(
			tick 					: out STD_LOGIC;
			clk, enable 		: in STD_LOGIC;
			zap 					: out STD_LOGIC_VECTOR (9 downto 0);
			sec, min, hour 	: out STD_LOGIC_VECTOR(7 downto 0);
			setS, setM, setH	: in STD_LOGIC;
			BinIn					: in STD_LOGIC_VECTOR (7 downto 0)
			);
		end component;
		
	component binto7seg is
			port
			(
			BinIn : in STD_LOGIC_VECTOR (7 downto 0);
			H00, H01, H02, H03, H04, H05, H06 : out STD_LOGIC;
			H10, H11, H12, H13, H14, H15, H16: out STD_LOGIC;
			overflow : out STD_LOGIC
			);
		end component;
	
begin

	BinIn(0) <= SW0;
	BinIn(1) <= SW1;
	BinIn(2) <= SW2;
	BinIn(3) <= SW3;
	BinIn(4) <= SW4;
	BinIn(5) <= SW5;
	BinIn(6) <= SW6;
	BinIn(7) <= SW7;

	u1: clock port map (clk=>CLOCK_50, enable=>SW9, zap=>zap, BinIn=>BinIn,
								setS=>PB0, setM=>PB1, setH=>PB2, sec=>sec, min=>min, hour=>hour);
								
	u2: binto7seg port map (H00=>HEX40, H01=>HEX41, H02=>HEX42, H03=>HEX43, H04=>HEX44, H05=>HEX45, H06=>HEX46, 
									H10=>HEX50, H11=>HEX51, H12=>HEX52, H13=>HEX53, H14=>HEX54, H15=>HEX55, H16=>HEX56, 
									BinIn=>hour);
									
	u3: binto7seg port map (H00=>HEX20, H01=>HEX21, H02=>HEX22, H03=>HEX23, H04=>HEX24, H05=>HEX25, H06=>HEX26, 
									H10=>HEX30, H11=>HEX31, H12=>HEX32, H13=>HEX33, H14=>HEX34, H15=>HEX35, H16=>HEX36, 
									BinIn=>min);

	u4: binto7seg port map (H00=>HEX00, H01=>HEX01, H02=>HEX02, H03=>HEX03, H04=>HEX04, H05=>HEX05, H06=>HEX06, 
									H10=>HEX10, H11=>HEX11, H12=>HEX12, H13=>HEX13, H14=>HEX14, H15=>HEX15, H16=>HEX16,  
									BinIn=>sec);
end test;




library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity binto7seg is
	port
	(
	BinIn : in STD_LOGIC_VECTOR (7 downto 0);
	H00, H01, H02, H03, H04, H05, H06 : out STD_LOGIC;
	H10, H11, H12, H13, H14, H15, H16: out STD_LOGIC;
	overflow : out STD_LOGIC
	);
end binto7seg;

architecture behavior of binto7seg is
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
			when "00000000" => Hex1Temp <= "0000001"; Hex0Temp <= "0000001";
			when "00000001" => Hex1Temp <= "0000001"; Hex0Temp <= "1001111";
			when "00000010" => Hex1Temp <= "0000001"; Hex0Temp <= "0010010";
			when "00000011" => Hex1Temp <= "0000001"; Hex0Temp <= "0000110";
			when "00000100" => Hex1Temp <= "0000001"; Hex0Temp <= "1001100";
			when "00000101" => Hex1Temp <= "0000001"; Hex0Temp <= "0100100";
			when "00000110" => Hex1Temp <= "0000001"; Hex0Temp <= "0100000";
			when "00000111" => Hex1Temp <= "0000001"; Hex0Temp <= "0001111";
			when "00001000" => Hex1Temp <= "0000001"; Hex0Temp <= "0000000";
			when "00001001" => Hex1Temp <= "0000001"; Hex0Temp <= "0001100";
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
end behavior;






library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity get7bitsbcd is 
	port
	(
	Digit1, Digit2 : in STD_LOGIC_VECTOR (3 downto 0);
	click		: in STD_LOGIC;
	BinOut	: out STD_LOGIC_VECTOR (7 downto 0)
	);
end get7bitsbcd;	

	
architecture behavior of get7bitsbcd is
	signal state: STD_LOGIC_VECTOR (7 downto 0) := "00000000";
begin
	
	process (click)
	begin
		if (click = '0') then
			if (Digit1 < "1010") and (Digit2 < "1010") then
				state <= (Digit1*"1010") + Digit2;
			end if;
		end if;
	end process;
	
	BinOut <= state;

end behavior;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity clock is
port
	(
	tick 					: out STD_LOGIC;
	clk, enable 		: in STD_LOGIC;
	zap 					: out STD_LOGIC_VECTOR (9 downto 0);
	sec, min, hour 	: out std_logic_vector(7 downto 0);
	setS, setM, setH	: in STD_LOGIC;
	BinIn					: in STD_LOGIC_VECTOR (7 downto 0)
	);
end clock;

architecture behavior of clock is

	signal count : integer :=1;
	signal tock : std_logic :='0';
	signal zip : std_logic_vector (9 downto 0);
	signal count2 : integer :=1;
	signal temp, tempS, tempM : std_logic_vector(7 downto 0) := "00000000";
	signal tempH : std_logic_vector(7 downto 0) := "00001100";
	
	function BinToBCD (
		 BinIn : in std_logic_vector(7 downto 0))
		 return std_logic_vector is 
		 variable var : std_logic_vector(7 downto 0); 
		 variable digit1, digit2 : std_logic_vector(3 downto 0);
	begin 
		Digit1 := BinIn(7 downto 4);
		Digit2 := BinIn(3 downto 0);
		if (Digit1 < "1010") and (Digit2 < "1010") then
			var := (Digit1*"1010") + Digit2;
		else
			var := "10000000";
		end if;
		return var;
	end BinToBCD;
	
begin
	
	process(clk, enable)
	begin
		if (clk = '1' and clk'event and enable = '0') then
		count <=count+1;
			if (count = 500000) then
				count2 <= count2+1;
				case count2 is
					when 1 => zip <= "1111111110"; tock <= not tock;
					when 2 => zip <= "1111111110";
					when 3 => zip <= "1111111110";
					when 4 => zip <= "1111111110";
					when 5 => zip <= "1111111110";
					when 6 => zip <= "1111111110";
					when 7 => zip <= "1111111110";
					when 8 => zip <= "1111111110";
					when 9 => zip <= "1111111110";
					when 10 => zip <= "1111111110";
					when 11 => zip <= "1111111110";
					when 12 => zip <= "1111111100";
					when 13 => zip <= "1111111100";
					when 14 => zip <= "1111111100";
					when 15 => zip <= "1111111100";
					when 16 => zip <= "1111111100";
					when 17 => zip <= "1111111100";
					when 18 => zip <= "1111111100";
					when 19 => zip <= "1111111100";
					when 20 => zip <= "1111111101";
					when 21 => zip <= "1111111101";
					when 22 => zip <= "1111111101";
					when 23 => zip <= "1111111101";
					when 24 => zip <= "1111111101";
					when 25 => zip <= "1111111101";
					when 26 => zip <= "1111111001";
					when 27 => zip <= "1111111001";
					when 28 => zip <= "1111111001";
					when 29 => zip <= "1111111001";
					when 30 => zip <= "1111111001";
					when 31 => zip <= "1111111011";
					when 32 => zip <= "1111111011";
					when 33 => zip <= "1111111011";
					when 34 => zip <= "1111111011";
					when 35 => zip <= "1111110011";
					when 36 => zip <= "1111110011";
					when 37 => zip <= "1111110011";
					when 38 => zip <= "1111110011";
					when 39 => zip <= "1111110111";
					when 40 => zip <= "1111110111";
					when 41 => zip <= "1111110111";
					when 42 => zip <= "1111110111";
					when 43 => zip <= "1111100111";
					when 44 => zip <= "1111100111";
					when 45 => zip <= "1111100111";
					when 46 => zip <= "1111101111";
					when 47 => zip <= "1111101111";
					when 48 => zip <= "1111101111";
					when 49 => zip <= "1111101111";
					when 50 => zip <= "1111001111";
					when 51 => zip <= "1111001111"; tock <= not tock;
					when 52 => zip <= "1111001111";
					when 53 => zip <= "1111011111";
					when 54 => zip <= "1111011111";
					when 55 => zip <= "1111011111";
					when 56 => zip <= "1111011111";
					when 57 => zip <= "1110011111";
					when 58 => zip <= "1110011111";
					when 59 => zip <= "1110011111";
					when 60 => zip <= "1110111111";
					when 61 => zip <= "1110111111";
					when 62 => zip <= "1110111111";
					when 63 => zip <= "1110111111";
					when 64 => zip <= "1100111111";
					when 65 => zip <= "1100111111";
					when 66 => zip <= "1100111111";
					when 67 => zip <= "1100111111";
					when 68 => zip <= "1101111111";
					when 69 => zip <= "1101111111";
					when 70 => zip <= "1101111111";
					when 71 => zip <= "1101111111";
					when 72 => zip <= "1001111111";
					when 73 => zip <= "1001111111";
					when 74 => zip <= "1001111111";
					when 75 => zip <= "1001111111";
					when 76 => zip <= "1001111111";
					when 77 => zip <= "1011111111";
					when 78 => zip <= "1011111111";
					when 79 => zip <= "1011111111";
					when 80 => zip <= "1011111111";
					when 81 => zip <= "1011111111";
					when 82 => zip <= "1011111111";
					when 83 => zip <= "0011111111";
					when 84 => zip <= "0011111111";
					when 85 => zip <= "0011111111";
					when 86 => zip <= "0011111111";
					when 87 => zip <= "0011111111";
					when 88 => zip <= "0011111111";
					when 89 => zip <= "0011111111";
					when 90 => zip <= "0011111111";
					when 91 => zip <= "0111111111";
					when 92 => zip <= "0111111111";
					when 93 => zip <= "0111111111";
					when 94 => zip <= "0111111111";
					when 95 => zip <= "0111111111";
					when 96 => zip <= "0111111111";
					when 97 => zip <= "0111111111";
					when 98 => zip <= "0111111111";
					when 99 => zip <= "0111111111";
					when 100 => zip <= "0111111111";
					when 101 => zip <= "0111111111"; tock <= not tock;
					when 102 => zip <= "0111111111";
					when 103 => zip <= "0111111111";
					when 104 => zip <= "0111111111";
					when 105 => zip <= "0111111111";
					when 106 => zip <= "0111111111";
					when 107 => zip <= "0111111111";
					when 108 => zip <= "0111111111";
					when 109 => zip <= "0111111111";
					when 110 => zip <= "0111111111";
					when 111 => zip <= "0111111111";
					when 112 => zip <= "0011111111";
					when 113 => zip <= "0011111111";
					when 114 => zip <= "0011111111";
					when 115 => zip <= "0011111111";
					when 116 => zip <= "0011111111";
					when 117 => zip <= "0011111111";
					when 118 => zip <= "0011111111";
					when 119 => zip <= "0011111111";
					when 120 => zip <= "1011111111";
					when 121 => zip <= "1011111111";
					when 122 => zip <= "1011111111";
					when 123 => zip <= "1011111111";
					when 124 => zip <= "1011111111";
					when 125 => zip <= "1011111111";
					when 126 => zip <= "1001111111";
					when 127 => zip <= "1001111111";
					when 128 => zip <= "1001111111";
					when 129 => zip <= "1001111111";
					when 130 => zip <= "1001111111";
					when 131 => zip <= "1101111111";
					when 132 => zip <= "1101111111";
					when 133 => zip <= "1101111111";
					when 134 => zip <= "1101111111";
					when 135 => zip <= "1100111111";
					when 136 => zip <= "1100111111";
					when 137 => zip <= "1100111111";
					when 138 => zip <= "1100111111";
					when 139 => zip <= "1110111111";
					when 140 => zip <= "1110111111";
					when 141 => zip <= "1110111111";
					when 142 => zip <= "1110111111";
					when 143 => zip <= "1110011111";
					when 144 => zip <= "1110011111";
					when 145 => zip <= "1110011111";
					when 146 => zip <= "1111011111";
					when 147 => zip <= "1111011111";
					when 148 => zip <= "1111011111";
					when 149 => zip <= "1111011111";
					when 150 => zip <= "1111001111";
					when 151 => zip <= "1111001111"; tock <= not tock;
					when 152 => zip <= "1111001111";
					when 153 => zip <= "1111101111";
					when 154 => zip <= "1111101111";
					when 155 => zip <= "1111101111";
					when 156 => zip <= "1111101111";
					when 157 => zip <= "1111100111";
					when 158 => zip <= "1111100111";
					when 159 => zip <= "1111100111";
					when 160 => zip <= "1111110111";
					when 161 => zip <= "1111110111";
					when 162 => zip <= "1111110111";
					when 163 => zip <= "1111110111";
					when 164 => zip <= "1111110011";
					when 165 => zip <= "1111110011";
					when 166 => zip <= "1111110011";
					when 167 => zip <= "1111110011";
					when 168 => zip <= "1111111011";
					when 169 => zip <= "1111111011";
					when 170 => zip <= "1111111011";
					when 171 => zip <= "1111111011";
					when 172 => zip <= "1111111001";
					when 173 => zip <= "1111111001";
					when 174 => zip <= "1111111001";
					when 175 => zip <= "1111111001";
					when 176 => zip <= "1111111001";
					when 177 => zip <= "1111111101";
					when 178 => zip <= "1111111101";
					when 179 => zip <= "1111111101";
					when 180 => zip <= "1111111101";
					when 181 => zip <= "1111111101";
					when 182 => zip <= "1111111101";
					when 183 => zip <= "1111111100";
					when 184 => zip <= "1111111100";
					when 185 => zip <= "1111111100";
					when 186 => zip <= "1111111100";
					when 187 => zip <= "1111111100";
					when 188 => zip <= "1111111100";
					when 189 => zip <= "1111111100";
					when 190 => zip <= "1111111100";
					when 191 => zip <= "1111111110";
					when 192 => zip <= "1111111110";
					when 193 => zip <= "1111111110";
					when 194 => zip <= "1111111110";
					when 195 => zip <= "1111111110";
					when 196 => zip <= "1111111110";
					when 197 => zip <= "1111111110";
					when 198 => zip <= "1111111110";
					when 199 => zip <= "1111111110";
					when others => zip <= "1111111110"; count2<=1;
				end case;
				count <= 1;
			end if;
		end if;
	end process;
	
	process(tock, enable, setS, setM, setH)
   
	begin
		
		if (enable = '1') then
			if (tempS > "00111011") then
				tempS <= "00000000";
			end if;
			if (tempM > "00111011") then
				tempM <= "00000000";
			end if;
			if (tempH > "00001100") or (tempH < "00000001") then
				tempH <= "00001100";
			end if;
		
		elsif (setS = '0') then
			temp <= BinToBCD(BinIn);
			if (temp <= "00111011") then
				tempS <= temp;
			end if;

		
		elsif (setM = '0') then
			temp <= BinToBCD(BinIn);
			if (temp <= "00111011") then
				tempM <= temp;
			end if;

		
		elsif (setH = '0') then
			temp <= BinToBCD(BinIn);
			if (temp <= "00001100") and (temp >= "00000001") then
				tempH <= temp;
			end if;

		
		elsif(tock = '1' and tock'event and enable = '0') then
			tempS <= tempS + "00000001";
			if(tempS >= "00111011") then
				tempS <="00000000";
				tempM <= tempM + "00000001";
				if(tempM >= "00111011") then
					tempH <= tempH + "00000001";
					tempM <= "00000000";
					if(tempH >= "00001101") or (tempH <= "00000000") then
						tempH <= "00000001";
					end if;
				end if;
			end if;
		end if;

	end process;
	
	tick <= tock;
	zap <= NOT zip;
	sec <= tempS;
	min <= tempM;
	hour <= tempH;
	
end behavior;
