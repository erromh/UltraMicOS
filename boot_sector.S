org 7c00h

xor ax, ax
mov ds, ax ; make sure ds is 0
mov es, ax

mov cl, dl

mov ss, ax
mov bp, 0x7c00 ; stack grows downwards from there, code addrs go up
mov sp, bp

mov dx, HELLO_STR
call print_string

mov dx, 0x8000
mov cl, cl
call disk_read

mov dx, [0x8000]
call put_char_hex

jmp loop

%include "print.S"
%include "disk.S"

loop:
jmp $ ; $ is for jump to cur. addr, loop

times 510-($-$$) db 0
dw 0xAA55

times 256 dw 0xDEAD
times 256 dw 0xBEEF
