DATAS SEGMENT
    ;�˴��������ݶδ��� 
    x            dw      ?
	array_head   dw      3,5,15,23,37,49,52,65,78,99
	array_end    dw      105
	n            dw      32           
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
          mov   ax, n
          mov   array_head-2, 0ffffh
          mov   si,  0
compare:
          cmp   array_end [si], ax
          jle      insert
          mov   bx, array_end [si]
          mov   array_end [si+2], bx
          sub    si, 2 
          jmp    short compare
insert:
          mov   array_end [si+2], ax

    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
