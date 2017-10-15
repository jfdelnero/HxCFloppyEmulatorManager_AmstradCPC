
; ----------------------------------------------------------------------------
	org &C000

	db 1 ; rom type = background rom  	
	db 3, 5, 0 ; version 3.5

	dw Commands
	jp RomInit
	jp Command_HXC

Commands:
	db "Hx", 'C'+&80
	db "HX", 'C'+&80
	db 0

; ----------------------------------------------------------------------------
RomInit:
	push hl
	push de

	ld hl, ROMInitLabel
	call DisplayText
	   
	pop de
	pop hl

	scf
	ret

DisplayText:
	ld a, (hl)
	inc hl
	or a
	ret z
	call &BB5A
	jp DisplayText
	
ROMInitLabel:
	db " HxC Manager V3.5", 10, 10, 13, 0
	
; ----------------------------------------------------------------------------
Command_HXC:
	include "main_rom.asm"
