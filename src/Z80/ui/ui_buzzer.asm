;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 8604 (May 11 2013) (MINGW32)
; This file was generated Sun Oct 15 00:38:10 2017
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
;ui_buzzer.c:17: char YesNo()
;	---------------------------------
; Function YesNo
; ---------------------------------
_YesNo_start:
_YesNo:
;ui_buzzer.c:20: do
YesNo_00104:
;ui_buzzer.c:22: key = WaitKey();
	call	_WaitKey
;ui_buzzer.c:23: } while ((key!='y')&&(key!='Y')&&(key!='n')&&(key!='N'));
	ld	a,l
	sub	  &59
	jr	NZ,YesNo_00127
	ld	a, &01
	jr	YesNo_00128
YesNo_00127:
	xor	a
YesNo_00128:
	ld	h,a
	ld	a,l
	sub	  &79
	jr	NZ,YesNo_00129
	ld	a, &01
	jr	YesNo_00130
YesNo_00129:
	xor	a
YesNo_00130:
	ld	d,a
	or	a
	jr	NZ,YesNo_00106
	or	h
	jr	NZ,YesNo_00106
	ld	a,l
	cp	 &6E
	jr	Z,YesNo_00106
	sub	  &4E
	jr	NZ,YesNo_00104
YesNo_00106:
;ui_buzzer.c:25: if ((key=='y')||(key=='Y'))
	ld	a,d
	or	a
	jr	NZ,YesNo_00107
	or	h
	jr	Z,YesNo_00108
YesNo_00107:
;ui_buzzer.c:27: return 1;
	ld	l, &01
	ret
YesNo_00108:
;ui_buzzer.c:30: return 0;
	ld	l, &00
	ret
_YesNo_end:
;ui_buzzer.c:34: void ShowBuzzerSettings()
;	---------------------------------
; Function ShowBuzzerSettings
; ---------------------------------
_ShowBuzzerSettings_start:
_ShowBuzzerSettings:
	dec	sp
;ui_buzzer.c:41: CLS();
	call	_CLS
;ui_buzzer.c:43: PrintEmptyLine();
	call	_PrintEmptyLine
;ui_buzzer.c:44: Println(" Buzzer settings");
	ld	hl,__str_ui_buzzer_0
	push	hl
	call	_Println
	pop	af
;ui_buzzer.c:45: PrintEmptyLine();
	call	_PrintEmptyLine
;ui_buzzer.c:47: Print(" Emits beep for UI operations ? (Y/N) ");
	ld	hl,__str_ui_buzzer_1
	push	hl
	call	_Print
	pop	af
;ui_buzzer.c:48: isYes = YesNo();
	call	_YesNo
	ld	iy,0
	add	iy,sp
	ld	(iy+0 ),l
;ui_buzzer.c:49: if (isYes==1)
	ld	a,(iy+0 )
	dec	a
	jr	NZ,ShowBuzzerSettings_00102
;ui_buzzer.c:51: configFile->ihm_sound =  &FF;
	ld	hl, &1B11
	ld	(hl), &FF
;ui_buzzer.c:52: Println("Y");
	ld	hl,__str_ui_buzzer_2
	push	hl
	call	_Println
	pop	af
	jr	ShowBuzzerSettings_00103
ShowBuzzerSettings_00102:
;ui_buzzer.c:56: configFile->ihm_sound =  &00;
	ld	hl, &1B11
	ld	(hl), &00
;ui_buzzer.c:57: Println("N");
	ld	hl,__str_ui_buzzer_3
	push	hl
	call	_Println
	pop	af
ShowBuzzerSettings_00103:
;ui_buzzer.c:60: Print(" Emits beep for disc access ? (Y/N) ");
	ld	hl,__str_ui_buzzer_4
	push	hl
	call	_Print
	pop	af
;ui_buzzer.c:61: isYes = YesNo();
	call	_YesNo
	ld	iy,0
	add	iy,sp
	ld	(iy+0 ),l
;ui_buzzer.c:62: if (isYes==1)
	ld	a,(iy+0 )
	dec	a
	jr	NZ,ShowBuzzerSettings_00105
;ui_buzzer.c:64: configFile->step_sound =  &FF;
	ld	hl, &1B10
	ld	(hl), &FF
;ui_buzzer.c:65: Println("Y");
	ld	hl,__str_ui_buzzer_2
	push	hl
	call	_Println
	pop	af
	jr	ShowBuzzerSettings_00107
ShowBuzzerSettings_00105:
;ui_buzzer.c:69: configFile->step_sound =  &00;
	ld	hl, &1B10
	ld	(hl), &00
;ui_buzzer.c:70: Println("N");
	ld	hl,__str_ui_buzzer_3
	push	hl
	call	_Println
	pop	af
ShowBuzzerSettings_00107:
	inc	sp
	ret
_ShowBuzzerSettings_end:
__str_ui_buzzer_0:
	db " Buzzer settings"
	db  &00
__str_ui_buzzer_1:
	db " Emits beep for UI operations ? (Y/N) "
	db  &00
__str_ui_buzzer_2:
	db "Y"
	db  &00
__str_ui_buzzer_3:
	db "N"
	db  &00
__str_ui_buzzer_4:
	db " Emits beep for disc access ? (Y/N) "
	db  &00
