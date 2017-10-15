;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 8604 (May 11 2013) (MINGW32)
; This file was generated Sat Oct 14 23:36:42 2017
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
;ui_init.c:15: void InfiniteLoop()
;	---------------------------------
; Function InfiniteLoop
; ---------------------------------
_InfiniteLoop_start:
_InfiniteLoop:
;ui_init.c:19: __endasm;
	jr _InfiniteLoop
	ret
_InfiniteLoop_end:
;ui_init.c:23: void InitScreen()
;	---------------------------------
; Function InitScreen
; ---------------------------------
_InitScreen_start:
_InitScreen:
;ui_init.c:43: __endasm;
	ld a, 1
	call &BC0E
	call &BD19
	ld bc, &0000
	call &BC38
	xor a
	SetBlackPaletteLoop:
	ld bc, 0
	push af
	call &BC32
	pop af
	inc a
	cp 4
	jr nz, SetBlackPaletteLoop
	ret
_InitScreen_end:
;ui_init.c:47: void InitProgram()
;	---------------------------------
; Function InitProgram
; ---------------------------------
_InitProgram_start:
_InitProgram:
	push	ix
	ld	ix,0
	add	ix,sp
	push	af
	dec	sp
;ui_init.c:52: InitScreen();
	call	_InitScreen
;ui_init.c:54: directAccessStatusSector = GetStatusSector();
	call	_GetStatusSector
	ld	(ix-2 ),l
	ld	(ix-1 ),h
;ui_init.c:56: InitFont();
	call	_InitFont
;ui_init.c:57: InitUI();
	call	_InitUI
;ui_init.c:58: CLS();
	call	_CLS
;ui_init.c:74: __endasm;
	ld hl, &E000+80+80+80
	ld (hl), 255
	ld d, h
	ld e, l
	inc de
	ld bc, 80-1
	ldir
	ld hl, &E800+80+80+80
	ld (hl), 255
	ld d, h
	ld e, l
	inc de
	ld bc, 80-1
	ldir
;ui_init.c:76: PrintEmptyLine();
	call	_PrintEmptyLine
;ui_init.c:77: Println(" Press H key for help");
	ld	hl,__str_ui_init_0
	push	hl
	call	_Println
	pop	af
;ui_init.c:79: PrintEmptyLine();
	call	_PrintEmptyLine
;ui_init.c:81: Println(" Init..");
	ld	hl,__str_ui_init_1
	push	hl
	call	_Println
	pop	af
;ui_init.c:83: if (!HxC_Init(directAccessStatusSector, &errorCode))
	ld	hl, &0000
	add	hl,sp
	ld	e, l
	ld	d, h
	push	hl
	push	de
	ld	c,(ix-2 )
	ld	b,(ix-1 )
	push	bc
	call	_HxC_Init
	pop	af
	pop	af
	ld	a,l
	pop	hl
	or	 a
	jr	NZ,InitProgram_00102
;ui_init.c:85: StopError(errorCode);
	push	hl
	ld	a,(ix-3 )
	push	af
	inc	sp
	call	_StopError
	inc	sp
	pop	hl
InitProgram_00102:
;ui_init.c:88: PrintEmptyLine();
	push	hl
	call	_PrintEmptyLine
	pop	hl
;ui_init.c:89: Print(" Found firmware version ");
	ld	de,__str_ui_init_2
	push	hl
	push	de
	call	_Print
	pop	af
	pop	hl
;ui_init.c:90: Println(directAccessStatusSector->FIRMWAREVERSION);
	ld	a,(ix-2 )
	add	a,  &08
	ld	e,a
	ld	a,(ix-1 )
	adc	a,  &00
	ld	d,a
	push	hl
	push	de
	call	_Println
	pop	af
	pop	hl
;ui_init.c:92: if (!HxC_Attach(&errorCode))
	ld	e, l
	ld	d, h
	push	hl
	push	de
	call	_HxC_Attach
	pop	af
	ld	a,l
	pop	hl
	or	 a
	jr	NZ,InitProgram_00104
;ui_init.c:94: StopError(errorCode);
	push	hl
	ld	a,(ix-3 )
	push	af
	inc	sp
	call	_StopError
	inc	sp
	pop	hl
InitProgram_00104:
;ui_init.c:97: if (!HxC_ReadConfigFile(&errorCode))
	push	hl
	call	_HxC_ReadConfigFile
	pop	af
	ld	a,l
	or	 a
	jr	NZ,InitProgram_00106
;ui_init.c:99: StopError(errorCode);
	ld	a,(ix-3 )
	push	af
	inc	sp
	call	_StopError
	inc	sp
InitProgram_00106:
;ui_init.c:102: SelectSlotInConfig();
	call	_SelectSlotInConfig
	ld	sp,ix
	pop	ix
	ret
_InitProgram_end:
__str_ui_init_0:
	db " Press H key for help"
	db  &00
__str_ui_init_1:
	db " Init.."
	db  &00
__str_ui_init_2:
	db " Found firmware version "
	db  &00
