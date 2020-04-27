INCLUDE Irvine32.inc
INCLUDE macros.inc

;counter Struct
; This struct contain the data of huffmancode
;contain Character , Left of parent ,right of parent,and parent
;--------------------------------------------------------
counter Struct
character byte ?
leftt Dword 0
rightt Dword 1
parent Dword ?
counter ends

;Hcode Struct 
;This struct contain  the code of each Character
;contain array of byte of zero's ,one's 
HCODE Struct
 BITS dword 5
 HCODE ends

 ;iter Struct
 ;This struct contain  the character and code of each charcter
;contain charcters,array of byte of zero's and one's 
iter struct
charr byte ?
code HCODE 10  dup(<>)
iter ENDS

HuffmanCode Struct
HC iter 10 dup (<>)
HuffmanCode ENDS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
charcode struct 
character byte ?
code Dword 10 dup(5)
charcode ends 

encode struct
parentt Dword ?
c1 counter <>
c2 counter <>
encode ends

summtion Struct 
left Dword ?
right byte ?
frequceny1 byte 26 dup(?)
character1 byte ?
nodesum Dword ?
summtion ends 

BUFFER_SIZE = 7000
.data
decode encode 50 dup (<>)
count counter 30 dup  (<>)
finalTree counter 30 dup(<>)
Hccode charcode 26 dup(<>)
hc HuffmanCode <>
ht HuffmanCode <>

left Dword ?
right Dword ?
cnt2 Dword 0
sum Dword ?
chh byte ?
writesearch Dword 0
strsize dword ?
strsize1 dword ?
tree Dword  1000 dup(?)
charh byte 1000 dup(?)


count2 dword 0
count1 dword 0
times dword 10
val dword 0
numbering dword 0
copy dword ?
byt byte 10000 dup(?)


temp dword ? 
temp1 dword ?
temp3 dword ?
temp4 dword ?
cnt  dword 0
check dword 0
cop dword ?

prnt dword ?
co1 dword ?
co2 dword ?
co3 dword ?
root dword ?
cnt3 Dword 1
f dword ?
newchar byte ?
Charters byte 1000 dup (?)
se dword 4
total dword ?
iteration dword ?

buffer BYTE BUFFER_SIZE DUP(?)
CharacterString BYTE lengthof buffer dup(?)
filename BYTE "output.txt", 0
fileHandle HANDLE ?
Filenamewrite  byte  "E:\\Data comp\\encoding\\input.txt",0
Filenameread byte "input.txt",0

.code
main PROC
; Let user input a filename.
;mWrite "Enter an input filename: "
;mov edx,OFFSET filename
;mov ecx,SIZEOF filename
;call ReadString
; Open the file for input.
mov edx,OFFSET filename
call OpenInputFile
mov fileHandle,eax
cmp eax,INVALID_HANDLE_VALUE ; error opening file?
jne file_ok ; no: skip
mWrite <"Cannot open file",0dh,0ah>
jmp quit ; and quit
file_ok:
; Read the file into a buffer.
mov edx,OFFSET buffer
mov ecx,BUFFER_SIZE
call ReadFromFile
jnc check_buffer_size ; error reading?
mWrite "Error reading file. " ; yes: show error message
call WriteWindowsMsg
jmp close_file
check_buffer_size:
cmp eax,BUFFER_SIZE ; buffer large enough?
jb buf_size_ok ; yes
mWrite <"Error: Buffer too small for the file",0dh,0ah>
jmp quit ; and quit
buf_size_ok:
mov buffer[eax],0 ; insert null terminator
mWrite "File size: "
call WriteDec ; display file size
call Crlf
mov strsize, eax
; Display the buffer.
mWrite <"Buffer:",0dh,0ah,0dh,0ah>
mov edx,OFFSET buffer ; display the buffer
call WriteString
call Crlf
close_file:
mov eax,fileHandle
call CloseFile
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Let user input a filename.
;mWrite "Enter an input filename: "
;mov edx,OFFSET filename
;mov ecx,SIZEOF filename
;call ReadString
; Open the file for input.
mov edx,OFFSET Filenameread
call OpenInputFile
mov fileHandle,eax
cmp eax,INVALID_HANDLE_VALUE ; error opening file?
jne file_ok1 ; no: skip
mWrite <"Cannot open file",0dh,0ah>
jmp quit ; and quit
file_ok1:
; Read the file into a buffer.
mov edx,OFFSET byt
mov ecx,10000
call ReadFromFile
jnc check_buffer_size1 ; error reading?
mWrite "Error reading file. " ; yes: show error message
call WriteWindowsMsg
jmp close_file1
check_buffer_size1:
cmp eax,10000 ; buffer large enough?
jb buf_size_ok1 ; yes
mWrite <"Error: Buffer too small for the file",0dh,0ah>
jmp quit ; and quit
buf_size_ok1:
mov byt[eax],0 ; insert null terminator
mWrite "File size: "
call WriteDec ; display file size
call Crlf
mov strsize1, eax
; Display the buffer.
mWrite <"Buffer:",0dh,0ah,0dh,0ah>
mov edx,OFFSET byt ; display the buffer
call WriteString
call Crlf
close_file1:
mov eax,fileHandle
call CloseFile

