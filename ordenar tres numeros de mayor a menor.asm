;ingresar tres nmeros y mostrar de mayor a menor

org 100h
inicio:
    mov ah,1
    int 21h
    mov bh,al
    int 21h
    mov ch,al
    int 21h
    mov dh,al
    
    cmp bh,ch
    ja sig1
    xchg bh,ch
sig1:
    cmp bh,dh
    ja sig2
    xchg bh,dh
sig2:
    cmp ch,dh
    ja mostrar
    xchg ch,dh
mostrar:
    mov bl,dh
    mov ah,2
    mov dl,bh
    int 21h
    mov dl,ch
    int 21h
    mov dl,bl
    int 21h
fin: int 20h




