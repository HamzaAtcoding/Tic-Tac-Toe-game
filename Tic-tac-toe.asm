INCLUDE IRVINE32.INc
Gtoxy MACRO X,Y
push edx
mov dh,Y
mov dl,X
call Gotoxy
pop edx
ENDM
;==============================================================
mprintstring MACRO var,colr,green
push edx
push eax
mov eax,colr+(green *16)
call SetTextColor
mov edx,OFFSET var
call Writestring
pop edx
pop eax
ENDM
;=================================================================inital MACRO
push ecx
push eax
push esi
mov al,30h
mov esi,offset arraynumber
mov ecx,9
q:
inc al
mov byte ptr [esi],al
inc esi
loop q
pop ecx
pop esi
pop eax
ENDM
;=================================================================
square2 macro
.data
X2 byte 28
Y2 byte 28
msge1 byte "::::::::::::::::::::::::::::::::::::::::::::::::::::",0dh,0ah,0
msge2 byte "::",0
msge3 byte " ",0.code
Gtoxy X2,Y2
mprintstring msge1,0,15
mov ecx,30
LA:
inc Y2
Gtoxy X2,Y2
mprintstring msge2,0,15
mprintstring msge3,0,6
mprintstring msge2,0,15
loop LA
inc Y2
Gtoxy X2,Y2
mprintstring msge1,0,15
mov al,28
mov X2,al
mov al,28
mov Y2,al
endm
;===================================================================
square macro
.dataX1 byte 18
Y1 byte 5
msg1 byte ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::",0dh,0ah,0
msg2 byte "::",0
msg3 byte " ",0
.code
Gtoxy X1,Y1
mprintstring msg1,0,15
mov ecx,16
l1:
inc Y1
Gtoxy X1,Y1
mprintstring msg2,0,15
mprintstring msg3,0,6
mprintstring msg2,0,15
loop l1
inc Y1
Gtoxy X1,Y1
mprintstring msg1,0,15
mov al,18
mov X1,almov al,5
mov Y1,al
endm
;==============================================================================
write macro esi
push eax
mov al,[esi]
.if(al=='X')
call crosssquare
.elseif(al=='O')
call squaresquare
.else
call numbersquare
.endif
pop eax
endm
;=================================================================
check macro varb
LOCAL yous,looser,congrt,umar,myx1,myy2,over
push esi
push ecx
push eax.data
myx1 byte 31
myy2 byte 30
yous byte ":: Yeah-----You have Won the Match ::",0dh,0ah,0
looser byte ":: Sorry----You have Loose the Match ::",0dh,0ah,0
congrt byte ":: CONGRATULATIONS ::",0dh,0ah,0
umar byte "::::::::::::::::::::::::::::::::::::::::::::::",0dh,0ah,0
over byte "GAME OVER",0dh,0ah,0
.code
Gtoxy myx1,myy2
.IF (varb=='X')
Gtoxy myx1,myy2
mprintstring umar,0,15
inc myy2
Gtoxy myx1,myy2
mprintstring congrt,0,6
inc myy2
Gtoxy myx1,myy2
mprintstring yous,0,6inc myy2
Gtoxy myx1,myy2
mprintstring umar,0,15
.ELSE
Gtoxy myx1,myy2
mprintstring umar,0,15
inc myy2
Gtoxy myx1,myy2
mprintstring looser,0,6
inc myy2
Gtoxy myx1,myy2
mprintstring umar,0,15
.endif
Gtoxy 48,57
mprintstring over,15,1
mov eax,1000
call delay
Gtoxy 48,63
mov al,31
mov myx1,al
mov al,30
mov myy2,alpop esi
pop ecx
jmp endgame
pop eax
endm
;=========================READ STRING=======================================
mReadStr MACRO varName
push ecx
push edx
mov edx,OFFSET varName
mov ecx, 30
call ReadString
pop edx
pop ecx
ENDM
;===================================================
;DATA
;====================================================
.data
sqrx byte 0
sqry byte 0
arraynumber byte "123456789",0
nam1 byte "Enter Your Name : ",0
matchechoice byte "FOR PLAYING AGAIN PRESS <Y> FOR EXIT PRESS <N> : ",0
nam byte 30 dup(?)choice dword ?
flg dword 0
indx dword 0
score dword 0
.code
main proc
call print
Gtoxy 25,19
mprintstring nam1,15,1
mov edx,offset nam
mov ecx,sizeof nam
call readstring
matches:
call playercomputercall print
endgame::
mov score,0
Gtoxy 31,24
inital
call print
Gtoxy 25,25
mprintstring matchechoice,15,1
call readchar
cmp al,'y'
je matches
cmp al,'Y'
je matches
jmp endall
endall:
exit
main endp
;================================================================
playercomputer proc uses esi eax edi ebx ecx
.data
forentery1 byte "Enter your choice : ",0
forentery2 byte "INVALID NUMBER RE-Enter Your Choice",0
present byte "YOUR SELECTION IS ALREADY PRESENT ",0dh,0ah,0count1 dword 0
.code
invalid::
mov al,35
mov sqrx,al
mov al,32
mov sqry,al
Gtoxy sqrx,sqry
mprintstring forentery1,10,1
xor eax,eax
call readchar
.IF(al<'1') || (al>'9')
mov al,35
mov sqrx,al
mov al,32
mov sqry,al
Gtoxy sqrx,sqry
mprintstring forentery2,10,1
jmp invalid
.ENDIF
mov ecx,9
mov esi ,offset arraynumbercompare:
cmp al,byte ptr [esi]
jne next
mov byte ptr [esi],'X'
add score,20
inc count1
jmp computer
next:
inc esi
loop compare
jne b
b:
mov al,35
mov sqrx,al
mov al,34
mov sqry,al
Gtoxy sqrx,sqry
mprintstring present,10,1
jmp invalid
computer:
xor eax,eax
push ecx
push edx
mov edx,0mov eax,50000
call randomrange
mov ecx,0Ah
div ecx
add dl,30h
mov al,dl
pop ecx
pop edx
mov ecx,9
mov esi,offset arraynumber
computercompare:
cmp al,byte ptr [esi]
jne nextc
mov byte ptr [esi],'O'
inc count1
jmp t
nextc:
inc esi
loop computercompare
cmp count1,9
je t
jmp computer
t:
; call clrscr
call printcall checker
ret
playercomputer endp
;================================================================
checker proc uses esi eax edx ebx ecx
.data
msglose byte "***************MATCH TIED****************",0dh,0ah,0
varesi byte ?
.code
call checkNumber
mov esi,offset arraynumber
.if((byte ptr[esi]=='X') && (byte ptr[esi+1]=='X') && (byte ptr[esi+2]=='X')) || ((byte ptr[esi]=='O') &&
(byte ptr[esi+1]=='O') && (byte ptr[esi+2]=='O'))
mov al,byte ptr [esi]
mov varesi,al
check varesi
.elseif((byte ptr[esi+3]=='X') && (byte ptr[esi+4]=='X') && (byte ptr[esi+5]=='X')) || ((byte
ptr[esi+3]=='O') && (byte ptr[esi+4]=='O') && (byte ptr[esi+5]=='O'))
mov al,byte ptr [esi+3]
mov varesi,al
check varesi
.elseif((byte ptr[esi+6]=='X') && (byte ptr[esi+7]=='X') && (byte ptr[esi+8]=='X')) || ((byte
ptr[esi+6]=='O') && (byte ptr[esi+7]=='O') && (byte ptr[esi+8]=='O'))mov al,byte ptr [esi+6]
mov varesi,al
check varesi
.elseif((byte ptr[esi+0]=='X') && (byte ptr[esi+3]=='X') && (byte ptr[esi+6]=='X')) || ((byte
ptr[esi+0]=='O') && (byte ptr[esi+3]=='O') && (byte ptr[esi+6]=='O'))
mov al,byte ptr [esi+0]
mov varesi,al
check varesi
.elseif((byte ptr[esi+1]=='X') && (byte ptr[esi+4]=='X') && (byte ptr[esi+7]=='X')) || ((byte
ptr[esi+1]=='O') && (byte ptr[esi+4]=='O') && (byte ptr[esi+7]=='O'))
mov al,byte ptr [esi+1]
mov varesi,al
check varesi
.elseif((byte ptr[esi+2]=='X') && (byte ptr[esi+5]=='X') && (byte ptr[esi+8]=='X')) || ((byte
ptr[esi+2]=='O') && (byte ptr[esi+5]=='O') && (byte ptr[esi+8]=='O'))
mov al,byte ptr [esi+2]
mov varesi,al
check varesi
.elseif((byte ptr[esi+0]=='X') && (byte ptr[esi+4]=='X') && (byte ptr[esi+8]=='X')) || ((byte
ptr[esi+0]=='O') && (byte ptr[esi+4]=='O') && (byte ptr[esi+8]=='O'))
mov al,byte ptr [esi+0]
mov varesi,al
check varesi.elseif((byte ptr[esi+2]=='X') && (byte ptr[esi+4]=='X') && (byte ptr[esi+6]=='X')) || ((byte
ptr[esi+2]=='O') && (byte ptr[esi+4]=='O') && (byte ptr[esi+6]=='O'))
mov al,byte ptr [esi+2]
mov varesi,al
check varesi
.elseif(flg==1)
mov ebx,0
mov flg,ebx
jmp invalid
.elseif(flg==0)
call crlf
mprintstring msglose,10,1
jmp endgame
.endif
ret
checker endp
;================================================================
checkNumber proc uses esi eax edx ebx ecx
mov eax,0
mov flg,eax
mov ecX,9
mov esi,offset arraynumber
trverse:.if(byte ptr [esi]=='X') ||(byte ptr [esi]=='O')
jmp incre
.else
mov ebx,1
mov flg,ebx
.endif
incre:
inc esi
loop trverse
ret
checkNumber endp
;================================================================
numbersquare proc
push edx
push eax
.data
s1 byte 0
s2 byte 0
lin1 byte " ",0
lin2 byte " ",0
num byte 0.code
mov eax,0
mov al,byte ptr sqrx
mov s1,al
mov al,byte ptr sqry
mov s2,al
Gtoxy s1,s2
mprintstring lin1,15,0
mprintstring lin1,15,0
mprintstring lin1,15,0
mprintstring lin1,15,0
mprintstring lin1,15,0
inc s2
Gtoxy s1,s2
mprintstring lin1,15,0
mprintstring lin1,15,15
mprintstring lin1,15,15
mprintstring lin1,15,15
mprintstring lin1,15,0
inc s2
Gtoxy s1,s2
mprintstring lin1,15,0
mprintstring lin1,0,15
mov al,[esi]mov num,al
call writechar
mov al,0
mprintstring lin2,1,15
mprintstring lin1,15,15
mprintstring lin1,15,0
inc s2
Gtoxy s1,s2
mprintstring lin1,15,0
mprintstring lin1,15,15
mprintstring lin1,15,15
mprintstring lin1,15,15
mprintstring lin1,15,0
inc s2
Gtoxy s1,s2
mprintstring lin1,15,0
mprintstring lin1,15,0
mprintstring lin1,15,0
mprintstring lin1,15,0
mprintstring lin1,15,0
go:
mov al,30
mov s2,al
Gtoxy s1,s2pop edx
pop eax
ret
numbersquare endp
;==============================================================================
squaresquare proc
push edx
push eax
.data
save1 byte 0
save2 byte 0
lines1 byte " ",0
.code
mov eax,0
mov al,byte ptr sqrx
mov save1,al
mov al,byte ptr sqry
mov save2,al
Gtoxy save1,save2
mprintstring lines1,15,0
mprintstring lines1,15,0
mprintstring lines1,15,0
mprintstring lines1,15,0mprintstring lines1,15,0
inc save2
Gtoxy save1,save2
mprintstring lines1,15,0
mprintstring lines1,15,10
mprintstring lines1,15,10
mprintstring lines1,15,10
mprintstring lines1,15,0
inc save2
Gtoxy save1,save2
mprintstring lines1,15,0
mprintstring lines1,15,10
mprintstring lines1,15,08
mprintstring lines1,15,10
mprintstring lines1,15,0
inc save2
Gtoxy save1,save2
mprintstring lines1,15,0
mprintstring lines1,15,10
mprintstring lines1,15,10
mprintstring lines1,15,10
mprintstring lines1,15,0
inc save2
Gtoxy save1,save2
mprintstring lines1,15,0mprintstring lines1,15,0
mprintstring lines1,15,0
mprintstring lines1,15,0
mprintstring lines1,15,0
go:
mov al,30
mov save2,al
Gtoxy save1,save2
pop edx
pop eax
ret
squaresquare endp
;===========================================================================
crosssquare proc
push edx
push eax
.data
sav1 byte 0
sav2 byte 0
line1 byte " ",0
.code
mov eax,0
mov al,byte ptr sqrxmov sav1,al
mov al,byte ptr sqry
mov sav2,al
Gtoxy sav1,sav2
mprintstring line1,15,0
mprintstring line1,15,08
mprintstring line1,15,08
mprintstring line1,15,08
mprintstring line1,15,0
inc sav2
Gtoxy sav1,sav2
mprintstring line1,15,8
mprintstring line1,15,10
mprintstring line1,15,8
mprintstring line1,15,10
mprintstring line1,15,8
inc sav2
Gtoxy sav1,sav2
mprintstring line1,15,08
mprintstring line1,15,08
mprintstring line1,15,0
mprintstring line1,15,08
mprintstring line1,15,08
inc sav2Gtoxy sav1,sav2
mprintstring line1,15,08
mprintstring line1,15,10
mprintstring line1,15,08
mprintstring line1,15,10
mprintstring line1,15,08
inc sav2
Gtoxy sav1,sav2
mprintstring line1,15,0
mprintstring line1,15,08
mprintstring line1,15,08
mprintstring line1,15,08
mprintstring line1,15,0
go:
mov al,30
mov sav2,al
Gtoxy sav1,sav2
pop edx
pop eax
ret
crosssquare endp
;====================================================================================
=======print proc uses esi edx eax ebx
.DATA
str1 byte " WELLCOME TO TIC TAC TOE GAME ",0dh,0ah,0
fast1 byte " FAST ",0dh,0ah,0
fast2 byte " NATIONAL UNIVERSITY OF COMPUTER ",0dh,0ah,0
fast3 byte " AND EMERGING SCIENCES PESH (CAMPUS)
",0dh,0ah,0
fast4 byte " :::::: :: :::::: :::::: ::::::: :::::: :::::: ::::::: ::::::",0dh,0ah,0
fast5 byte " :: :: :: :: :: :: :: :: :: :: :: ",0dh,0ah,0
fast6 byte " :: :: :: ::: :: ::::::: :: ::: :: :: :: ::::::",0dh,0ah,0
fast7 byte " :: :: :: :: :: :: :: :: :: :: :: ",0dh,0ah,0
fast8 byte " :: :: :::::: :: :: :: :::::: :: ::::::: ::::::",0dh,0ah,0
fast9 byte "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::",0dh,0ah,0
str10 byte " ",0
str11 byte "Player - 1 : ",0
yscore byte "SCORE : ",0
.CODE
mov eax,0
square
mov al,24
mov sqrx,al
mov al,7
mov sqry,alGtoxy sqrx,sqry
mprintstring str1,0,6
mov al,8
mov sqry,al
Gtoxy sqrx,sqry
mprintstring fast1,0,6
mov al,9
mov sqry,al
Gtoxy sqrx,sqry
mprintstring fast2,0,6
mov al,10
mov sqry,al
Gtoxy sqrx,sqry
mprintstring fast3,0,6
mov al,13
mov sqry,al
Gtoxy sqrx,sqry
mprintstring fast4,9,6
mov al,14
mov sqry,al
Gtoxy sqrx,sqry
mprintstring fast5,15,6
mov al,15
mov sqry,alGtoxy sqrx,sqry
mprintstring fast6,15,6
mov al,16
mov sqry,al
Gtoxy sqrx,sqry
mprintstring fast7,15,6
mov al,17
mov sqry,al
Gtoxy sqrx,sqry
mprintstring fast8,15,6
mov al,18
mov sqry,al
Gtoxy sqrx,sqry
mprintstring fast9,10,6
Gtoxy 25,20
mprintstring str11,15,1
mprintstring nam,15,01
Gtoxy 29,26
mprintstring yscore,15,01
mov eax,score
call writedec
mov eax,0
square2mov esi,offset arraynumber
mov al,34
mov sqrx,al
mov al,37
mov sqry,al
Gtoxy sqrx,sqry
write esi
inc esi
mov al,48
mov sqrx,al
write esi
inc esi
mov al,63
mov sqrx,al
write esi
inc esi
mov al,34
mov sqrx,al
mov al,44
mov sqry,al
write esi
inc esi
mov al,48
mov sqrx,al
write esiinc esi
mov al,63
mov sqrx,al
write esi
mov al,[esi]
inc esi
mov al,34
mov sqrx,al
mov al,51
mov sqry,al
write esi
inc esi
mov al,48
mov sqrx,al
write esi
inc esi
mov al,63
mov sqrx,al
write esi
inc esi
;add sqrx,
;crosssquare sqrx,sqry
;add sqrx,8ret
print endp
;===========================================================================
END MAIN