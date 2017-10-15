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
_regularScreenPtr:
	ds 2
_firstCharScreenPtr:
	ds 2
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
;ui_font.c:14: void InitFont()
;	---------------------------------
; Function InitFont
; ---------------------------------
_InitFont_start:
_InitFont:
;ui_font.c:40: __endasm;
	ld de,  &0300
	ld hl,  &1900 +64
	ld bc, 8
	call InitFontStart
	ld de,  &0600
	ld hl,  &1A00 +64
	ld bc, 16
	jp InitFontStart
	InitFontStart:
	ld a, 128-32
	InitFontLoop:
	ld (hl), e
	inc hl
	ld (hl), d
	inc hl
	ex de, hl
	add hl, bc
	ex de, hl
	dec a
	jr nz, InitFontLoop
	ret
	ret
_InitFont_end:
;ui_font.c:44: void SetRegularScreenPtr(char *screenPtr)
;	---------------------------------
; Function SetRegularScreenPtr
; ---------------------------------
_SetRegularScreenPtr_start:
_SetRegularScreenPtr:
;ui_font.c:46: regularScreenPtr = screenPtr;
	pop	bc
	pop	de
	push	de
	push	bc
	ld	(_regularScreenPtr),de
;ui_font.c:47: firstCharScreenPtr = screenPtr;
	ld	(_firstCharScreenPtr),de
	ret
_SetRegularScreenPtr_end:
;ui_font.c:51: void PrintTiny(char *screenPtr, char *str)
;	---------------------------------
; Function PrintTiny
; ---------------------------------
_PrintTiny_start:
_PrintTiny:
;ui_font.c:110: __endasm;
	push ix
	ld ix, 0
	add ix, sp
	ld l, (ix+4)
	ld h, (ix+5)
	ld c, (ix+6)
	ld b, (ix+7)
; HL = Screen Ptr
; BC = Text Ptr
	PrintTinyLoop:
	ld a, (bc)
	or a
	jp z, PrintTinyLeave
	push hl
	push hl
	ld h,  &1900/256
	add a, a
	ld l, a
	ld e, (hl)
	inc l
	ld d, (hl)
	pop hl
	MACRO TinyCharLine
	ld a, (de)
	inc de
	ld (hl), a
	ENDM
	MACRO TinyLastCharLine
	ld a, (de)
	ld (hl), a
	ENDM
	REPT 7
	TinyCharLine
	call Private_SCR_NEXT_LINE
	ENDM
	TinyLastCharLine
	pop hl
	inc hl
	inc bc
	jr PrintTinyLoop
	PrintTinyLeave:
	pop ix
	ret
_PrintTiny_end:
;ui_font.c:114: void Print(char *str)
;	---------------------------------
; Function Print
; ---------------------------------
_Print_start:
_Print:
;ui_font.c:207: __endasm;
	push ix
	ld ix, 0
	add ix, sp
	ld c, (ix+4)
	ld b, (ix+5)
	ld hl, (_regularScreenPtr)
; HL = Screen Ptr
; BC = Text Ptr
	PrintRegularLoop:
	ld a, (bc)
	or a
	jp z, PrintRegularLeave
	push hl
	push hl
	ld h,  &1A00/256
	add a, a
	ld l, a
	ld e, (hl)
	inc l
	ld d, (hl)
	pop hl
	MACRO RegularCharLine
	ld a, (de)
	inc de
	ld (hl), a
	inc l
	ld a, (de)
	inc de
	ld (hl), a
	dec l
	ENDM
	MACRO RegularLastCharLine
	ld a, (de)
	inc de
	ld (hl), a
	inc l
	ld a, (de)
	ld (hl), a
	ENDM
; display char row
; 000 line 0
; 001 line 1 / set 3,h
; 011 line 3 / set 4,h
; 010 line 2 / res 3,h
; 110 line 6 / set 5,h
; 100 line 4 / res 4,h
; 101 line 5 / set 3,h
; 111 line 7 / set 4,h
	RegularCharLine
	set 3, h
	RegularCharLine
	set 4, h
	RegularCharLine
	res 3, h
	RegularCharLine
	set 5, h
	RegularCharLine
	res 4, h
	RegularCharLine
	set 3, h
	RegularCharLine
	set 4, h
	RegularLastCharLine
	pop hl
