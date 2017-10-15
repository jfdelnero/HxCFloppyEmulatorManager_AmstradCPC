
// ----------------------------------------------------------------------------
#include "config.h"
#include "platform\firmware_define.h"
#include "hxc\hxc_define.h"
#include "platform\bios.h"

// ----------------------------------------------------------------------------
void BiosUtils()
{
__asm

; ----------------------------------------------------------------------------
; OUTPUT
;  e = current drive (0 or 1)
GetDrive:
	ld hl, (AMSDOS_RESERVED_AREA_PTR)
    ld e, (hl)
    ret
    
; INPUT
;  e = current drive (0 or 1)
SetDrive:
	ld hl, (AMSDOS_RESERVED_AREA_PTR)
	ld a, e
    ld (hl), a
    ret
	
; ----------------------------------------------------------------------------
; INPUT
;  c = rom number
PushRom:
	call KL_ROM_SELECT
	ld a, b
	ld ( rom_previous_state+1 ), a
	ld a, c
	ld ( urom_index+1 ), a
    ret ; jp KL_U_ROM_ENABLE
	
; ----------------------------------------------------------------------------
PopRom:
urom_index:
	ld c, 0
	call KL_ROM_SELECT
rom_previous_state:
	ld a, 0
	call KL_ROM_RESTORE
	ret ; jp KL_U_ROM_DISABLE

; ----------------------------------------------------------------------------
__endasm;
}

// ----------------------------------------------------------------------------
void ResetAmsdos()
{
__asm
	ld a, (TXT_OUTPUT)
	push af
	ld a, (SCR_SET_MODE)
	push af
	ld a, (SCR_SET_BORDER)
	push af
	ld a, (SCR_SET_INK)
	push af
	
	ld a, &C9
	ld (TXT_OUTPUT), a
	ld (SCR_SET_MODE), a
	ld (SCR_SET_BORDER), a
	ld (SCR_SET_INK), a

	call GetDrive
	push de
	
	ld c, 7
	ld de, &0040
	ld hl, &ABFF
	call KL_ROM_WALK
	
	pop de
	call SetDrive
	
	pop af
	ld (SCR_SET_INK), a
	pop af
	ld (SCR_SET_BORDER), a
	pop af
	ld (SCR_SET_MODE), a
	pop af
	ld (TXT_OUTPUT), a
__endasm;
}

// ----------------------------------------------------------------------------
void ConfigDiskDrive()
{
	ResetAmsdos();
	
__asm
	; Save error handling
	ld a, (DISC_RETRIES)
	ld (DiscRetries+1), a
	ld a, (DISC_ERROR_MESSAGE_FLAG)
	ld (DiscErrorMessageFlag+1), a
	
	; Setup error handling
	ld a, 1
    ld (DISC_RETRIES), a ; no errors
    ld (DISC_ERROR_MESSAGE_FLAG), a ; 1 try only
    
    ld c, 7
    call PushRom
    
    ; Fast disc parameters
    ld hl, FastDiscParameters
    call BIOS_SETUP_DISC
    
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
__endasm;
}

// ----------------------------------------------------------------------------
void RestoreDiskDrive()
{
	ResetAmsdos();
	
__asm
	; Restore error handling
DiscRetries:
	ld a, 0
    ld (DISC_RETRIES), a ; no errors
DiscErrorMessageFlag:
    ld a, 0
    ld (DISC_ERROR_MESSAGE_FLAG), a ; 1 try only
__endasm;
}

// ----------------------------------------------------------------------------
char ReadSector(unsigned char *buffer, unsigned char track, unsigned char sector)
{
	buffer;
	track;
	sector;
	
__asm
	push ix
	ld	ix, 0
	add	ix, sp
	
	ld c, 7
    call PushRom
    
    call GetDrive ; e = current drive (0 or 1)
	
	ld l, (ix+4) ; buffer
    ld h, (ix+5)
    ld d, (ix+6) ; track
    ld c, (ix+7) ; sector

    call BIOS_READ_SECTOR
    
    push af
    
    call PopRom
    
    pop af
    
    ld l, 1
    jr c, ReadSector_OK
    dec l
ReadSector_OK:    
    
    pop	ix
__endasm;
}

// ----------------------------------------------------------------------------
char WriteSector(unsigned char *buffer, unsigned char track, unsigned char sector)
{
	buffer;
	track;
	sector;
	
__asm
	push ix
	ld	ix, 0
	add	ix, sp
	
    ld c, 7
    call PushRom
    
    call GetDrive ; e = current drive (0 or 1)
	
	ld l, (ix+4) ; buffer
    ld h, (ix+5)
    ld d, (ix+6) ; track
    ld c, (ix+7) ; sector

    call BIOS_WRITE_SECTOR
    
    push af
    
    call PopRom
    
    pop af
    
    ld l, 1
    jr c, WriteSector_OK
    dec l
WriteSector_OK:  
    
    pop	ix
__endasm;
}

// ----------------------------------------------------------------------------
char MoveToTrack(unsigned char track)
{
	track;
	
__asm
	push ix
	ld	ix, 0
	add	ix, sp
	
    ld c, 7
    call PushRom
    
    call GetDrive ; e = current drive (0 or 1)
	
	ld d, (ix+4) ; track

    call BIOS_MOVE_TRACK
    
    push af
    
    call PopRom
    
    pop af
    
    ld l, 1
    jr c, MoveTrack_OK
    dec l
MoveTrack_OK:  
    
    pop	ix
__endasm;
}
