
// ----------------------------------------------------------------------------
#include "config.h"
#include "ui\ui_define.h"
#include "platform\firmware_define.h"
#include "ui\ui_font.h"
#include "crt\crt.h"

// ----------------------------------------------------------------------------
static char *regularScreenPtr;
static char *firstCharScreenPtr;

// ----------------------------------------------------------------------------
void InitFont()
{
__asm
	ld de, TINY_FONT
	ld hl, TINY_FONTCHARPTR+64
	ld bc, 8
	call InitFontStart
	
	ld de, REGULAR_FONT
	ld hl, REGULAR_FONTCHARPTR+64
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
__endasm;
}

// ----------------------------------------------------------------------------
void SetRegularScreenPtr(char *screenPtr)
{
	regularScreenPtr = screenPtr;
	firstCharScreenPtr = screenPtr;
}

// ----------------------------------------------------------------------------
void PrintTiny(char *screenPtr, char *str)
{
	screenPtr;
	str;
	
__asm
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
	ld h, TINY_FONTCHARPTR/256
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
__endasm;
}

// ----------------------------------------------------------------------------
void Print(char *str)
{
	str;
	
__asm
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
	
	ld h, REGULAR_FONTCHARPTR/256
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
__endasm;
}

// ----------------------------------------------------------------------------
void Println(char *str)
{
	Print(str);
	
	PrintEmptyLine();
}

// ----------------------------------------------------------------------------
#define columnTabPosX 12
void PrintlnTab(char *str)
{
	regularScreenPtr = firstCharScreenPtr + columnTabPosX;
	
	Print(str);
	
	PrintEmptyLine();
}

// ----------------------------------------------------------------------------
void PrintEmptyLine()
{
	firstCharScreenPtr = firstCharScreenPtr + 80;
	regularScreenPtr = firstCharScreenPtr;
}

// ----------------------------------------------------------------------------
void PrintUInt8( unsigned char value )
{
	char itoa_buffer[16];
	uitoa(value, itoa_buffer, 10);
	
	Print(itoa_buffer);
}

// ----------------------------------------------------------------------------
void PrintUInt8_WithZero( unsigned char value )
{
	if (value < 10)
	{
		Print("0");
	}	
	PrintUInt8(value);
}
