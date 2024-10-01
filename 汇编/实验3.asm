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

    ; 读取输入至缓冲区
    MOV AH, 0AH
    LEA DX, BUFFER
    INT 21H

    ; 统计字符个数
    MOV SI, 1  
COUNT_LOOP:   
    MOV AL, BUFFER[SI] 
    CMP AL, 0DH ; 判断是否为回车符
    JE END_COUNT 
    CMP AL, 'A' ; 判断是否为字母
    JB CHECK_DIGIT 
    CMP AL, 'Z' ; 判断是否为大写字母
    JBE INCREMENT_LETTER 
    CMP AL, 'a' ; 判断是否为小写字母
    JB CHECK_DIGIT 
    CMP AL, 'z' ; 判断是否为小写字母
    JBE INCREMENT_LETTER
CHECK_DIGIT:
    CMP AL, '0' ; 判断是否为数字
    JB INCREMENT_OTHER ; 若字符小于 '0'，则不是数字
    CMP AL, '9' ; 判断是否为数字
    JBE INCREMENT_DIGIT ; 若小于等于 '9'，则是数字
INCREMENT_OTHER:
    INC OTHER ; 增加其他字符计数
    JMP CONTINUE_COUNT
INCREMENT_DIGIT:
    INC DIGIT ; 增加数字计数
    JMP CONTINUE_COUNT
INCREMENT_LETTER:
    INC LETTER ; 增加字母计数
CONTINUE_COUNT:
    INC SI ; 移至下一个字符
    JMP COUNT_LOOP
END_COUNT:
    ; 输出统计结果
    ; 在此处输出统计结果的代码

    MOV AH, 4CH
    INT 21H
CODES ENDS
    END START


