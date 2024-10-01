DATAS SEGMENT
    ;�˴��������ݶδ��� 
       array     dw   12,11,22,33,44,55,66,
                      77,88,99,111,222,333
       number    dw   90
       low_idx   dw   ?
       high_idx  dw   ?
       
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
      lea  di, array
      mov  ax, number  ;Ҫ������
      cmp  ax, [di+2]  ; (ax)���һ��Ԫ�رȽ�
      ja   chk_last
      lea  si, [di+2]  ; lea ��Ӱ���־
      je   exit        ; (ax)����һ��Ԫ��,�ҵ��˳�
      stc
      jmp  exit        ; (ax)<��һ��Ԫ��,δ�ҵ��˳�
chk_last:
      mov  si, [di]    ; Ԫ�ظ���
      shl  si, 1       ; �������һ��Ԫ��
      add  si, di      ;     �ĵ�ַ��byte VS word
      cmp  ax, [si]    ; (ax)�����һ��Ԫ�رȽ�
      jb   search
      je   exit        ; (ax)�����һ��Ԫ��,�ҵ��˳�
      stc
      jmp  exit        ; (ax)>���һ��Ԫ��,δ�ҵ��˳�
      
search:
    mov  low_idx, 1
    mov  bx, [di] ;����
    mov  high_idx, bx
    mov  bx, di
mid:
    mov  cx, low_idx
    mov  dx, high_idx
    cmp  cx, dx
    ja   no_match
    add  cx, dx
    shr  cx, 1
    mov  si, cx
    shl  si, 1
    
compare:
   cmp  ax, [bx+si]
   je   exit
   ja   higher
   dec  cx
   mov  high_idx, cx
   jmp  mid
higher:
   inc  cx
   mov  low_idx, cx
   jmp  mid
no_match:
   stc

exit:   	
MOV AH,4CH
    	INT 21H
CODES ENDS
    END START
