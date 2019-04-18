; Blinky.asm: modified to do Lab4
$MODDE0CV

N0 equ 1000000b
N1 equ 1111001b
N2 equ 0100100b
N3 equ 0110000b
N5 equ 0010010b
N6 equ 0000011b
LO equ 1000000b
LL equ 1000111b
Lu equ 1100011b
LH equ 0001001b
Ln equ 1001000b
LC equ 0000110b
LP equ 0001100b
LLE equ 0000110b	; LE is apparently reserved
Blank equ 1111111b




org 0000H
	ljmp myprogram

;For a 33.333333MHz clock, one machine cycle takes 30ns
WaitHalfSec:
	mov R2, #90
L3: mov R1, #250
L2: mov R0, #250
L1: djnz R0, L1 ; 3 machine cycles-> 3*30ns*250=22.5us
	djnz R1, L2 ; 22.5us*250=5.625ms
	djnz R2, L3 ; 5.625ms*90=0.506s (approximately)
	ret
	
Wait1Sec:
	lcall WaitHalfSec
	lcall WaitHalfSec
	ret
	
		
	
checkKey3: ;Latches SW2 -> SW0 to R3 if Key3 is pressed
	mov a, key
	anl a, #0x08
	cjne a, #0x08, latch
nolatch: ret
latch: 
	mov a, SWA
	anl a, #0x07
	mov R3, a
	ret
	

	
	
branch:
	cjne R3, #0x00, i001
i000:
	mov R4, #0x00
	mov LEDRA, R4 ; debug lights
	ljmp part0
	ret
i001:	
	cjne R3, #0x01, i010
	mov R4, #0x01
	mov LEDRA, R4 ; debug lights
	ljmp part1
	ret
i010:	
	cjne R3, #0x02, i011
	mov R4, #0x02
	mov LEDRA, R4 ; debug lights
	ljmp part2
	ret
i011:	
	cjne R3, #0x03, i100
	mov R4, #0x03
	mov LEDRA, R4 ; debug lights
	ljmp part3
	ret
i100:	
	cjne R3, #0x04, i101
	mov R4, #0x04
	mov LEDRA, R4 ; debug lights
	ljmp part4
	ret
i101:	
	cjne R3, #0x05, i110
	mov R4, #0x05
	mov LEDRA, R4 ; debug lights
	ljmp part5
	ret
i110:	
	cjne R3, #0x06, i111
	mov R4, #0x06
	mov LEDRA, R4 ; debug lights
	ljmp part6
	ret
i111:
	cjne R3, #0x06, i111	
	mov R4, #0x07
	mov LEDRA, R4 ; debug lights
	ljmp part7
	ret
	
	
	
	
part0:
	mov HEX5, #N6
	mov HEX4, #N3
	mov HEX3, #N2
	mov HEX2, #N0
	mov HEX1, #N5
	mov HEX0, #N1
	lcall check0
	ljmp part0
	
check0:
	cjne R3, #0x00, breakA
	lcall WaitHalfSec
	lcall checkKey3
	cjne R3, #0x00, breakA
	lcall WaitHalfSec
	lcall checkKey3
	ret
	
	
	
	
part1:
	mov HEX1, #N6
	mov HEX0, #N5
	lcall check1
	ljmp part1
	
check1:
	cjne R3, #0x01, breakA
	lcall WaitHalfSec
	lcall checkKey3
	cjne R3, #0x01, breakA
	lcall WaitHalfSec
	lcall checkKey3
	ret
	
breakA: 
	mov HEX5, #Blank
	mov HEX4, #Blank
	mov HEX3, #Blank
	mov HEX2, #Blank
	mov HEX1, #Blank
	mov HEX0, #Blank
	ljmp M0
	

part2:
	mov HEX5, #N6
	mov HEX4, #N3
	mov HEX3, #N2
	mov HEX2, #N0
	mov HEX1, #N5
	mov HEX0, #N1
	mov R5, #N6
	mov R6, #N5
loop2:
	lcall check2
	mov R7, HEX5
	mov HEX5, HEX4
	mov HEX4, HEX3
	mov HEX3, HEX2
	mov HEX2, HEX1
	mov HEX1, HEX0
	mov HEX0, R5
	mov a, R6
	mov R5, a
	mov a, R7
	mov R6, a
	ljmp loop2
	
check2:
	cjne R3, #0x02, breakB
	lcall WaitHalfSec
	lcall checkKey3
	cjne R3, #0x02, breakB
	lcall WaitHalfSec
	lcall checkKey3
	ret
	


part3:
	mov HEX5, #N6
	mov HEX4, #N3
	mov HEX3, #N2
	mov HEX2, #N0
	mov HEX1, #N5
	mov HEX0, #N1
	mov R5, #N6
	mov R6, #N5
loop3:
	lcall check3
	mov a, R6
	mov R7, a
	mov a, R5
	mov R6, a
	mov R5, HEX0
	mov HEX0, HEX1
	mov HEX1, HEX2
	mov HEX2, HEX3
	mov HEX3, HEX4
	mov HEX4, HEX5
	mov HEX5, R7
	ljmp loop3
	
