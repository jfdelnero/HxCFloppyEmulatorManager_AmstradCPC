;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 8604 (May 11 2013) (MINGW32)
; This file was generated Sat Oct 14 23:36:22 2017
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
;_divulong.c:331: _divulong (unsigned long x, unsigned long y)
;	---------------------------------
; Function _divulong
; ---------------------------------
__divulong_start:
__divulong:
	push	ix
	ld	ix,0
	add	ix,sp
	dec	sp
;_divulong.c:333: unsigned long reste = 0L;
	ld	e, &00
	ld	bc, &0000
	ld	d, &00
;_divulong.c:337: do
	ld	(ix-1 ), &20
_divulong_00105:
;_divulong.c:340: c = MSB_SET(x);
	ld	a,(ix+7 )
	rlc	a
	and	 &01
	ld	h,a
;_divulong.c:341: x <<= 1;
	push	af
	pop	af
	sla	(ix+4 )
	rl	(ix+5 )
	rl	(ix+6 )
	rl	(ix+7 )
;_divulong.c:342: reste <<= 1;
	sla	e
	rl	b
	rl	c
	rl	d
;_divulong.c:343: if (c)
	ld	a,h
	or	 a
	jr	Z,_divulong_00102
;_divulong.c:344: reste |= 1L;
	set	0, e
_divulong_00102:
;_divulong.c:346: if (reste >= y)
	ld	a,e
	sub	 (ix+8 )
	ld	a,b
	sbc	a, (ix+9 )
	ld	a,c
	sbc	a, (ix+10 )
	ld	a,d
	sbc	a, (ix+11 )
	jr	C,_divulong_00106
;_divulong.c:348: reste -= y;
	ld	a,e
	sub	 (ix+8 )
	ld	e,a
	ld	a,b
	sbc	a, (ix+9 )
	ld	b,a
	ld	a,c
	sbc	a, (ix+10 )
	ld	c,a
	ld	a,d
	sbc	a, (ix+11 )
	ld	d,a
;_divulong.c:350: x |= 1L;
	set	0, (ix+4 )
_divulong_00106:
;_divulong.c:353: while (--count);
	dec	(ix-1 )
	ld	a,(ix-1 )
	or	 a
	jr	NZ,_divulong_00105
;_divulong.c:354: return x;
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	ld	e,(ix+6 )
	ld	d,(ix+7 )
	inc	sp
	pop	ix
	ret
__divulong_end:

IF NOT DEFINED __divsuchar_rrx_s

; divmixed.s
__divsuchar_rrx_s:
	ld hl, 2+1
	add hl, sp        
	ld e, ( hl )
	dec hl
	ld l, ( hl )
	ld h, 0
	jp __div_signexte

__divuschar_rrx_s:
	ld hl, 2+1
	ld d, h
	add hl,sp
	ld e, ( hl )
	dec hl
	ld l, ( hl )
	ld a, l
	rlca
	sbc a, a
	ld h, a
	jp __div16
	
ENDIF


IF NOT DEFINED __divsint_rrx_s

; divsigned.s
__divsint_rrx_s:
	pop af
	pop hl
	pop de
	push de
	push hl
	push af
	jp __div16

__divschar_rrx_s:
	ld hl, 2+1
	add hl, sp
	ld e, ( hl )
	dec hl
	ld l, ( hl )        
__divschar_rrx_hds:
__div8:
	ld a, l
	rlca
	sbc a, a
	ld h, a
__div_signexte:
	ld a, e
	rlca
	sbc a, a
	ld d, a
__divsint_rrx_hds:
__div16:
	ld a, h
	xor d
	rla
	ld a, h
	push af
	rla
	jr nc, .chkde
	sub a
	sub l
	ld l, a
	sbc a, a
	sub h
	ld h, a
.chkde:
	bit 7, d
	jr z, .dodiv
	sub a
	sub e
	ld e, a
	sbc a, a
	sub d
	ld d, a
        
.dodiv:
	call __divu16

.fix_quotient:
	pop af
	ret nc
	ld b, a
	sub a
	sub l
	ld l, a
	sbc a, a
	sub h
	ld h, a
	ld a, b
	ret

__get_remainder:
    rla
	ex de, hl
	ret nc
	sub a
	sub l
	ld l, a
	sbc a, a
	sub h
	ld h, a
	ret
	
ENDIF


IF NOT DEFINED __divuint_rrx_s

; divunsigned.s
__divuint_rrx_s:
	pop af
	pop hl
	pop de
	push de
	push hl
	push af
	jr __divu16

__divuchar_rrx_s:
	ld hl, 2+1
	add hl, sp
	ld e, ( hl )
	dec hl
	ld l, ( hl )
__divuchar_rrx_hds:
__divu8:
	ld h, 0
	ld d, h
__divuint_rrx_hds:
__divu16:
	ld a, e
	or d
	and &80
	jr nz, .morethan7bits
	or d
	jr nz, .morethan7bits        
.atmost7bits:
	ld b, 16
	adc hl, hl
.dvloop7:
	rla
	sub e
	jr nc, .nodrop7
	add a, e
.nodrop7:
	ccf
	adc hl, hl
	djnz .dvloop7
	ld e, a
	ret

.morethan7bits:
	ld b, 9
	ld a, l
	ld l, h
	ld h, 0
	rr l
.dvloop:
	adc hl,hl
	sbc hl,de
	jr nc, .nodrop
	add hl, de
.nodrop:
	ccf
	rla
	djnz .dvloop
	rl b
	ld d, b
	ld e, a
	ex de, hl
	ret

ENDIF

