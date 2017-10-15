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
;ui_help.c:8: void ShowHelp()
;	---------------------------------
; Function ShowHelp
; ---------------------------------
_ShowHelp_start:
_ShowHelp:
;ui_help.c:10: CLS();
	call	_CLS
;ui_help.c:12: PrintEmptyLine();
	call	_PrintEmptyLine
;ui_help.c:13: Println(" Keys");
	ld	hl,__str_ui_help_0
	push	hl
	call	_Println
;ui_help.c:14: Println("  Up/Down/Left/Right: navigate");
	ld	hl, __str_ui_help_1
	ex	(sp),hl
	call	_Println
;ui_help.c:15: Println("  Ctrl+Left/Ctrl+Right: prev/next slot");
	ld	hl, __str_ui_help_2
	ex	(sp),hl
	call	_Println
;ui_help.c:16: Println("  Space/Enter: select");
	ld	hl, __str_ui_help_3
	ex	(sp),hl
	call	_Println
;ui_help.c:17: Println("  S: slot list");
	ld	hl, __str_ui_help_4
	ex	(sp),hl
	call	_Println
;ui_help.c:18: Println("  B: buzzer settings");
	ld	hl, __str_ui_help_5
	ex	(sp),hl
	call	_Println
;ui_help.c:19: Println("  ESC: quit");
	ld	hl, __str_ui_help_6
	ex	(sp),hl
	call	_Println
	pop	af
;ui_help.c:20: PrintEmptyLine();
	call	_PrintEmptyLine
;ui_help.c:21: Println(" Credits");
	ld	hl,__str_ui_help_7
	push	hl
	call	_Println
;ui_help.c:22: Println("  V3.5 by NoRecess/Ced (Condense)");
	ld	hl, __str_ui_help_8
	ex	(sp),hl
	call	_Println
;ui_help.c:23: Println("  Original by JF Del Nero (HxC2001)");
	ld	hl, __str_ui_help_9
	ex	(sp),hl
	call	_Println
	pop	af
;ui_help.c:24: PrintEmptyLine();
	call	_PrintEmptyLine
;ui_help.c:25: Println(" Press a key..");
	ld	hl,__str_ui_help_10
	push	hl
	call	_Println
	pop	af
;ui_help.c:27: WaitKey();
	jp	_WaitKey
_ShowHelp_end:
__str_ui_help_0:
	db " Keys"
	db  &00
__str_ui_help_1:
	db "  Up/Down/Left/Right: navigate"
	db  &00
__str_ui_help_2:
	db "  Ctrl+Left/Ctrl+Right: prev/next slot"
	db  &00
__str_ui_help_3:
	db "  Space/Enter: select"
	db  &00
__str_ui_help_4:
	db "  S: slot list"
	db  &00
__str_ui_help_5:
	db "  B: buzzer settings"
	db  &00
__str_ui_help_6:
	db "  ESC: quit"
	db  &00
__str_ui_help_7:
	db " Credits"
	db  &00
__str_ui_help_8:
	db "  V3.5 by NoRecess/Ced (Condense)"
	db  &00
__str_ui_help_9:
	db "  Original by JF Del Nero (HxC2001)"
	db  &00
__str_ui_help_10:
	db " Press a key.."
	db  &00
