
; cilos
;cicloscondicionados -while, do while, repeat
; ciclos con contador - for 
;el 7 en ah,7 y 21h es lo mismo que ah1 pero sin eco en la pantalla

org 100h
inicio:
    mov ah,7
    int 21h
    cmp al,'0'
    jb inicio
    cmp al,39h
    ja inicio 
    
    mov dl,al
    mov ah,2
    int 21h
fin: int 20h




