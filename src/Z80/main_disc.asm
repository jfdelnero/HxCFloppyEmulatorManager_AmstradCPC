
; ----------------------------------------------------------------------------
	include "config.asm"

; ----------------------------------------------------------------------------
main:
	call &BD19

	ld bc, &BC00+6
	out (c), c
	ld bc, &BD00+0
	out (c), c

	ld hl, Core_Packed
	ld de, &C000
	ld bc, Core_Packed_End-Core_Packed
	xor a
	sub c
	and 16-1
	add a, a
	ld (Fast_LDIR_JP+1), a
Fast_LDIR_JP:
	jr nz, $
Fast_LDIR_Loop:
	LDI
	LDI
	LDI
	LDI

	LDI
	LDI
	LDI
	LDI

	LDI
	LDI
	LDI
	LDI

	LDI
	LDI
	LDI
	LDI
	jp pe, Fast_LDIR_Loop
	
	ld hl, TinyFont
	ld de, TINY_FONT_BUFFER
	call BitBuster_Unpack
	
	ld hl, RegularFont
	ld de, REGULAR_FONT_BUFFER
	call BitBuster_Unpack

	ld hl, Background
	ld de, BACKGROUNDTEMP_BUFFER
	call BitBuster_Unpack

	ld hl, &C000
	ld de, CoreStartAddress
	call BitBuster_Unpack
	
	jp CoreStartAddress
	
; ----------------------------------------------------------------------------
	include "bitbuster.asm"
	
; ----------------------------------------------------------------------------
Core_Packed:
	incbin "core.bin.pck"
Core_Packed_End:
TinyFont:
	incbin "assets\tinyFont.bmp.font.pck"
RegularFont:
	incbin "assets\regularFont.bmp.font.pck"
Background:
	incbin "assets\background.bmp.sprRawData1.pck"
