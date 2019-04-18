; Blinky.asm: blinks LEDR0 of the CV-8052 each second.
$MODDE0CV

; long hold on KEY3 to trigger changes

org 0000H
	ljmp myprogram

_7seg:
	DB 0xC0, 0xF9, 0xA4, 0xB0, 0x99
	DB 0x92, 0x82, 0xF8, 0x80, 0x90
	DB 0xFF
	
myprogram:
	lcall initializeLEDs
	ljmp checkKeyIndef
	
checkSwitch:
	mov A, SWA	
	anl A, #00000111b
	mov R3, A
	cjne R3, #000b, not000
	ljmp case000
	
	not000:
	cjne R3, #001b, not001
	ljmp case001	
	
	not001:
	cjne R3, #010b, not010
	ljmp case010
	
	not010:
	cjne R3, #011b, not011
	ljmp case011
	
	not011:
	cjne R3, #100b, not100
	ljmp case100
	
	not100:
	cjne R3, #101b, not101
	ljmp case101
	
	not101:
	cjne R3, #110b, case111buffer
	ljmp case110

case111buffer:
	ljmp case111

case000:
	lcall setTo6mostSigFig
	ljmp checkKeyIndef

case001:
	mov dptr, #_7seg
	mov A, #10
	movc A, @A+dptr
	mov HEX5, A
	mov A, #10
	movc A, @A+dptr
	mov HEX4, A
	mov A, #10
	movc A, @A+dptr
	mov HEX3, A
	mov A, #10
	movc A, @A+dptr
	mov HEX2, A
	mov A, #6
	movc A, @A+dptr
	mov HEX1, A
	mov A, #5
	movc A, @A+dptr
	mov HEX0, A
	ljmp checkKeyIndef

case010:
	lcall setTo6mostSigFig
	mov dptr, #_7seg
	mov A, #6
	movc A, @A+dptr
	mov R3, A
	mov A, #5
	movc A, @A+dptr
	mov R4, A
	
	scrollLeft:
	lcall waitHalfSec
	mov A, HEX5
	mov R5, A
	mov HEX5, HEX4
	mov HEX4, HEX3
	mov HEX3, HEX2
	mov HEX2, HEX1
	mov HEX1, HEX0
	mov HEX0, R3
	mov A, R4
	mov R3, A
	mov A, R5
	mov R4, A
	lcall checkKeyOnce
	ljmp scrollLeft
	
case011:
	lcall setTo6mostSigFig
	mov dptr, #_7seg
	mov A, #6
	movc A, @A+dptr
	mov R3, A
	mov A, #5
	movc A, @A+dptr
	mov R4, A
	
	scrollRight:
	lcall waitHalfSec
	mov A, R4
	mov R5, A
	mov A, R3
	mov R4, A
	mov R3, HEX0
	mov HEX0, HEX1
	mov HEX1, HEX2
	mov HEX2, HEX3
	mov HEX3, HEX4
	mov HEX4, HEX5
	mov A, R5
	mov HEX5, A
	lcall checkKeyOnce
	ljmp scrollRight
	
case100:
	lcall setTo6leastSigFig
	lcall waitHalfSec
	lcall checkKeyOnce
	lcall setToBlank
	lcall waitHalfSec
	lcall checkKeyOnce
	ljmp case100

case101:
	lcall checkKeyOnce
	lcall setToBlank
	mov dptr, #_7seg
	mov A, #6
	movc A, @A+dptr
	mov HEX5, A
	lcall waitHalfSec
	mov A, #3
	movc A, @A+dptr
	mov HEX4, A
	lcall waitHalfSec
	mov A, #2
	movc A, @A+dptr
	mov HEX3, A
	lcall waitHalfSec
	mov A, #0
	movc A, @A+dptr
	mov HEX2, A
	lcall waitHalfSec
	mov A, #5
	movc A, @A+dptr
	mov HEX1, A
	lcall waitHalfSec
	mov A, #1
	movc A, @A+dptr
	mov HEX0, A
	lcall waitHalfSec
	ljmp case101

case110: 
	mov HEX0, #11111111b
	mov HEX1, #11000000b
	mov HEX2, #11000111b
	mov HEX3, #11000111b
	mov HEX4, #10000110b
	mov HEX5, #10001001b
	lcall waitHalfSec
	lcall waitHalfSec
	lcall checkKeyOnce
	lcall setTo6mostSigFig
	lcall waitHalfSec
	lcall waitHalfSec
	lcall checkKeyOnce
	mov HEX0, #10100100b
	mov HEX1, #11111001b
	mov HEX2, #10110000b
	mov HEX3, #11001000b
	mov HEX4, #10001100b
	mov HEX5, #11000110b
	lcall waitHalfSec
	lcall waitHalfSec
	lcall checkKeyOnce
	ljmp case110

case111:
	mov HEX0, #11111111b
	mov HEX1, #11111110b
	mov HEX2, #11111000b
	mov HEX3, #10000110b
	mov HEX4, #10000110b
	mov HEX5, #10011001b
	ljmp checkKeyIndef


checkKeyIndef:
	jnb KEY.3, checkSwitchBuffer
	ljmp checkKeyIndef
	
checkKeyOnce:
	jnb KEY.3, checkSwitchBuffer
	ret
	
checkSwitchBuffer:
	ljmp checkSwitch

initializeLEDs:
	clr C
	clr A
	
	mov LEDRA, #00000000b
	mov A, LEDRB
	anl A, #00b
	mov LEDRB, A
	
	lcall setToBlank
	
	ret
	
;For a 33.333333MHz clock, one machine cycle takes 30ns
waitHalfSec:
	mov R2, #90
L3: mov R1, #250
L2: mov R0, #250
L1: djnz R0, L1 ; 3 machine cycles-> 3*30ns*250=22.5us
	djnz R1, L2 ; 22.5us*250=5.625ms
	djnz R2, L3 ; 5.625ms*90=0.506s (approximately)
	ret
	
setTo6mostSigFig:
	mov dptr, #_7seg
	mov A, #6
	movc A, @A+dptr
	mov HEX5, A
	mov A, #3
	movc A, @A+dptr
	mov HEX4, A
	mov A, #2
	movc A, @A+dptr
	mov HEX3, A
	mov A, #0
	movc A, @A+dptr
	mov HEX2, A
	mov A, #5
	movc A, @A+dptr
	mov HEX1, A
	mov A, #1
	movc A, @A+dptr
	mov HEX0, A
	ret
	
setTo6leastSigFig:
	mov dptr, #_7seg
	mov A, #2
	movc A, @A+dptr
	mov HEX5, A
	mov A, #0
	movc A, @A+dptr
	mov HEX4, A
	mov A, #5
	movc A, @A+dptr
	mov HEX3, A
	mov A, #1
	movc A, @A+dptr
	mov HEX2, A
	mov A, #6
	movc A, @A+dptr
	mov HEX1, A
	mov A, #5
	movc A, @A+dptr
	mov HEX0, A
	ret
	
setToBlank:
	mov A, #10
	mov dptr, #_7seg
	movc A, @A+dptr
	mov HEX0, A
	mov HEX1, A
	mov HEX2, A
	mov HEX3, A
	mov HEX4, A
	mov HEX5, A
	ret
	
END