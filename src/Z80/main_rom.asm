
; ----------------------------------------------------------------------------
	include "config.asm"

; ----------------------------------------------------------------------------
main:
	call &BD19

	ld bc, &BC00+6
	out (c), c
	ld bc, &BD00+0
	out (c), c

	ld hl, TinyFont
	ld de, TINY_FONT_BUFFER
	call BitBuster_Unpack
	
	ld hl, RegularFont
	ld de, REGULAR_FONT_BUFFER
	call BitBuster_Unpack

	ld hl, Background
	ld de, BACKGROUNDTEMP_BUFFER
	call BitBuster_Unpack

	ld hl, Core_Packed
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
