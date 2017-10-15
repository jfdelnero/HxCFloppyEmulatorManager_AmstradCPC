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
;hxc_error.c:7: char *GetErrorString(char errorCode)
;	---------------------------------
; Function GetErrorString
; ---------------------------------
_GetErrorString_start:
_GetErrorString:
;hxc_error.c:49: __endasm;
	push ix
	ld ix, 0
	add ix, sp
	ld b, 0
	ld c, (ix+4)
	ld hl, ErrorStrings
	add hl, bc
	add hl, bc
	ld a, (hl)
	inc hl
	ld h, (hl)
	ld l, a
	pop ix
	ret
	ErrorStrings:
	dw HXCERROR_OK_string
	dw HXCERROR_FLOPPYACCESSERROR_string
	dw HXCERROR_BADSIGNATURE_string
	dw HXCERROR_ATTACHMEDIAFAILED_string
	dw HXCERROR_READCONFIGFILEERROR_string
	dw HXCERROR_CMDSETTRACKPOS_string
	HXCERROR_OK_string:
	db "HXCERROR_OK", 0
	HXCERROR_FLOPPYACCESSERROR_string:
	db "HXCERROR_FLOPPYACCESSERROR", 0
	HXCERROR_BADSIGNATURE_string:
	db "HXCERROR_BADSIGNATURE", 0
	HXCERROR_ATTACHMEDIAFAILED_string:
	db "HXCERROR_ATTACHMEDIAFAILED", 0
	HXCERROR_READCONFIGFILEERROR_string:
	db "HXCERROR_READCONFIGFILEERROR", 0
	HXCERROR_CMDSETTRACKPOS_string:
	db "HXCERROR_CMDSETTRACKPOS", 0
	ret
_GetErrorString_end:
