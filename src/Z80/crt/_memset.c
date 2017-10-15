
#include "string.h" 
#include <sdcc-lib.h>

#if !_SDCC_PORT_PROVIDES_MEMCPY

#undef memcpy /* Avoid conflict with builtin memcpy() in Z80 and some related ports */

void * z80_memset (
	void * dst,
	char value,
	int acount
	) 
{
	dst;
	value; 
	acount;

__asm	
	push ix
	ld ix, 0
	add	ix, sp
	
	ld	e, (ix+4)
	ld	d, (ix+5)
	
 	ld	a, (ix+6)
	
	ld	c, (ix+7)
	ld	b, (ix+8)

	ld h, d
	ld l, e
	dec bc
	inc de
	ld ( hl ), a
	call OptimizedLDIR
	
	pop ix
__endasm;
}
#endif

