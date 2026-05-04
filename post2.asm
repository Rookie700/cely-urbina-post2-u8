; post2.asm - Suma y Resta de 32 bits (ADC/SBB)
ORG 100h

section .data
    ; Numeros de prueba: A = 0001FFFFh, B = 00010001h
    aLo dw 0FFFFh
    aHi dw 0001h
    bLo dw 0001h
    bHi dw 0001h
    msgSum db "Suma OK: 0003:0000$", 0Dh, 0Ah, "$"
    msgRes db "Resta OK: 0001:FFFFh$", 0Dh, 0Ah, "$"
    msgErr db "Error en operacion.$"

section .text
start:
    ; --- SUMA 32 BITS ---
    mov ax, [aLo]
    mov dx, [aHi]
    add ax, [bLo]    ; Sumar partes bajas
    adc dx, [bHi]    ; Sumar partes altas + acarreo
    
    cmp ax, 0000h
    jne .error
    cmp dx, 0003h
    jne .error
    mov ah, 09h
    mov dx, msgSum
    int 21h

    ; --- RESTA 32 BITS ---
    mov ax, 0000h    ; Parte baja de A
    mov dx, 0003h    ; Parte alta de A
    sub ax, 0001h    ; Restar bajas (genera prestamo)
    sbb dx, 0001h    ; Restar altas - prestamo

    cmp ax, 0FFFFh
    jne .error
    cmp dx, 0001h
    jne .error
    mov ah, 09h
    mov dx, msgRes
    int 21h
    jmp .fin

.error:
    mov ah, 09h
    mov dx, msgErr
    int 21h
.fin:
    mov ah, 4Ch
    int 21h