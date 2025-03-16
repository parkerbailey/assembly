section .text
	global _start

_start:
	mov ax, '8'             ; ASCII '8' to ax register
	sub ax, '0'             ; convert to decimal

	mov bl, '2'             ; ASCII '2' to bl register
	sub bl, '0'             ; convert to decimal
	div bl                  ; perform division
	add ax, '0'             ; convert quotient back to ASCII

	mov [res], ax           ; mov quotient result from ax register to res value
	mov byte [res+1], 0xA   ; add newline character to result
	mov ecx, msg            ; move msg to ecx register
	mov edx, len            ; move length to edx register
	mov ebx, 1              ; stdout
	mov eax, 4              ; sys_write
	int 0x80

	mov ecx, res            ; move result variable to ecx register
	mov edx, 2              ; move length 2 of result to edx register
	mov ebx, 1              ; stdout
	mov eax, 4              ; sys_write
	int 0x80

	mov eax, 1              ; exit
	int 0x80

section .data
msg db 'The result is '     ; define message
len equ $ - msg             ; calcualte message length

section .bss
res resb 2                  ; reserve 2 bytes for results