section .data                                   ; data segment
    usrMsg db 'Please enter a number: '         ; user prompt string
    lenUsrMsg equ $ - usrMsg                    ; dynamically calculate prompt length
    dispMsg db 'Your number is '                ; output string
    lenDispMsg equ $ - dispMsg                  ; dynamically calculate display message length
    
section .bss                                    ; unitialized data
    num resb 5                                  ; reserve 5 bytes of memory for user response               

section .text                                   ; code segment
    global _start

_start:
    ; prompt user
    mov eax, 4                                  ; syscall write
    mov ebx, 1                                  ; descriptor stdout
    mov ecx, usrMsg                             ; store address of string in counter register
    mov edx, lenUsrMsg                          ; sets message length write operation
    int 0x80                                    ; ayo kernel

    ; read and store user response
    mov eax, 3                                  ; syscall read
    mov ebx, 0                                  ; descriptor stdin
    mov ecx, num                                ; store address for reserved space in counter register
    mov edx, 5                                  ; set a 5-byte maximum for read operation
    int 0x80                                    ; kernel

    ; output display message
    mov eax, 4                                  ; syscall write
    mov ebx, 1                                  ; descriptor stdout
    mov ecx, dispMsg                            ; store address of display message in counter register
    mov edx, lenDispMsg                         ; allocate space in data register for display message string
    int 0x80                                    ; kernie

    ; output user's number
    mov eax, 4                                  ; syscall write
    mov ebx, 1                                  ; descriptor stdout
    mov ecx, num                                ; load user input address for write operation
    mov edx, 5                                  ; set write operation size at 5 bytes
    int 0x80                                    ; kernel call

    ; Exit
    mov eax, 1                                  ; syscall exit
    mov ebx, 0                                  ; exit status 0
    int 0x80
