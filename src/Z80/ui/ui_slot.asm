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
;ui_slot.c:17: void ShowSlots()
;	---------------------------------
; Function ShowSlots
; ---------------------------------
_ShowSlots_start:
_ShowSlots:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-34
	add	hl,sp
	ld	sp,hl
;ui_slot.c:30: CLS();
	call	_CLS
;ui_slot.c:32: PrintEmptyLine();
	call	_PrintEmptyLine
;ui_slot.c:33: Println(" Slot list");
	ld	hl,__str_ui_slot_0
	push	hl
	call	_Println
	pop	af
;ui_slot.c:34: PrintEmptyLine();
	call	_PrintEmptyLine
;ui_slot.c:36: for (iSlot = 1; iSlot < SLOTCOUNT; iSlot++ )
	ld	hl, &0002
	add	hl,sp
	ld	(ix-4 ),l
	ld	(ix-3 ),h
	ld	a,(ix-4 )
	ld	(ix-6 ),a
	ld	a,(ix-3 )
	ld	(ix-5 ),a
	ld	(ix-8 ), &01
	ld	(ix-7 ), &00
	ld	(ix-2 ), &2E
	ld	(ix-1 ), &00
ShowSlots_00105:
;ui_slot.c:38: slot = &slots[ iSlot ];
	ld	a,(ix-2 )
	add	a,  &00
	ld	(ix-34 ),a
	ld	a,(ix-1 )
	adc	a,  &1D
	ld	(ix-33 ),a
;ui_slot.c:40: Print(" ");
	ld	hl,__str_ui_slot_1
	push	hl
	call	_Print
	pop	af
;ui_slot.c:41: PrintUInt8_WithZero(iSlot);
	ld	h,(ix-8 )
	push	hl
	inc	sp
	call	_PrintUInt8_WithZero
	inc	sp
;ui_slot.c:42: Print(" ");
	ld	hl,__str_ui_slot_1
	push	hl
	call	_Print
	pop	af
;ui_slot.c:44: if (slot->DirEnt.size>0)
	pop	hl
	push	hl
	ld	de,  &0011
	add	hl, de
	ld	c,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	a, (hl)
	or	 e
	or	 d
	or	c
	jr	Z,ShowSlots_00102
;ui_slot.c:46: z80_memcpy(slotLabel, slot->DirEnt.longName, 16 );
	ld	a,(ix-34 )
	add	a,  &15
	ld	l,a
	ld	a,(ix-33 )
	adc	a,  &00
	ld	h,a
	ld	e,(ix-4 )
	ld	d,(ix-3 )
	ld	bc, &0010
	push	bc
	push	hl
	push	de
	call	_z80_memcpy
	ld	hl, &0006
	add	hl,sp
	ld	sp,hl
;ui_slot.c:47: slotLabel[16]=0;
	ld	a,(ix-4 )
	add	a,  &10
	ld	l,a
	ld	a,(ix-3 )
	adc	a,  &00
	ld	h,a
	ld	(hl), &00
;ui_slot.c:48: Println(slotLabel);
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	push	hl
	call	_Println
	pop	af
	jr	ShowSlots_00106
ShowSlots_00102:
;ui_slot.c:52: PrintEmptyLine();	
	call	_PrintEmptyLine
ShowSlots_00106:
;ui_slot.c:36: for (iSlot = 1; iSlot < SLOTCOUNT; iSlot++ )
	ld	a,(ix-2 )
	add	a,  &2E
	ld	(ix-2 ),a
	ld	a,(ix-1 )
	adc	a,  &00
	ld	(ix-1 ),a
	inc	(ix-8 )
	jr	NZ,ShowSlots_00119
	inc	(ix-7 )
ShowSlots_00119:
	ld	a,(ix-8 )
	sub	  &10
	ld	a,(ix-7 )
	rla
	ccf
	rra
	sbc	a,  &80
	jp	C,ShowSlots_00105
;ui_slot.c:56: PrintEmptyLine();
	call	_PrintEmptyLine
;ui_slot.c:57: Println(" Press a key..");
	ld	hl,__str_ui_slot_2
	push	hl
	call	_Println
	pop	af
;ui_slot.c:59: WaitKey();
	call	_WaitKey
	ld	sp,ix
	pop	ix
	ret
_ShowSlots_end:
__str_ui_slot_0:
	db " Slot list"
	db  &00
__str_ui_slot_1:
	db " "
	db  &00
__str_ui_slot_2:
	db " Press a key.."
	db  &00
;ui_slot.c:63: void PrevSlot()
;	---------------------------------
; Function PrevSlot
; ---------------------------------
_PrevSlot_start:
_PrevSlot:
;ui_slot.c:67: selectedSlot = GetSelectedSlot();
	call	_GetSelectedSlot
	ld	d,l
;ui_slot.c:69: if (selectedSlot==1)
	ld	a,d
	dec	a
	jr	NZ,PrevSlot_00102
;ui_slot.c:71: selectedSlot = SLOTCOUNT-1;
	ld	d, &0F
	jr	PrevSlot_00103
PrevSlot_00102:
;ui_slot.c:75: selectedSlot--;
	dec	d
PrevSlot_00103:
;ui_slot.c:78: SetSelectedSlot(selectedSlot);
	push	de
	inc	sp
	call	_SetSelectedSlot
	inc	sp
;ui_slot.c:80: RefreshPathSlot();
	jp	_RefreshPathSlot
_PrevSlot_end:
;ui_slot.c:84: void NextSlot()
;	---------------------------------
; Function NextSlot
; ---------------------------------
_NextSlot_start:
_NextSlot:
;ui_slot.c:88: selectedSlot = GetSelectedSlot();
	call	_GetSelectedSlot
	ld	h,l
;ui_slot.c:90: if (selectedSlot==SLOTCOUNT-1)
	ld	a,h
	sub	  &0F
	jr	NZ,NextSlot_00102
;ui_slot.c:92: selectedSlot = 1;
	ld	h, &01
	jr	NextSlot_00103
NextSlot_00102:
;ui_slot.c:96: selectedSlot++;
	inc	h
NextSlot_00103:
;ui_slot.c:99: SetSelectedSlot(selectedSlot);
	push	hl
	inc	sp
	call	_SetSelectedSlot
	inc	sp
;ui_slot.c:101: RefreshPathSlot();
	jp	_RefreshPathSlot
_NextSlot_end:
;ui_slot.c:105: void SelectSlotInConfig()
;	---------------------------------
; Function SelectSlotInConfig
; ---------------------------------
_SelectSlotInConfig_start:
_SelectSlotInConfig:
;ui_slot.c:112: slot = configFile->slot_index;
	ld	a,( &1B17)
;ui_slot.c:114: if (slot!=0)
	or	 a
	jr	Z,SelectSlotInConfig_00102
;ui_slot.c:116: SetSelectedSlot(slot);
	push	af
	inc	sp
	call	_SetSelectedSlot
	inc	sp
	ret
SelectSlotInConfig_00102:
;ui_slot.c:120: SetSelectedSlot(1);
	ld	a, &01
	push	af
	inc	sp
	call	_SetSelectedSlot
	inc	sp
	ret
_SelectSlotInConfig_end:
