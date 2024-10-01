data segment
    prompt db 'Please input number n: ', 13, 10 ,'$' 
    output db 'fibonacci(n): ', 13, 10, '$' 
    newline db 13, 10, '$' ¡Œ
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

   ¡Œ
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
    sub     al, 48         
    mov     cx, ax          
    jmp     check          

two:
    
    mov     al, 10
    mov     ah, ds:[si]    
    sub     ah, 48         
    mul     ah             
    mov     ah, 0           
    add     al, ds:[si+1] 
    mov     cx, ax        
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
    pop     ax             
  
    cmp     cx, 2       
    jbe     print           
    sub     cx, 2      
    mov     len, 4

fibonacci:
  
    push    cx
    mov     si, ax 
    mov     di, bx
    push    ax
   
    mov     ax, len     
    shr     ax, 1        
    mov     cx, ax       
    add     cx, add_time 
    xor     ax, ax       
    mov     add_time, ax
    pop     ax          

_add:
   
    push    ax
    push    bx
    mov     ax, ds:[si] 
    mov     bx, ds:[di] 
    add     bx, ax      
    mov     ds:[si], bx 
    mov     ds:[di], ax
 
    mov     bx, 10
    cmp     ds:[si], bx 
    pop     bx
    pop     ax
    jb      less_than_10
    
bigger_than_10:
   
    mov     dx, ds:[si]
    push    ax
    mov     ax, 10
    sub     ds:[si], ax 
    xor     ax, ax
    mov     ax,1
    add     ds:[di+2], ax
    pop     ax
    add     si, 2
    add     di, 2
    add     add_time, 1   
    mov     len, si
    sub     len, ax
    loop    _add         
    jmp     addr_change  

less_than_10:
  
    add     si, 2
    add     di, 2
    mov     len, si
    sub     len, ax   
    cmp     len,44
    jne     _add

addr_change:
    
    pop     cx
    loop    fibonacci   

print:
   
    xor     dx, dx
    lea     dx, output
    mov     ah, 09
    int     21h
    
    
    xor     dx, dx
    xor     bx, bx
    mov     cx, 44  
    shr     cx, 1  
    sub     si, 2    
    print_num:
       
        mov     dx, ds:[si] 
        remove_head_zero:
        cmp     bx, 0
        jne     convert_num
        cmp     dx, 0
        je      move_forward
        convert_num:
        mov     bx, 1  
        add     dx, 48 

        mov     ah, 02
        int     21h
        move_forward:
        sub     si, 2       
        loop    print_num  

    mov     dl, 13
    mov     ah, 02      
    int     21h

exit:
    mov     ax, 4c00h
    int     21h

main endp

code ends

end start



