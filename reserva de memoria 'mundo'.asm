
; imprimir en pantalla una reserva de memoria

org 100h

inicio:
    mov si,offset aux
    mov ah,2
    mov dl,[si]
    int 21h
    inc si
    mov dl,[si]
    int 21h
    inc si
    mov dl,[si]
    int 21h
    inc si
    mov dl,[si]
    int 21h
    inc si
    mov dl,[si]
    int 21h
    inc si
fin: int 20h
aux db 'mundo'



