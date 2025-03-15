section .text               ; code section
    global _start:          ; define for linker

_start:                     ; linker entry
    mov edx, 1              ; message length
    mov ecx, choice         ; message to write
    mov ebx, 1              ; stdout
    mov eax, 4              ; sys_write
    int 0x80                ; call kernel

    mov eax, 1              ; sys_exit
    int 0x80                ; call kernel

section .data               ; data section
choice db 'y', 0xA          ; define choice as 'y' with db (define byte) directive along with the 0xA (newline character)