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
_last_setlbabase:
	ds 4
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
;hxc_io.c:17: char setlbabase( unsigned long lba )
;	---------------------------------
; Function setlbabase
; ---------------------------------
_setlbabase_start:
_setlbabase:
;hxc_io.c:32: strcpy( dacs->DAHEADERSIGNATURE, "HxCFEDA" );
	ld	hl,__str_hxc_io_0
	ld	de, &2300
	xor	 a
setlbabase_00108:
	cp	 (hl)
	ldi
	jr	NZ, setlbabase_00108
;hxc_io.c:33: dacs->cmd_code = 1; // CMD_SET_LBA
	ld	hl, &2308
	ld	(hl), &01
;hxc_io.c:35: ptr = (unsigned char*) &lba;
	ld	hl, &0002
	add	hl,sp
	ex	de,hl
;hxc_io.c:36: dacs->parameter_0 = *ptr++;
	ld	a,(de)
	inc	de
	ld	hl, &2309
	ld	(hl),a
;hxc_io.c:37: dacs->parameter_1 = *ptr++;
	ld	a,(de)
	inc	de
	ld	l,  &0A
	ld	(hl),a
;hxc_io.c:38: dacs->parameter_2 = *ptr++;
	ld	a,(de)
	inc	de
	ld	l,  &0B
	ld	(hl),a
;hxc_io.c:39: dacs->parameter_3 = *ptr++;
	ld	a,(de)
	ld	l,  &0C
	ld	(hl),a
;hxc_io.c:40: dacs->parameter_4 =  &A5;
	ld	l,  &0D
	ld	(hl), &A5
;hxc_io.c:41: dacs->parameter_5 =  &00;
	ld	l,  &0E
	ld	(hl), &00
;hxc_io.c:43: if ( !WriteSector( (unsigned char *) HXC_CMDSECTOR, track, sector ) )
	ld	hl, &00FF
	push	hl
	ld	hl, &2300
	push	hl
	call	_WriteSector
	pop	af
	pop	af
	ld	a,l
;hxc_io.c:45: return OPERATIONRESULT_ERROR;
	or	a
	jr	NZ,setlbabase_00102
	ld	l,a
	ret
setlbabase_00102:
;hxc_io.c:48: return OPERATIONRESULT_SUCCESS;
	ld	l, &01
	ret
_setlbabase_end:
__str_hxc_io_0:
	db "HxCFEDA"
	db  &00
;hxc_io.c:52: void MediaInit()
;	---------------------------------
; Function MediaInit
; ---------------------------------
_MediaInit_start:
_MediaInit:
;hxc_io.c:54: last_setlbabase =  &FFFFFF00;
	ld	hl,_last_setlbabase + 0
	ld	(hl),  &00
	ld	hl,_last_setlbabase + 1
	ld	(hl),  &FF
	ld	hl,_last_setlbabase + 2
	ld	(hl),  &FF
	ld	hl,_last_setlbabase + 3
	ld	(hl),  &FF
	ret
_MediaInit_end:
;hxc_io.c:58: int MediaQuit()
;	---------------------------------
; Function MediaQuit
; ---------------------------------
_MediaQuit_start:
_MediaQuit:
;hxc_io.c:73: strcpy( dacs->DAHEADERSIGNATURE, "HxCFEDA" );
	ld	hl,__str_hxc_io_1
	ld	de, &2300
	xor	 a
MediaQuit_00108:
	cp	 (hl)
	ldi
	jr	NZ, MediaQuit_00108
;hxc_io.c:74: dacs->cmd_code = 2; // CMD_SET_TRACK_POS
	ld	hl, &2308
	ld	(hl), &02
;hxc_io.c:76: dacs->parameter_0 =  &00;
	ld	l,  &09
	ld	(hl), &00
;hxc_io.c:77: dacs->parameter_1 =  &00;
	ld	l,  &0A
	ld	(hl), &00
;hxc_io.c:78: dacs->parameter_2 =  &00;
	ld	l,  &0B
	ld	(hl), &00
;hxc_io.c:79: dacs->parameter_3 =  &00;
	ld	l,  &0C
	ld	(hl), &00
;hxc_io.c:80: dacs->parameter_4 =  &00;
	ld	l,  &0D
	ld	(hl), &00
;hxc_io.c:81: dacs->parameter_5 =  &00;
	ld	l,  &0E
	ld	(hl), &00
;hxc_io.c:83: if ( !WriteSector( (unsigned char *) HXC_CMDSECTOR, track, sector ) )
	ld	hl, &00FF
	push	hl
	ld	hl, &2300
	push	hl
	call	_WriteSector
	pop	af
	pop	af
	ld	a,l
	or	 a
	jr	NZ,MediaQuit_00102
;hxc_io.c:85: return OPERATIONRESULT_ERROR;
	ld	hl, &0000
	ret
MediaQuit_00102:
;hxc_io.c:89: RestoreDiskDrive();
	call	_RestoreDiskDrive
;hxc_io.c:91: return OPERATIONRESULT_SUCCESS;
	ld	hl, &0001
	ret
_MediaQuit_end:
__str_hxc_io_1:
	db "HxCFEDA"
	db  &00
;hxc_io.c:95: int MediaRead(unsigned long lba_sector, unsigned char *buffer)
;	---------------------------------
; Function MediaRead
; ---------------------------------
_MediaRead_start:
_MediaRead:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-5
	add	hl,sp
	ld	sp,hl
