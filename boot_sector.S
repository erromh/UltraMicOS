ORG 7c00h

xor ax, ax
mov ds, ax ; make sure ds is 0
mov es, ax

mov ss, ax
mov bp, 0x7c00 ; stack grows downwards from there, code addrs go up
mov sp, bp

mov ax, HELLO_STR
call print_string

jmp loop

; put_char prints 1 char. takes ax as a first argument (a char)
put_char:
    push bp
    mov bp, sp

    mov ah, TTY_MODE
    int 10h

    mov sp, bp
    pop bp
    ret

; print_symbol func. takes ax as a first argument (pointer to str)
print_string:
    push bp
    mov bp, sp

    mov si, ax

    xor ax, ax
    mov ah, TTY_MODE ; tty mode
print:
    cmp [si], 0
    je print_end

    mov al, [si]
    call put_char

    inc si
    jmp print
print_end:
    mov sp, bp
    pop bp
    ret

TTY_MODE equ 0x0E
HELLO_STR db "Hello World!", 0

loop:
jmp $ ; $ is for jump to cur. addr, loop

times 510-($-$$) db 0

dw 0xAA55
