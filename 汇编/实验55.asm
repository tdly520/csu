data segment
    prompt db 'Please input number n: ', 13, 10 ,'$' ; ��ʾ�û�����n
    output db 'fibonacci(n): ', 13, 10, '$' ; ��ʾ쳲��������еı�ǩ
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
    sub     al, 48          ; �� ASCII �ַ�ת��Ϊ����
    mov     cx, ax         
    jmp     check           

two:
    
    mov     al, 10
    mov     ah, ds:[si]     
    sub     ah, 48          
    mul     ah              ; ��ʮλ���� 10(al)������al��
    mov     ah, 0         
    add     al, ds:[si+1]   ; ����λ�����֣�ASCII��ʽ���ӵ�ʮλ����(10*ʮλ��+��λ��+��0��)
    sub     al, 48          ; �� ASCII �ַ�ת��Ϊ����
    mov     cx, ax          ; �����ֱ����� CX �Ĵ�����

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
    pop     ax              ; ��ջ�е�ֵ������ AX �Ĵ���(����ǰ�����AX��
    ; �ж�n>1&&n>2
    cmp     cx, 2          
    jbe     print           
    sub     cx, 2           ; cx�ǽ���쳲��������м���Ĵ���


fibonacci:
    ; �Ѿ�ȷ��n>2
    push    cx
    mov     si, ax 
    mov     di, bx 
    push    ax
    ; ������һ���쳲���������ֵ
    mov     ax, len      
    shr     ax, 1        ; ����һλ���൱�ڳ��� 2
    mov     cx, ax       
    add     cx, add_time ; �����ϴε���ʱ�Ľ�λֵ
    xor     ax, ax       
    mov     add_time, ax ; �����ϴε����Ľ�λֵ
    pop     ax           

_add:
   
    push    ax
    push    bx
    mov     ax, ds:[si] ; ��ȡ��ǰ���ֵ
    mov     bx, ds:[di] ; ��ȡǰһ���ֵ
    add     bx, ax      
    mov     ds:[si], bx 
    mov     ds:[di], ax ; ������ǰ�ĵ�ǰ��浽ǰһ��
    
    mov     bx, 10
    cmp     ds:[si], bx 
    pop     bx
    pop     ax
    jb      less_than_10 ; ���С�� 10����ת����ǩ less_than_10
    
bigger_than_10:

    mov     dx, ds:[si] ; ��ȡ��ǰ���ֵ
    push    ax
    mov     ax, 10
    sub     ds:[si], ax ; ��ǰ���ȥ 10
    xor     ax, ax
    mov     ax,1
    add     ds:[di+2], ax ; ����λ�ӵ���һλ
    pop     ax
    add     si, 2
    add     di, 2
    add     add_time, 1   ; ������λ����
    mov     len, si
    sub     len, ax
    loop    _add         ; ������һ�ε���
    jmp     addr_change   ; ��ת����ַ������

less_than_10:
  
    add     si, 2
    add     di, 2
    mov     len, si
    sub     len, ax   
    cmp     len,44
    jne     _add

addr_change:
    ; ������ַ��׼����һ�ε���
    pop     cx
    loop    fibonacci   ; ������һ�ε���

print:
 
    xor     dx, dx
    lea     dx, output ; ������ַ����ĵ�ַ���ص� dx �Ĵ���
    mov     ah, 09
    int     21h
    
    ; ���������
    xor     dx, dx
    xor     bx, bx
    mov     cx, 44  
    shr     cx, 1    
    sub     si, 2    ; �� si �Ĵ����ƶ������һ����Ч����

    print_num:
        ; ������ת��Ϊ ASCII �룬����ʾ
        mov     dx, ds:[si] ; ��ȡ��ǰ���ֵ
        remove_head_zero:
        cmp     bx, 0
        jne     convert_num
        cmp     dx, 0
        je      move_forward
        
        convert_num:
        mov     bx, 1  
        add     dx, 48 ; ����ת��ΪASCIIʮ����

        mov     ah, 02
        int     21h
        
        move_forward:
        sub     si, 2        ; �ƶ���ǰһλ
        loop    print_num   ; ������һ�ε���

    mov     dl, 13 ; �س�
    mov     ah, 02      
    int     21h

exit:
    mov     ax, 4c00h
    int     21h

main endp

code ends

end start







