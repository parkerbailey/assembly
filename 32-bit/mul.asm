section .text
	global _start

_start:
	mov al, '3'             ; store multiplicand in al
	sub al, '0'             ; convert to decimal

	mov bl, '2'             ; store multiplier in bl
	sub bl, '0'             ; convert to decimal
	mul bl                  ; multiply al and bl (AX = AL * BL)
	add al, '0'             ; convert al back to ASCII

	mov [res], al           ; set value of res to the contents of al (the product)
    mov byte [res+1], 0xA   ; add newline to result 

	mov ecx, msg            ; move msg to ecx register
	mov edx, len            ; store message length in edx register
	mov ebx, 1              ; stdout
	mov eax, 4              ; sys_write
	int 0x80                ; kernel

	mov ecx, res            ; res to ecx register
	mov edx, 2              ; length of result
	mov ebx, 1              ; stdout
	mov eax, 4              ; sys_write
	int 0x80                ; kernel

	mov eax, 1              ; sys_exit
	int 0x80                ; kernel

section .data
msg db 'The result is '     ; define message
len equ $ - msg             ; msg length

section .bss
res resb 2                  ; reserve two bytes, one for result, one for newline