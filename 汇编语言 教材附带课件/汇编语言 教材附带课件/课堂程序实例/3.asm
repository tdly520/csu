;-----���ݶ�------------
DATAS SEGMENT
    string_1 DB 'Please input 10 numbers(0-65536):','$'
    string_2 DB 'ERROR: OVERFLOW! Please input again:','$'
    string_3 DB 'The array you have input is:',0ah,0dh,'$'
    string_4 DB 'After Sort the num is:',0ah,0dh,'$'
    string_5 DB ' ','$'
    DATA  DW 10 DUP(?)  
    massege  DB 'The sum of the array is: ',0ah,0DH,'$'   
DATAS ENDS

;-----��ջ��------------
STACKS SEGMENT
    DW 256 dup(?)
STACKS ENDS

;-----�����------------
CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS


;-----------����ʼ------------
START:
    MOV AX,DATAS
    MOV DS,AX
    MOV SI, 0  ;ָ���ʼ��
    MOV CX, 10 ;ѭ������
;---------Input----------
    MOV DX, OFFSET string_1 ;Please input 10 numbers(0-65536)
    MOV AH, 9
    INT 21H
Lp:
    CALL Input
    ADD SI, 2
    Loop Lp
;--------�������룬����---------------
    CALL CRLF
    MOV DX, OFFSET string_3 ;'The array you have input is:'
    MOV AH, 9               ;�׵�ַ DS:DX 
    INT 21H
 ;-------��� ----------------   
    MOV CX, 10
    MOV DI, 0
Again:
    CALL Print
    CALL Space
    ADD DI , 2
    Loop Again
;/******************************/





;/************�ӳ������****************/


;---------���뺯�������������룩------------
Input PROC Near
    push AX
    push BX
    push CX
    push DX


    MOV BX, 0
    CLC
    MOV DX, 0
;----------��������--------------
    Lp_0:
        MOV AH, 1
        INT 21H
        CMP AL, 20H ;�ո�
        JE L_CRLF

;-----   x belong to [0,9]   ----------        
        SUB AL, 30H ; ASCII -> int
        JL L_ERROR  
        CMP AL, 9
        JG L_ERROR
;-------  string -> int   -----------
        MOV AH, 0   ;�� AL��չ�� AX
        XCHG AX, BX ;���� AXֵ
        MOV CX, 10
        MUL CX      ; bx *= 10
        ADD AX , BX
        JC L_ERROR  ; OVERFLOW����
        XCHG AX, BX 
        JMP Lp_0
    L_ERROR:
        MOV DX, 0
        MOV BX, 0
        CALL CRLF   ; ����        
        CALL ERROR  ; ���������ʾ
        JMP Lp_0
    L_again:
        MOV DX, 0
        MOV BX, 0
        pop si
        CALL CRLF   ; ����        
        CALL ERROR  ; ���������ʾ
        JMP Lp_0
        
    L_CRLF:         ; �Ի�����Ϊһ�����Ľ�����־
        
        
      mov di, 0
       mov cx,10
       
      
check:  
        
        cmp bx,data[di]
        je l_error
        add di,2
        loop check
      
        
        MOV DX, 0
        MOV DATA[SI], BX ;
        POP DX
        POP CX
        POP BX
        POP AX
        RET
        Input ENDP


;----�����Ӻ�����һ����������ϣ�-------
CRLF PROC Near
    push AX
    push DX
    MOV DL, 0ah
    MOV AH, 2
    INT 21H
    pop DX
    pop AX
    RET
    CRLF ENDP
;---------�ո�-----------
Space PROC Near
    push AX
    push DX
    MOV DX, OFFSET string_5 ;' '
    MOV AH, 9
    INT 21H
    pop DX
    pop AX
    RET 
    Space ENDP
;----------������ʾ-------------
ERROR PROC Near
    push BX
    push DX
    MOV DX, OFFSET string_2 ; ERROR: OVERFLOW! Please input again:
    MOV AH, 9
    INT 21H
    pop DX
    pop BX
    RET
    ERROR ENDP

;---------��������������������-------------
Print PROC Near
    PUSH AX
    PUSH BX
	PUSH CX
	PUSH DX 

    MOV CX, 0
    MOV BX, 10
    MOV AX, DATA[DI]
    LAST:
        MOV DX, 0
        DIV BX ; DIV�̷�AX����������DX
        PUSH DX
        INC CX
        CMP AX, 0
        JNZ LAST
    AGE:
        POP DX
        OR DX, 30H
        MOV AH, 2
        INT 21H
        LOOP AGE
        POP  DX
        POP  CX
	    POP  BX
	    POP  AX
	    RET
        Print ENDP



CODES ENDS
    END START



