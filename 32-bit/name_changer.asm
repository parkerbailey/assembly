section .text                   ; code section
    global _start               ; linker
_start:                         ; linker entry

    ; write name 'Zara Ali'
    mov edx, 9                  ; name length (includes trailing space)
    mov ecx, name               ; store name in ecx
    mov ebx, 1                  ; stdout
    mov eax, 4                  ; sys_write
    int 0x80                    ; kernel execute

    ; change first name
    mov [name], dword 'Nuha'    ; change first name to 'Nuha'

    ; write name 'Nuha Ali'
    mov edx, 8                  ; new name length
    mov ecx, name               ; store name in ecx
    mov ebx, 1                  ; stdout
    mov eax, 4                  ; sys_write
    int 0x80                    ; kernel execute

    ; exit
    mov eax, 1                  ; sys_exit
    int 0x80                    ; kernel execute

section .data                   ; data section
name db 'Zara Ali '             ; define name