;ciclo for
;mostrar un numero el numero que indica en numero-pregunta de examen

org 100h
inicio:
    mov ah,7
    int 21h
    cmp al,'0'
    jb inicio
    cmp al,'9'
    ja inicio
    
    mov bl,al
    mov cx,0
    mov cl,al
    sub cl,30h
    
    mov dl,al
    mov ah,2
    int 21h  
    ;salto de linea(enter)
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
    
gatito:    
    mov ah,2 
    ;imprime en pantalla lo que esta en dl
    mov dl,bl
    int 21h 
    ;loop siempre se fija en cx y le descuenta de uno en uno

    loop gatito

fin: int 20h




