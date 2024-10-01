Newline macro
;CR return
mov dl,0dh
mov ah,02h
int 21h
;LF new line
mov dl,0ah
mov ah,02h
int 21h
endm
;Data Segment
dseg segment
namemax db 21 ;Max name length with ending
namelen db ? ;Actual name length from input
namestr db 21 dup(?) ;Name input
phonemax db 9 ;Max phone no. length with ending
phonelen db ? ;Actual phone no. length with ending
phonestr db 9 dup(?) ;Phone no. input
teltab db 50 dup(28 dup(?)) ;telphone no and name table
counter dw 0 ;Counter
endtel dw ? ;end of table
swapped dw ? ;is swapped
temp dw ? ;temp space
telephsort db 28 dup(?),13,10,¡®$¡¯ ;unknown yet
;Messages
info1 db ¡®Input name:$¡¯
info2 db ¡®Input a telephone number:$¡¯
info3 db ¡®Input error! Please input again(8 digits)!$¡¯
info4 db ¡®More?(y to continue,other keys go to searching)$¡¯
info5 db ¡®Do you want a telephone number?(Y/N)$¡¯
info6 db ¡®Name?$¡¯
info7 db 0ah,0dh,¡®Name Telephone¡¯,0ah,0dh,¡®$¡¯
info8 db 0ah,0dh,¡®Sorry,Not Found!¡¯,0ah,0dh,¡®$¡¯
dseg ends
;Stack Segment
sseg segment stack
sseg ends
;Code Segment
cseg segment
;Main Proc
main proc far

assume cs:cseg,ds:dseg,es:dseg,ss:sseg
;set up stack for return
start: ;start addr
push ds
xor ax,ax ;put zero in ax
push ax ;save ax on stack
;set DS ES reg to current data segment
mov ax,dseg
mov ds,ax
mov es,ax
lea di,teltab ;get tele table addr
newrecord:
;display info1
lea dx,info1
mov ah,09h
int 21h
;call input_name proc to get name
call input_name
;Newline
;display info2
lea dx,info2
mov ah,09h
int 21h
;call inphone proc to get phone no.
call inphone
Newline
;if there is already 50 records
cmp counter,50
ja sortrec
;display info4 to determine if there is more
lea dx,info4
mov ah,09h
int 21h
;get input char(only 1)
mov ah,01h
int 21h
;if it is Y
cmp al,79h
;continue to store record
Newline
jz newrecord
;else sort records
sortrec:
call sort
search1:
;display info5 to promote for searching
lea dx,info5
mov ah,09h
int 21h
;get input char(only 1)
mov ah,01h
int 21h
;if the char is Y (upper and lower case)
cmp al,79h ;y
jz dosearch
cmp al,59h ;Y
jz dosearch
;if the char is N (upper and lower case)
cmp al,6eh ;n
jz endprog
cmp al,4eh ;N
jz endprog
;if neither then promote for input again (only accept Y or N)
Newline
jmp search1
;Search Proc
dosearch:
Newline
call name_search
Newline
;Ask for another name to search
jmp search1
endprog:
ret
main endp
;input_name proc
input_name proc near

;Increase counter by 1
inc counter
;Get name input
lea dx,namemax
mov ah,0ah
int 21h
Newline ;begin a new line
mov bh,0 ;put zero in bx¡¯s high bits
mov bl,namelen ;put actual length in bx¡¯s low bits
mov cx,21 ;put max length in cx
sub cx,bx ;count input name¡¯s spaces
fillspc:
mov namestr[bx],20h ;fill space
inc bx ;move pointer to next space
loop fillspc ;loop to fill all the spaces
cld ;clear direction flag
;pass namestr by byte to store the input name
lea si,namestr
mov cx,20
rep movsb
ret
input_name endp
;inphone proc
inphone proc near

;get phone no.
pagain:
lea dx,phonemax
mov ah,0ah
int 21h
;validate input phone no.
cmp phonelen,8
jnz wrongno ;invalidate no. detected
cld ;clear direction flag
;store number
lea si,phonestr
mov cx,8
rep movsb
ret

wrongno:
Newline
;display info3 wrong number
lea dx,info3
mov ah,09h
int 21h
Newline
;display info2
lea dx,info2
mov ah,09h
int 21h
;input again
jmp pagain
inphone endp
;sort proc
sort proc near

cmp counter,1 ;if there is only 1 rec(no need to sort)
jbe later
;get end addr of table
sub di,56 ;move pointer back 2 records for comparing
mov endtel,di
lbl1:
mov swapped,0 ;is swapped flag set to zero(false)
lea si,teltab ;get telephone table addr
lbl2:
mov cx,28 ;put 28 in cx counter
mov di,si
add di,28 ;move to next record
mov ax,di
mov bx,si
repe cmpsb ;compare to determine if exchanging is needed
jbe lbl3
call exchange ;call proc to exchange the 2 record
lbl3: ;no need to exchange
mov si,ax
cmp si,endtel ;if there is more records to compare
jbe lbl2
cmp swapped,0 ;no more swapped
jnz lbl1
later:
ret
sort endp
;exchange proc ¨C exchange the set of name and the number
exchange proc near

mov cx,28
lea di,telephsort
mov si,bx
rep movsb
mov cx,28
mov di,bx
rep movsb
mov cx,28
lea si,telephsort
rep movsb
mov swapped,1
ret
exchange endp
;name_search proc ¨C search for needed
name_search proc near

;display info6 promote for search key
lea dx,info6
mov ah,09h
int 21h
;get input name to search
lea dx,namemax
mov ah,0ah
int 21h
;fill spaces
mov bh,0
mov bl,namelen
mov cx,21
sub cx,bx
lbl1:
mov namestr[bx],20h
inc bx
loop lbl1
;get record count
mov bx,counter
;get table addr
lea di,teltab
lbl2:
mov ax,di
lea si,namestr
mov cx,0
mov cl,20
repe cmpsb
je found
add ax,28 ;move to next record 20 name +8 phone no.
mov di,ax ;put pos in pointer
dec bx ;decrease counter by 1
;if bx is zero then there is no more records to search not found!
jz nofound
;else compare next record¡¯s name field
jmp lbl2
found:
mov temp,ax
;display info7 found needed
lea dx,info7
mov ah,09h
int 21h
;move to extra seg for display
lea di,telephsort
mov si,temp
mov cx,28
rep movsb
;display the record found just now
lea dx,telephsort
mov ah,09h
int 21h
ret
nofound:
;display info8 not found!
lea dx,info8
mov ah,09h
int 21h
ret

name_search endp
cseg ends
end main
