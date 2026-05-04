; post2b.asm - Ajuste BCD (DAA/DAS)
ORG 100h
section .data
    bcd1 db 47h
    bcd2 db 38h
    msgSum db "BCD Suma: $"
    msgRes db 0Dh, 0Ah, "BCD Resta: $"
section .text
start:
    mov al, [bcd1]
    add al, [bcd2]
    daa              ; Ajuste tras suma
    mov bl, al
    mov ah, 09h
    mov dx, msgSum
    int 21h
    call printBCD

    mov al, 73h
    sub al, 28h
    das              ; Ajuste tras resta[cite: 4]
    mov bl, al
    mov ah, 09h
    mov dx, msgRes
    int 21h
    call printBCD
    mov ah, 4Ch
    int 21h

printBCD:
    mov al, bl
    shr al, 4        ; Obtener decenas[cite: 4]
    add al, 30h
    mov dl, al
    mov ah, 02h
    int 21h
    mov al, bl
    and al, 0Fh      ; Obtener unidades[cite: 4]
    add al, 30h
    mov dl, al
    int 21h
    ret