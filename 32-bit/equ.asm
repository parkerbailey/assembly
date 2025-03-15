sys_exit equ 1
sys_write equ 4
stdin equ 0
stdout equ 1

section .text
    global _start

_start:
    ; write msg1
    mov eax, sys_write
    mov ebx, stdout
    mov ecx, msg1
    mov edx, len1
    int 0x80

    ; write msg2
    mov eax, sys_write
    mov ebx, stdout
    mov ecx, msg2
    mov edx, len2
    int 0x80

    ; write msg3
    mov eax, sys_write
    mov ebx, stdout
    mov ecx, msg3
    mov edx, len3
    int 0x80

    ; exit
    mov eax, sys_exit
    int 0x80

section .data
msg1 db 'Hello programmers!', 0xA
len1 equ $ - msg1

msg2 db 'Welcome to the world of', 0xA
len2 equ $ - msg2

msg3 db 'Linux Assembly programming!', 0xA
len3 equ $ - msg3