;------------------------------------------------------------
;This Function make split to the File(buffer) into two arrays 
;input edi=offset buffer, esi =offset tree ,ecx=length of actual buffer 
;first array contain the tree 
;second array contain the char 
; return two array one to the tree and the second to char
;-------------------------------------------------------
mov edi,offset buffer  
mov esi, offset tree 
mov count2 , 0 
mov ecx , strsize
mov eax , 0
lW:
mov val ,ecx
mov ebx ,[edi]
cmp bl,' '
jne take
 mov [esi], eax
 mov eax ,[esi]
 call writedec
 mov al ,' '
 call writechar
 mov eax , 0 
 add esi,4
 add count1,1
jmp nextone  

take:
cmp bl , '.'
je termin
movzx ecx ,bl
sub ecx , 48
mul times
add eax , ecx

nextone :
add count2 , 1
mov ecx , val
add edi , 1
loop lW

termin:
call crlf
mov esi, offset tree
mov ecx , count1

Li:
mov eax ,[esi]
 call writedec
 mov al ,' '
 call writechar
 add esi,4
 loop Li
 call crlf
 mov ebx , count2 
 add ebx , 3
 mov esi , offset buffer
 add esi , ebx 
 mov ecx ,  strsize
 sub ecx , ebx
 sub ecx , 1
 mov edi ,offset charh
 mov ebx , numbering
lz:
mov eax ,[esi]

cmp al,' '
je tak
mov [edi],al
mov al , [edi]
call writechar
add edi , 1 
add ebx ,1

tak:
add esi ,1
loop lz
mov numbering , ebx

call crlf
;------------------------------------------------------------
;This Function get the child of each parent and char of each leaf
;input edi=offset tree, esi =offset tree ,ecx=length of actual buffer ,ebx=offset count (object fron Struct),ebp=offset array of char
;full the counter Struct  and return the parent and the child of each parent and char 
;-------------------------------------------------------
mov esi,offset tree
mov edi,offset tree
mov ebx , offset count 
mov ecx, lengthof tree
mov ebp, offset charh
l1:
mov edx , [esi]
cmp edx ,0
jne parent 
add esi,4 
add esi, 4
jmp ex

parent :
mov (counter ptr [ebx]).parent , edx
add edi , type tree
mov edx , [edi]
cmp edx,0
jne child
 mov eax ,[ebp]
 mov (counter ptr [ebx]).character ,al
 add ebp ,1
 add esi,type tree
 add edi ,type tree
 add ebx , type counter 
 jmp ex
 child:

 add ebx , type counter
 mov eax ,[edi]
 mov (counter ptr [ebx]).parent ,eax
 add edi ,type tree
 add ebx , type counter 
 mov eax , [edi]
 mov (counter ptr [ebx]).parent ,eax
 add esi,type tree
 add ebx , type counter 
