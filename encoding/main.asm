INCLUDE Irvine32.inc
INCLUDE macros.inc

counter Struct
frequency dword 26 dup(?)
character byte 26 dup (?)
counter ends


summtion Struct 
index dword 0
left dword 0
right dword 0
frequceny1 dword ?
character1 byte ?
summtion ends 

HCODE Struct
 BITS dword 5
 HCODE ends

iter struct
charr byte ?
code HCODE 10 dup(<>)
iter ENDS

HuffmanCode Struct
HC iter 10 dup (<>)
HuffmanCode ENDS


BUFFER_SIZE = 10000
.data

count counter <>
treestruct summtion 400 dup (<>)
finaltree  summtion 400 dup (<>)
anothertree  summtion 400 dup (<>)


hc HuffmanCode <>
ht HuffmanCode <>

strsize dword ?
check dword ?
cnt dword ?
len dword 0
lentree dword 0
final_tree_len dword 0
strr BYTE "abcdefghijklmnopqrstuvwxyz" ,0
f dword 0
copy dword 0
copy2 dword 0
copy3 dword 0
copy4 dword 0
sizetreeform dword 0
buffer BYTE BUFFER_SIZE DUP(?)
newbuffer BYTE BUFFER_SIZE DUP(?)
buffer2 BYTE BUFFER_SIZE DUP(?)
treeform dword 1000 dup(?)
treecharacters byte 1000 DUP(?)
offsettreechar dword ?

filename BYTE "input.txt", 0
filenameoutput BYTE "E:\\Data comp\\Decoding\\input.txt", 0
fileHandle HANDLE ?

fmin dword ?
smin dword ?
findex dword ?
sindex dword ?
clear dword 0
.code

main PROC

CALL ReadtheString

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov ebx, offset buffer
mov edx, offset newbuffer
mov ecx, strsize
loop1:
mov eax, [ebx]
mov [edx], eax
add ebx, type buffer
add edx, type newbuffer
loop loop1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


mov esi,OFFSET strr
mov ecx, lengthof strr
dec ecx
mov check, 0
mov cnt, 0
mov f, 0
mov edi, 0
CALL Calculat_frequance
quit:

mov edx, offset buffer
call writestring
call crlf

mov esi, offset count
mov edi, offset count
mov ebx, offset finaltree
mov edx, offset treestruct
mov ecx , len
mov cnt, 0
loop3:
mov al, (counter ptr [edi]).character
call writechar
mov (summtion ptr [ebx]).character1, al
mov (summtion ptr [edx]).character1, al

mov eax,(counter ptr [esi]).frequency
call writedec
mov (summtion ptr [ebx]).frequceny1, eax
mov (summtion ptr [edx]).frequceny1, eax
call crlf
mov eax, cnt
mov (summtion ptr [edx]).index, eax
mov (summtion ptr [ebx]).index, eax 
add esi,4
add edi,1
inc cnt
add edx, type summtion
add ebx, type summtion
loop loop3

mov ebx, offset finaltree
mov ecx, len
loop6: 
mov eax, (summtion ptr [ebx]).frequceny1
call writedec
mov al, (summtion ptr [ebx]).character1
call writechar
mov eax, (summtion ptr [ebx]).left
call writedec
mov eax, (summtion ptr [ebx]).right
call writedec
mov eax, (summtion ptr [ebx]).index
call writedec
call crlf
call crlf
add ebx, type summtion

loop loop6

mov esi, offset treestruct
mov edi, offset treestruct

mov ecx , len
dec ecx
mov ebx ,0
mov smin, 10000
mov fmin , 10000
mov check, 0
mov cnt, 1
mov ebx , len
mov f, ebx
mov ebx ,0
cmp ecx, 0
je exitt
mov eax, len
mov ebx, type summtion
mul ebx
add edi, eax
add eax, offset finaltree
loop5:
    mov edx , 0
	mov cnt, edx
    mov ebx, ecx
	mov esi, offset treestruct

    mov ecx , f
	CALL GetFMin
	
	mov edx , 0
	mov cnt, edx
	mov ecx , f
	mov esi, offset treestruct
	CALL GetSMin

	
	CALL writing


	add f, 1
	mov ecx, ebx
	add eax , type summtion
	add edi,type summtion
