DATAS SEGMENT
    ;�˴��������ݶδ���  
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
             mov   bx, 0
newchar:
	  mov   ah, 1 
      int   21h
      sub   al, 30h         
      jl    exit       ; <0 exit
      cmp   al, 9
      jg    exit       ; >9 exit
      cbw

      xchg  ax, bx
      mov   cx, 10
      mul   cx
      xchg  ax, bx
      add   bx, ax

      jmp   newchar
exit:   
    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
