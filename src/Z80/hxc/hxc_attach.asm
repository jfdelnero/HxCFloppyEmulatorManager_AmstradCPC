;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 8604 (May 11 2013) (MINGW32)
; This file was generated Sat Oct 14 23:36:39 2017
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
;hxc_attach.c:14: char HxC_Attach(char *errorCode)
;	---------------------------------
; Function HxC_Attach
; ---------------------------------
_HxC_Attach_start:
_HxC_Attach:
;hxc_attach.c:16: MediaInit();
	call	_MediaInit
;hxc_attach.c:20: if ( fl_attach_media( MediaRead, MediaWrite ) != FAT_INIT_OK )
	ld	hl,_MediaWrite
	push	hl
	ld	hl,_MediaRead
	push	hl
	call	_fl_attach_media
	pop	af
	pop	af
;hxc_attach.c:22: *errorCode = HXCERROR_ATTACHMEDIAFAILED;
	pop	bc
	pop	de
	push	de
	push	bc
;hxc_attach.c:20: if ( fl_attach_media( MediaRead, MediaWrite ) != FAT_INIT_OK )
	ld	a,h
	or	l
	jr	Z,HxC_Attach_00102
;hxc_attach.c:22: *errorCode = HXCERROR_ATTACHMEDIAFAILED;
	ld	a, &03
	ld	(de),a
;hxc_attach.c:23: return OPERATIONRESULT_ERROR;
	ld	l, &00
	ret
HxC_Attach_00102:
;hxc_attach.c:27: *errorCode = HXCERROR_OK;
	xor	 a
	ld	(de),a
;hxc_attach.c:28: return OPERATIONRESULT_SUCCESS;
	ld	l, &01
	ret
_HxC_Attach_end:
;hxc_attach.c:32: char HxC_Detach(char *errorCode)
;	---------------------------------
; Function HxC_Detach
; ---------------------------------
_HxC_Detach_start:
_HxC_Detach:
;hxc_attach.c:34: if (!MediaQuit())
	call	_MediaQuit
;hxc_attach.c:36: *errorCode = HXCERROR_CMDSETTRACKPOS;
	pop	bc
	pop	de
	push	de
	push	bc
;hxc_attach.c:34: if (!MediaQuit())
	ld	a,h
	or	l
	jr	NZ,HxC_Detach_00102
;hxc_attach.c:36: *errorCode = HXCERROR_CMDSETTRACKPOS;
	ld	a, &05
	ld	(de),a
;hxc_attach.c:37: return OPERATIONRESULT_ERROR;
	ld	l, &00
	ret
HxC_Detach_00102:
;hxc_attach.c:40: *errorCode = HXCERROR_OK;
	xor	 a
	ld	(de),a
;hxc_attach.c:41: return OPERATIONRESULT_SUCCESS;
	ld	l, &01
	ret
_HxC_Detach_end:
