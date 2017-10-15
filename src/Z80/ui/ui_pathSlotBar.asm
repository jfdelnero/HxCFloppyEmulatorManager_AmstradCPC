;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 8604 (May 11 2013) (MINGW32)
; This file was generated Sat Oct 14 23:36:43 2017
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
;ui_pathSlotBar.c:15: void RefreshPathSlot()
;	---------------------------------
; Function RefreshPathSlot
; ---------------------------------
_RefreshPathSlot_start:
_RefreshPathSlot:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-44
	add	hl,sp
	ld	sp,hl
;ui_pathSlotBar.c:36: __endasm;
	ld hl,  &1680 +4 ; +4=HxC: label
	ld (hl), 32 ; space
	ld de,  &1680 +1+4
	ld bc, 80-1-4
	ldir
	ld (hl), 0
;ui_pathSlotBar.c:40: selectedSlot = GetSelectedSlot();
	call	_GetSelectedSlot
	ld	(ix-18 ),l
;ui_pathSlotBar.c:43: offset = 0;
	ld	(ix-13 ), &00
;ui_pathSlotBar.c:44: if (selectedSlot<10)
	ld	a,(ix-18 )
	xor	  &80
	sub	  &8A
	jr	NC,RefreshPathSlot_00102
;ui_pathSlotBar.c:46: slotLabel[0] = '0';
	ld	hl, &0000
	add	hl,sp
	ld	(hl), &30
;ui_pathSlotBar.c:47: offset = 1;
	ld	(ix-13 ), &01
RefreshPathSlot_00102:
;ui_pathSlotBar.c:49: uitoa( selectedSlot, &slotLabel[offset], 10);	
	ld	hl, &0000
	add	hl,sp
	ld	(ix-2 ),l
	ld	(ix-1 ),h
	ld	a,(ix-2 )
	add	a, (ix-13 )
	ld	(ix-4 ),a
	ld	a,(ix-1 )
	adc	a,  &00
	ld	(ix-3 ),a
	ld	a,(ix-18 )
	ld	(ix-10 ),a
	ld	a,(ix-18 )
	rla
	sbc	a, a
	ld	(ix-9 ),a
	ld	a, &0A
	push	af
	inc	sp
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	push	hl
	ld	l,(ix-10 )
	ld	h,(ix-9 )
	push	hl
	call	_uitoa
	pop	af
	pop	af
	inc	sp
;ui_pathSlotBar.c:50: slotLabel[2] = ':';
	ld	a,(ix-2 )
	add	a,  &02
	ld	(ix-10 ),a
	ld	a,(ix-1 )
	adc	a,  &00
	ld	(ix-9 ),a
	ld	l,(ix-10 )
	ld	h,(ix-9 )
	ld	(hl), &3A
;ui_pathSlotBar.c:53: diskInDrive = &slots[ selectedSlot ];
	ld	c,(ix-18 )
	ld	a, c
	rlc	a
	sbc	a, a
	ld	b, a
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	(ix-10 ),l
	ld	(ix-9 ),h
	ld	a,(ix-10 )
	add	a,  &00
	ld	(ix-20 ),a
	ld	a,(ix-9 )
	adc	a,  &1D
	ld	(ix-19 ),a
;ui_pathSlotBar.c:55: dirEntSize = diskInDrive->DirEnt.size;
	ld	a,(ix-20 )
	ld	(ix-10 ),a
	ld	a,(ix-19 )
	ld	(ix-9 ),a
	ld	l,(ix-10 )
	ld	h,(ix-9 )
	ld	de,  &0011
	add	hl, de
	ld	a,(hl)
	ld	(ix-17 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-16 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-15 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-14 ),a
;ui_pathSlotBar.c:62: z80_memcpy(&slotLabel[3], diskInDrive->DirEnt.longName, dirEntSize );
	ld	a,(ix-2 )
	add	a,  &03
	ld	(ix-10 ),a
	ld	a,(ix-1 )
	adc	a,  &00
	ld	(ix-9 ),a