loop loop5
exitt:


mov ebx, offset finaltree
mov ecx, len
add ecx, len
dec ecx
loop7: 
mov eax, (summtion ptr [ebx]).frequceny1
call writedec
mov al, (summtion ptr [ebx]).character1
call writechar
mov eax, (summtion ptr [ebx]).left
call writedec
mov eax, (summtion ptr [ebx]).right
call writedec
mov eax, (summtion ptr [ebx]).index
call writedec
call crlf
call crlf
add ebx, type summtion
loop loop7

mov eax, len
add eax, len
dec eax
mov final_tree_len, eax
mWrite "Length Final Tree:"
call crlf
CALL writedec
call crlf


mov ecx, len
mov f, ecx
dec f
mov esi, offset finaltree
mov edi, offset finaltree
mov eax, len
mov ebx, type summtion
mul ebx
add edi, eax
mov check, edi
mov edx, offset hc
add edx ,offset HuffmanCode.HC
loop8:
     mov ebx, ecx
	 mov eax, (summtion ptr [esi]).index
	 mov ecx, f
	 mov edi, offset finaltree
	 mov edi, check
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	 
	 ;CALL GetCode
	  mov copy2 ,ebx
	mov ebx, 0
	mov ebx , edx 
	add ebx , offset iter.code
    loop9:
         mov copy, ecx
	     cmp eax, (summtion ptr [edi]).left
		 jne skip1
		 mov ecx, 0
		 mov ((HCODE PTR [ebx])).BITS, ecx
		 mov eax, (summtion ptr [edi]).index
		 add ebx ,type HCODE
		 
		 skip1:      
		 
		 cmp eax, (summtion ptr [edi]).right
		 jne skip2
		 mov ecx, 1
		 mov ((HCODE PTR [ebx])).BITS, ecx
		 mov eax, (summtion ptr [edi]).index
		 add ebx ,type HCODE
		 skip2:
		 add edi, type summtion
		 mov ecx, copy
	loop loop9
	mov bl,(summtion ptr [esi]).character1
	mov (iter ptr [edx]).charr, bl
	add edx, type iter
	mov ebx , copy2
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	 mov ecx, ebx
	 add esi, type summtion
loop loop8

call crlf
mov esi, offset hc
add esi ,offset HuffmanCode.HC
mov ecx , len
Frq :
     mov f , ecx
    mov ebx , esi 
	mov al,(iter ptr [esi]).charr
	call writechar
	mov al ,' '
	call writechar
	add ebx , offset iter.code
	 mov ecx , 10
     bits :
	  mov eax ,((HCODE PTR [ebx])).BITS
	   cmp eax ,5
	   je next
	   call writedec
	   next:
      add ebx , type HCODE
   loop bits
   	add esi, type iter
	call crlf
	mov ecx , f
loop frq
mov edx, offset newbuffer
CALL WriteString 
CALL CRLF
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov esi, offset hc
add esi ,offset HuffmanCode.HC

mov edi, offset ht
add edi ,offset HuffmanCode.HC

mov ecx ,len
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
	 	 
	  
	  sub	ebx , type HCODE

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



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
mov ecx, strsize
mov edx, offset newbuffer
mov edi, offset buffer2
mov copy3, 0
loop20:
      mov copy, ecx
	  mov esi, offset ht
	  add esi ,offset HuffmanCode.HC
	  mov ecx, len
	  loop21:
	       mov copy2, ecx
		   mov ebx , esi
		   mov al, (iter ptr [esi]).charr
		   cmp al, [edx]
		   jne outt
		   add ebx , offset iter.code
		   mov ecx, 1000
		   loop22:
		         mov eax, ((HCODE PTR [ebx])).BITS
				 cmp eax, 5
				 je nxt
				 add al, 48
				 mov [edi], al
				 add edi, type buffer2
				 add ebx , type HCODE
				 inc copy3
		   loop loop22
		    outt:
			mov ecx, copy2
		   add esi, type iter 
	  loop loop21
	  nxt:
	  mov ecx, copy
	  add edx, type newbuffer
loop loop20
mov edx, offset buffer2
CALL WriteString 
CALL CRLF

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; making tree

mov esi, offset finaltree
mov eax , final_tree_len
mov edx, type summtion 
mul edx
add esi, eax
sub esi ,type summtion
mov edi, offset treeform
mov edx, offset finaltree


mov eax, (summtion ptr [esi]).frequceny1
mov [edi], eax
add edi, type treeform
    

	mov eax, (summtion ptr [esi]).left
	mov ecx, final_tree_len
	loop88:
	     cmp eax, (summtion ptr [edx]).index
		 jne jump
		 mov eax, (summtion ptr [edx]).frequceny1
		 mov [edi], eax
		 mov eax, 100000
		 add edi, type treeform
		 jump:
		 add edx, type finaltree
	loop loop88

	mov edx, offset finaltree
	mov eax, (summtion ptr [esi]).right
	mov ecx, final_tree_len
	loop99:
	     cmp eax, (summtion ptr [edx]).index
		 jne jumpp
		 mov eax, (summtion ptr [edx]).frequceny1
		 mov [edi], eax
		 mov eax, 100000
		 add edi, type treeform
		 jumpp:
		 add edx, type finaltree
    loop loop99

mov eax, len
add eax, len
add eax, final_tree_len
mov lentree, eax
mov esi, offset treeform
add esi, type treeform
mov edx, esi
add edx, type treeform
add edx, type treeform
mov ecx, final_tree_len
mov edi, offset finaltree
mov offsettreechar, offset treecharacters
mov sizetreeform, 3
loop999:
	mov eax, [esi]
	 cmp eax, 0
	 je qut
	 mov ebx, (summtion ptr [edi]).frequceny1
	 cmp eax, (summtion ptr [edi]).frequceny1
	 jne sk
	 mov ebx, (summtion ptr [edi]).right
	 cmp ebx, 0
	 jne skk
	 mov [edx], ebx
	 add edx, type treeform
	 mov [edx], ebx
	 add edx, type treeform
	 mov ebx, offsettreechar
	 mov al, (summtion ptr [edi]).character1
	 mov [ebx], al
	 add offsettreechar, type treecharacters
	 mov ebx, -1
	 add sizetreeform, 2
	 mov edi, offset finaltree
	 jmp k
	 skk:
	 
	Call morsi
	 
	 add sizetreeform, 2
	 mov edi, offset finaltree
	 qut:
	 k:
	 mov ecx, final_tree_len
	 add esi, type treeform
	 jmp loop999
	 sk:
	 add edi, type finaltree
	 mov eax , sizetreeform
	 cmp eax, lentree
	 je qq
loop loop999
qq:






mov esi, offset treeform

mov ecx, lentree
loop555:
mov eax, [esi]
add esi, type treeform
CALL WRITEDEC
CALL CRLF
loop loop555

;;;;;;;

mov esi, offset treecharacters
mov ecx, len
loop5555:
mov al, [esi]
add esi, type treecharacters
CALL WRITECHAR
CALL CRLF
loop loop5555

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Create a new text file.
mov edx,OFFSET filenameoutput
call CreateOutputFile
mov fileHandle,eax
; Write the buffer to the output file.
mov eax,fileHandle
mov edx,OFFSET buffer2
mov ecx,copy3
call WriteToFile
call CloseFile