ex:
loop l1
quit:
;-----------------------
;compare each parent with zero if not zero store the value to the parent(remove zero from the tree),reject the repeatly node
;edi =offset tree,esi=off set finaltree ,ecx length of tree (count)
;-----------------------
mov edi , offset tree
mov esi , offset finalTree
;mov ecx, lengthof tree
mov ecx,count1
l11:
mov eax ,[edi]
cmp eax ,0
je exx 
mov (counter ptr [esi]).parent ,eax 
add esi ,type counter
inc cnt
exx :
add edi , type tree
loop l11
;--------------------
;input esi=offset final tree ,cnt lenght of finaltree ,edi,offset=count(object from struct )
;assign each char to the his leaf 
;--------------------
mov esi , offset finalTree
mov ecx, cnt
l111:
  mov edi , offset count 
  mov edx , (counter ptr [esi]).parent 
  mov ebx, ecx
  mov ecx, cnt
  add ecx , cnt
  l2:
	 cmp edx, (counter ptr [edi]).parent
	 jne reep
	 mov al, (counter ptr [edi]).character
	 cmp al, 0
	 je reep
	 cmp al, '#'
	 je reeep
	 mov (counter ptr [esi]).character, al
	 mov al, '#'
	 mov (counter ptr [edi]).character, al
	 jmp outt
	 reep:
	 reeep:
	 repp:
	 add edi, type counter  
  loop l2
  outt:
  mov ecx, ebx
  add esi, type counter
loop l111

;---------------------------
;input esi=offset finaltree,ecx
;assign zero to left node and one to right node until reach to leaf
;---------------------------
mov esi , offset finaltree 
add esi , type counter 
mov ecx , cnt 
dec ecx
LQ:
mov eax ,0
mov (counter ptr [esi]).leftt ,eax
add esi , type counter
mov eax , 1
mov (counter ptr [esi]).leftt,eax
add esi ,type counter 
dec ecx
loop LQ
;-----------------------
;this function display the tree 
;each leaf and it's char and first zero or one of it's code 
;input esi=offset finaltree
;-----------------------

mov esi, offset finaltree
mov ecx, cnt
loop11:
mov eax, (counter ptr [esi]).parent
CALL WriteDec
mov al, ' '
CALL WriteChar
mov al, (counter ptr [esi]).character
CALL WriteChar
mov al, ' '
CALL WriteChar

mov eax, (counter ptr [esi]).leftt
CALL WriteDec
mov al, ' '
CALL WriteChar

mov eax, (counter ptr [esi]).rightt
CALL WriteDec

mov al, ' '
CALL WriteChar
add esi, type counter
CALL CRLF
CALL CRLF
loop loop11
;-----------------------------------
;This store the parent and child and zero or one of each node and char for leaf in one (struct encoding) and the parent of each child
;input esi=off set finaltree,edi=offset decode(object of encoding),ecx= cnt
;-----------------------------------
mov esi ,offset finaltree
mov edi ,offset decode 
add esi , type counter 
mov ecx , cnt 
dec ecx
LQ1:
mov eax,(counter ptr [esi]).parent
mov (encode PTR [edi]).c1.parent ,eax
mov eax,(counter ptr [esi]).leftt 
mov (encode PTR [edi]).c1.leftt,eax
mov al,(counter ptr [esi]).character
mov (encode PTR [edi]).c1.character ,al
add esi , type counter

mov eax,(counter ptr [esi]).parent
mov (encode PTR [edi]).c2.parent ,eax
mov eax,(counter ptr [esi]).leftt 
mov (encode PTR [edi]).c2.leftt,eax
mov al,(counter ptr [esi]).character
mov (encode PTR [edi]).c2.character ,al

