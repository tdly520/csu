DATAS SEGMENT
    ; ����buf1������
    buf1 DW 15 DUP(?)  ; 15��Ԫ�س�ʼ��Ϊ��

    ; ����buf2������
    buf2 DW 20 DUP(?)  ; 20��Ԫ�س�ʼ��Ϊ��

    ; ��20�����ʼ��buf3
    buf3 DW 20 DUP(0)

    ; ������ʾ����Ϣ���ַ���
    string_input_buf1 DB 'Enter 15 numbers for buf1 (0-65535): $'
    string_input_buf2 DB 'Enter 20 numbers for buf2 (0-65535): $'
    string_prompt_end DB 0ah, 0dh, '$'
    DATA  DW 10 DUP(?) 
    ; ������ʾ��Ϣ
    string_error DB 'ERROR: Illegal INPUT! Please input again: $'
    string_error_2 DB 'ERROR: INPUT repeat !Please input again: $'

DATAS ENDS

STACKS SEGMENT
   DW 256 dup(?) ; ������Ҫ�����ջ��
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES, DS:DATAS, SS:STACKS

main PROC FAR
    mov ax, DATAS
    mov ds, ax
    mov es, ax

    ; �ֶ�����buf1������
    mov si, 0
    mov cx, 15  ; �޸�Ϊ15������
input_buf1:
    mov dx, OFFSET string_input_buf1
    mov ah, 9
    int 21h
lp1:
    call Input_1   ; ��Ҫʵ��Input���������������ֵ��������֤

    
    add si, 2
    loop lp1
    call crlf
    ; �ֶ�����buf2������
    mov si, 0
    mov cx, 20  ; �޸�Ϊ20������
input_buf2:
    mov dx, OFFSET string_input_buf2
    mov ah, 9
    int 21h
lp2:
    call Input_2   ; ��Ҫʵ��Input���������������ֵ��������֤

 
    add si, 2
    loop lp2
    call crlf

    ; ����buf1��buf2�Ĵ���
    mov si, 0
    mov di, 0
loop_begin:
    cld                 ; ����ѭ������
    mov ax, [buf1 + si]
    cmp si, 30  ; �޸�Ϊ30
    je print0

    add si, 2
    push di
    mov cx, 40  ; �޸�Ϊ40
    lea di, buf2
    repnz scasw
    pop di
    jne loop_begin
    mov [buf3 + di], ax
    add di, 2
    jmp loop_begin

print0:
    mov si, 0
    mov di, 0
    mov cx, 20  ; �޸�Ϊ20
print:
    mov bx, [buf3 + si]
    push cx
    call print_proc
    pop cx
    mov dl, 0ah
    mov ah, 02h
    int 21h
    add si, 2
    loop print

    mov ah, 4ch
    int 21h

main endp


; �����ӳ��򣬴��������ֵ��������֤
Input_1 PROC Near
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
    L_repeat:
        MOV DX, 0
        MOV BX, 0
        CALL CRLF   ; ����        
        CALL again  ; ����ظ�����
        JMP Lp_0
    L_CRLF:         ; �Ի�����Ϊһ�����Ľ�����־
        mov di, 0
        mov cx,10
check:         
        cmp bx,buf1[di]
        je l_repeat
        add di,2
        loop check
        
        
        MOV DX, 0
        MOV buf1[SI], BX ;
        POP DX
        POP CX
        POP BX
        POP AX
        RET
        Input_1 ENDP



Input_2 PROC Near
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
    L_repeat:
        MOV DX, 0
        MOV BX, 0
        CALL CRLF   ; ����        
        CALL again  ; ����ظ�����
        JMP Lp_0
    L_CRLF:         ; �Ի�����Ϊһ�����Ľ�����־
        mov di, 0
        mov cx,10
check:         
        cmp bx,buf2[di]
        je l_repeat
        add di,2
        loop check
      
        
        
        MOV DX, 0
        MOV buf2[SI], BX ;
        POP DX
        POP CX
        POP BX
        POP AX
        RET
        Input_2 ENDP
; �����ӳ���
CRLF PROC NEAR
    push AX
    push DX
    MOV DL, 0ah
    MOV AH, 02h
    INT 21h
    pop DX
    pop AX
    RET
CRLF ENDP

; ������ʾ�ӳ���
ERROR PROC NEAR
    push BX
    push DX
    MOV DX, OFFSET string_error ; ������ʾ��Ϣ
    MOV AH, 09h
    INT 21H
    pop DX
    pop BX
    RET
ERROR ENDP


again PROC NEAR
    push BX
    push DX
    MOV DX, OFFSET string_error_2 ; ������ʾ��Ϣ
    MOV AH, 09h
    INT 21H
    pop DX
    pop BX
    RET
again ENDP

; ����������ֵ��ӳ���
print_proc PROC NEAR
    mov DX, BX
    mov CL, 4
    SHR DH, CL
    ADD DH, 30h
    CMP DH, 39h
    JLE first
    ADD DH, 07h
first:
    MOV DL, DH
    MOV AH, 02h
    INT 21h

    MOV DH, BH
    AND DH, 0Fh
    ADD DH, 30h
    CMP DH, 39h
    JLE second
    ADD DH, 07h
second:
    MOV DL, DH
    MOV AH, 02h
    INT 21h

    MOV DL, BL
    SHR DL, CL
    ADD DL, 30h
    CMP DL, 39h
    JLE third
    ADD DL, 07h
third:
    MOV AH, 02h
    INT 21h

    MOV DL, BL
    AND DL, 0Fh
    ADD DL, 30h
    CMP DL, 39h
    JLE forth
    ADD DL, 07h
forth:
    MOV AH, 02h
    INT 21h

    RET
print_proc ENDP

CODES ENDS
END main



