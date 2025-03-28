;sumar dos numeros

org 100h


    call captura
    mov bl,al 
    call captura
    mov bh,al
    
    sub bx,3030h
    add bh,bl
    
    
    call saltolinea
    mov ah,2
    mov dl,bh
    add dl,30h
    int 21h
fin: int 20h


proc captura

ciclo:
    mov ah,7
    int 21h
    cmp al,'0'
    jb ciclo
    cmp al,'9'
    ja ciclo
    mov ah,2
    mov dl,al
    int 21h
    ret
captura endp


proc saltolinea
    mov ah,2
    mov dl,13
    int 21h
    mov dl,10
    int 21h
    ret
saltolinea endp

