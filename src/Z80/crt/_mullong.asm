;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 8604 (May 11 2013) (MINGW32)
; This file was generated Sun Oct 15 00:37:51 2017
;--------------------------------------------------------
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
;--------------------------------------------------------
; Home
;--------------------------------------------------------
;--------------------------------------------------------
; code
;--------------------------------------------------------
;_mullong.c:703: _mullong (long a, long b)
;	---------------------------------
; Function _mullong
; ---------------------------------
__mullong_start:
__mullong:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-14
	add	hl,sp
	ld	sp,hl
;_mullong.c:707: t.i.hi = bcast(a)->b.b0 * bcast(b)->b.b2;           // A
	ld	hl, &0000
	add	hl,sp
	ld	(ix-4 ),l
	ld	(ix-3 ),h
	inc	hl
	inc	hl
	ld	c,l
	ld	b,h
	ld	hl, &0012
	add	hl,sp
	ld	(ix-2 ),l
	ld	(ix-1 ),h
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	ld	e,(hl)
	ld	hl, &0016
	add	hl,sp
	ld	(ix-6 ),l
	ld	(ix-5 ),h
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	inc	hl
	inc	hl
	ld	a,(hl)
	push	bc
	ld	h,a
	ld	l,  &00
	ld	d, l
	ld	b,  &08
_mullong_00103:
	add	hl,hl
	jr	NC,_mullong_00104
	add	hl,de
_mullong_00104:
	djnz	_mullong_00103
	pop	bc
	ex	de,hl
	ld	a,e
	ld	(bc),a
	inc	bc
	ld	a,d
	ld	(bc),a
;_mullong.c:708: t.i.lo = bcast(a)->b.b0 * bcast(b)->b.b0;           // A
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	ld	e,(hl)
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	ld	h, (hl)
	ld	l,  &00
	ld	d, l
	ld	b,  &08
_mullong_00105:
	add	hl,hl
	jr	NC,_mullong_00106
	add	hl,de
_mullong_00106:
	djnz	_mullong_00105
	ex	de,hl
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	ld	(hl),e
	inc	hl
	ld	(hl),d
;_mullong.c:709: t.b.b3 += bcast(a)->b.b3 * bcast(b)->b.b0;          // G
	ld	hl,  &0000+1+1+1
	add	hl, sp
	ex	de, hl
	ld	a,(de)
	ld	c,a
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	inc	hl
	inc	hl
	inc	hl
	ld	b,(hl)
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	ld	h,(hl)
	push	de
	ld	e,b
	ld	l,  &00
	ld	d, l
	ld	b,  &08
_mullong_00107:
	add	hl,hl
	jr	NC,_mullong_00108
	add	hl,de
_mullong_00108:
	djnz	_mullong_00107
	pop	de
	ld	a,c
	add	a, l
	ld	(de),a
;_mullong.c:710: t.b.b3 += bcast(a)->b.b2 * bcast(b)->b.b1;          // F
	ld	a,(de)
	ld	c,a
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	inc	hl
	inc	hl
	ld	b,(hl)
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	inc	hl
	ld	h,(hl)
	push	de
	ld	e,b
	ld	l,  &00
	ld	d, l
	ld	b,  &08
_mullong_00109:
	add	hl,hl
	jr	NC,_mullong_00110
	add	hl,de
_mullong_00110:
	djnz	_mullong_00109
	pop	de
	ld	a,c
	add	a, l
	ld	(de),a
;_mullong.c:711: t.i.hi += bcast(a)->b.b2 * bcast(b)->b.b0;          // E <- b lost in .lst
	ld	hl,  &0000+1+1
	add	hl, sp
	ex	de, hl
	ld	l, e
	ld	h, d
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	inc	hl
	inc	hl
	ld	a,(hl)
	ld	(ix-4 ),a
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	ld	a,(hl)
	push	de
	push	bc
	ld	e,a
	ld	h,(ix-4 )
	ld	l,  &00
	ld	d, l
	ld	b,  &08
_mullong_00111:
	add	hl,hl
	jr	NC,_mullong_00112
	add	hl,de
_mullong_00112:
	djnz	_mullong_00111
	pop	bc
	pop	de
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	l, e
	ld	h, d
	ld	(hl),c
	inc	hl
	ld	(hl),b
;_mullong.c:713: t.i.hi += bcast(a)->b.b1 * bcast(b)->b.b1;          // D <- b lost in .lst
	ld	l, e
	ld	h, d
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	inc	hl
	ld	a,(hl)
	ld	(ix-4 ),a
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	inc	hl
	ld	a,(hl)
	push	de
	push	bc
	ld	e,a
	ld	h,(ix-4 )
	ld	l,  &00
	ld	d, l
	ld	b,  &08
_mullong_00113:
	add	hl,hl
	jr	NC,_mullong_00114
	add	hl,de
_mullong_00114:
	djnz	_mullong_00113
	pop	bc
	pop	de
	add	hl,bc
	ld	c,l
	ld	b,h
	ld	a,c
	ld	(de),a
	inc	de
	ld	a,b
	ld	(de),a
;_mullong.c:715: bcast(a)->bi.b3 = bcast(a)->b.b1 * bcast(b)->b.b2;  // C
	ld	e,(ix-2 )
	ld	d,(ix-1 )
	inc	de
	inc	de
	inc	de
	ld	c,e
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	inc	hl
	ld	e,(hl)
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	inc	hl
	inc	hl
	ld	h,(hl)
	push	de
	ld	l,  &00
	ld	d, l
	ld	b,  &08
_mullong_00115:
	add	hl,hl
	jr	NC,_mullong_00116
	add	hl,de