;hxc_io.c:104: unsigned char sector = 1;
	ld	(ix-1 ), &01
;hxc_io.c:107: diff = lba_sector-last_setlbabase;
	ld	hl,_last_setlbabase
	ld	a,(ix+4 )
	sub	 (hl)
	ld	d,a
	ld	a,(ix+5 )
	inc	hl
	sbc	a, (hl)
	ld	e,a
	ld	a,(ix+6 )
	inc	hl
	sbc	a, (hl)
	ld	b,a
	ld	a,(ix+7 )
	inc	hl
	sbc	a, (hl)
	ld	c,a
	ld	(ix-5 ),d
	ld	(ix-4 ),e
	ld	(ix-3 ),b
	ld	(ix-2 ),c
;hxc_io.c:109: if ( diff < 8 )
	ld	a,(ix-5 )
	sub	  &08
	ld	a,(ix-4 )
	sbc	a,  &00
	ld	a,(ix-3 )
	sbc	a,  &00
	ld	a,(ix-2 )
	sbc	a,  &00
	jr	NC,MediaRead_00104
;hxc_io.c:111: sector = diff+1;
	ld	a,(ix-5 )
	inc	a
	ld	(ix-1 ),a
	jr	MediaRead_00105
MediaRead_00104:
;hxc_io.c:115: if ( !setlbabase( lba_sector ) )
	ld	l,(ix+6 )
	ld	h,(ix+7 )
	push	hl
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	push	hl
	call	_setlbabase
	pop	af
	pop	af
	ld	a,l
	or	 a
	jr	NZ,MediaRead_00102
;hxc_io.c:117: return OPERATIONRESULT_ERROR;
	ld	hl, &0000
	jr	MediaRead_00108
MediaRead_00102:
;hxc_io.c:120: last_setlbabase = lba_sector;
	ld	de, _last_setlbabase
	ld	hl, 9
	add	hl, sp
	ld	bc, 4
	ldir
MediaRead_00105:
;hxc_io.c:123: if ( !ReadSector( buffer, track, sector ) )
	ld	d, (ix-1 )
	ld	e, &FF
	push	de
	ld	l,(ix+8 )
	ld	h,(ix+9 )
	push	hl
	call	_ReadSector
	pop	af
	pop	af
	ld	a,l
	or	 a
	jr	NZ,MediaRead_00107
;hxc_io.c:125: return OPERATIONRESULT_ERROR;
	ld	hl, &0000
	jr	MediaRead_00108
MediaRead_00107:
;hxc_io.c:128: return OPERATIONRESULT_SUCCESS;
	ld	hl, &0001
MediaRead_00108:
	ld	sp,ix
	pop	ix
	ret
_MediaRead_end:
;hxc_io.c:132: int MediaWrite(unsigned long lba_sector, unsigned char *buffer)
;	---------------------------------
; Function MediaWrite
; ---------------------------------
_MediaWrite_start:
_MediaWrite:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-5
	add	hl,sp
	ld	sp,hl
;hxc_io.c:141: unsigned char sector = 1;
	ld	(ix-1 ), &01
;hxc_io.c:144: diff = lba_sector - last_setlbabase;
	ld	hl,_last_setlbabase
	ld	a,(ix+4 )
	sub	 (hl)
	ld	d,a
	ld	a,(ix+5 )
	inc	hl
	sbc	a, (hl)
	ld	e,a
	ld	a,(ix+6 )
	inc	hl
	sbc	a, (hl)
	ld	b,a
	ld	a,(ix+7 )
	inc	hl
	sbc	a, (hl)
	ld	c,a
	ld	(ix-5 ),d
	ld	(ix-4 ),e
	ld	(ix-3 ),b
	ld	(ix-2 ),c
;hxc_io.c:146: if ( diff < 8 )
	ld	a,(ix-5 )
	sub	  &08
	ld	a,(ix-4 )
	sbc	a,  &00
	ld	a,(ix-3 )
	sbc	a,  &00
	ld	a,(ix-2 )
	sbc	a,  &00
	jr	NC,MediaWrite_00102
;hxc_io.c:148: sector = diff+1;
	ld	a,(ix-5 )
	inc	a
	ld	(ix-1 ),a
	jr	MediaWrite_00103
MediaWrite_00102:
;hxc_io.c:152: setlbabase( lba_sector );
	ld	l,(ix+6 )
	ld	h,(ix+7 )
	push	hl
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	push	hl
	call	_setlbabase
	pop	af
	pop	af
;hxc_io.c:153: last_setlbabase = lba_sector;
	ld	de, _last_setlbabase
	ld	hl, 9
	add	hl, sp
	ld	bc, 4
	ldir
MediaWrite_00103:
;hxc_io.c:156: if ( !WriteSector( buffer, track, sector ) )
	ld	d, (ix-1 )
	ld	e, &FF
	push	de
	ld	l,(ix+8 )
	ld	h,(ix+9 )
	push	hl
	call	_WriteSector
	pop	af
	pop	af
	ld	a,l
	or	 a
	jr	NZ,MediaWrite_00105
;hxc_io.c:158: return OPERATIONRESULT_ERROR;
	ld	hl, &0000
	jr	MediaWrite_00106
MediaWrite_00105:
;hxc_io.c:161: return OPERATIONRESULT_SUCCESS;
	ld	hl, &0001
MediaWrite_00106:
	ld	sp,ix
	pop	ix
	ret
_MediaWrite_end:
