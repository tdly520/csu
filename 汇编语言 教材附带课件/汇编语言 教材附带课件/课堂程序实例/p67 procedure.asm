DATAS SEGMENT
    ;�˴��������ݶδ��� 
    x	dw	10
    y	dw	25
    z	dw	330
    V	dw	4444
    quotient	dw	?
    remains		dw	?
     
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;�˴��������δ���
    mov	ax,x
    imul	y
    mov	cx,ax
    mov	bx,dx
    mov	ax,z
    cwd
    add	cx,ax
    adc	bx,dx
    sub	cx,540
    sbb	bx,0
    mov	ax,v
    cwd
    sub	ax,cx
    sbb	dx,bx
    idiv	x
    mov	quotient	,ax
    mov	remains	,dx
        
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
