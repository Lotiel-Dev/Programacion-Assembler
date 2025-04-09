;Ejercicio 5
;Realizar un programa que muestre un menú
;1) Ingreso de números, 2) ingreso de Operación, 3) 
;Selección de Sistema numérico (b, d, o, h), 4) 
;Mostrar resultado en el sistema numérico seleccionado.

include 'emu8086.inc'

org 100h
inicio: 
    
    call menu1
    call CLEAR_SCREEN
    
    mov ah,1
    cmp al,'1'
    je input
    cmp al,'2'
    je operacion
    cmp al,'3'
    je SistNum
    cmp al,'4'
    je  resultado


input:
    call PTHIS
    db 'ingrese el primer numero: ',0
    mov ah,1
    int 21h
    mov bh,al
    call saltoLinea
    call PTHIS
    db 'ingrese el segundo numero: ',0
    mov ah,1 
    int 21h
    mov bl,al 
    sub bx,3030h
    call CLEAR_SCREEN
    jmp inicio
    
operacion:
    call CLEAR_SCREEN
    cmp bh,bl
    ja continuar
    xchg bh,bl
    
    continuar:
    call PTHIS
    db 'Seleccione una de las 4 operaciones (+,-,/,*): ',0
    
    mov ax,0
    mov ah,1
    int 21h
    cmp al,'+'
    je suma
    cmp al,'-'
    je resta
    cmp al,'/'
    je division
    cmp al,'*'
    je  multiplicacion
    jmp operacion
    
    suma:
    add bh,bl
    jmp retorno
    resta:
    sub bh,bl
    jmp retorno
    division:
    mov ax,0
    mov al,bh
    div bl 
    mov bh,al
    jmp retorno
    multiplicacion:
    mov ax,0
    mov al,bh
    mul bl 
    mov bh,al
    
    retorno:
    call CLEAR_SCREEN
    jmp inicio

SistNum:
    call PTHIS
    db 'Selecione b=binario, d=decimal, o=octal, h=hexadecimal ',0
    
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
    mov al,bh
    mov si,offset numConvertido
    mov cx,0
    call convB
    jmp retorno2
          
          
          
    decimal:
    mov al,bh
    mov si,offset numConvertido
    mov cx,0
    call convD 
    
    
    
    
    jmp retorno2
    octal:
    mov al,bh
    mov si,offset numConvertido
    mov cx,0
    call convO
    jmp retorno2
    
    hexadecimal:
    mov al,bh
    mov si,offset numConvertido
    mov cx,0
    call convH
    jmp retorno2
    
    retorno2:
    call CLEAR_SCREEN
    jmp inicio
    
    
resultado:
    call PTHIS
    db 'El Resultado de la Conversion Es: ',0
    
    call saltoLinea
    mov dx,offset numConvertido
    mov ah,9
    int 21h       
  
  
   

fin: int 20h 


;-----Variables----------
numConvertido db 8 dup ('$') 


;-------Procedimientos-----

menu1 proc 
    call saltoLinea
    call PTHIS
    db '1) Ingreso de Numeros',0
    call saltoLinea
    call PTHIS
    db '2) Ingreso de Operacion',0
    call saltoLinea
    call PTHIS
    db '3) Seleccion de Sistema de Numerico (b,d,o,h)',0
    call saltoLinea
    call PTHIS
    db '4) Mostrar el Resultado en el Sistema Numerico Seleccionado',0
    call saltoLinea
    call PTHIS
    db 'Opcion: ',0
    mov ah,1
    int 21h
    cmp al,'1'
    jb menu1
    cmp al,'4'
    jbe fin2
    jmp menu1
fin2: ret
menu1 endp

saltoLinea proc
    mov ah,2
    mov dl,13
    int 21h
    mov dl,10
    int 21h
ret
saltoLinea endp



convH proc
    ;el numero debe estar en AL y CX en 0
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
    mov [si],dl
    inc si
    loop mostrarH
    jmp finH
    
    casoH:
    add dl,37H
    mov [si],dl
    inc si
    loop mostrarH
finH: ret
convH endp


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
    mov [si],dl
    inc si
    loop mostrarO
ret
convO endp

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
    mov [si],dl
    inc si
    loop mostrarB
ret
convB endp


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
    mov [si],dl
    inc si
    loop mostrarD
ret
convD endp


DEFINE_PTHIS 
DEFINE_CLEAR_SCREEN




