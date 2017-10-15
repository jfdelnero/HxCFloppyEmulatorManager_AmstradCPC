;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 8604 (May 11 2013) (MINGW32)
; This file was generated Sat Oct 14 23:36:42 2017
;--------------------------------------------------------
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
;--------------------------------------------------------
; Home
;--------------------------------------------------------
;--------------------------------------------------------
; code
;--------------------------------------------------------
;ui_main.c:20: void main()
;	---------------------------------
; Function main
; ---------------------------------
_main_start:
_main:
	dec	sp
;ui_main.c:32: __endasm;
	call  &B912
	call  &B903
	ld h, &12 ; first repeat, default is &1E
	ld l, &02 ; repeat speed, default is &02
	call  &BB3F
;ui_main.c:34: InitProgram();
	call	_InitProgram
;ui_main.c:36: strcpy((char*)BROWSE_CURRENTPATH, "/");
	ld	hl,__str_ui_main_0
	ld	de, &1700
	xor	 a
main_00185:
	cp	 (hl)
	ldi
	jr	NZ, main_00185
;ui_main.c:37: InitNavigate();
	call	_InitNavigate
;ui_main.c:38: BrowsePath();
	call	_BrowsePath
;ui_main.c:40: isQuit = 0;
	ld	iy,0
	add	iy,sp
	ld	(iy+0 ), &00
;ui_main.c:42: while(isQuit==0)
main_00138:
	ld	iy,0
	add	iy,sp
	ld	a,(iy+0 )
	or	 a
	jp	NZ,main_00140
;ui_main.c:44: key = WaitKey();
	call	_WaitKey
;ui_main.c:46: if (key== &F0) // Up
	ld	a,l
	sub	  &F0
	jr	NZ,main_00136
;ui_main.c:48: Up();
	call	_Up
	jr	main_00138
main_00136:
;ui_main.c:50: else if (key== &F1) // Down
	ld	a,l
	sub	  &F1
	jr	NZ,main_00133
;ui_main.c:52: Down();
	call	_Down
	jr	main_00138
main_00133:
;ui_main.c:54: else if (key== &F2) // Left
	ld	a,l
	sub	  &F2
	jr	NZ,main_00130
;ui_main.c:56: Left();
	call	_Left
	jr	main_00138
main_00130:
;ui_main.c:58: else if (key== &F3) // Right
	ld	a,l
	sub	  &F3
	jr	NZ,main_00127
;ui_main.c:60: Right();
	call	_Right
	jr	main_00138
main_00127:
;ui_main.c:62: else if (key== &FA) // Ctrl+Left
	ld	a,l
	sub	  &FA
	jr	NZ,main_00124
;ui_main.c:64: PrevSlot();
	call	_PrevSlot
	jr	main_00138
main_00124:
;ui_main.c:66: else if (key== &FB) // Ctrl+Right
	ld	a,l
	sub	  &FB
	jr	NZ,main_00121
;ui_main.c:68: NextSlot();
	call	_NextSlot
	jr	main_00138
main_00121:
;ui_main.c:70: else if ((key== &20)||(key== &8B)||(key== &0D)) // Space, Enter, Return
	ld	a,l
	cp	 &20
	jr	Z,main_00115
	cp	 &8B
	jr	Z,main_00115
	sub	  &0D
	jr	NZ,main_00116
main_00115:
;ui_main.c:72: Select();
	call	_Select
	jr	main_00138
main_00116:
;ui_main.c:74: else if( (key=='h')||(key=='h'))
	ld	a,l
	sub	  &68
	jr	NZ,main_00202
	ld	a, &01
	jr	main_00203
main_00202:
	xor	a
main_00203:
	or	 a
	jr	NZ,main_00111
	or	 a
	jr	Z,main_00112
main_00111:
;ui_main.c:76: ShowHelp();
	call	_ShowHelp
;ui_main.c:77: BrowsePage();	
	call	_BrowsePage
	jp	main_00138
main_00112:
;ui_main.c:79: else if( (key=='s')||(key=='S'))
	ld	a,l
	cp	 &73
	jr	Z,main_00107
	sub	  &53
	jr	NZ,main_00108
main_00107:
;ui_main.c:81: ShowSlots();
	call	_ShowSlots
;ui_main.c:82: BrowsePage();	
	call	_BrowsePage
	jp	main_00138
main_00108:
;ui_main.c:84: else if( (key=='b')||(key=='B'))
	ld	a,l
	cp	 &62
	jr	Z,main_00103
	sub	  &42
	jr	NZ,main_00104
main_00103:
;ui_main.c:86: ShowBuzzerSettings();
	call	_ShowBuzzerSettings
;ui_main.c:87: BrowsePage();	
	call	_BrowsePage
	jp	main_00138
main_00104:
;ui_main.c:89: else if(key== &FC) // ESC
	ld	a,l
	sub	  &FC
	jp	NZ,main_00138
;ui_main.c:91: isQuit = ShowQuit();
	call	_ShowQuit
	ld	iy,0
	add	iy,sp
	ld	(iy+0 ),l
	jp	main_00138
main_00140:
;ui_main.c:97: __endasm;
	call 0
	inc	sp
	ret
_main_end:
__str_ui_main_0:
	db "/"
	db  &00
