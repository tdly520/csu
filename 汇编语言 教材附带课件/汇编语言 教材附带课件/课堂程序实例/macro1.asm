DATAS SEGMENT
    ;�˴��������ݶδ���  
    A	dw	8,5,16,84,32
    var	dw	20h
    var1	dw	30h
    xyz	dw	20 dup (?)
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

multiply MACRO opr1,opr2,result
      push  dx
      push  ax
      mov   ax,opr1
      imul  opr2
      mov   result,ax
      pop   ax
      pop   dx
      ENDM
      
CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
    ;�˴��������δ���
   		 multiply cx,var,xyz[bx]
   		  multiply var1,var,xyz[bx]
   		 
          mov     cx, 5       ;Ԫ�ظ���
          dec     cx           ;�Ƚϱ���
loop1:    mov     di, cx      ;�Ƚϴ���
          mov     bx, 0
loop2:     
          mov     ax, A[bx]      ;��������
          cmp     ax, A[bx+2] ;  �Ƚ�
          jle        continue
          xchg    ax, A[bx+2] ;����λ��
          mov     A[bx], ax
continue:
          add      bx, 2 
          loop     loop2
          mov     cx, di
          loop     loop1

    MOV AH,4CH
    INT 21H
CODES ENDS
    END START

