;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 8604 (May 11 2013) (MINGW32)
; This file was generated Sat Oct 14 23:36:41 2017
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
;ui_element.c:11: void InitUI()
;	---------------------------------
; Function InitUI
; ---------------------------------
_InitUI_start:
_InitUI:
;ui_element.c:13: SetRegularScreenPtr(REGULAR_SCREENPTR);
	ld	hl, &C140
	push	hl
	call	_SetRegularScreenPtr
	pop	af
;ui_element.c:83: __endasm;
	call InitInvertLines
	call CopyBackgroundToScreen
	call  &BD19
	ld bc, &BC00+6
	out (c), c
	ld bc, &BD00+25
	out (c), c
	ld hl, Palette
	xor a
	SetFirmwarePalette_Loop:
	push af
	push hl
	ld b, (hl)
	ld c, b
	call  &BC32
	pop hl
	pop af
	inc hl
	inc a
	cp 4
	jr nz, SetFirmwarePalette_Loop
	ret
	Palette:
	db 1, 11, 23, 0
	CharLineHeight:
	db 8, 8, 8, 8
	CopyBackgroundToScreen:
	push ix
	ld ix, CharLineHeight
	ld hl,  &0C00
	ld de, &C000
	ld a, 4
	CopyBackgroundToScreen_Char:
	push af
	ld a, (ix)
	inc ix
	CopyBackgroundToScreen_Line:
	push af
	push de
	REPT 80
	ldi
	ENDM
	pop de
	ld a, d
	add a, 8
	ld d, a
	pop af
	dec a
	jp nz, CopyBackgroundToScreen_Line
	ex de, hl
	ld bc, &C000 + 80
	add hl, bc
	ex de, hl
	pop af
	dec a
	jp nz, CopyBackgroundToScreen_Char
	pop ix
	ret
	ret
_InitUI_end:
;ui_element.c:87: void StopError(char errorCode)
;	---------------------------------
; Function StopError
; ---------------------------------
_StopError_start:
_StopError:
;ui_element.c:89: PrintEmptyLine();
	call	_PrintEmptyLine
;ui_element.c:90: PrintEmptyLine();
	call	_PrintEmptyLine
;ui_element.c:91: Println(" Ooops.. something went wrong");
	ld	hl,__str_ui_element_0
	push	hl
	call	_Println
	pop	af
;ui_element.c:92: PrintEmptyLine();
	call	_PrintEmptyLine
;ui_element.c:93: Println(" Errorcode");
	ld	hl,__str_ui_element_1
	push	hl
	call	_Println
;ui_element.c:94: Print(" ");
	ld	hl, __str_ui_element_2
	ex	(sp),hl
	call	_Print
	pop	af
;ui_element.c:95: Println(GetErrorString(errorCode));
	ld	hl, 2+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_GetErrorString
	inc	sp
	push	hl
	call	_Println
	pop	af
;ui_element.c:97: InfiniteLoop();
	jp	_InfiniteLoop
_StopError_end:
__str_ui_element_0:
	db " Ooops.. something went wrong"
	db  &00
__str_ui_element_1:
	db " Errorcode"
	db  &00
__str_ui_element_2:
	db " "
	db  &00
;ui_element.c:101: void CLS()
;	---------------------------------
; Function CLS
; ---------------------------------
_CLS_start:
_CLS:
;ui_element.c:103: SetRegularScreenPtr(REGULAR_SCREENPTR);
	ld	hl, &C140
	push	hl
	call	_SetRegularScreenPtr
	pop	af
;ui_element.c:129: __endasm;
	di
	ld (CLS_PrevSP+1), sp
	ld d, 8
	ld e, &08
	ld hl, &0000-48
	ld bc, &0000 ; Clear value
	CLS_CharLineLoop:
	ld sp, hl
	ld a, 21
	CLS_ClearLineLoop:
	REPT 40
	push bc
	ENDM
	dec a
	jr nz, CLS_ClearLineLoop
	ld a, h
	sub e
	ld h, a
	dec d
	jr nz, CLS_CharLineLoop
	CLS_PrevSP:
	ld sp, 0
	ei
	ret
_CLS_end:
;ui_element.c:133: void InvertLine(char y)
;	---------------------------------
; Function InvertLine
; ---------------------------------
_InvertLine_start:
_InvertLine:
;ui_element.c:204: __endasm;
	push ix
	ld ix, 0
	add ix, sp
	ld a, (ix+4)
	add a, a
	ld h,  &1800/256
	ld l, a
	ld a, (hl)
	inc l
	ld h, (hl)
	ld l, a
; HL = start screen ptr
; E = length
	ld d, 255 ; xor value
	ld b, 8
	InvertLineCharLoop:
	push hl
	REPT 80/16
	REPT 15
	ld a, (hl)
	xor d
	ld (hl), a
	inc l
	ENDM
	ld a, (hl)
	xor d
	ld (hl), a
	inc hl
	ENDM
	pop hl
	ld a, h
	add a, 8
	ld h, a
	dec b
	jp nz, InvertLineCharLoop
	jp InvertLine_Leave
	InitInvertLines:
	ld de, &C000
	ld bc, &0050
	ld hl,  &1800
	ld a, 25
	CalcLine:
	ld (hl), e
	inc l
	ld (hl), d
	inc l
	ex de, hl
	add hl, bc
	ex de, hl
	dec a
	jr nz, CalcLine
	ret
	CharLines:
	ds 25*2
	InvertLine_Leave:
	pop ix
	ret
_InvertLine_end:
