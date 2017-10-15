
char * z80_strcpy (
	char * d, 
	const char * s) 
{
__asm
	push ix
	ld ix, 0
	add ix, sp
	
	ld e, (ix+4)
	ld d, (ix+5)
	
	ld l, (ix+6)
	ld h, (ix+7)
	
	xor	a
strcpy_loop:
	cp (hl)
	ldi
	jr nz, strcpy_loop
	
	pop ix
__endasm;
}