;ui_pathSlotBar.c:56: if (dirEntSize)
	ld	a,(ix-14 )
	or	 (ix-15 )
	or	 (ix-16 )
	or	(ix-17 )
	jp	Z,RefreshPathSlot_00106
;ui_pathSlotBar.c:58: if (dirEntSize>15)
	ld	a, &0F
	cp	 (ix-17 )
	ld	a, &00
	sbc	a, (ix-16 )
	ld	a, &00
	sbc	a, (ix-15 )
	ld	a, &00
	sbc	a, (ix-14 )
	jr	NC,RefreshPathSlot_00104
;ui_pathSlotBar.c:60: dirEntSize = 16;
	ld	(ix-17 ), &10
	xor	 a
	ld	(ix-16 ),a
	ld	(ix-15 ),a
	ld	(ix-14 ),a
RefreshPathSlot_00104:
;ui_pathSlotBar.c:62: z80_memcpy(&slotLabel[3], diskInDrive->DirEnt.longName, dirEntSize );
	ld	a,(ix-17 )
	ld	(ix-4 ),a
	ld	a,(ix-16 )
	ld	(ix-3 ),a
	ld	a,(ix-20 )
	add	a,  &15
	ld	(ix-6 ),a
	ld	a,(ix-19 )
	adc	a,  &00
	ld	(ix-5 ),a
	ld	a,(ix-10 )
	ld	(ix-8 ),a
	ld	a,(ix-9 )
	ld	(ix-7 ),a
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	push	hl
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	push	hl
	ld	l,(ix-8 )
	ld	h,(ix-7 )
	push	hl
	call	_z80_memcpy
	ld	hl, &0006
	add	hl,sp
	ld	sp,hl
;ui_pathSlotBar.c:63: slotLabel[3+dirEntSize]=0;
	ld	a,(ix-17 )
	add	a,  &03
	ld	(ix-8 ),a
	ld	a,(ix-2 )
	add	a, (ix-8 )
	ld	(ix-8 ),a
	ld	a,(ix-1 )
	adc	a,  &00
	ld	(ix-7 ),a
	ld	l,(ix-8 )
	ld	h,(ix-7 )
	ld	(hl), &00
	jr	RefreshPathSlot_00107
RefreshPathSlot_00106:
;ui_pathSlotBar.c:67: slotLabel[3]=0;
	ld	l,(ix-10 )
	ld	h,(ix-9 )
	ld	(hl), &00
RefreshPathSlot_00107:
;ui_pathSlotBar.c:70: len = z80_strlen( slotLabel );
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	push	hl
	call	_z80_strlen
	pop	af
	ld	(ix-11 ),l
;ui_pathSlotBar.c:71: maxPathSize = 80-len-1;
	ld	a, &4F
	sub	 (ix-11 )
	ld	(ix-12 ),a
;ui_pathSlotBar.c:72: z80_memcpy( &pathSlotBuffer[maxPathSize+1], slotLabel, len );
	ld	e,(ix-11 )
	ld	d, &00
	ld	c,(ix-2 )
	ld	b,(ix-1 )
	ld	l,(ix-12 )
	ld	h, &00
	inc	hl
	push	de
	ld	de, &1680
	add	hl, de
	push	bc
	push	hl
	call	_z80_memcpy
	ld	hl, &0006
	add	hl,sp
	ld	sp,hl
;ui_pathSlotBar.c:78: z80_strcpy(pathSlotBuffer, "HxC:");
	ld	hl,__str_ui_pathSlotBar_0
	push	hl
	ld	hl, &1680
	push	hl
	call	_z80_strcpy
	pop	af
	pop	af
;ui_pathSlotBar.c:80: maxPathSize -= 4; // sizeof("SDCard:")
	ld	a,(ix-12 )
	add	a, &FC
	ld	(ix-12 ),a
;ui_pathSlotBar.c:83: len = (unsigned char) strlen(path);
	ld	hl, &1700
	push	hl
	call	_strlen
	pop	af
