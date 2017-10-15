
// ----------------------------------------------------------------------------
#include "config.h"
#include "ui\ui_define.h"
#include "ui\ui_element.h"
#include "ui\ui_font.h"
#include "platform\firmware_define.h"
#include "hxc\hxc_error.h"

// ----------------------------------------------------------------------------
void InitUI()
{
	SetRegularScreenPtr(REGULAR_SCREENPTR);
	
__asm	
	call InitInvertLines
	
	call CopyBackgroundToScreen
	
	call MC_WAIT_FLYBACK

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
	call SCR_SET_INK
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
	ld hl, BACKGROUNDTEMP_BUFFER
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
__endasm;
}

// ----------------------------------------------------------------------------
void StopError(char errorCode)
{
	PrintEmptyLine();
	PrintEmptyLine();
	Println(" Ooops.. something went wrong");
	PrintEmptyLine();
	Println(" Errorcode");
	Print(" ");
	Println(GetErrorString(errorCode));
	
	InfiniteLoop();
}

// ----------------------------------------------------------------------------
void CLS()
{
	SetRegularScreenPtr(REGULAR_SCREENPTR);
	
__asm
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
__endasm;
}

// ----------------------------------------------------------------------------
void InvertLine(char y)
{
	y;
	
__asm
	push ix
	ld ix, 0
	add ix, sp
	
	ld a, (ix+4)
	add a, a
	ld h, SCREEN_CHARPTR/256
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
	ld hl, SCREEN_CHARPTR
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
__endasm;
}
