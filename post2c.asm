; post2c.asm - Calculadora con MUL y DIV (Version Ultra-Compatible)
ORG 100h

section .data
    ; Separamos los mensajes para evitar errores de sintaxis en el parser
    pA     db 'Primer operando (0-9): $'
    
    pB_nl  db 0Dh, 0Ah, '$'
    pB_txt db 'Segundo operando (0-9): $'
    
    pOp_nl db 0Dh, 0Ah, '$'
    pOp_tx db 'Operacion (* o /): $'
    
    msgR   db 0Dh, 0Ah, 'Resultado: $'
    msgErr db 0Dh, 0Ah, 'Error: Div por 0$', '$'
    crlf   db 0Dh, 0Ah, '$'

section .text
start:
    ; --- Leer operando A ---
    mov ah, 09h
    mov dx, pA
    int 21h
    mov ah, 01h
    int 21h
    sub al, 30h
    mov bl, al

    ; --- Leer operando B ---
    mov ah, 09h
    mov dx, pB_nl
    int 21h
    mov dx, pB_txt
    int 21h
    mov ah, 01h
    int 21h
    sub al, 30h
    mov cl, al

    ; --- Leer operador ---
    mov ah, 09h
    mov dx, pOp_nl
    int 21h
    mov dx, pOp_tx
    int 21h
    mov ah, 01h
    int 21h
    mov bh, al

    ; --- Mostrar Resultado ---
    mov ah, 09h
    mov dx, msgR
    int 21h

    cmp bh, '*'
    je .multiplicar
    cmp bh, '/'
    je .dividir
    jmp .fin

.multiplicar:
    mov al, bl
    mul cl          ; AX = AL * CL
    call imprimirAX
    jmp .fin

.dividir:
    cmp cl, 0
    je .errorDiv
    xor ah, ah
    mov al, bl
    div cl          ; AL = cociente, AH = residuo
    push ax
    xor ah, ah      ; Imprimir solo el cociente
    call imprimirAX
    pop ax
    jmp .fin

.errorDiv:
    mov ah, 09h
    mov dx, msgErr
    int 21h

.fin:
    mov ah, 09h
    mov dx, crlf
    int 21h
    mov ah, 4Ch
    int 21h

; --- Subrutina: Imprimir AX en Decimal ---
imprimirAX:
    mov bx, 10
    xor cx, cx
.div_loop:
    xor dx, dx
    div bx          ; AX / 10
    push dx
    inc cx
    test ax, ax
    jnz .div_loop
.print_loop:
    pop dx
    add dl, 30h
    mov ah, 02h
    int 21h
    loop .print_loop
    ret