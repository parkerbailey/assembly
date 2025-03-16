section .text
	global _start

_start:
	mov ax, '8'
	sub ax, '0'

	mov bl, '2'
	sub bl, '0'
	div bl
	add ax, '0'

	mov [res], ax
	mov byte [res+1], 0xA
	mov ecx, msg
	mov edx, len
	mov ebx, 1
	mov eax, 4
	int 0x80

	mov ecx, res
	mov edx, 2
	mov ebx, 1
	mov eax, 4
	int 0x80

	mov eax, 1
	int 0x80

section .data
msg db 'The result is '
len equ $ - msg

section .bss
res resb 2