data segment
    prompt db 'Please input number n: ', 13, 10 ,'$' ; 提示用户输入n
    output db 'fibonacci(n): ', 13, 10, '$' ; 显示斐波那契数列的标签
    newline db 13, 10, '$' 
    error_prompt db 'Error input out of 0-100','$'

    number label byte
        max db 3    
        act db ?    
        num db 3 dup(?) 

   
    n1  dw 22 dup(0)
    n2  dw 22 dup(0)
    len dw 1 
    add_time dw 1 dup(0) 
data ends

code segment
main    proc    far    
    assume cs:code, ds:data
start::
    push    ds          
    xor     ax, ax     
    push    ax        
    mov     ax, data    
    mov     ds, ax     
  
    lea     dx, prompt
    mov     ah, 09
    int     21h
  
    lea     dx, number

    mov     ah, 0ah
    int     21h

   
    mov ah, 9
    lea dx, newline
    int 21h
  
    lea     si, num
    
    xor     cx, cx
    xor     ax, ax
    xor     bx, bx
  
    cmp     act, 2
    je      two
one:

    mov     ah, 0
    mov     al, ds:[si]    
    sub     al, 48          ; 将 ASCII 字符转换为数字
    mov     cx, ax         
    jmp     check           

two:
    
    mov     al, 10
    mov     ah, ds:[si]     
    sub     ah, 48          
    mul     ah              ; 将十位乘以 10(al)保存在al中
    mov     ah, 0         
    add     al, ds:[si+1]   ; 将个位的数字（ASCII形式）加到十位数上(10*十位数+个位数+‘0’)
    sub     al, 48          ; 将 ASCII 字符转换为数字
    mov     cx, ax          ; 将数字保存在 CX 寄存器中

check:
    cmp     cx, 1
    jb      error_exit
    cmp     cx, 99
    jbe     compare

error_exit:
    mov     ah, 9
    lea     dx, newline
    int     21H

    mov     ah, 9
    lea     dx, error_prompt
    int     21H
    jmp     exit


compare:
    xor     ax, ax
    xor     bx, bx
    lea     ax, n1          
    lea     bx, n2        
    mov     si, ax         
    mov     di, bx          
    push    ax            
    xor     ax, ax
    mov     ax, 1          
    mov     ds:[si], ax     
    mov     ds:[di], ax     
    pop     ax              ; 将栈中的值弹出到 AX 寄存器(即此前保存的AX）
    ; 判断n>1&&n>2
    cmp     cx, 2          
    jbe     print           
    sub     cx, 2           ; cx是进行斐波那契数列计算的次数


fibonacci:
    ; 已经确定n>2
    push    cx
    mov     si, ax 
    mov     di, bx 
    push    ax
    ; 计算下一项的斐波那契数列值
    mov     ax, len      
    shr     ax, 1        ; 右移一位，相当于除以 2
    mov     cx, ax       
    add     cx, add_time ; 加上上次迭代时的进位值
    xor     ax, ax       
    mov     add_time, ax ; 清零上次迭代的进位值
    pop     ax           

_add:
   
    push    ax
    push    bx
    mov     ax, ds:[si] ; 获取当前项的值
    mov     bx, ds:[di] ; 获取前一项的值
    add     bx, ax      
    mov     ds:[si], bx 
    mov     ds:[di], ax ; 将计算前的当前项保存到前一项
    
    mov     bx, 10
    cmp     ds:[si], bx 
    pop     bx
    pop     ax
    jb      less_than_10 ; 如果小于 10，跳转到标签 less_than_10
    
bigger_than_10:

    mov     dx, ds:[si] ; 获取当前项的值
    push    ax
    mov     ax, 10
    sub     ds:[si], ax ; 当前项减去 10
    xor     ax, ax
    mov     ax,1
    add     ds:[di+2], ax ; 将进位加到下一位
    pop     ax
    add     si, 2
    add     di, 2
    add     add_time, 1   ; 递增进位计数
    mov     len, si
    sub     len, ax
    loop    _add         ; 继续下一次迭代
    jmp     addr_change   ; 跳转到地址调整处

less_than_10:
  
    add     si, 2
    add     di, 2
    mov     len, si
    sub     len, ax   
    cmp     len,44
    jne     _add

addr_change:
    ; 调整地址，准备下一次迭代
    pop     cx
    loop    fibonacci   ; 继续下一次迭代

print:
 
    xor     dx, dx
    lea     dx, output ; 将输出字符串的地址加载到 dx 寄存器
    mov     ah, 09
    int     21h
    
    ; 输出计算结果
    xor     dx, dx
    xor     bx, bx
    mov     cx, 44  
    shr     cx, 1    
    sub     si, 2    ; 将 si 寄存器移动到最后一个有效数字

    print_num:
        ; 将数字转化为 ASCII 码，并显示
        mov     dx, ds:[si] ; 获取当前项的值
        remove_head_zero:
        cmp     bx, 0
        jne     convert_num
        cmp     dx, 0
        je      move_forward
        
        convert_num:
        mov     bx, 1  
        add     dx, 48 ; 重新转化为ASCII十进制

        mov     ah, 02
        int     21h
        
        move_forward:
        sub     si, 2        ; 移动到前一位
        loop    print_num   ; 继续下一次迭代

    mov     dl, 13 ; 回车
    mov     ah, 02      
    int     21h

exit:
    mov     ax, 4c00h
    int     21h

main endp

code ends

end start







