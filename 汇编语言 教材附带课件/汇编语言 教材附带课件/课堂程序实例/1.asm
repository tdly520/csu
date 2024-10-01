DATAS SEGMENT
    ; 输入buf1的数据
    buf1 DW 15 DUP(?)  ; 15个元素初始化为零

    ; 输入buf2的数据
    buf2 DW 20 DUP(?)  ; 20个元素初始化为零

    ; 用20个零初始化buf3
    buf3 DW 20 DUP(0)

    ; 用于提示和消息的字符串
    string_input_buf1 DB 'Enter 15 numbers for buf1 (0-65535): $'
    string_input_buf2 DB 'Enter 20 numbers for buf2 (0-65535): $'
    string_prompt_end DB 0ah, 0dh, '$'
    DATA  DW 10 DUP(?) 
    ; 错误提示消息
    string_error DB 'ERROR: Illegal INPUT! Please input again: $'
    string_error_2 DB 'ERROR: INPUT repeat !Please input again: $'

DATAS ENDS

STACKS SEGMENT
   DW 256 dup(?) ; 根据需要定义堆栈段
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES, DS:DATAS, SS:STACKS

main PROC FAR
    mov ax, DATAS
    mov ds, ax
    mov es, ax

    ; 手动输入buf1的数据
    mov si, 0
    mov cx, 15  ; 修改为15个数字
input_buf1:
    mov dx, OFFSET string_input_buf1
    mov ah, 9
    int 21h
lp1:
    call Input_1   ; 需要实现Input过程来处理单个数字的输入和验证

    
    add si, 2
    loop lp1
    call crlf
    ; 手动输入buf2的数据
    mov si, 0
    mov cx, 20  ; 修改为20个数字
input_buf2:
    mov dx, OFFSET string_input_buf2
    mov ah, 9
    int 21h
lp2:
    call Input_2   ; 需要实现Input过程来处理单个数字的输入和验证

 
    add si, 2
    loop lp2
    call crlf

    ; 处理buf1和buf2的代码
    mov si, 0
    mov di, 0
loop_begin:
    cld                 ; 清零循环方向
    mov ax, [buf1 + si]
    cmp si, 30  ; 修改为30
    je print0

    add si, 2
    push di
    mov cx, 40  ; 修改为40
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
    mov cx, 20  ; 修改为20
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
Input_1 PROC Near
    push AX
    push BX
    push CX
    push DX


    MOV BX, 0
    CLC
    MOV DX, 0
;----------输入数字--------------
    Lp_0:
        MOV AH, 1
        INT 21H
        CMP AL, 20H ;空格
        JE L_CRLF

;-----   x belong to [0,9]   ----------        
        SUB AL, 30H ; ASCII -> int
        JL L_ERROR  
        CMP AL, 9
        JG L_ERROR
;-------  string -> int   -----------
        MOV AH, 0   ;将 AL扩展成 AX
        XCHG AX, BX ;保护 AX值
        MOV CX, 10
        MUL CX      ; bx *= 10
        ADD AX , BX
        JC L_ERROR  ; OVERFLOW处理
        XCHG AX, BX 
        JMP Lp_0
    L_ERROR:
        MOV DX, 0
        MOV BX, 0
        CALL CRLF   ; 换行        
        CALL ERROR  ; 输出错误提示
        JMP Lp_0
    L_repeat:
        MOV DX, 0
        MOV BX, 0
        CALL CRLF   ; 换行        
        CALL again  ; 输出重复错误
        JMP Lp_0
    L_CRLF:         ; 以换行作为一个数的结束标志
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
;----------输入数字--------------
    Lp_0:
        MOV AH, 1
        INT 21H
        CMP AL, 20H ;空格
        JE L_CRLF

;-----   x belong to [0,9]   ----------        
        SUB AL, 30H ; ASCII -> int
        JL L_ERROR  
        CMP AL, 9
        JG L_ERROR
;-------  string -> int   -----------
        MOV AH, 0   ;将 AL扩展成 AX
        XCHG AX, BX ;保护 AX值
        MOV CX, 10
        MUL CX      ; bx *= 10
        ADD AX , BX
        JC L_ERROR  ; OVERFLOW处理
        XCHG AX, BX 
        JMP Lp_0
    L_ERROR:
        MOV DX, 0
        MOV BX, 0
        CALL CRLF   ; 换行        
        CALL ERROR  ; 输出错误提示
        JMP Lp_0
    L_repeat:
        MOV DX, 0
        MOV BX, 0
        CALL CRLF   ; 换行        
        CALL again  ; 输出重复错误
        JMP Lp_0
    L_CRLF:         ; 以换行作为一个数的结束标志
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


again PROC NEAR
    push BX
    push DX
    MOV DX, OFFSET string_error_2 ; 错误提示消息
    MOV AH, 09h
    INT 21H
    pop DX
    pop BX
    RET
again ENDP

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