mov eax,0
add eax,(encode PTR [edi]).c1.parent
add eax,(encode PTR [edi]).c2.parent
mov (encode PTR [edi]).parentt,eax

add esi ,type counter 
dec ecx
inc cnt2
add edi,type encode
loop LQ1
 ;-------------
 ;display the struct of encode
 ; parent ,child ,char ,with edge 
 ;------------
mov ecx,cnt2
mov iteration , ecx
add iteration , ecx
mov edi ,offset decode 
l12:
mov eax, (encode ptr [edi]).parentt
call writedec 
call crlf
mov eax,(encode PTR [edi]).c1.parent
call writedec 
mov al, ' '
CALL WriteChar
mov eax,(encode PTR [edi]).c1.leftt
call writedec 
mov al, ' '
CALL WriteChar
mov al,(encode PTR [edi]).c1.character 
call writechar 
call crlf
mov eax,(encode PTR [edi]).c2.parent 
call writedec 
mov al, ' '
CALL WriteChar
mov eax,(encode PTR [edi]).c2.leftt
call writedec 
mov al, ' '
CALL WriteChar
mov al,(encode PTR [edi]).c2.character 
call writechar 
call crlf
add edi,type encode 
loop l12
;---------------------------
; get the code of each char in tree 
;input edi=offset decode ,esi,offset=array of char,edx=off set hc(object from struct), 
;---------------------------
mov edi ,offset decode
mov esi,offset charh ;"f, c, d, e, a, b",0
mov edx, offset hc
add edx ,offset HuffmanCode.HC

mov eax, length decode
mov ecx,numbering
mov eax,(encode ptr [edi]).parentt
mov root, eax
l123:
   CALL BBB
   CALL BB
	cmp eax, root
	je Exitt
add ebx ,type HCODE
 mov edi, offset decode
 mov ecx, iteration
 call AA 
  Exitt:
  mov al, chh
  mov ecx, co1
  add edx, type iter
  add esi ,type charh
loop l123
call crlf
;-----------------------
;display each char with it's code 
;input esi=offset hc
;-----------------------

mov esi, offset hc
add esi ,offset HuffmanCode.HC
mov ecx ,numbering
frq:
    mov f , ecx
    mov ebx , esi 
	mov al,(iter ptr [esi]).charr
	call writechar
	mov al ,' '
	call writechar
	add ebx , offset iter.code
	mov ecx , 10
    bits:
	   mov eax ,((HCODE PTR [ebx])).BITS
	   cmp eax ,5
	   je next
	   call writedec
      add ebx , type HCODE
   loop bits
   next:
   	add esi, type iter
	call crlf
	mov ecx , f

loop frq
;------------------------------------
;reverse the code of char because the previous proc get the code from the bottom but here get the correct code 
; input esi=ofsset hc,edi=offset ht both are object of struct HuffmanCode
;return the char and the correct code 
;------------------------------------
mov esi, offset hc
add esi ,offset HuffmanCode.HC
mov edi, offset ht
add edi ,offset HuffmanCode.HC
mov ecx , numbering
Frqq :
    mov f , ecx
    mov ebx , esi 
	mov edx , edi
	mov al,(iter ptr [esi]).charr
	mov (iter ptr [edi]).charr ,al

	call writechar
	mov al ,' '
	call writechar

	 add  edx , offset iter.code
	 add ebx , offset iter.code
	 mov ecx , 10
	 reverse :
	 add ebx , type HCODE
	 loop reverse
	 
	 sub ebx , type HCODE
	 mov ecx , 10
     bitss :
	  mov eax ,((HCODE PTR [ebx])).BITS
	  cmp eax ,5
	   je nextt
	   mov ((HCODE PTR [edx])).BITS , eax
	   mov eax ,((HCODE PTR [edx])).BITS
	   call writedec
	   add edx , type HCODE
	   nextt:   
      sub ebx , type HCODE
    loop bitss
   	 add esi, type iter
	 add edi , type iter
	 call crlf
	 mov ecx , f
    loop frqq
