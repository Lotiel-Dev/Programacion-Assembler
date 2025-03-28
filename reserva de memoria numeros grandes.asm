; imprimir en pantalla una reserva de memoria

org 100h

inicio:
    mov si,offset aux1
    mov dx,[si]
    inc si
    inc si
    mov dx,[si]
    inc si
    
fin: int 20h
aux db 'mundo'
aux dw 1000,2547,3698,4478
