DATAS SEGMENT
  fiblist dw 1,1,98 dup(?)
  n db ?
  result dw ?
    ;�˴��������ݶδ���  
DATAS ENDS

STACKS SEGMENT
    dw 100 dup(?);�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    
    mov ah,01h
    int 21h
  
     sub al, 30h
    mov n,al
    lea si,fiblist
   
    mov cl,n
    xor ch,ch
    sub cl,2
    
one:
 mov ax,[si+2]
    mov bx,[si]
    call fib
    mov [si+4],ax
    add si,2
    loop one
    
    mov dx,[si-2]
    add dx,30h
    mov ah,02h
    int 21h
    
fib proc
   add ax,bx
   ret
 fib endp     
    ;�˴��������δ���
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START





