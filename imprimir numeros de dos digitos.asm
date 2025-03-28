
org 100h
inicio:
    mov dl,18
    cmp dl,9
    ja mostrar
    mov ah,2
    add dl,30h
    int 21h
    jmp fin
mostrar:
    mov ax,0
    mov al,dl
    mov bh,10
    div bh
    mov bx, ax
    mov ah,2
    mov dl,bl
    add dl,30h
    int 21h
    mov dl,bh
    add dl,30h
    int 21h    
fin: int 20h