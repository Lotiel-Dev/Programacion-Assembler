;ejercicio 1

;Realizar un programa que permita el ingreso de una fecha, al concluir el ingreso deberá 
;guardarse en un registro, posteriormente mostrar todo el registro y a continuacion en líneas 
;diferentes la fecha, el año, el mes y el dia, debe presentarse en un menu para que se pueda 
;seleccionar si el usuario quiere mostrar en binario, octal, decimal o hexadecimal. 

include 'emu8086.inc'
include 'e:\macros.inc'

org 100h

    call PTHIS
    db 'Ingrese la Fecha:',0
    saltoLinea
    
    call PTHIS
    db 'dia: ',0 
    mov ah,1
    int 21h
    mov cadFecha[0],al
    sub al,30h
    mov bx,0
    mov ch,10
    mov ah,0
    mul ch
    mov bl,al
    mov ah,1
    int 21h
    mov cadFecha[1],al
    sub al,30h
    add bl,al
    mov dx,0
    or dx,bx
    
    saltoLinea
    call PTHIS
    db 'mes: ',0
    mov ah,1
    int 21h
    mov cadFecha[2],al
    sub al,30h
    mov bx,0
    mov ch,10
    mov ah,0
    mul ch
    mov bl,al
    mov ah,1
    int 21h
    mov cadFecha[3],al
    sub al,30h
    add bl,al
    shl bx,5
    or dx,bx 
    
    saltoLinea
    call PTHIS
    db 'anio: ',0
    mov ah,1
    int 21h
    mov cadFecha[4],al
    sub al,30h
    mov bx,0
    mov ch,10
    mov ah,0
    mul ch
    mov bl,al
    mov ah,1
    int 21h
    mov cadFecha[5],al
    sub al,30h
    add bl,al
    shl bx,9
    or dx,bx
    
    mov ax,dx 
    mov dx,0
    mov bx,ax
    saltoLinea
    
    call PTHIS
    db 'Fecha Almacenada en el Registor AX: ',0
    call mostrarBin
    saltoLinea
    
    call PTHIS
    db 'Seleccion de Sistema de Numerico (b,d,o,h): ',0
    
    SistNum:
    mov ax,0
    mov ah,1
    int 21h
    cmp al,'b'
    je binario
    cmp al,'d'
    je decimal
    cmp al,'o'
    je octal
    cmp al,'h'
    je  hexadecimal
    jmp SistNum

    
 binario:
    saltoLinea
    mov ax,0
    call PTHIS
    db 'dia: ',0
    mov ch,cadFecha[0]
    add cl,cadFecha[1]
    sub cx,3030h
    mov al,ch
    mov dh,10
    mul dh
    add al,cl
    mov cx,0
    call convB
    
    saltoLinea
    mov ax,0
    call PTHIS
    db 'mes: ',0
    mov ch,cadFecha[2]
    add cl,cadFecha[3]
    sub cx,3030h
    mov al,ch
    mov dh,10
    mul dh
    add al,cl
    mov cx,0
    call convB
    
    saltoLinea
    mov ax,0
    call PTHIS
    db 'anio: ',0
    mov ch,cadFecha[4]
    add cl,cadFecha[5]
    sub cx,3030h
    mov al,ch
    mov dh,10
    mul dh
    add al,cl
    mov cx,0
    call convB
    
    jmp fin
          
          
          
    decimal:
    saltoLinea
    mov ax,0
    call PTHIS
    db 'dia: ',0
    mov ah,2
    mov dx,0
    mov dl,cadFecha[0]
    int 21h
    mov dl,cadFecha[1]
    int 21h  
    
    saltoLinea
    mov ax,0
    call PTHIS
    db 'mes: ',0
    mov ah,2
    mov dx,0
    mov dl,cadFecha[2]
    int 21h
    mov dl,cadFecha[3]
    int 21h

    saltoLinea
    mov ax,0
    call PTHIS
    db 'anio: ',0
    mov ah,2
    mov dx,0
    mov dl,cadFecha[4]
    int 21h
    mov dl,cadFecha[5]
    int 21h
    
    jmp fin
    
    
    
    octal:
    saltoLinea
    mov ax,0
    call PTHIS
    db 'dia: ',0
    mov ch,cadFecha[0]
    add cl,cadFecha[1]
    sub cx,3030h
    mov al,ch
    mov dh,10
    mul dh
    add al,cl
    mov cx,0
    call convO
    
    saltoLinea
    mov ax,0
    call PTHIS
    db 'mes: ',0
    mov ch,cadFecha[2]
    add cl,cadFecha[3]
    sub cx,3030h
    mov al,ch
    mov dh,10
    mul dh
    add al,cl
    mov cx,0
    call convO
    
    saltoLinea
    mov ax,0
    call PTHIS
    db 'anio: ',0
    mov ch,cadFecha[4]
    add cl,cadFecha[5]
    sub cx,3030h
    mov al,ch
    mov dh,10
    mul dh
    add al,cl
    mov cx,0
    call convO
    
    jmp fin
    
    
    
    hexadecimal:
    saltoLinea
    mov ax,0
    call PTHIS
    db 'dia: ',0
    mov ch,cadFecha[0]
    add cl,cadFecha[1]
    sub cx,3030h
    mov al,ch
    mov dh,10
    mul dh
    add al,cl
    mov cx,0
    call convH
    
    saltoLinea
    mov ax,0
    call PTHIS
    db 'mes: ',0
    mov ch,cadFecha[2]
    add cl,cadFecha[3]
    sub cx,3030h
    mov al,ch
    mov dh,10
    mul dh
    add al,cl
    mov cx,0
    call convH
    
    saltoLinea
    mov ax,0
    call PTHIS
    db 'anio: ',0
    mov ch,cadFecha[4]
    add cl,cadFecha[5]
    sub cx,3030h
    mov al,ch
    mov dh,10
    mul dh
    add al,cl
    mov cx,0
    call convH
    
    jmp fin
        
    

    
    






fin: int 20h



cadFecha db 6 dup ('*')


mostrarBin proc
    mov ah,2
    mov cx,16
    
    mostrarBinario:
    push bx
    
    xchg cl,dh
    shl bx,cl
    shr bx,15
    mov dl,bl
    add dl,30h
    int 21h
    xchg cl,dh
    inc dh
    pop bx
    loop mostrarBinario
ret
mostrarBin endp


convB proc
    mov ah,0
    mov bh,2
    div bh
    push ax
    inc cx
  
    cmp al,0
    je mostrarB
    jmp convB
    
    mostrarB:
    mov dx,0
    pop ax
    mov dl,ah
    add dl,30h
    mov ah,2
    int 21h
    loop mostrarB
ret
convB endp



convO proc
    mov ah,0
    mov bh,8
    div bh
    push ax
    inc cx
  
    cmp al,0
    je mostrarO
    jmp convO
    
    mostrarO:
    mov dx,0
    pop ax
    mov dl,ah
    add dl,30h
    mov ah,2
    int 21h
    loop mostrarO
ret
convO endp



convH proc
    mov ah,0
    mov bh,16
    div bh
    push ax
    inc cx
  
    cmp al,0
    je mostrarH
    jmp convH
    
    mostrarH:
    mov dx,0
    pop ax
    mov dl,ah
    cmp dl,9
    ja casoH
    add dl,30h
    mov ah,2
    int 21h
    loop mostrarH
    jmp finH
    
    casoH:
    add dl,37H
    mov ah,2
    int 21h
    loop mostrarH
finH: ret
convH endp




DEFINE_PTHIS
DEFINE_CLEAR_SCREEN

