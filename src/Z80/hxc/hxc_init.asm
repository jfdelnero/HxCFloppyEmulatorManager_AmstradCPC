;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 8604 (May 11 2013) (MINGW32)
; This file was generated Sun Oct 15 00:38:09 2017
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
;hxc_init.c:16: char HxC_Init(struct DirectAccessStatusSector *statusSector, char *errorCode)
;	---------------------------------
; Function HxC_Init
; ---------------------------------
_HxC_Init_start:
_HxC_Init:
	push	ix
	ld	ix,0
	add	ix,sp
;hxc_init.c:21: ConfigDiskDrive();
	call	_ConfigDiskDrive
;hxc_init.c:25: retry = 0;
	ld	c, &00
;hxc_init.c:26: do
HxC_Init_00106:
;hxc_init.c:31: if (!ReadSector(HXC_SECTORDATA, 255, 0)) // HXC FORMAT
	push	bc
	ld	hl, &00FF
	push	hl
	ld	hl, &2100
	push	hl
	call	_ReadSector
	pop	af
	pop	af
	ld	e,l
	pop	bc
;hxc_init.c:36: *errorCode = HXCERROR_FLOPPYACCESSERROR;
	ld	l,(ix+6 )
	ld	d,(ix+7 )
;hxc_init.c:31: if (!ReadSector(HXC_SECTORDATA, 255, 0)) // HXC FORMAT
	ld	a,e
	or	 a
	jr	NZ,HxC_Init_00104
;hxc_init.c:34: if ( retry == 8 )
	ld	a,c
	sub	  &08
	jr	NZ,HxC_Init_00102
;hxc_init.c:36: *errorCode = HXCERROR_FLOPPYACCESSERROR;
	ld	h, d
	ld	(hl), &01
;hxc_init.c:37: return OPERATIONRESULT_ERROR;
	ld	l, &00
	jr	HxC_Init_00111
HxC_Init_00102:
;hxc_init.c:39: retry++;
	inc	c
	jr	HxC_Init_00107
HxC_Init_00104:
;hxc_init.c:43: retry = 0;
	ld	c, &00
HxC_Init_00107:
;hxc_init.c:45: } while ( retry != 0 );
	ld	a,c
	or	 a
	jr	NZ,HxC_Init_00106
;hxc_init.c:47: z80_memcpy( statusSector, HXC_SECTORDATA, sizeof(struct DirectAccessStatusSector));
	ld	h,(ix+4 )
	ld	e,(ix+5 )
	push	hl
	push	de
	ld	bc, &0021
	push	bc
	ld	bc, &2100
	push	bc
	ld	c, h
	ld	b, e
	push	bc
	call	_z80_memcpy
	ld	hl, &0006
	add	hl,sp
	ld	sp,hl
	pop	de
	pop	hl
;hxc_init.c:54: if(strcmp(statusSector->DAHEADERSIGNATURE, "HxCFEDA"))
	ld	bc,__str_hxc_init_0
	ld	e,(ix+4 )
	ld	h,(ix+5 )
	push	hl
	push	de
	push	bc
	ld	c, e
	ld	b, h
	push	bc
	call	_strcmp
	pop	af
	pop	af
	ld	b,l
	ld	c,h
	pop	de
	pop	hl
	ld	a,c
	or	b
	jr	Z,HxC_Init_00110
;hxc_init.c:56: *errorCode = HXCERROR_BADSIGNATURE;
	ld	h, d
	ld	(hl), &02
;hxc_init.c:57: return OPERATIONRESULT_ERROR;
	ld	l, &00
	jr	HxC_Init_00111
HxC_Init_00110:
;hxc_init.c:60: *errorCode = HXCERROR_OK;
	ld	h, d
	ld	(hl), &00
;hxc_init.c:61: return OPERATIONRESULT_SUCCESS;
	ld	l, &01
HxC_Init_00111:
	pop	ix
	ret
_HxC_Init_end:
__str_hxc_init_0:
	db "HxCFEDA"
	db  &00