_mullong_00116:
	djnz	_mullong_00115
	pop	de
	ld	e,l
	ld	l, c
	ld	h, d
	ld	(hl),e
;_mullong.c:716: bcast(a)->bi.i12 = bcast(a)->b.b1 * bcast(b)->b.b0; // C
	ld	e,(ix-2 )
	ld	d,(ix-1 )
	inc	de
	ld	c,e
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	inc	hl
	ld	e,(hl)
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	ld	h,(hl)
	push	de
	ld	l,  &00
	ld	d, l
	ld	b,  &08
_mullong_00117:
	add	hl,hl
	jr	NC,_mullong_00118
	add	hl,de
_mullong_00118:
	djnz	_mullong_00117
	pop	de
	ld	e,l
	ld	b,h
	ld	l, c
	ld	h, d
	ld	(hl),e
	inc	hl
	ld	(hl),b
;_mullong.c:718: bcast(b)->bi.b3 = bcast(a)->b.b0 * bcast(b)->b.b3;  // B
	ld	e,(ix-6 )
	ld	d,(ix-5 )
	inc	de
	inc	de
	inc	de
	ld	c,e
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	ld	e,(hl)
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	inc	hl
	inc	hl
	inc	hl
	ld	h,(hl)
	push	de
	ld	l,  &00
	ld	d, l
	ld	b,  &08
_mullong_00119:
	add	hl,hl
	jr	NC,_mullong_00120
	add	hl,de
_mullong_00120:
	djnz	_mullong_00119
	pop	de
	ld	e,l
	ld	l, c
	ld	h, d
	ld	(hl),e
;_mullong.c:719: bcast(b)->bi.i12 = bcast(a)->b.b0 * bcast(b)->b.b1; // B
	ld	e,(ix-6 )
	ld	d,(ix-5 )
	inc	de
	ld	c,e
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	ld	e,(hl)
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	inc	hl
	ld	h,(hl)
	push	de
	ld	l,  &00
	ld	d, l
	ld	b,  &08
_mullong_00121:
	add	hl,hl
	jr	NC,_mullong_00122
	add	hl,de
_mullong_00122:
	djnz	_mullong_00121
	pop	de
	ld	e,l
	ld	b,h
	ld	l, c
	ld	h, d
	ld	(hl),e
	inc	hl
	ld	(hl),b
;_mullong.c:721: bcast(b)->bi.b0 = 0;                                // B
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	ld	(hl), &00
;_mullong.c:722: bcast(a)->bi.b0 = 0;                                // C
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	ld	(hl), &00
;_mullong.c:723: t.l += a;
	ld	hl, &0000
	add	hl,sp
	ex	de,hl
	push	de
	ld	hl,  &0006
	add	hl, sp
	ex	de, hl
	ld	bc,  &0004
	ldir
	pop	de
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	ld	c,(ix+6 )
	ld	b,(ix+7 )
	ld	a,(ix-10 )
	add	a, l
	ld	(ix-10 ),a
	ld	a,(ix-9 )
	adc	a, h
	ld	(ix-9 ),a
	ld	a,(ix-8 )
	adc	a, c
	ld	(ix-8 ),a
	ld	a,(ix-7 )
	adc	a, b
	ld	(ix-7 ),a
	push	de
	ld	hl,  &0006
	add	hl, sp
	ld	bc,  &0004
	ldir
;_mullong.c:725: return t.l + b;
	pop	hl
	ld	l,(ix+8 )
	ld	h,(ix+9 )
	ld	e,(ix+10 )
	ld	d,(ix+11 )
	ld	a,(ix-10 )
	add	a, l
	ld	l,a
	ld	a,(ix-9 )
	adc	a, h
	ld	h,a
	ld	a,(ix-8 )
	adc	a, e
	ld	e,a
	ld	a,(ix-7 )
	adc	a, d
	ld	d,a
	ld	sp,ix
	pop	ix
	ret
__mullong_end:

IF NOT DEFINED __mulint_rrx_s

; mul.s
__mulint_rrx_s:
	pop af
	pop hl
	pop de
	push de
	push hl
	push af	
__muluchar_rrx_hds:
__mulint_rrx_hds:
	ld b, h
	ld c, l
__mul16:
	xor a
	ld l, a
	or b
	ld b, 16
	jr nz, __mul162
	ld b, 8
	ld a, c
__mul161:
	add hl, hl
__mul162:
	rl c
	rla
	jr nc, __mul163
	add hl, de
__mul163:
	djnz __mul161
	ret

ENDIF


IF NOT DEFINED __muluchar_rrx_s

; mulchar.s
__muluchar_rrx_s:
	ld hl, 2+1
	ld d, h
	add hl, sp
	ld e, ( hl )
	dec hl
	ld h, ( hl )
	ld l, d
	ld b, 8
muluchar_rrx_s_loop:
	add hl, hl
	jr nc, muluchar_rrx_s_noadd
	add hl, de
muluchar_rrx_s_noadd:
	djnz muluchar_rrx_s_loop
	ret

__mulsuchar_rrx_s:
	ld hl, 2+1
	ld b, h
	add hl, sp
	ld e, ( hl )
	dec hl
	ld c, ( hl )
	jr signexte

__muluschar_rrx_s:
	ld hl, 2
	ld b, h
	add hl, sp
	ld e, ( hl )
	inc hl
	ld c, ( hl )
	jr signexte

__mulschar_rrx_s:
	ld hl, 2+1
	add hl, sp
	ld e, ( hl )
	dec hl
	ld l, ( hl )
__mulschar_rrx_hds:
	ld c, l
	ld a, l
	rla
	sbc a, a
	ld b, a
signexte:
	ld a, e
	rla
	sbc a, a
	ld d, a
	jp __mul16

ENDIF

