;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 8604 (May 11 2013) (MINGW32)
; This file was generated Sat Oct 14 23:36:43 2017
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
;ui_quit.c:10: char ShowQuit()
;	---------------------------------
; Function ShowQuit
; ---------------------------------
_ShowQuit_start:
_ShowQuit:
	dec	sp
;ui_quit.c:15: CLS();
	call	_CLS
;ui_quit.c:17: PrintEmptyLine();
	call	_PrintEmptyLine
;ui_quit.c:18: Print(" Save ? (Y/N) ");
	ld	hl,__str_ui_quit_0
	push	hl
	call	_Print
	pop	af
;ui_quit.c:20: do
ShowQuit_00104:
;ui_quit.c:22: key = WaitKey();
	call	_WaitKey
;ui_quit.c:23: } while ((key!='y')&&(key!='Y')&&(key!='n')&&(key!='N'));
	ld	a,l
	sub	  &59
	jr	NZ,ShowQuit_00138
	ld	a, &01
	jr	ShowQuit_00139
ShowQuit_00138:
	xor	a
ShowQuit_00139:
	ld	b,a
	ld	a,l
	sub	  &79
	jr	NZ,ShowQuit_00140
	ld	a, &01
	jr	ShowQuit_00141
ShowQuit_00140:
	xor	a
ShowQuit_00141:
	ld	e,a
	or	a
	jr	NZ,ShowQuit_00106
	or	b
	jr	NZ,ShowQuit_00106
	ld	a,l
	cp	 &6E
	jr	Z,ShowQuit_00106
	sub	  &4E
	jr	NZ,ShowQuit_00104
ShowQuit_00106:
;ui_quit.c:25: if ((key=='y')||(key=='Y'))
	ld	a,e
	or	a
	jr	NZ,ShowQuit_00109
	or	b
	jr	Z,ShowQuit_00110
ShowQuit_00109:
;ui_quit.c:27: Println("Y");	
	ld	hl,__str_ui_quit_1
	push	hl
	call	_Println
	pop	af
;ui_quit.c:28: PrintEmptyLine();
	call	_PrintEmptyLine
;ui_quit.c:30: Println(" Saving..");
	ld	hl,__str_ui_quit_2
	push	hl
	call	_Println
	pop	af
;ui_quit.c:32: if (!HxC_WriteConfigFile(&errorCode))
	ld	hl, &0000
	add	hl,sp
	push	hl
	call	_HxC_WriteConfigFile
	pop	af
	ld	a,l
	or	 a
	jr	NZ,ShowQuit_00111
;ui_quit.c:34: StopError(errorCode);
	ld	hl, 0+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_StopError
	inc	sp
	jr	ShowQuit_00111
ShowQuit_00110:
;ui_quit.c:39: Println("N");	
	ld	hl,__str_ui_quit_3
	push	hl
	call	_Println
	pop	af
;ui_quit.c:40: PrintEmptyLine();
	call	_PrintEmptyLine
;ui_quit.c:42: Println(" Exiting..");		
	ld	hl,__str_ui_quit_4
	push	hl
	call	_Println
	pop	af
ShowQuit_00111:
;ui_quit.c:45: if (!HxC_Detach(&errorCode))
	ld	hl, &0000
	add	hl,sp
	push	hl
	call	_HxC_Detach
	pop	af
	ld	a,l
	or	 a
	jr	NZ,ShowQuit_00114
;ui_quit.c:47: StopError(errorCode);
	ld	hl, 0+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_StopError
	inc	sp
ShowQuit_00114:
;ui_quit.c:50: return 1;
	ld	l, &01
	inc	sp
	ret
_ShowQuit_end:
__str_ui_quit_0:
	db " Save ? (Y/N) "
	db  &00
__str_ui_quit_1:
	db "Y"
	db  &00
__str_ui_quit_2:
	db " Saving.."
	db  &00
__str_ui_quit_3:
	db "N"
	db  &00
__str_ui_quit_4:
	db " Exiting.."
	db  &00
