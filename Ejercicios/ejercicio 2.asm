
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt
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
    db 'anio: 20',0
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
    db 'Inserte un Numero de Dias: ',0
    ;mov bx,ax
    mov cx,0
    
    ingresar:
    mov ah,1
    int 21h
    cmp al,13
    je resultado
    mov ah,0
    sub al,30h
    xchg cx,ax
    mov dl,10
    mul dl
    add ax,cx
    xchg cx,ax
    jmp ingresar
    ;numero guardado en cx
    
    
    
    
    
    
    
    resultado:
    saltoLinea
    
    
    
    ;----------------
    
    push ax
    push dx
    
    ;mov ax,cx
    mov ax,0
    mov al,cadFecha[0]
    sub al,30h
    mov dl,10
    mul dl
    mov dl,cadFecha[1]
    sub dl,30h
    add al,dl
    mov ah,0
    add ax,cx
    cmp ax,31
    jb hmmm
    cont:
    mov dx,31
    sub ax,dx
    cmp ax,dx
    jb hmmm
    inc cx
    jmp cont 
    
    
    hmmm:
    pop dx
    pop ax
    ;-------------------
    
    
    
    
    
    
    mov dx,0
    
    add bx,cx
    
    call mostrarBin
    
    
    ;-------se convierte el registro BX a decimal
    saltoLinea
    mov ax,bx
    mov cx,0
    
    ;-----------dia
    call PTHIS
    db 'dia: ',0 
    
    push bx
    shl ax, 11
    shr ax, 11
    
    call convD
    pop bx
    
    saltoLinea
    mov ax,bx
    mov cx,0
    ;-----------mes
    call PTHIS
    db 'mes: ',0
    
    push bx
    shl ax, 7
    shr ax, 12
    call convD
    pop bx
    
    saltoLinea
    mov ax,bx
    mov cx,0
    ;-------anio-----
    call PTHIS
    db 'anio: 20',0
    
    shr ax, 9
    call convD 
    
    
    
    
    
    
    
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
    

convD proc
    mov ah,0
    mov bh,10
    div bh
    push ax
    inc cx
  
    cmp al,0
    je mostrarD
    jmp convD
    
    mostrarD:
    mov dx,0
    pop ax
    mov dl,ah
    add dl,30h
    mov ah,2
    int 21h
    loop mostrarD
ret
convD endp




    
    
DEFINE_PTHIS
DEFINE_CLEAR_SCREEN    
    
    
    