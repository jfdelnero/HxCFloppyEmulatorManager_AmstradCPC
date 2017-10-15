;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 8604 (May 11 2013) (MINGW32)
; This file was generated Sat Oct 14 23:36:41 2017
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
_StatusSector:
	ds 33
_SelectedSlot:
	ds 1
_LastSetSlot:
	ds 1
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
;ui_global.c:25: struct DirectAccessStatusSector *GetStatusSector()
;	---------------------------------
; Function GetStatusSector
; ---------------------------------
_GetStatusSector_start:
_GetStatusSector:
;ui_global.c:27: return &StatusSector;
	ld	hl,_StatusSector
	ret
_GetStatusSector_end:
;ui_global.c:31: char GetSelectedSlot()
;	---------------------------------
; Function GetSelectedSlot
; ---------------------------------
_GetSelectedSlot_start:
_GetSelectedSlot:
;ui_global.c:33: return SelectedSlot;
	ld	iy,_SelectedSlot
	ld	l,(iy+0 )
	ret
_GetSelectedSlot_end:
;ui_global.c:37: char SetSelectedSlot(char selectedSlot)
;	---------------------------------
; Function SetSelectedSlot
; ---------------------------------
_SetSelectedSlot_start:
_SetSelectedSlot:
;ui_global.c:39: SelectedSlot = selectedSlot;
	ld	iy,2
	add	iy,sp
	ld	a,(iy+0 )
	ld	iy,_SelectedSlot
	ld	(iy+0 ),a
	ret
_SetSelectedSlot_end:
;ui_global.c:43: char GetLastSetSlot()
;	---------------------------------
; Function GetLastSetSlot
; ---------------------------------
_GetLastSetSlot_start:
_GetLastSetSlot:
;ui_global.c:45: return LastSetSlot;
	ld	iy,_LastSetSlot
	ld	l,(iy+0 )
	ret
_GetLastSetSlot_end:
;ui_global.c:49: char SetLastSetSlot(char lastSetSlot)
;	---------------------------------
; Function SetLastSetSlot
; ---------------------------------
_SetLastSetSlot_start:
_SetLastSetSlot:
;ui_global.c:51: LastSetSlot = lastSetSlot;
	ld	iy,2
	add	iy,sp
	ld	a,(iy+0 )
	ld	iy,_LastSetSlot
	ld	(iy+0 ),a
	ret
_SetLastSetSlot_end:
