DATAS SEGMENT
    ; 输入buf1的数据
    buf1 DW 10 DUP(?)  ; 10个元素初始化为零

    ; 输入buf2的数据
    buf2 DW 30 DUP(?)  ; 30个元素初始化为零

    ; 用20个零初始化buf3
    buf3 DW 20 DUP(0)

    ; 用于提示和消息的字符串
string_input_buf1 DB 'Enter 10 numbers for buf1 (0-65535): $'
    string_input_buf2 DB 'Enter 30 numbers for buf2 (0-65535): $'
    string_prompt_end DB 0ah, 0dh, '$'

    ; 错误提示消息
    string_error DB 'ERROR: INPUT OUT OF RANGE! Please input again: $'

DATAS ENDS


STACKS SEGMENT
    ; 根据需要定义堆栈段
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES, DS:DATAS, SS:STACKS

main PROC FAR
    mov ax, DATAS
    mov ds, ax
    mov es, ax

    ; 手动输入buf1的数据
    mov si, 0
    mov cx, 10
input_buf1:
    mov dx, OFFSET string_input_buf1
    mov ah, 9
    int 21h

    call Input   ; 需要实现Input过程来处理单个数字的输入和验证

    mov [buf1 + si], ax  ; 将输入值存入buf1
    add si, 2
    loop input_buf1

    ; 手动输入buf2的数据
    mov si, 0
    mov cx, 30
input_buf2:
    mov dx, OFFSET string_input_buf2
    mov ah, 9
    int 21h

    call Input   ; 需要实现Input过程来处理单个数字的输入和验证

    mov [buf2 + si], ax  ; 将输入值存入buf2
    add si, 2
    loop input_buf2

    ; 处理buf1和buf2的代码
    mov si, 0
    mov di, 0
loop_begin:
    cld                 ; 清零循环方向
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

; 输入子程序，处理单个数字的输入和验证
Input PROC NEAR
    push AX
    push BX
    push CX
    push DX

    mov BX, 0    ; BX用于存储当前输入的数字
    CLC
    MOV DX, 0

Lp_0:
    MOV AH, 1
    INT 21H

    CMP AL, 20H  ; 检查是否是空格
    JE L_SPACE   ; 如果是空格，跳转到处理空格的标签

    CMP AL, 0DH  ; 检查是否是回车键
    JE L_END     ; 如果是回车键，跳转到结束输入的标签

    ; x 属于 [0, 9]
    SUB AL, 30H  ; ASCII -> int
    JL L_ERROR  
    CMP AL, 9
    JG L_ERROR

    ; string -> int
    MOV AH, 0   ; 扩展 AL 到 AX
    XCHG AX, BX ; 保护 AX 值
    MOV CX, 10
    MUL CX      ; BX *= 10
    ADD AX, BX
    JC L_ERROR  ; 处理溢出
    XCHG AX, BX 
    JMP Lp_0

L_SPACE:
    MOV DX, 0
    MOV [DI], BX ; 将输入的数字存入目标地址
    POP DX
    POP CX
    POP BX
    POP AX
    RET

L_END:
    MOV DX, 0
    MOV [DI], BX ; 将输入的数字存入目标地址
    POP DX
    POP CX
    POP BX
    POP AX
    RET

L_ERROR:
    MOV DX, 0
    MOV BX, 0
    CALL CRLF   ; 换行        
    CALL ERROR  ; 输出错误提示
    JMP Lp_0

Input ENDP


; 换行子程序
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

; 错误提示子程序
ERROR PROC NEAR
    push BX
    push DX
    MOV DX, OFFSET string_error ; 错误提示消息
    MOV AH, 09h
    INT 21H
    pop DX
    pop BX
    RET
ERROR ENDP


; 输出单个数字的子程序
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

