; capturar un numero, y mostrar su tabla de suma
; 3
; 3+1=4
; 3+2=5

org 100h
inicio:
    mov ah,7
    int 21h
    cmp al,'0'
    jb inicio
    cmp al,'9'
    ja inicio
    mov bl,al
    mov bh,1
    
    mov cx,10
ciclo:
    mov ah,2 
    mov dl,10
    int 21h
    mov dl,13
    int 21h
    
    mov dl,bl
    int 21h
    
    mov dl,'+'
    int 21h
    mov dl,bh
    add dl,30h
    int 21h
    mov dl,'='
    int 21h
    
    mov dl,bl
    sub dl,30h
    add dl,bh
    inc bh
    cmp dl,9
    ja mostrar
    jmp mostrarSimple
    
    
mostrar:
    mov ch,bh
    mov dh,bl
    
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
    
    mov bh,ch
    mov ch,0
    mov bl,dh
    mov dh,0
    
    jmp volver
    
mostrarSimple:
    add dl,30h
    mov ah,2
    int 21h
    jmp volver
    
    

volver:
    loop ciclo
    
fin: int 20h




   

