section .text
	global _start

_start:
	MOV ECX, 10 ; increment start value of 10
	MOV EAX, '1' ; initial character to print

L1:
	MOV [num], EAX ; store current character in memory at label 'num'
	MOV EAX, 4 ; sys_write
	MOV EBX, 1 ; stdout
	PUSH ECX ; save loop counter to the stack (INT 0x80 can modify it)

	MOV ECX, num ; load value of 'num' to the ECX register
	MOV EDX, 1 ; set EDX to number of bytes to be written
	INT 0x80 ; kernel call

	MOV EAX, [num] ; loads content of 'num' variable to the EAX register
	SUB EAX, '0' ; converts contents of EAX from ASCII to numeric
	INC EAX ; increments the EAX numeric value by 1
	ADD EAX, '0' ; converts EAX value back to ASCII from numeric
	POP ECX ; restores loop counter from the stack
	LOOP L1 ; decrements ECX and loops back to the L1 section tag

	MOV EAX, 1 ; sys_exit
	INT 0x80 ; kernel call

section .bss
	num resb 1 ; reserves a 1-byte space for the num variable
