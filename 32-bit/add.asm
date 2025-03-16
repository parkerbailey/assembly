SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4
STDIN equ 0
STDOUT equ 1

section .data
	msg1 db 'Enter a digit:', 0xA
	len1 equ $ - msg1

	msg2 db 'Enter a second digit:', 0xA
	len2 equ $ - msg2

	msg3 db 'The sum is '
	len3 equ $ - msg3

segment .bss
	num1 resb 2 ; needs 2 bytes because of the user return key
	num2 resb 2 ; same
	res resb 2 ; same to have the result print the newline as well

section .text
	global _start

_start:
    ; write first message
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, msg1
	mov edx, len1
	int 0x80

    ; read in first digit
	mov eax, SYS_READ
	mov ebx, STDIN
	mov ecx, num1
	mov edx, 2
	int 0x80

    ; write second message
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, msg2
	mov edx, len2
	int 0x80

    ; read in second digit
	mov eax, SYS_READ
	mov ebx, STDIN
	mov ecx, num2
	mov edx, 2
	int 0x80

    ; write result message
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, msg3
	mov edx, len3
	int 0x80

    ; calculate sum
	mov eax, [num1] ; store first digit value in eax register
	sub eax, '0' ; subtracting ASCII '0' to convert to decimal
	mov ebx, [num2] ; store second digit value in eax register
	sub ebx, '0' ; subtracting ASCII '0' to convert to decimal
	add eax, ebx ; add values in the two registers together
	add eax, '0' ; add ASCII '0' to convert back to ASCII
	mov [res], eax ; store result of addition to the value of the res variable
    mov byte [res+1], 0xA ; store newline in the second byte of the value of res

    ; write out the resulting number
	mov eax, SYS_WRITE
	mov ebx, STDOUT
	mov ecx, res
	mov edx, 2
	int 0x80
	
exit:
	mov eax, SYS_EXIT
	xor ebx, ebx ; a quick trick to efficiently zero out a register
	int 0x80