exit
main ENDP
morsi PROC
 mov ebx, (summtion ptr [edi]).left
	 mov eax, offset finaltree
	 mov ecx, final_tree_len
	 loop888:
	     cmp ebx, (summtion ptr [eax]).index
		 jne jumppp
		 mov ebx, (summtion ptr [eax]).frequceny1
		 mov [edx], ebx
		 mov ebx, 100000
		 add edx, type treeform
		 jumppp:
		 add eax, type finaltree
	 loop loop888

	 mov ebx, (summtion ptr [edi]).right
	 mov eax, offset finaltree
	 mov ecx, final_tree_len
	 loop889:
	     cmp ebx, (summtion ptr [eax]).index
		 jne jumpppp
		 mov ebx, (summtion ptr [eax]).frequceny1
		 mov [edx], ebx
		 mov ebx, 100000
		 add edx, type treeform
		 jumpppp:
		 add eax, type finaltree
	 loop loop889
ret
morsi endp

;----------------------------------------------
ReadtheString PROC

;that procedure read the string  
;from the file that need to encode
;using hufman code. 
;----------------------------------------------
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
quit:

ret
ReadtheString ENDP

;-----------------------------------------------------------------

writing  PROC

	mov ecx, 0
	add ecx, fmin
	add ecx, smin 
	mov (summtion ptr [edi]).frequceny1, ecx 
	mov edx ,findex
	mov (summtion ptr [edi]).left, edx
	mov edx , sindex
	mov (summtion ptr [edi]).right, edx
	mov edx,f
	mov (summtion ptr [edi]).index,edx 
	
	mov (summtion ptr [eax]).frequceny1, ecx 
	mov edx,findex
	mov (summtion ptr [eax]).left, edx
	mov  edx,sindex
	mov (summtion ptr [eax]).right, edx
	mov edx,f
	mov (summtion ptr [eax]).index, edx
	

	ret
writing ENDP

;-----------------------------------------------------------------
Calculat PROC
	loop2:
	    cmp al, [edx]
	    jne skip
		inc cnt
		mov BYTE PTR [edx], bl
		skip:
		cmp bl, [edx]
		jne notinc
		inc check 
		notinc:    
		add edx, type buffer
	loop loop2

	ret
Calculat ENDP

;-----------------------------------------------------------------
;that procedure calculat the number of each character in the string  
;-----------------------------------------------------------------
Calculat_frequance PROC
loop1:
    mov al, [esi]
	mov copy, ecx
    mov ecx, strsize
	mov check, 0
	mov cnt, 0
	mov bl,'#'
	mov edx, offset buffer

	CALL Calculat

	mov ecx ,cnt
	cmp ecx, 0
	je kail	
	mov ebx, f
	mov [count.character+edi], al
	mov [count.frequency+ebx], ecx
	add len,1
	mov ecx ,check
	cmp ecx, strsize
	je quit
	add f, 4
	add edi, 1
	kail:
    add esi, type strr
    mov ecx, copy
    loop loop1
	quit:
ret
Calculat_frequance ENDP
;--------------------------------------------------------------------------------
GetFMin PROC
 mov edx , 10000
 mov fmin ,edx
l1:

	mov edx , (summtion ptr [esi]).frequceny1
	cmp edx , fmin 
	jae GO
	mov fmin, edx
	mov check, esi
	mov edx, cnt
	mov findex, edx
	mov esi, check
	GO:
	add esi , type summtion
	inc cnt
loop l1
	mov esi, check
	mov (summtion ptr [esi]).frequceny1, 10000
	ret
GetFMin ENDP

;--------------------------------------------------------------------------------
GetSMin PROC
mov edx , 10000
 mov smin ,edx
l0:

	mov edx , (summtion ptr [esi]).frequceny1
	cmp edx , smin 
	jae GO
	mov smin, edx
    mov check, esi
	mov edx, cnt
	mov sindex, edx
	mov esi, check
	GO:
	add esi , type summtion
	inc cnt
loop l0
	mov esi, check
	mov (summtion ptr [esi]).frequceny1, 10000
   ret
GetSMin ENDP

;--------------------------------------------------------------------------------
;-----------------------------------------------------------------

END main

;------------------------------------------------------

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
