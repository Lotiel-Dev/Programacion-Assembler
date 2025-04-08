
;4.- Realizar un programa que solo permita el ingreso de 3 números de hasta 3 dígitos cada 
;uno. Sumar el medio y el menor y mostrar la tabla de suma de cada digito del resultado. 
;Restar el mayor y menor y mostrar la tabla de multiplicación del primer y último digito de
;del resultado.
macro salto
    mov ah, 2
    mov dl, 0Ah
    int 21h
    mov dl, 0Dh
    int 21h
endm

org 100h
inicio:

capturarPirmerNumero:
    mov dx, offset cadIngr1erNum
    mov ah, 9
    int 21h
    mov cx, 3
    call capturarNumero16bits
    push bx
    salto
    
capturarSegundoNumero:
    mov dx, offset cadIngr2doNum
    mov ah, 9
    int 21h
    mov cx, 3
    call capturarNumero16bits
    push bx          
    salto
    
capturarTercerNumero:
    mov dx, offset cadIngr3erNum
    mov ah, 9
    int 21h
    mov cx, 3
    call capturarNumero16bits
    push bx
   
salto

Ordenar:
    call ordenarDeMayorAMenor    
sumarMedioYMenor:
    call obtenerDatos
    add bx, cx
    call tablaSuma

salto
    
RestarMayorYMenor:
    call obtenerDatos
    sub ax, cx
    cmp ax, 99
    ja sonDe3dig
    cmp ax, 9
    ja sonDe2dig
    jmp sonDe1dig
    
    sonDe1dig:
        mov bx, ax
        call tablaMulti
        jmp fin
    sonDe2dig:
        mov cx, 10
        mov dx, 0
        div cx
        mov bx, dx
        push bx
        mov bx, ax
        mov bh, 0
        call tablaMulti
        pop bx
        mov bh, 0
        call tablaMulti
        jmp fin
        
        
        
    sonDe3dig:
        mov cx, 100
        mov dx, 0
        div cx
        mov bx, ax
        cmp dx, 9
        ja dosDigitos
        push dx
        call tablaMulti
        pop bx
        call tablaMulti
        jmp fin
        dosDigitos:
        mov cx, 10
        push bx
        mov ax, dx
        mov dx, 0
        div cx
        pop bx
        push dx
        call tablaMulti
        pop bx
        call tablaMulti
        
    
    
    
            
    
   
       
        
            
    


fin: int 20h
num db 1,2,3,4,5,6,7,8,9,10,'$'
cadIngr1erNum db 'Ingrese Primer Numero: $'
cadIngr2doNum db 'Ingrese Segundo Numero: $'
cadIngr3erNum db 'Ingrese Tercer Numero: $'
tablaMulti proc
    mov si, offset num
    mov cx, 10
    cicloTM:
    ;n
    mov dl, bl
    add dl, 30h
    mov ah, 2
    int 21h
    ;+
    mov dl, '*'
    int 21h
    ;i
    mov dl, [si]
    cmp dl, 10
    je es10
    add dl, 30h
    int 21h
    jmp salto001
    es10:
    mov dl, '1'
    mov ah, 2
    int 21h
    mov dl, '0'
    int 21h
    
    salto001:
    ;=
    mov dl, '='
    int 21h
    ;(n*i)
    mov al, bl
    mov ah, 0
    mov dl, [si]
    mul dl
    push bx
    mov bx, ax
    call mostrarNumero16bits
    pop bx
    inc si
    salto
    loop cicloTM
    
    ret
tablaMulti endp
mostrarNumero16bits proc
    cmp bx, 9999
    ja s5dig
    cmp bx, 999
    ja s4dig
    cmp bx, 99
    ja s3dig
    cmp bx, 9
    ja s2dig
    jmp s1dig
    s5dig:
        mov ax, bx
        mov dx, 0
        mov bx, 10000
        div bx
        mov bx, dx
        mov dl, al
        add dl, 30h
        mov ah, 2
        int 21h
        cmp bx, 10
        jb s1dig
        cmp bx, 100
        jb s2dig
        cmp bx, 1000
        jb s3dig
        
    s4dig:
        mov ax, bx
        mov dx, 0
        mov bx, 1000
        div bx
        mov bx, dx
        mov dl, al
        add dl, 30h
        mov ah, 2
        int 21h
        cmp bx, 10
        jb s1dig
        cmp bx, 100
        jb s2dig
    s3dig: 
        mov ax, bx
        mov dx, 0
        mov bx, 100
        div bx
        mov bx, dx
        mov dl, al
        add dl, 30h
        mov ah, 2
        int 21h
        cmp bx, 10
        jb s1dig
    s2dig:  
        mov ax, bx
        mov dx, 0
        mov bx, 10
        div bx
        mov bx, dx
        mov dl, al
        add dl, 30h
        mov ah, 2
        int 21h
    s1dig:
        mov dl, bl
        add dl, 30h
        mov ah, 2
        int 21h 
    
    
    ret
mostrarNumero16bits endp
tablaSuma proc
    mov si, offset num
    mov cx, 10
    cicloTS:
    ;n
    push bx
    call mostrarNumero16bits
    pop bx
    ;+
    mov dl, '+'
    mov ah, 2
    int 21h
    ;i
    push bx
    mov bl, [si]
    mov bh,0
    call mostrarNumero16bits
    pop bx
    ;=
    mov dl, '='
    mov ah, 2
    int 21h
    ;(n+i)
    mov al, [si]
    mov ah, 0
    push bx
    add bx, ax
    call mostrarNumero16bits
    pop bx
    salto
    inc si
    loop cicloTS    
    ret
tablaSuma endp
obtenerDatos proc
    pop dx
    pop cx
    pop bx
    pop ax
    
    push ax
    push bx
    push cx
    push dx
    
    ret
obtenerDatos endp
ordenarDeMayorAMenor proc
    pop dx
    pop ax
    pop bx
    pop cx
    
    cmp ax, bx
    ja cAxCx
    xchg ax, bx
    cAxCx:
    cmp ax, cx
    ja cBxCx
    xchg ax, cx
    cBxCx:
    cmp bx, cx
    ja terminarOMM
    xchg bx, cx
    
    terminarOMM:
    push ax
    push bx
    push cx
    push dx
    ret
ordenarDeMayorAMenor endp
capturarNumero16bits proc
    mov bx, 0
    mov dx, 0
    cicloCN:
        mov ah, 7
        int 21h
        cmp al, 0Dh
        je terminarCN
        cmp al, '0'
        jb cicloCN
        cmp al, '9'
        ja cicloCN
        mov dl, al
        mov ah, 2
        int 21h
        sub al, 30h
        mov ah, 0
        xchg bx, ax
        mov dx, 10
        mul dx
        add bx, ax
        loop cicloCN
    enter:
        mov ah, 7
        int 21h
        cmp al, 0Dh
        jne enter    
    terminarCN:
    ret
capturarNumero16bits endp



