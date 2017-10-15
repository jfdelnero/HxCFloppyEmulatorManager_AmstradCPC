
unsigned short z80_strlen ( const char * str )
{
__asm
	push ix
	ld ix, 0
	add ix, sp
	
	ld l, (ix+4)
	ld h, (ix+5)
	
	xor	a
	ld bc, 0
	cpir
	ld hl, -1
	sbc	hl, bc ; C flag still cleared from xor above
	
	pop ix
__endasm;
}