library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Lab2 is
	port
	(
	PB0, PB1 : in STD_LOGIC;
	SW	: in STD_LOGIC_VECTOR (9 downto 0);
	HEX0 	: out STD_LOGIC_VECTOR (0 to 6);
	HEX1 	: out STD_LOGIC_VECTOR (0 to 6);
	HEX2 	: out STD_LOGIC_VECTOR (0 to 6);
	HEX3 	: out STD_LOGIC_VECTOR (0 to 6);
	HEX4 	: out STD_LOGIC_VECTOR (0 to 6);
	HEX5 	: out STD_LOGIC_VECTOR (0 to 6);
	LED : out STD_LOGIC_VECTOR (9 downto 0)
	);
end Lab2;

architecture a of Lab2 is
	signal saveBin0 : STD_LOGIC;
	signal saveBin1 : STD_LOGIC;
	signal addSubSwitch : STD_LOGIC_VECTOR (9 downto 9);
	signal binIN : STD_LOGIC_VECTOR (8 downto 0);
	signal bcdIN0 : STD_LOGIC_VECTOR (3 downto 0);
	signal bcdIN1 : STD_LOGIC_VECTOR (7 downto 4);
	signal dispBCD0 : STD_LOGIC_VECTOR (6 downto 0);
	signal dispBCD1 : STD_LOGIC_VECTOR (0 to 6);
	signal dispBCD2 : STD_LOGIC_VECTOR (0 to 6);
	signal dispBCD3 : STD_LOGIC_VECTOR (0 to 6);
	signal dispBCD4 : STD_LOGIC_VECTOR (0 to 6);
	signal dispBCD5 : STD_LOGIC_VECTOR (0 to 6);
	signal dispLED : STD_LOGIC_VECTOR (9 downto 0);
	
	shared variable sign : natural; -- sign, determined by SW9
	shared variable bin0 : natural; -- bin num 0
	shared variable bin1 : natural; -- bin num 1
	shared variable bcd00 : natural; -- ones digit of bcd number 0
	shared variable bcd01 : natural; -- tenths digit of bcd number 0
	shared variable bcd10 : natural; -- ones digit of bcd number 1
	shared variable bcd11 : natural; -- tenths digit of bcd number 1
	shared variable binOut : natural; -- bin num out
	shared variable bcdOut0 : natural; -- ones digit of bcd number out
	shared variable bcdOut1 : natural; -- tenths digit of bcd number out
	
	
	component naturalTo7seg is
		port
		(
		NatIn : in natural;
		H : out STD_LOGIC_VECTOR (6 downto 0)
		--overflow : out STD_LOGIC
		);
	end component;
	
	begin
	-- store inputs from board
	saveBin0 <= PB0;
	saveBin1 <= PB1;
	addSUBSwitch <= SW (9 downto 9);
	binIN <= SW (8 downto 0);
	bcdIN0 <= SW (3 downto 0);
	bcdIN1 <= SW (7 downto 4);
	-- store outputs to board
	HEX0 <= dispBCD0;
	HEX1 <= dispBCD1;
	HEX2 <= dispBCD2;
	HEX3 <= dispBCD3;
	HEX4 <= dispBCD4;
	HEX5 <= dispBCD5;
	LED <= dispLED;

	
	-- 3 processes:
	-- 1. add/subtract changes when SW9 is changed
	-- 2. bin1, bcd00, bcd01 changes when PB0 is pressed
	-- 3. bin2, bcd10, bcd11 changes when PB1 is pressed
	
	process( addSubSwitch) is
	begin 
		sign := to_integer(unsigned(addSubSwitch));
		
		-- do math for bin
		-- should've been refactored out but whatever
		
		if (sign = 1) then
		dispLED<="1111111111";
		dispBCD0<="1111111";
		dispBCD1<="0000000";
		dispBCD2<="1111111";
		dispBCD3<="1111111";
		dispBCD4<="1111111";
		dispBCD5<="1111111";
		elsif (sign = 0) then
		dispLED<="1111111111";
		dispBCD0<="0000000";
		dispBCD1<="0000000";
		dispBCD2<="1111111";
		dispBCD3<="1111111";
		dispBCD4<="1111111";
		dispBCD5<="1111111";
		else 
		dispLED<="0000000000";
		dispBCD0<="1111111";
		dispBCD1<="0000000";
		dispBCD2<="1111111";
		dispBCD3<="1111111";
		dispBCD4<="0000000";
		dispBCD5<="1111111";
		end if;
		
		--TODO 7 seg disp
	end process;
	
	process (saveBin0) is
	begin
		if (saveBin0 = '0') then
			bcd00 := to_integer(unsigned(bcdIN0));
			bcd01 := to_integer(unsigned(bcdIN1));
			
			
		end if;
		u1: naturalTo7seg port map(NatIn=>bcd00, H=>dispBCD0);
		
	end process;
	
	
	
end a;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity naturalTo7seg is
	port
	(
	NatIn : in natural;
	H : out STD_LOGIC_VECTOR (6 downto 0)
	--overflow : out STD_LOGIC
	);
end naturalTo7seg;

architecture behavior of naturalTo7seg is
	signal Hex0Temp: STD_LOGIC_VECTOR (0 to 6);
	
begin	
	H <= Hex0Temp;
	
	process(NatIn) is
	begin
		case NatIn is
			when 0 => Hex0Temp <= "0000001";
			when 1 => Hex0Temp <= "1001111";
			when 2 => Hex0Temp <= "0010010";
			when 3 => Hex0Temp <= "0000110";
			when 4 => Hex0Temp <= "1001100";
			when 5 => Hex0Temp <= "0100100";
			when 6 => Hex0Temp <= "0100000";
			when 7 => Hex0Temp <= "0001111";
			when 8 => Hex0Temp <= "0000000";
			when 9 => Hex0Temp <= "0001100";
			when others => Hex0Temp <= "1111111";
		end case;
		
		--if (NatIn >= 0) and (NatIn < 10) then
		--	overflow <= 0;
		--else
		--	overflow <= 1;
		--end if;		
	end process;
end behavior;