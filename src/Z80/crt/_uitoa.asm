;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 8604 (May 11 2013) (MINGW32)
; This file was generated Sun Oct 15 00:37:52 2017
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
;_uitoa.c:2: void uitoa(unsigned int value, char* string, unsigned char radix)
;	---------------------------------
; Function uitoa
; ---------------------------------
_uitoa_start:
_uitoa:
	push	ix
	ld	ix,0
	add	ix,sp
	push	af
	push	af
;_uitoa.c:7: do {
	ld	c, &00
uitoa_00103:
;_uitoa.c:8: string[index] = '0' + (value % radix);
	ld	l,(ix+6 )
	ld	h,(ix+7 )
	ld	b, &00
	add	hl, bc
	ld	e,(ix+8 )
	ld	d, &00
	push	hl
	push	bc
	push	de
	push	de
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	push	hl
	call	__moduint_rrx_s
	pop	af
	pop	af
	ld	(ix-1 ),h
	ld	(ix-2 ),l
	pop	de
	pop	bc
	pop	hl
	ld	a,(ix-2 )
	add	a,  &30
	ld	b,a
	ld	(hl),b
;_uitoa.c:9: if (string[index] > '9')
	ld	a, &39
	sub	 b
	jp	PO, uitoa_00128
	xor	  &80
uitoa_00128:
	jp	P,uitoa_00102
;_uitoa.c:10: string[index] += 'A' - '9' - 1;
	ld	a,(hl)
	add	a,  &07
	ld	(hl),a
uitoa_00102:
;_uitoa.c:11: value /= radix;
	push	bc
	push	de
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	push	hl
	call	__divuint_rrx_s
	pop	af
	pop	af
	pop	bc
	ld	(ix+4 ),l
	ld	(ix+5 ),h
;_uitoa.c:12: ++index;
	inc	c
;_uitoa.c:13: } while (value != 0);
	ld	a,(ix+5 )
	or	(ix+4 )
	jr	NZ,uitoa_00103
;_uitoa.c:16: string[index--] = '\0';
	ld	a,c
	add	a, &FF
	ld	(ix-2 ),a
	ld	l,(ix+6 )
	ld	h,(ix+7 )
	ld	b, &00
	add	hl, bc
	ld	(hl), &00
;_uitoa.c:19: while (index > i) {
	ld	(ix-3 ), &00
uitoa_00106:
	ld	a,(ix-3 )
	sub	 (ix-2 )
	jp	PO, uitoa_00129
	xor	  &80
uitoa_00129:
	jp	P,uitoa_00109
;_uitoa.c:20: char tmp = string[i];
	ld	a,(ix+6 )
	add	a, (ix-3 )
	ld	c,a
	ld	a,(ix+7 )
	adc	a,  &00
	ld	b,a
	ld	a,(bc)
	ld	(ix-4 ),a
;_uitoa.c:21: string[i] = string[index];
	ld	a,(ix+6 )
	add	a, (ix-2 )
	ld	e,a
	ld	a,(ix+7 )
	adc	a,  &00
	ld	d,a
	ld	a,(de)
	ld	(bc),a
;_uitoa.c:22: string[index] = tmp;
	ld	a,(ix-4 )
	ld	(de),a
;_uitoa.c:23: ++i;
	inc	(ix-3 )
;_uitoa.c:24: --index;
	dec	(ix-2 )
	jr	uitoa_00106
uitoa_00109:
	ld	sp,ix
	pop	ix
	ret
_uitoa_end:

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


IF NOT DEFINED __modsuchar_rrx_s

; modmixed.s
__modsuchar_rrx_s:
	ld hl, 2+1
	add hl, sp
	ld e, ( hl )
	dec hl
	ld l, ( hl )
	ld h, 0
	call __div_signexte
	jp __get_remainder

__moduschar_rrx_s:
	ld hl, 2+1
	ld d, h
	add hl, sp
	ld e, ( hl )
	dec hl
	ld l, ( hl )
	ld a, l
	rlca
	sbc a, a
	ld h, a
	call __div16
	jp __get_remainder

ENDIF


IF NOT DEFINED __modschar_rrx_s

; modsigned.s
__modschar_rrx_s:
	ld hl, 2+1
	add hl, sp
	ld e, ( hl )
	dec hl
	ld l, ( hl )
__modschar_rrx_hds:
	call __div8
	jp __get_remainder

__modsint_rrx_s:
	pop af
	pop hl
	pop de
	push de
	push hl
	push af
__modsint_rrx_hds:
	call __div16
	jp __get_remainder
	
ENDIF


IF NOT DEFINED __moduchar_rrx_s

; modunsigned.s
__moduchar_rrx_s:
	ld hl, 2+1
	add hl, sp
	ld e, ( hl )
	dec hl
	ld l, ( hl )
__moduchar_rrx_hds:
	call __divu8
	ex de,hl
	ret

__moduint_rrx_s:
	pop af
	pop hl
	pop de
	push de
	push hl
	push af
__moduint_rrx_hds:
	call __divu16
	ex de, hl
	ret

ENDIF

