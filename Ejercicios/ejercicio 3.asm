
;3.- Realizar un programa que solo permita el ingreso de números (N) de hasta dos dígitos 
;cada uno. Mostrar todos los primos, el promedio de todos y la media de todos.
macro salto
    mov ah, 2
    mov dl, 0Ah
    int 21h
    mov dl, 0Dh
    int 21h    
endm

org 100h
inicio:
    mov ah,9
    mov dx, offset cadIngrNumero
    int 21h
    salto
    mov si, offset numeros
registrarNumero:
    
    mov cx, 2
    call capturarNumeroDe8bits
    cmp dh, 0
    je mostrar
    mov [si], bl
    inc si
    salto
    jmp registrarNumero    
        
mostrar:
    mostrarPrimos:
    mov dx, offset cadPrimos
    mov ah, 9
    int 21h              
    
   
    call cantDeNumerosEnCx
    mov si, offset numeros
    encontrarPrimo:
        mov bl, [si]
        push cx
        call esPrimo
        cmp dh, 2
        jne saltoMP                                
        
        mov bh, 0
        call mostrarNumero8bitsDeBx
        salto
        saltoMP:
        inc si
        
        pop cx
        loop encontrarPrimo
        
         
    
    mostrarPromedio:
    salto
    mov dx, offset cadPromedio
    mov ah, 9
    int 21h
    
    call cantDeNumerosEnCx
    mov si, offset numeros
    mov bx, 0
    sumar:
        mov al, [si]
        mov ah,0
        add bx, ax
        inc si
        loop sumar
    promedio:
        call cantDeNumerosEnCx
        mov ax, bx
        mov dx, 0
        div cx
        mov bx, ax
        call mostrarNumero8bitsDeBx    
        salto
    
    mostrarMedia:
        mov dx, offset cadMedia
        mov ah, 9
        int 21h
        
        mov bh, 99
        ordenar:
            call cantDeNumerosEnCx 
            mov si, offset numeros
            encontrar:
            mov bl, [si]
            cmp bl, 'e'
            je saltoMM
            cmp bh, bl
            jne saltoMM
            push bx
            mov [si], 'e' 
            
            saltoMM:
            inc si
            loop encontrar
            dec bh
            cmp bh, 0
            jne ordenar
            
        sacarMedia:
            call cantDeNumerosEnCx
            mov bx, 2
            mov ax, cx
            div bl
            cmp ah, 0
            je esPar
            
            esImpar:
                mov cl, al
                add cl, ah
                sacarNumero:
                    pop bx
                    loop sacarNumero
                    mov bh, 0
                    call mostrarNumero8bitsDeBx
                    jmp fin
            
            esPar:
                mov cl, al
                sacarNumero1:
                    pop bx
                    loop sacarNumero1    
                    pop ax
                    add al, bl
                    mov ah, 0
                    mov bh, 2
                    div bh
                    mov bl, al
                    mov bh, 0
                    call mostrarNumero8bitsDeBx
        
        
fin: int 20h       

numeros db 500 dup('d')
cadingrNumero db 'Ingresar Numeros[doble enter para terminar]: $'
cadPromedio db 'Promedio: $'
cadPrimos db 'Primos: $'
cadMedia db 'Media: $'   
esPrimo proc
    mov dl, 1
    mov dh, 0
    cmp bl, 0
    je terminarEP
    cmp bl, 1
    je terminarEP
    cicloEP:
        mov al, bl
        mov ah, 0
        div dl
        cmp ah, 0
        jne saltoEP
        inc dh
        saltoEP:
        inc dl
        cmp dl, bl
        jbe cicloEP
    terminarEP:
    ret
esPrimo endp
mostrarNumero8bitsDeBx proc
    cmp bl, 99
    ja d3dig
    cmp bl, 9
    ja d2dig
    jmp d1dig
    d3dig:
    mov al, bl
    mov ah, 0
    mov dl, 100
    div dl
    mov bl, ah
    mov dl, al
    add dl, 30h
    mov ah, 2 
    int 21h
    d2dig:
    mov al, bl
    mov ah, 0
    mov dl, 10
    div dl
    mov bl, ah
    mov dl, al
    add dl, 30h
    mov ah, 2
    int 21h
    d1dig:
    mov dl, bl
    add dl, 30h
    mov ah, 2
    int 21h
     
    ret
mostrarNumero8bitsDeBx endp
cantDeNumerosEnCx proc
    mov si, offset numeros
    mov cx, 0
    cicloCDN:
        mov al, [si]
        cmp al, 'd'
        je terminarCDN
        inc si
        inc cx
        jmp cicloCDN
    
    terminarCDN:
    ret
cantDeNumerosEnCx endp
capturarNumeroDe8bits proc
    mov bx, 0
    mov dh, 0
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
        mov dl, 10
        mul dl
        add bx, ax
        mov dh, 1
        loop cicloCN
        
    enter:
        mov ah, 7
        int 21h
        cmp al, 0Dh
        jne enter    
        
        
    terminarCN:    
    ret
capturarNumeroDe8bits endp

