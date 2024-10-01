DATAS SEGMENT
    INPUT_SIZE DB 80
    BUFFER DB 80 DUP('$')
    LETTER DB 0
    DIGIT DB 0
    OTHER DB 0
DATAS ENDS

STACKS SEGMENT
    INPUT_STACK DB 80 DUP('$')
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX

    ; ��ȡ������������
    MOV AH, 0AH
    LEA DX, BUFFER
    INT 21H

    ; ͳ���ַ�����
    MOV SI, 1  
COUNT_LOOP:   
    MOV AL, BUFFER[SI] 
    CMP AL, 0DH ; �ж��Ƿ�Ϊ�س���
    JE END_COUNT 
    CMP AL, 'A' ; �ж��Ƿ�Ϊ��ĸ
    JB CHECK_DIGIT 
    CMP AL, 'Z' ; �ж��Ƿ�Ϊ��д��ĸ
    JBE INCREMENT_LETTER 
    CMP AL, 'a' ; �ж��Ƿ�ΪСд��ĸ
    JB CHECK_DIGIT 
    CMP AL, 'z' ; �ж��Ƿ�ΪСд��ĸ
    JBE INCREMENT_LETTER
CHECK_DIGIT:
    CMP AL, '0' ; �ж��Ƿ�Ϊ����
    JB INCREMENT_OTHER ; ���ַ�С�� '0'����������
    CMP AL, '9' ; �ж��Ƿ�Ϊ����
    JBE INCREMENT_DIGIT ; ��С�ڵ��� '9'����������
INCREMENT_OTHER:
    INC OTHER ; ���������ַ�����
    JMP CONTINUE_COUNT
INCREMENT_DIGIT:
    INC DIGIT ; �������ּ���
    JMP CONTINUE_COUNT
INCREMENT_LETTER:
    INC LETTER ; ������ĸ����
CONTINUE_COUNT:
    INC SI ; ������һ���ַ�
    JMP COUNT_LOOP
END_COUNT:
    ; ���ͳ�ƽ��
    ; �ڴ˴����ͳ�ƽ���Ĵ���

    MOV AH, 4CH
    INT 21H
CODES ENDS
    END START


