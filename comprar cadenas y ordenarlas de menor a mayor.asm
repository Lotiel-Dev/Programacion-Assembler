
;ingresar 3 cadenas y mostrarlas ordenadas
;input  mundo, hola, ave 




;output  ave,hola,mundo

org 100h
inicio:     
    mov cx,19
    mov si,offset cad1
    call captura
    call salto1
    
    mov cx,19
    mov si,offset cad2
    call captura
    call salto1 
    
    
    mov si,offset cad1
    mov di, offset cad2
    mov ah,[si]   ;q
    mov al,[di]   ;a
       ;q , a
    cmp ah,al
    jb mostrar
    mov si,offset cad1
    mov di,offset cad3
    call interc
    mov si,offset cad2
    mov di,offset cad1
    call interc
    mov si,offset cad3
    mov di,offset cad2
    call interc
    

mostrar:    
    mov ah,9
    mov dx,offset cad1
    int 21h
    call salto1
    mov ah,9
    mov dx,offset cad2
    int 21h

fin: int 20h

cad1 db 20 dup('$')   ;qwert 
cad2 db 20 dup('$')   ;asdf
cad3 db 20 dup('$')   ;


interc proc
    mov cx,19
next:
    mov bh,[si]
    mov [di],bh
    inc si
    inc di
    loop next    
    
ret
interc endp


captura proc
ciclo:    
    mov ah,1
    int 21h
    cmp al,13
    je fin2
    mov [si],al
    inc si
    loop ciclo
fin2:ret 
captura endp
 
 
salto1 proc

    mov ah,2
    mov dl,13
    int 21h
    mov dl,10
    int 21h
ret 
salto1 endp 




