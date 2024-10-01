DATAS SEGMENT
  mess1 db 'Input name:',13,10,'$'
  mess2 db 'Input a telephone number:',13,10,'$'
  mess3 db 'Do you want a telephone number?(Y/N)',13,10,'$'
  mess4 db 'name?',13,10,'$'
 mess5 	db 		'name',19 dup(0),'tel.',13,10,'$'
	mess6 	db 		'Not find!',13,10,'$'
	mess7 db 'wrong',13,10,'$'
  num dw 0;
  phonein label 	byte
	  pmax 	db 		9
	  pact 	db 		?
	  phone db 		9 dup(?)
	namin 	label 	byte
	  nmax 	db 		20
	  nact 	db 		?
	  nam   db      20 dup(?)
temp_nam db 20 dup(?)
temp_tab db 20 dup(?),4 dup(?),9 dup(?),13,10,'$'
tel_tab db 50 dup(20 dup (?),4 dup(?),9 dup(?),13,10,'$')




    ;�˴��������ݶδ���  
DATAS ENDS

STACKS SEGMENT
    ;�˴������ջ�δ���
STACKS ENDS

CODES SEGMENT
  main proc far
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START::
    push ds
    sub ax,ax
    push ax
    
    MOV AX,DATAS
    MOV DS,AX
    mov es,ax
begin:
     mov ah,09h
     lea dx,mess1
     int 21h
     call clear
     call input_name;��������
     cmp nact,0
     je search;δ����
     call stor_name
     
     mov ah,09h
     lea dx,mess2
     int 21h
     call inphone 
     call name_sort
     jmp begin
 
search:
      mov ah,09h  
      lea dx,mess3
      int 21h
       
      mov ah,01h
      int 21h
      cmp al,'N'
      je exit
      call crlf
      mov ah ,09h
      lea dx, mess4
      int 21h
       
      call  input_name
      cmp nact,0
      je exit
      call name_search
      call printline
      jmp search
     
     
exit:
     ret
main endp 

input_name proc  near
 
     
    mov 	ah,0ah
	lea 	dx,namin
	int 	21h
	call 	crlf
	ret
input_name    endp

stor_name    proc    near
    cmp 	nact,0
    je 		exit1
    lea 	si,nam
    lea 	di,temp_tab
    sub 	ch,ch
    mov 	cl,nact
    cld
    rep 	movsb
exit1:
    ret
stor_name    endp
 

inphone    proc    near
    mov 	ah,0ah
    lea 	dx,phonein
    int 	21h

    cmp 	pact, 8       ; ���绰�����Ƿ�Ϊ8λ
    je      valid_phone  ; �����8λ����ת�� valid_phone ��ǩ

    ; �������8λ����ʾ������Ϣ����ת�� exit2
    mov ah, 09h
    lea dx, mess7  ; ��ʾ������Ϣ
    int 21h
    jmp exit2      ; ��ת���˳�

valid_phone:
    call 	crlf

    lea 	si,phone
    lea 	di,temp_tab
    add     di,23
    sub 	ch,ch
    mov 	cl,pact
    cld
    rep 	movsb
 exit2:
	ret   




inphone    endp
 

name_sort    proc    near
	cmp 	num,0
	jnz 	sort
	lea 	si,temp_tab 	;���������û�����ݣ�ֱ�Ӳ���
	lea 	di,tel_tab
	mov 	cx,35
	cld
	rep 	movsb
	jmp 	exit3
sort: 						;���򣬽�������
	mov 	cx,num
	lea 	di,tel_tab	
	lea 	si,temp_tab
	
loopsort:
	push 	di
	push 	cx
	mov 	cx,20
	repz 	cmpsb
	ja 		move		
	pop 	cx
	pop 	di
 	call 	insert  	
 
 	jmp 	exit3		;����������˳�
move:
	pop 	cx
	pop 	di
	add 	di,35  
	lea 	si,temp_tab
 	loop	loopsort
 	mov 	cx,35		;�����˳�ѭ����˵����Ҫ���������
 	rep 	movsb
 
exit3:
 	inc 	num  		;���������1
	ret 	
name_sort endp
 
insert proc near
 mov ax,num
 
loopinsert:
    push ax
    mov bx,35
    mul bx
    lea di,tel_tab
    add di,ax
    mov si,di
    sub si,35
    
    push cx
    mov cx,35
    rep movsb
    pop cx
    pop ax
    dec ax
    loop loopinsert
    lea si,temp_tab
    lea di,tel_tab
    mov bx,35
    mul bx
    add di,ax
    mov cx,35
    rep movsb
    ret
    
insert endp

name_search proc near
    call clear
    mov ch,0
    mov cl,nact
    lea si,nam
    lea di,temp_nam
    rep movsb
    mov cx,num
    lea di,tel_tab
    lea si,temp_nam
loopfind:
    push di
    push cx
    mov ch,0
    mov cl,20
    repz cmpsb
    je find
    pop cx
    pop di
    add di,35
    lea si,temp_nam
    loop loopfind
    mov cx,0
    jmp exit4
    
find:
   pop cx
   pop di
exit4: 
  ret
name_search endp

printline proc near
    cmp cx,0
    jnz next
    mov ah,09h
    lea dx,mess6;not find
    int 21h
    jmp exit5
next:
    lea dx,mess5
    mov ah,09h
    int 21h
    mov ax,num
    sub ax,cx
    mov bx,35
    mul  bx
    lea dx,tel_tab
    add dx,ax
    mov ah,09h
    int 21h
    
exit5:
  ret
  
printline endp    
  
  

crlf 	proc 	near
	mov 	dl,0ah
	mov 	ah,02h;����
	int 	21h
	mov 	dl,0ah
	mov 	ah,02h
	int 	21h
	ret
crlf endp	
	
	
clear 	proc 	near
	lea 	di,temp_tab
	xor 	al,al;��Ϊ0
    mov 	cx,32
	rep 	stosb;���
	lea 	di,temp_nam
	xor 	al,al
    mov 	cx,20
	rep 	stosb
	ret
clear 	endp

   
    

    
    
    
            
     
 
     
     
     
    ;�˴��������δ���
    
    INT 21H
CODES ENDS
    END START