;-------------------------------
;the iteration loop until the the entire code match with any char and jump to termi to write this char after matching
;and get the other byte and check it's matching or not 
;input eax,length of entire code ,edx offset Charters,ebp,offset byt entire code ,esi,offset ht object of huffman
;-------------------------------
 mov eax , strsize1 ;; taking the size
 add eax , offset byt
 mov total ,eax
 mov ecx , 10000
 mov edx , offset Charters 
 mov ebp , offset byt
  search :
    mov edi , ebp
    mov ecx , numbering
	mov esi , offset ht
  checking :
	   mov check , ecx
	   mov ebx , esi 
       add ebx , offset iter.code
       mov ecx , 10
	l55 :
	   mov eax , [edi]
	   sub eax,48
	   cmp al , byte ptr((HCODE PTR [ebx])).BITS ;;byte ptr
	   jne che 
	   add edi , type byt
	   add ebx , type HCODE
	   mov eax , ((HCODE PTR [ebx])).BITS
	   cmp eax ,5 
	   je exist
	   loop l55
	    che:
	    add esi , type iter
	    mov edi ,  ebp
     	mov ecx , check
	  loop checking
	 exist:
		mov ebp , edi
		mov al ,(iter ptr [esi]).charr 
		mov [edx] , al
		add edx , 1
		inc writesearch
		cmp edi ,total 
	  je termi
  loop search

	termi:
	mov esi , offset Charters
	mov ecx , writesearch
	print :
	mov al , [esi]
	call writechar

	mov al , ' '
	call writechar
	add esi ,1
	loop print 

	;------------------
	;display to file the matching char from entire code  
	;------------------
	mov edx,OFFSET Filenamewrite
	call CreateOutputFile
	mov fileHandle,eax
	; Write the buffer to the output file.
	mov eax,fileHandle
	mov edx,OFFSET Charters
	mov ecx,writesearch
	call WriteToFile
	call CloseFile

exit
main ENDP
AA proc
loop15:
     mov eax, prnt

	 cmp eax, (encode ptr [edi]).c1.parent
	 jne skip3
	 mov copy, eax
	 mov al, (encode ptr [edi]).c1.character
	 mov al, 0
	 cmp (encode ptr [edi]).c1.character, al
	 jne skip5
	 mov eax, copy
	 mov eax, (encode ptr [edi]).c1.leftt
	 mov ((HCODE PTR [ebx])).BITS, eax
	 mov eax, (encode ptr [edi]).c1.parent
	 add eax, (encode ptr [edi]).c2.parent
	 mov prnt, eax
     mov edi, offset decode
	 add ebx ,type HCODE
	 jmp jumpp
	 skip3:
	 skip5:
	 mov cop, eax
	 mov eax, (encode ptr [edi]).c2.parent
	 mov eax, cop
	 cmp eax, (encode ptr [edi]).c2.parent
	 jne skip4
	 mov copy, eax
	 mov al, 0
	 cmp (encode ptr [edi]).c2.character, al
	 jne skip6
	  
	 mov eax, copy
	 mov eax, (encode ptr [edi]).c2.leftt
	 mov ((HCODE PTR [ebx])).BITS, eax
	 mov eax, (encode ptr [edi]).c1.parent
	 add eax, (encode ptr [edi]).c2.parent
	 mov prnt, eax
	 mov edi,offset decode
	 add ebx ,type HCODE
	 jmp jumpp
	skip6:
	 skip4:
     add edi,type decode
	 jumpp:
  loop loop15
