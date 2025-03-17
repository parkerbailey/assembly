SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4
STDIN equ 0
STDOUT equ 1

section .data
prompt db 'Enter a number: '
plen equ $ - prompt
even_msg db 'Number is even.', 0xA  ; Add newline for better formatting
len1 equ $ - even_msg
odd_msg db 'Number is odd.', 0xA
len2 equ $ - odd_msg

section .bss
    input resb 2        ; reserve 2 bytes for user input (one for newline)

section .text
    global _start

_start:
    ; write prompt
    MOV EAX, SYS_WRITE  ; syscall: SYS_WRITE
    MOV EBX, STDOUT     ; file desciptor: STDOUT
    MOV ECX, prompt     ; pointer to prompt message
    MOV EDX, plen       ; length of prompt message
    INT 0x80            ; call kernel to write to stdout

    ; user input
    MOV EAX, SYS_READ   ; syscall: SYS_READ
    MOV EBX, STDIN      ; file descriptor: STDIN
    MOV ECX, input      ; pointer to user input
    MOV EDX, 2          ; length of user input
    INT 0x80            ; call kernel to read to stdin

    ; convert ASCII input to decimal
    MOV AL, [input]     ; load first byte of the input variable into the AX register
    SUB AL, '0'         ; subtracting ASCII '0' to convert to decimal

    ; check even/odd using bitwise AND
    AND AL, 1           ; Perform bitwise AND with 1
                        ; If the number is even, the least significant bit (LSB) is 0, setting ZF (Zero Flag)
                        ; If the number is odd, the LSB is 1, so ZF is not set
    JZ evnn             ; Jump to 'evnn' if ZF is set (i.e., number is even)
    
    ; odd number case
    MOV EAX, SYS_WRITE  ; syscall: SYS_WRITE
    MOV EBX, STDOUT     ; file descriptor: STDOUT
    MOV ECX, odd_msg    ; pointer to "Number is odd." message
    MOV EDX, len2       ; length of the odd message
    INT 0x80            ; call kernel to write to stdout
    JMP outprog         ; jump to exit program

evnn:
    ; even number case
    MOV EAX, SYS_WRITE  ; syscall: SYS_WRITE
    MOV EBX, STDOUT     ; file descriptor: STDOUT
    MOV ECX, even_msg   ; pointer to "Number is even." message
    MOV EDX, len1       ; length of the even message
    INT 0x80            ; call kernel to write to stdout

outprog:
    MOV EAX, SYS_EXIT   ; syscall: SYS_EXIT (Linux)
    INT 0x80            ; call kernel to exit