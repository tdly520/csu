DATAS SEGMENT
    ;�˴��������ݶδ���
    mess1 DB 'Enter keyword:','$'
    mess2 DB 'Enter Sentence:','$'
    mess3 DB 'Match at location:','$'
    mess4 DB 'NOT MATCH.',13,10,'$'
    mess5 DB ' in the sentence',13,10,'$'
    change DB 13,10,'$'
    stoknin1 label byte
    max1 db 10 	;�ؼ��ִ�С
    act1 db ?	
    stokn1 db 10 dup(?)
    stoknin2 label byte
    max2 db 50  ;�ַ�����С
    act2 db ?	
    stokn2 db 50 dup(?) 
    
DATAS ENDS

STACKS SEGMENT

STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
    
START:
    MOV AX,DATAS
    MOV DS,AX
    
    LEA DX,mess1
    MOV ah,09
    INT 21h			
    LEA DX,stoknin1
    MOV ah,0ah		
    INT 21h
    
    cmp act1,0
    je exit			;���Ϊ��ֱ���˳�����
a10: 
    ;����Sentence���ж�
    LEA DX,change
    MOV ah,09
    INT 21h			
    LEA DX,mess2 
    MOV ah,09
    INT 21h
    				;���Enter Sentence:
    LEA DX,stoknin2
    MOV ah,0ah
    INT 21h
   		 			
    MOV AL,act1
    CBW;��չ
    MOV CX,AX
    				;����ؼ��ֳ��ȵ�cx
    PUSH CX
    				
    MOV AL,act2
    cmp AL,0
    je a50
    				;������ӳ��ȵ�al��������Ϊ������ת��ʾnot match
    SUB AL,act1
    js a50
    				;�����ӳ���С�ڹؼ��ֳ��ȣ�����ת��ʾnot match
    INC AL
    CBW
    LEA BX,stokn2
    				;�����ӵ��׵�ַ�Ž�BX
    MOV DI,0
    MOV SI,0 
a20:
    				;�Ƚϣ���ѭ�� 
    MOV AH,[BX+DI]
    CMP AH,stokn1[SI]
    				;�����ַ�����Ⱦ���ת��a30
    jne a30
    INC DI
    INC SI
    DEC CX
    				;ÿ����һ����ȵ��ַ�,cx-1,��cx��Ϊ0��Ƚ���һ���ַ�,��cxΪ0��˵���ؼ��ֱȽ���
    CMP CX,0
    je a40
    jmp a20
a30:

	;��ѭ����BX+1,���si��di������ѭ���Ƚ�
	INC BX
	DEC AL
	cmp AL,0
	je a50
	MOV DI,0
	MOV SI,0
	POP CX
	push CX
	jmp a20
a40:

	;match,��bx��ȥ���ӵ��׵�ַ��һ�õ��ؼ�������λ�ã����ö�����תʮ�������Ӻ�����λ�����
	SUB BX,offset stokn2
	INC BX
	LEA DX,change
	MOV ah,09
	INT 21h
	LEA DX,mess3
	MOV ah,09
	INT 21h
	CALL btoh
	LEA DX,mess5
	MOV ah,09
	INT 21h
	jmp a10
	
	;������ת��ʮ������
	btoh PROC NEAR
	MOV CH,4
	rotate: MOV CL,4
	ROL BX,CL;��ѭ��
	MOV AL,BL
	and AL,0fh
	add AL,30h
	cmp al,3ah
	jl printit
	add al,7h
	printit:
	MOV dl,al
	MOV ah,2
	int 21h
	dec ch
	jnz rotate
	ret
btoh endp
a50: 

	;��ʾnot match
	LEA DX,change
	MOV ah,09
	INT 21h
	LEA DX,mess4
	
	MOV ah,09
	INT 21h
	jmp a10
exit:
	ret
CODES ENDS
    END START










