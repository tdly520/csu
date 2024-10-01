    include io.inc
DATAS SEGMENT
    ;此处输入数据段代码  
    grade dw  56,69,84,82,73,88,99,63,100,80
    s5 dw 0
    s6 dw 0
    s7 dw 0
    s8 dw 0
    s9 dw 0
    s10 dw 0
    msg1 db 's5 = $'
    msg2 db 's6 = $'
    msg3 db 's7 = $'
    msg4 db 's8 = $'
    msg5 db 's9 = $'
    msg6 db 's10 = $'
DATAS ENDS

STACKS SEGMENT
    ;此处输入堆栈段代码
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    ;此处输入代码段代码
    push ds
    sub ax,ax
    push ax
    MOV AX,DATAS
    MOV DS,AX
    mov cx,lengthof grade
    mov bx,offset grade
compare:mov ax,[bx]
    cmp ax,60
    jl five
    cmp ax,70
    jl six
    cmp ax,80
    jl seven
    cmp ax,90
    jl eight
    cmp ax,100
    jne nine
    inc s10
    jmp  addrr
nine:inc s9
    jmp  addrr
eight:inc s8
    jmp  addrr
seven:inc s7
    JMP  addrr
six:inc s6
    jmp  addrr
five:inc s5
addrr:add bx,2
    loop compare
    mov dx, offset msg1
    mov ah,9
    int 21h
    mov ax,s5
    call dispuiw
    call dispcrlf
    mov dx,offset msg2
    mov ah,9
    int 21h
    mov ax,s6
    call dispuiw
    call dispcrlf
    mov dx,offset msg3
    mov ah,9
    int 21h
    mov ax,s7
    call dispuiw
    call dispcrlf
    mov dx,offset msg4
    mov ah,9
    int 21h
    mov ax,s8
    call dispuiw
    call dispcrlf
    mov dx,offset msg5
    mov ah,9
    int 21h
    mov ax,s9
    call dispuiw
    call dispcrlf
    mov dx,offset msg6
    mov ah,9
    int 21h
    mov ax,s10
    call dispuiw
    call dispcrlf
    pop ax
    pop ds
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START

