
; ----------------------------------------------------------------------------
BitBuster_Unpack:
	di
	exx
	push bc
	push de
	push hl
	exx
	
	call BitBuster_Unpack_Internal
	
	exx
	pop hl
	pop de
	pop bc
	exx
	ei
	
	ret

BitBuster_Unpack_Internal:
	inc hl
	inc hl
	inc hl
	inc hl

	ld a, 128
	
	exx
	ld de, 1
	exx

depack_loop:
	add a, a
	jr nz, getbit1

	ld a, ( hl )
	inc hl
	rla

getbit1:
	jr c, output_compressed
	ldi

	add a, a
	jr nz, getbit0

	ld a, ( hl )
	inc hl
	rla

getbit0:
	jr c, output_compressed
	ldi
	
	add a, a
	jr nz, getbit2

	ld a, ( hl )
	inc hl
	rla

getbit2 :
	jr c, output_compressed
	ldi

	add a, a
	jr nz, getbit3

	ld a, ( hl )
	inc hl
	rla

getbit3:
	jr c, output_compressed
	ldi
	jr depack_loop

output_compressed:
	ld c, ( hl )
	inc hl

output_match:
	ld b, 0
	bit 7, c
	jr z, output_match1

	add a, a
	jr nz, getbit4

	ld a, ( hl )
	inc hl
	rla

getbit4:
	rl b

	add a, a
	jr nz, getbit5

	ld a, ( hl )
	inc hl
	rla

getbit5:
	rl b

	add a, a
	jr nz, getbit6

	ld a, ( hl )
	inc hl
	rla

getbit6:
	rl b

	add a, a
	jr nz, getbit7

	ld a, ( hl )
	inc hl
	rla

getbit7:
	jr c, output_match1
	res 7, c

output_match1:
	inc bc

	exx
	ld h, d
	ld l, e
	ld b, e

get_gamma_value_size:
	exx

	add a, a
	jr nz, getbit8

	ld a, ( hl )
	inc hl
	rla

getbit8:
	exx
	jr nc, get_gamma_value_size_end
	inc b
	jr get_gamma_value_size

get_gamma_value_bits:
	exx

	add a, a
	jr nz, getbit9

	ld a, ( hl )
	inc hl
	rla

getbit9:
	exx
	adc hl, hl

get_gamma_value_size_end:
	djnz get_gamma_value_bits

get_gamma_value_end:
	inc hl
	exx

	ret c

	push hl

	exx
	push hl
	exx

	ld h, d
	ld l, e
	sbc hl, bc

	pop bc

	ldir

	pop hl

	add a, a
	jr nz, getbita

	ld a, ( hl )
	inc hl
	rla

getbita:
	jr c, output_compressed
	ldi

	add a, a
	jr nz, getbitb

	ld a, ( hl )
	inc hl
	rla

getbitb:
	jr c, output_compressed
	ldi
	jp depack_loop
	