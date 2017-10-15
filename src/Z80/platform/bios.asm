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
;bios.c:9: void BiosUtils()
;	---------------------------------
; Function BiosUtils
; ---------------------------------
_BiosUtils_start:
_BiosUtils:
;bios.c:51: __endasm;
; ----------------------------------------------------------------------------
; OUTPUT
; e = current drive (0 or 1)
	GetDrive:
	ld hl, ( &BE7D)
	ld e, (hl)
	ret
; INPUT
; e = current drive (0 or 1)
	SetDrive:
	ld hl, ( &BE7D)
	ld a, e
	ld (hl), a
	ret
; ----------------------------------------------------------------------------
; INPUT
; c = rom number
	PushRom:
	call  &B90F
	ld a, b
	ld ( rom_previous_state+1 ), a
	ld a, c
	ld ( urom_index+1 ), a
	ret ; jp  &B900
; ----------------------------------------------------------------------------
	PopRom:
	urom_index:
	ld c, 0
	call  &B90F
	rom_previous_state:
	ld a, 0
	call  &B90C
	ret ; jp  &B903
; ----------------------------------------------------------------------------
	ret
_BiosUtils_end:
;bios.c:55: void ResetAmsdos()
;	---------------------------------
; Function ResetAmsdos
; ---------------------------------
_ResetAmsdos_start:
_ResetAmsdos:
;bios.c:92: __endasm;
	ld a, ( &BB5A)
	push af
	ld a, ( &BC0E)
	push af
	ld a, ( &BC38)
	push af
	ld a, ( &BC32)
	push af
	ld a, &C9
	ld ( &BB5A), a
	ld ( &BC0E), a
	ld ( &BC38), a
	ld ( &BC32), a
	call GetDrive
	push de
	ld c, 7
	ld de, &0040
	ld hl, &ABFF
	call  &BCCB
	pop de
	call SetDrive
	pop af
	ld ( &BC32), a
	pop af
	ld ( &BC38), a
	pop af
	ld ( &BC0E), a
	pop af
	ld ( &BB5A), a
	ret
_ResetAmsdos_end:
;bios.c:96: void ConfigDiskDrive()
;	---------------------------------
; Function ConfigDiskDrive
; ---------------------------------
_ConfigDiskDrive_start:
_ConfigDiskDrive:
;bios.c:98: ResetAmsdos();
	call	_ResetAmsdos
;bios.c:146: __endasm;
; Save error handling
	ld a, ( &BE66)
	ld (DiscRetries+1), a
	ld a, ( &BE78)
	ld (DiscErrorMessageFlag+1), a
; Setup error handling
	ld a, 1
	ld ( &BE66), a ; no errors
	ld ( &BE78), a ; 1 try only
	ld c, 7
	call PushRom
; Fast disc parameters
	ld hl, FastDiscParameters
	call  &C036
; Motor On
	di
	ld bc, &FB7E
	ld a, &03
	call PutFDC
	ld a, &F1
	call PutFDC
	ld a, &03
	call PutFDC
	ei
	jp PopRom
	PutFDC:
	push af
	PutFDC_Loop:
	in a, (c)
	rla
	jr nc, PutFDC_Loop
	inc c
	pop af
	out (c), a
	dec c
	ret
	FastDiscParameters:
	db &23, &00, &C8, &00, &AF, &0F, &0A, &01, &03
	ret
_ConfigDiskDrive_end:
;bios.c:150: void RestoreDiskDrive()
;	---------------------------------
; Function RestoreDiskDrive
; ---------------------------------
_RestoreDiskDrive_start:
_RestoreDiskDrive:
;bios.c:152: ResetAmsdos();
	call	_ResetAmsdos
;bios.c:162: __endasm;
; Restore error handling
	DiscRetries:
	ld a, 0
	ld ( &BE66), a ; no errors
	DiscErrorMessageFlag:
	ld a, 0
	ld ( &BE78), a ; 1 try only
	ret
_RestoreDiskDrive_end:
;bios.c:166: char ReadSector(unsigned char *buffer, unsigned char track, unsigned char sector)
;	---------------------------------
; Function ReadSector
; ---------------------------------
_ReadSector_start:
_ReadSector:
;bios.c:201: __endasm;
	push ix
	ld ix, 0
	add ix, sp
	ld c, 7
	call PushRom
	call GetDrive ; e = current drive (0 or 1)
	ld l, (ix+4) ; buffer
	ld h, (ix+5)
	ld d, (ix+6) ; track
	ld c, (ix+7) ; sector
	call  &C03C
	push af
	call PopRom
	pop af
	ld l, 1
	jr c, ReadSector_OK
	dec l
	ReadSector_OK:
	pop ix
	ret
_ReadSector_end:
;bios.c:205: char WriteSector(unsigned char *buffer, unsigned char track, unsigned char sector)
;	---------------------------------
; Function WriteSector
; ---------------------------------
_WriteSector_start:
_WriteSector:
;bios.c:240: __endasm;
	push ix
	ld ix, 0
	add ix, sp
	ld c, 7
	call PushRom
	call GetDrive ; e = current drive (0 or 1)
	ld l, (ix+4) ; buffer
	ld h, (ix+5)
	ld d, (ix+6) ; track
	ld c, (ix+7) ; sector
	call  &C03F
	push af
	call PopRom
	pop af
	ld l, 1
	jr c, WriteSector_OK
	dec l
	WriteSector_OK:
	pop ix
	ret
_WriteSector_end:
;bios.c:244: char MoveToTrack(unsigned char track)
;	---------------------------------
; Function MoveToTrack
; ---------------------------------
_MoveToTrack_start:
_MoveToTrack:
;bios.c:274: __endasm;
	push ix
	ld ix, 0
	add ix, sp
	ld c, 7
	call PushRom
	call GetDrive ; e = current drive (0 or 1)
	ld d, (ix+4) ; track
	call  &C045
	push af
	call PopRom
	pop af
	ld l, 1
	jr c, MoveTrack_OK
	dec l
	MoveTrack_OK:
	pop ix
	ret
_MoveToTrack_end:
