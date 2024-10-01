DATAS SEGMENT
    ; ����buf1������
    buf1 DW 10 DUP(?)  ; 10��Ԫ�س�ʼ��Ϊ��

    ; ����buf2������
    buf2 DW 30 DUP(?)  ; 30��Ԫ�س�ʼ��Ϊ��

    ; ��20�����ʼ��buf3
    buf3 DW 20 DUP(0)

    ; ������ʾ����Ϣ���ַ���
string_input_buf1 DB 'Enter 10 numbers for buf1 (0-65535): $'
    string_input_buf2 DB 'Enter 30 numbers for buf2 (0-65535): $'
    string_prompt_end DB 0ah, 0dh, '$'

    ; ������ʾ��Ϣ
    string_error DB 'ERROR: INPUT OUT OF RANGE! Please input again: $'

DATAS ENDS


STACKS SEGMENT
    ; ������Ҫ�����ջ��
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES, DS:DATAS, SS:STACKS

main PROC FAR
    mov ax, DATAS
    mov ds, ax
    mov es, ax

    ; �ֶ�����buf1������
    mov si, 0
    mov cx, 10
input_buf1:
    mov dx, OFFSET string_input_buf1
    mov ah, 9
    int 21h

    call Input   ; ��Ҫʵ��Input���������������ֵ��������֤

    mov [buf1 + si], ax  ; ������ֵ����buf1
    add si, 2
    loop input_buf1

    ; �ֶ�����buf2������
    mov si, 0
    mov cx, 30
input_buf2:
    mov dx, OFFSET string_input_buf2
    mov ah, 9
    int 21h

    call Input   ; ��Ҫʵ��Input���������������ֵ��������֤

    mov [buf2 + si], ax  ; ������ֵ����buf2
    add si, 2
    loop input_buf2

    ; ����buf1��buf2�Ĵ���
    mov si, 0
    mov di, 0
loop_begin:
    cld                 ; ����ѭ������
    mov ax, [buf1 + si]
    cmp si, 20
    je print0

    add si, 2
    push di
    mov cx, 60
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
    mov cx, 20
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
Input PROC NEAR
    push AX
    push BX
    push CX
    push DX

    mov BX, 0    ; BX���ڴ洢��ǰ���������
    CLC
    MOV DX, 0

Lp_0:
    MOV AH, 1
    INT 21H

    CMP AL, 20H  ; ����Ƿ��ǿո�
    JE L_SPACE   ; ����ǿո���ת������ո�ı�ǩ

    CMP AL, 0DH  ; ����Ƿ��ǻس���
    JE L_END     ; ����ǻس�������ת����������ı�ǩ

    ; x ���� [0, 9]
    SUB AL, 30H  ; ASCII -> int
    JL L_ERROR  
    CMP AL, 9
    JG L_ERROR

    ; string -> int
    MOV AH, 0   ; ��չ AL �� AX
    XCHG AX, BX ; ���� AX ֵ
    MOV CX, 10
    MUL CX      ; BX *= 10
    ADD AX, BX
    JC L_ERROR  ; �������
    XCHG AX, BX 
    JMP Lp_0

L_SPACE:
    MOV DX, 0
    MOV [DI], BX ; ����������ִ���Ŀ���ַ
    POP DX
    POP CX
    POP BX
    POP AX
    RET

L_END:
    MOV DX, 0
    MOV [DI], BX ; ����������ִ���Ŀ���ַ
    POP DX
    POP CX
    POP BX
    POP AX
    RET

L_ERROR:
    MOV DX, 0
    MOV BX, 0
    CALL CRLF   ; ����        
    CALL ERROR  ; ���������ʾ
    JMP Lp_0

Input ENDP


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

