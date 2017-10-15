
// ----------------------------------------------------------------------------
#include "config.h"
#include "firmware.h"

// ----------------------------------------------------------------------------
unsigned char WaitKey()
{
__asm
	call &BB06
	ld l, a
__endasm;
}

// ----------------------------------------------------------------------------
void Private_SCR_NEXT_LINE()
{
__asm
Private_SCR_NEXT_LINE:
	ld a, h
	add a, 8
	ld h, a
	ret nc
	push bc
	ld bc, &C050
	add hl, bc
	pop bc
	ret
__endasm;
}