;ui_pathSlotBar.c:87: z80_strcpy(pathSlotBuffer, &path[len-maxPathSize]);
	ld	(ix-11 ), l
	ld	(ix-8 ), l
	ld	(ix-7 ), &00
;ui_pathSlotBar.c:85: if ( len >= maxPathSize)
	ld	a,(ix-11 )
	sub	 (ix-12 )
	jr	C,RefreshPathSlot_00109
;ui_pathSlotBar.c:87: z80_strcpy(pathSlotBuffer, &path[len-maxPathSize]);
	ld	l,(ix-12 )
	ld	h, &00
	ld	a,(ix-8 )
	sub	 l
	ld	l,a
	ld	a,(ix-7 )
	sbc	a, h
	ld	h,a
	ld	bc, &1700
	add	hl,bc
	push	hl
	ld	hl, &1684
	push	hl
	call	_z80_strcpy
	pop	af
	pop	af
;ui_pathSlotBar.c:88: pathSlotBuffer[maxPathSize] = ' ';
	ld	a,(ix-12 )
	add	a,  &84
	ld	l,a
	ld	a, &00
	adc	a,  &16
	ld	h,a
	ld	(hl), &20
	jr	RefreshPathSlot_00127
RefreshPathSlot_00109:
;ui_pathSlotBar.c:92: z80_strcpy(pathSlotBuffer, path);
	ld	hl, &1700
	push	hl
	ld	hl, &1684
	push	hl
	call	_z80_strcpy
	pop	af
	pop	af
;ui_pathSlotBar.c:93: pathSlotBuffer[len] = ' ';
	ld	a,(ix-11 )
	add	a,  &84
	ld	l,a
	ld	a, &00
	adc	a,  &16
	ld	h,a
	ld	(hl), &20
;ui_pathSlotBar.c:96: for( i=0; i<len; i++ )
RefreshPathSlot_00127:
	ld	b, &00
RefreshPathSlot_00117:
	ld	a,b
	sub	 (ix-11 )
	jr	NC,RefreshPathSlot_00113
;ui_pathSlotBar.c:98: if (pathSlotBuffer[i] == '/')
	ld	a,b
	add	a,  &84
	ld	e,a
	ld	a, &00
	adc	a,  &16
	ld	d,a
	ld	a,(de)
	sub	  &2F
	jr	NZ,RefreshPathSlot_00118
;ui_pathSlotBar.c:100: pathSlotBuffer[i] = '\\';
	ld	a, &5C
	ld	(de),a
RefreshPathSlot_00118:
;ui_pathSlotBar.c:96: for( i=0; i<len; i++ )
	inc	b
	jr	RefreshPathSlot_00117
RefreshPathSlot_00113:
;ui_pathSlotBar.c:104: if (len>1)
	ld	a, &01
	sub	 (ix-11 )
	jr	NC,RefreshPathSlot_00115
;ui_pathSlotBar.c:106: pathSlotBuffer[len-1] = ' ';
	ld	l,(ix-8 )
	ld	h,(ix-7 )
	ld	bc, &1684-1
	add	hl,bc
	ld	(hl), &20
RefreshPathSlot_00115:
;ui_pathSlotBar.c:110: pathSlotBuffer[80]=0;
	ld	hl, &16D0
	ld	(hl), &00
;ui_pathSlotBar.c:112: PrintTiny(TINY_TOP_SCREENPTR, pathSlotBuffer);
	ld	l,  &80
	push	hl
	ld	hl, &F0A0
	push	hl
	call	_PrintTiny
	ld	sp,ix
	pop	ix
	ret
_RefreshPathSlot_end:
__str_ui_pathSlotBar_0:
	db "HxC:"
	db  &00

IF NOT DEFINED _strlen

; strlen.s
_strlen:
	pop bc
	pop hl
	push hl
	push bc
	xor a
	ld b, a
	ld c, a
	cpir
	ld hl, -1
	sbc hl, bc
	ret

ENDIF