; HL = screen ptr
	inc l
	inc hl
; BC = text ptr
	inc bc
	jp PrintRegularLoop
	PrintRegularLeave:
	ld ( _regularScreenPtr ), hl
	pop ix
	ret
_Print_end:
;ui_font.c:211: void Println(char *str)
;	---------------------------------
; Function Println
; ---------------------------------
_Println_start:
_Println:
;ui_font.c:213: Print(str);
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	call	_Print
	pop	af
;ui_font.c:215: PrintEmptyLine();
	jp	_PrintEmptyLine
_Println_end:
;ui_font.c:220: void PrintlnTab(char *str)
;	---------------------------------
; Function PrintlnTab
; ---------------------------------
_PrintlnTab_start:
_PrintlnTab:
;ui_font.c:222: regularScreenPtr = firstCharScreenPtr + columnTabPosX;
	ld	hl,_regularScreenPtr
	ld	a,(_firstCharScreenPtr + 0)
	add	a,  &0C
	ld	(hl),a
	ld	a,(_firstCharScreenPtr + 1)
	adc	a,  &00
	inc	hl
	ld	(hl),a
;ui_font.c:224: Print(str);
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	call	_Print
	pop	af
;ui_font.c:226: PrintEmptyLine();
	jp	_PrintEmptyLine
_PrintlnTab_end:
;ui_font.c:230: void PrintEmptyLine()
;	---------------------------------
; Function PrintEmptyLine
; ---------------------------------
_PrintEmptyLine_start:
_PrintEmptyLine:
;ui_font.c:232: firstCharScreenPtr = firstCharScreenPtr + 80;
	ld	hl,_firstCharScreenPtr
	ld	a,(hl)
	add	a,  &50
	ld	(hl),a
	inc	hl
	ld	a,(hl)
	adc	a,  &00
	ld	(hl),a
;ui_font.c:233: regularScreenPtr = firstCharScreenPtr;
	ld	hl,(_firstCharScreenPtr)
	ld	(_regularScreenPtr),hl
	ret
_PrintEmptyLine_end:
;ui_font.c:237: void PrintUInt8( unsigned char value )
;	---------------------------------
; Function PrintUInt8
; ---------------------------------
_PrintUInt8_start:
_PrintUInt8:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-18
	add	hl,sp
	ld	sp,hl
;ui_font.c:240: uitoa(value, itoa_buffer, 10);
	ld	hl, &0000
	add	hl,sp
	ex	de,hl
	ld	(ix-2 ),e
	ld	(ix-1 ),d
	ld	c,(ix+4 )
	ld	b, &00
	push	de
	ld	a, &0A
	push	af
	inc	sp
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	push	hl
	push	bc
	call	_uitoa
	pop	af
	pop	af
	inc	sp
	call	_Print
	ld	sp,ix
	pop	ix
	ret
_PrintUInt8_end:
;ui_font.c:246: void PrintUInt8_WithZero( unsigned char value )
;	---------------------------------
; Function PrintUInt8_WithZero
; ---------------------------------
_PrintUInt8_WithZero_start:
_PrintUInt8_WithZero:
;ui_font.c:248: if (value < 10)
	ld	hl, 2+0
	add	hl, sp
	ld	a, (hl)
	sub	  &0A
	jr	NC,PrintUInt8_WithZero_00102
;ui_font.c:250: Print("0");
	ld	hl,__str_ui_font_0
	push	hl
	call	_Print
	pop	af
PrintUInt8_WithZero_00102:
;ui_font.c:252: PrintUInt8(value);
	ld	hl, 2+0
	add	hl, sp
	ld	a, (hl)
	push	af
	inc	sp
	call	_PrintUInt8
	inc	sp
	ret
_PrintUInt8_WithZero_end:
__str_ui_font_0:
	db "0"
	db  &00
