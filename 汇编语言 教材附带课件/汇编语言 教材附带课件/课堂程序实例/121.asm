DATAS SEGMENT
 		org	100h
        string		db		'happy new year!',0dh,0ah,'$'
        COUNT       DW     17

DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
;                 mov    cx,  count                   ; mov  cx, 17         
;            mov    bx,  offset  string        ; string��ƫַ ? bx
;Next :   mov   dl,   [bx]                     
;            mov    ah,   2
;           int       21h                             ; ��ʾһ���ַ�
;            inc      bx
;            loop   next                             ; ѭ��ָ��

             mov  cx,  count                  ; mov  cx, 17      
            mov  di,   0                         
Next :   mov  dl,   string[di]             ; mov  dl,  [string+si] 
            mov  ah,  2
            int     21h                           ; ��ʾһ���ַ�
            inc     di
            loop   next 



    MOV AH,4CH
    INT 21H
CODES ENDS
    END START
