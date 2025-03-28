
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

inicio:
    mov cx,20
    mov si, offset aux
    mov ah,2
ciclo:
    mov dl,[si]
    int 21h
    inc si
    loop ciclo
    
    
    mov ah,2
    mov dl,13
    int 21h
    mov dl,10
    int 21h
    
    
    mov cx,9
    mov si,offset aux
ciclo2:
    mov bl,cl
    add bl,30h
    mov [si],bl
    inc si
    loop ciclo2 
    
    
    mov cx,20
    mov si,offset aux
ciclo3:
    mov ah,2
    mov dl,[si]
    cmp dl,'*'
    je fin
    int 21h
    inc si
    loop ciclo3
    
fin: int 20h
aux db 20 dup ('*')



