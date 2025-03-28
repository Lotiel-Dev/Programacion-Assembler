
; sumar dos numeros garantizando que sean numeros

org 100h 
inicio:
    mov ah,7
    int 21h
    cmp al,'0'
    jb inicio
    cmp al,39h
    ja inicio
     
    ;para guardar en bl
    mov bl,al
    ;para imprimir en pantalla se pone en dl
    mov dl,al
    mov ah,2
    int 21h
    
patito:
    
    mov ah,7
    int 21h
    cmp al,'0'
    jb patito
    cmp al,39h
    ja patito
    
    mov bl,al
    mov dl,al
    mov ah,2
    int 21h  
    
    ;se resta por que en ascii es mas 30
    sub bx,3030h
    add bh,bl
    
    mov dl,bh
    add dl,30h
    mov ah,2
    int 21h
fin: int 20h