ret
AA  endp
BB PROC
;-------------------------
;this proc full the array of code to each char start from the char and it's frequency and add his zero or one to array
;get the parent for this node and take the edge until reach the root and repeat until get the code for all char
;return code of each char(reversed)
;-------------------------
loop14:
    mov co2, ecx
    cmp al ,(encode ptr [edi]).c1.character
    jne skip
	mov eax, (encode ptr [edi]).c1.leftt
	mov ((HCODE PTR [ebx])).BITS, eax
	mov eax, 0
	mov eax, (encode ptr [edi]).c1.parent
	add eax, (encode ptr [edi]).c2.parent
	mov prnt, eax
	
	jmp breakk
    skip:

    cmp al,(encode ptr [edi]).c2.character
	mov cl , (encode ptr [edi]).c2.character
	
    jne skip1 
	mov eax, (encode ptr [edi]).c2.leftt
	mov ((HCODE PTR [ebx])).BITS, eax
	mov eax, 0
	mov eax, (encode ptr [edi]).c2.parent
	add eax, (encode ptr [edi]).c1.parent
	mov prnt, eax

	jmp breakk
    skip1:
    add edi,type encode
	mov ecx, co2
    inc cnt3
 loop loop14
 breakk:
 ret
BB ENDP

BBB PROC
   mov cnt3, 1
   mov al, [esi]
	mov (iter ptr [edx]).charr, al
	mov chh, al
	mov co1, ecx
	mov ecx, 5
	mov ebx , edx 
    add ebx , offset iter.code
    mov edi, offset decode
	ret

BBB  ENDP

END main

;------------------------------------------------------
CreateOutputFile PROC
;
; Creates a new file and opens it in output mode.
; Receives: EDX points to the filename.
; Returns: If the file was created successfully, EAX
; contains a valid file handle. Otherwise, EAX
; equals INVALID_HANDLE_VALUE.
;------------------------------------------------------
INVOKE CreateFile,
edx, GENERIC_WRITE, DO_NOT_SHARE, NULL,
CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
ret
CreateOutputFile ENDP
;------------------------------------------------------
OpenFile PROC
;
; Opens a new text file and opens for input.
; Receives: EDX points to the filename.
; Returns: If the file was opened successfully, EAX
; contains a valid file handle. Otherwise, EAX equals
; INVALID_HANDLE_VALUE.
;------------------------------------------------------
INVOKE CreateFile,
edx, GENERIC_READ, DO_NOT_SHARE, NULL,
OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0
ret
OpenFile ENDP
;--------------------------------------------------------
WriteToFile PROC
;
; Writes a buffer to an output file.
; Receives: EAX = file handle, EDX = buffer offset,
; ECX = number of bytes to write
; Returns: EAX = number of bytes written to the file.
; If the value returned in EAX is less than the
; argument passed in ECX, an error likely occurred.
;--------------------------------------------------------
.data
WriteToFile_1 DWORD ? ; number of bytes written
.code
INVOKE WriteFile, ; write buffer to file
eax, ; file handle
edx, ; buffer pointer
ecx, ; number of bytes to write
ADDR WriteToFile_1, ; number of bytes written
0 ; overlapped execution flag
mov eax,WriteToFile_1 ; return value
ret
WriteToFile ENDP
;--------------------------------------------------------
ReadFromFile PROC
;
; Reads an input file into a buffer.
; Receives: EAX = file handle, EDX = buffer offset,
; ECX = number of bytes to read
; Returns: If CF = 0, EAX = number of bytes read; if
; CF = 1, EAX contains the system error code returned
; by the GetLastError Win32 API function.
;--------------------------------------------------------
.data
ReadFromFile_1 DWORD ? ; number of bytes read
.code
INVOKE ReadFile,
eax, ; file handle
edx, ; buffer pointer
ecx, ; max bytes to read
ADDR ReadFromFile_1, ; number of bytes read
0 ; overlapped execution flag
mov eax,ReadFromFile_1
ret
ReadFromFile ENDP
;--------------------------------------------------------
CloseFile PROC
;
; Closes a file using its handle as an identifier.
; Receives: EAX = file handle
; Returns: EAX = nonzero if the file is successfully
; closed.
;--------------------------------------------------------
INVOKE CloseHandle, eax
ret
CloseFile ENDP