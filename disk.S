; takes dx as a first argument, buffer to write to
; cx as a second argument, drive number
disk_read:

    push dx ; buffer to write to
    
    mov ah, 0x02

    mov dl, cl ; set driver number to the one BIOS gave us
    mov dh, 0x00 ; idk
    mov ch, 0x00
    mov cl, 0x02 ; sector 2 start at
    mov al, 0x02 ; read 2 sectors
    pop bx
    int 0x13
    
    jc disk_error
    
    ret

disk_error:
    mov dx, ERROR_STR
    call print_string

    ret

ERROR_STR db "Disk read error", 0