check3:
	cjne R3, #0x03, breakB
	lcall WaitHalfSec
	lcall checkKey3
	cjne R3, #0x03, breakB
	lcall WaitHalfSec
	lcall checkKey3
	ret

breakB: 
	mov HEX5, #Blank
	mov HEX4, #Blank
	mov HEX3, #Blank
	mov HEX2, #Blank
	mov HEX1, #Blank
	mov HEX0, #Blank
	ljmp M0
	
part4:
	mov HEX5, #N2
	mov HEX4, #N0
	mov HEX3, #N5
	mov HEX2, #N1
	mov HEX1, #N6
	mov HEX0, #N5
	cjne R3, #0x04, breakB
	lcall WaitHalfSec
	lcall checkKey3
	cjne R3, #0x04, breakB
	lcall WaitHalfSec
	lcall checkKey3
	mov HEX5, #Blank
	mov HEX4, #Blank
	mov HEX3, #Blank
	mov HEX2, #Blank
	mov HEX1, #Blank
	mov HEX0, #Blank
	cjne R3, #0x04, breakB
	lcall WaitHalfSec
	lcall checkKey3
	cjne R3, #0x04, breakB
	lcall WaitHalfSec
	lcall checkKey3
	ljmp part4
	
	
part5:
	mov HEX5, #N6
	cjne R3, #0x05, breakC
	lcall Wait1Sec
	lcall checkKey3
	mov HEX4, #N3
	cjne R3, #0x05, breakC
	lcall Wait1Sec
	lcall checkKey3
	mov HEX3, #N2
	cjne R3, #0x05, breakC
	lcall Wait1Sec
	lcall checkKey3
	mov HEX2, #N0
	cjne R3, #0x05, breakC
	lcall Wait1Sec
	lcall checkKey3
	mov HEX1, #N5
	cjne R3, #0x05, breakC
	lcall Wait1Sec
	lcall checkKey3
	mov HEX0, #N1
	cjne R3, #0x05, breakC
	lcall Wait1Sec
	lcall checkKey3
	mov HEX5, #Blank
	mov HEX4, #Blank
	mov HEX3, #Blank
	mov HEX2, #Blank
	mov HEX1, #Blank
	mov HEX0, #Blank
	cjne R3, #0x05, breakC
	lcall Wait1Sec
	lcall checkKey3
	ljmp part5	
	
breakC: 
	mov HEX5, #Blank
	mov HEX4, #Blank
	mov HEX3, #Blank
	mov HEX2, #Blank
	mov HEX1, #Blank
	mov HEX0, #Blank
	ljmp M0
	
part6:
	mov HEX5, #LH
	mov HEX4, #LLE
	mov HEX3, #LL
	mov HEX2, #LL
	mov HEX1, #LO
	mov HEX0, #Blank
	cjne R3, #0x06, breakC
	lcall Wait1Sec
	lcall checkKey3
	mov HEX5, #N6
	mov HEX4, #N3
	mov HEX3, #N2
	mov HEX2, #N0
	mov HEX1, #N5
	mov HEX0, #N1
	cjne R3, #0x06, breakC
	lcall Wait1Sec
	lcall checkKey3
	mov HEX5, #LC
	mov HEX4, #LP
	mov HEX3, #Ln
	mov HEX2, #N3
	mov HEX1, #N1
	mov HEX0, #N2
	cjne R3, #0x06, breakC
	lcall Wait1Sec
	lcall checkKey3
	ljmp part6

breakD: 
	mov HEX5, #Blank
	mov HEX4, #Blank
	mov HEX3, #Blank
	mov HEX2, #Blank
	mov HEX1, #Blank
	mov HEX0, #Blank
	ljmp M0

part7:
	mov HEX5, #N6
	cjne R3, #0x05, breakD
	lcall Wait1Sec
	lcall checkKey3
	mov HEX5, #N3
	cjne R3, #0x05, breakD
	lcall Wait1Sec
	lcall checkKey3
	mov HEX5, #N2
	cjne R3, #0x05, breakD
	lcall Wait1Sec
	lcall checkKey3
	mov HEX5, #N0
	cjne R3, #0x05, breakD
	lcall Wait1Sec
	lcall checkKey3
	mov HEX5, #N5
	cjne R3, #0x05, breakD
	lcall Wait1Sec
	lcall checkKey3
	mov HEX5, #N1
	cjne R3, #0x05, breakD
	lcall Wait1Sec
	lcall checkKey3
	mov HEX5, #N6
	cjne R3, #0x05, breakD
	lcall Wait1Sec
	lcall checkKey3
	mov HEX5, #N5
	cjne R3, #0x05, breakD
	lcall Wait1Sec
	lcall checkKey3
	ljmp part7

myprogram:
	mov SP, #7FH ; Set the beginning of the stack (more on this later)
	mov LEDRA, #0 ; Turn off all unused LEDs (Too bright!)
	mov LEDRB, #0
M0:
	lcall checkKey3
	lcall branch
	ljmp M0
END