
;ejercicio 6
;Realizar un programa para contabilizar las repeticiones 
;de un caracter determinado por Usted,
;segun el numero de repeticiones de ese caracter, 
;las tablas matematicas del numero de repeticiones.

include 'emu8086.inc'


org 100h
inicio:
    mov cx,0
    mov si, offset cadena
    call PTHIS
    db 'Introduzca los Caracteres: ',0
    call saltoLinea
    
leer:
    mov ah,1
    int 21h
    cmp al,13
    je buscarCar
    mov [si],al
    inc si
    inc cx
    jmp leer
    
    
buscarCar:
    call saltoLinea
    call PTHIS
    db 'Cual es el Caracter que desea Contar: ',0
    mov ah,1
    int 21h
    
    mov bx,0
    mov si, offset cadena 
cont:
    mov dh,[si]   
    cmp dh,al
    jne salt
    inc bl
    cmp bl,9
    jbe salt
    inc bh
    mov decimal[0],bh
    mov bl,0
    salt:
    inc si
    loop cont
    mov decimal[1],bl
         
         
         
    call saltoLinea
    call PTHIS
    db 'El Caracter se Repite: ',0
    
    mov ah, 2
    mov dx,0
    mov dl,decimal[0]
    add dl,30h
    int 21h
    mov dl,decimal[1]
    add dl,30h
    int 21h
    
    call PTHIS
    db ' Veces ',0
    
    
Tablas:
    
    ;---------SUMA-------
    call saltoLinea
    call PTHIS
    db 'suma: ',0
    
    mov cx,10
    mov si, offset num
    suma:
    call saltoLinea
    mov dx,0
    mov ah,2
    
    mov dl,decimal[0]
    add dl,30h
    int 21h
    mov dl,decimal[1]
    add dl,30h
    int 21h
    
    mov dl,'+'
    int 21h
    mov dl,[si]
    add dl,30h
    int 21h
    mov dl,'='
    int 21h
    
    mov dl,[si]
    add dl,bl
  
    inc si
    
    cmp dl,9
    ja mostrarS
    jmp mostrarSimpleS
    
    
    mostrarS:
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
    
    jmp volverS
    
    mostrarSimpleS:
    add dl,30h
    mov ah,2
    int 21h
    jmp volverS
    
    
    
    
    
    volverS:
    loop suma
    
    
    ;---------RESTA-------
    call saltoLinea
    call PTHIS
    db 'resta: ',0
    
    mov cx,10
    mov si, offset num
    resta:
    call saltoLinea
    mov dx,0
    mov ah,2
    
    mov dl,decimal[0]
    add dl,30h
    int 21h
    mov dl,decimal[1]
    add dl,30h
    int 21h
    
    mov dl,'-'
    int 21h
    mov dl,[si]
    add dl,30h
    int 21h
    mov dl,'='
    int 21h
    
    mov dl,[si]
    mov dh,bl
    cmp dl,dh
    ja continuar
    xchg dl,dh
    continuar:
    sub dl,dh
  
    inc si
    
    cmp dl,9
    ja mostrarR
    jmp mostrarSimpleR
    
    
    mostrarR:
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
    
    jmp volverR
    
    mostrarSimpleR:
    add dl,30h
    mov ah,2
    int 21h
    jmp volverR
    
    
    
    
    
    volverR:
    loop resta
    
    
    
    ;---------DIVISION-------
    call saltoLinea
    call PTHIS
    db 'division: ',0
    
    mov cx,10
    mov si, offset num
    division:
    call saltoLinea
    mov dx,0
    mov ah,2
    
    mov dl,decimal[0]
    add dl,30h
    int 21h
    mov dl,decimal[1]
    add dl,30h
    int 21h
    
    mov dl,'/'
    int 21h
    mov dl,[si]
    add dl,30h
    int 21h
    mov dl,'='
    int 21h
    
    mov dl,[si]
    mov dh,bl
    cmp dl,dh
    ja continuard
    xchg dl,dh
    continuard:
    mov ax,0
    mov al,dl
    div dh
    mov dl,al
    mov ah,2
  
    inc si
    
    cmp dl,9
    ja mostrarD
    jmp mostrarSimpleD
    
    
    mostrarD:
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
    
    jmp volverD
    
    mostrarSimpleD:
    add dl,30h
    mov ah,2
    int 21h
    jmp volverD
    
    
    
    
    
    volverD:
    loop division
    
    
    
    
    
    ;---------MULTIPLICACION-------
    call saltoLinea
    call PTHIS
    db 'multiplicacion: ',0
    
    mov cx,10
    mov si, offset num
    multiplicacion:
    call saltoLinea
    mov dx,0
    mov ah,2
    
    mov dl,decimal[0]
    add dl,30h
    int 21h
    mov dl,decimal[1]
    add dl,30h
    int 21h
    
    mov dl,'*'
    int 21h
    mov dl,[si]
    add dl,30h
    int 21h
    mov dl,'='
    int 21h
    
    mov dl,[si]
    mov ax,0
    mov al,bl
    mul dl
    mov dl,al
    mov ah,2
  
    inc si
    
    cmp dl,9
    ja mostrarM
    jmp mostrarSimpleM
    
    
    mostrarM:
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
    
    jmp volverM
    
    mostrarSimpleM:
    add dl,30h
    mov ah,2
    int 21h
    jmp volverM
    
    
    
    
    
    volverM:
    loop multiplicacion
    
    
    
    
    
 


fin: int 20h

cadena db 100 dup('$')
decimal db 0,0,'$'
num db 1,2,3,4,5,6,7,8,9,10 







saltoLinea proc

    mov ah,2
    mov dl,13
    int 21h
    mov dl,10
    int 21h
ret 
saltoLinea endp

DEFINE_PTHIS
DEFINE_CLEAR_SCREEN
