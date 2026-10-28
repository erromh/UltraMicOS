; put_char prints 1 char. takes dx as a first argument (a char)
put_char:
    mov ah, TTY_MODE
    mov al, dl
    int 10h

    ret
    
put_char_hex:            ; prints dx as 4 hex digits
    pusha
    xor bx, bx           ; page 0
    mov cx, 4
.next:
    rol dx, 4
    mov al, dl
    and al, 0x0F
    cmp al, 10
    jb .digit
    add al, 'A' - 10 - '0'
.digit:
    add al, '0'
    mov ah, TTY_MODE     ; 0x0E
    int 10h
    dec cx
    jnz .next
    popa
    ret

; print_symbol func. takes dx as a first argument (pointer to str)
print_string:
    mov si, dx

    xor ax, ax
    mov ah, TTY_MODE ; tty mode
print:
    cmp [si], 0
    je print_end

    mov dl, [si]
    call put_char

    inc si
    jmp print
print_end:
    ret

TTY_MODE equ 0x0E
HELLO_STR db "Hello World!", 0
