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
_YPos:
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
;ui_navigate.c:21: char IsDirEntryEmpty(char yPos)
;	---------------------------------
; Function IsDirEntryEmpty
; ---------------------------------
_IsDirEntryEmpty_start:
_IsDirEntryEmpty:
;ui_navigate.c:25: yPos -= START_Y;
	ld	hl,2
	add	hl,sp
	ld	a,(hl)
	add	a, &FC
	ld	(hl),a
;ui_navigate.c:29: if ( dirEntries[yPos].longName[0] == 0 )
	ld	hl, 2+0
	add	hl, sp
	ld	c, (hl)
	ld	a, c
	rlc	a
	sbc	a, a
	ld	b, a
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	bc, &2500
	add	hl,bc
	ld	de,  &0015
	add	hl, de
	ld	a,(hl)
	or	 a
	jr	NZ,IsDirEntryEmpty_00102
;ui_navigate.c:31: return 1;
	ld	l, &01
	ret
IsDirEntryEmpty_00102:
;ui_navigate.c:34: return 0;
	ld	l, &00
	ret
_IsDirEntryEmpty_end:
;ui_navigate.c:38: void InitNavigate()
;	---------------------------------
; Function InitNavigate
; ---------------------------------
_InitNavigate_start:
_InitNavigate:
;ui_navigate.c:40: YPos = START_Y;
	ld	hl,_YPos + 0
	ld	(hl),  &04
	ret
_InitNavigate_end:
;ui_navigate.c:44: void UpdateNavigate()
;	---------------------------------
; Function UpdateNavigate
; ---------------------------------
_UpdateNavigate_start:
_UpdateNavigate:
;ui_navigate.c:46: while ( IsDirEntryEmpty( YPos ) == 1 )
UpdateNavigate_00101:
	ld	a,(_YPos)
	push	af
	inc	sp
	call	_IsDirEntryEmpty
	inc	sp
	dec	l
	jr	NZ,UpdateNavigate_00103
;ui_navigate.c:48: YPos--;
	ld	hl, _YPos+0
	dec	(hl)
	jr	UpdateNavigate_00101
UpdateNavigate_00103:
;ui_navigate.c:51: InvertLine(YPos);
	ld	a,(_YPos)
	push	af
	inc	sp
	call	_InvertLine
	inc	sp
	ret
_UpdateNavigate_end:
;ui_navigate.c:55: void Up()
;	---------------------------------
; Function Up
; ---------------------------------
_Up_start:
_Up:
;ui_navigate.c:57: if (YPos==START_Y)
	ld	a,(_YPos + 0)
	sub	  &04
	jr	NZ,Up_00104
;ui_navigate.c:59: if ( IsFirstPage()==0 )
	call	_IsFirstPage
	ld	a,l
	or	 a
	jr	NZ,Up_00102
;ui_navigate.c:61: YPos = END_Y;
	ld	hl,_YPos + 0
	ld	(hl),  &18
Up_00102:
;ui_navigate.c:63: Left();
;ui_navigate.c:64: return;
	jp	_Left
Up_00104:
;ui_navigate.c:67: InvertLine(YPos);
	ld	a,(_YPos)
	push	af
	inc	sp
	call	_InvertLine
	inc	sp
;ui_navigate.c:68: YPos--;
	ld	hl, _YPos+0
	dec	(hl)
;ui_navigate.c:69: InvertLine(YPos);
	ld	a,(_YPos)
	push	af
	inc	sp
	call	_InvertLine
	inc	sp
	ret
_Up_end:
;ui_navigate.c:73: void Down()
;	---------------------------------
; Function Down
; ---------------------------------
_Down_start:
_Down:
;ui_navigate.c:77: if (YPos==END_Y)
	ld	a,(_YPos + 0)
	sub	  &18
	jr	NZ,Down_00104
;ui_navigate.c:79: prevPage = GetPage();
	call	_GetPage
	ld	d,l
;ui_navigate.c:81: YPos = START_Y;
	ld	hl,_YPos + 0
	ld	(hl),  &04
;ui_navigate.c:82: BrowseNextPage();
	push	de
	call	_BrowseNextPage
	call	_GetPage
	ld	b,l
	pop	de
	ld	a,d
	sub	 b
	ret	NZ
;ui_navigate.c:86: YPos=END_Y;
	ld	hl,_YPos + 0
	ld	(hl),  &18
;ui_navigate.c:88: return;
	ret
Down_00104:
;ui_navigate.c:91: if (IsDirEntryEmpty(YPos+1)==1)
	ld	iy,_YPos
	ld	h,(iy+0 )
	inc	h
	push	hl
	inc	sp
	call	_IsDirEntryEmpty
	inc	sp
	dec	l
	ret	Z
	jr	Down_00106
;ui_navigate.c:93: return;
	ret
Down_00106:
;ui_navigate.c:96: InvertLine(YPos);
	ld	a,(_YPos)
	push	af
	inc	sp
	call	_InvertLine
	inc	sp
;ui_navigate.c:97: YPos++;
	ld	hl, _YPos+0
	inc	(hl)
;ui_navigate.c:98: InvertLine(YPos);
	ld	a,(_YPos)
	push	af
	inc	sp
	call	_InvertLine
	inc	sp
	ret
_Down_end:
;ui_navigate.c:102: void Left()
;	---------------------------------
; Function Left
; ---------------------------------
_Left_start:
_Left:
;ui_navigate.c:107: if ( IsFirstPage()==1 )
	call	_IsFirstPage
	dec	l
	jr	NZ,Left_00108
;ui_navigate.c:109: pathLen = (unsigned char) z80_strlen( (char*)BROWSE_CURRENTPATH );
	ld	hl, &1700
	push	hl
	call	_z80_strlen
	pop	af
	ld	e,l
;ui_navigate.c:111: if ( pathLen>1 )
	ld	a, &01
	sub	 e
	ret	NC
;ui_navigate.c:115: path[pathLen-1] = 0;
	ld	c,e
	ld	b, &00
	dec	bc
	ld	hl, &1700
	add	hl,bc
	ld	(hl), &00
;ui_navigate.c:116: while( pathLen && path[pathLen-1] != '/' )
Left_00102:
	ld	a,e
	or	 a
	jr	Z,Left_00104
	ld	c,e
	ld	b, &00
	dec	bc
	ld	hl, &1700
	add	hl,bc
	ld	a,(hl)
	sub	  &2F
	jr	Z,Left_00104
;ui_navigate.c:118: path[pathLen-1] = 0;
	ld	(hl), &00
;ui_navigate.c:119: pathLen--;
	dec	e
	jr	Left_00102
Left_00104:
;ui_navigate.c:122: BrowsePath();
	jp	_BrowsePath
Left_00108:
;ui_navigate.c:127: BrowsePrevPage();
	jp	_BrowsePrevPage
_Left_end:
;ui_navigate.c:132: void Right()
;	---------------------------------
; Function Right
; ---------------------------------
_Right_start:
_Right:
;ui_navigate.c:139: dirIndex = YPos - START_Y;
	ld	a,(_YPos + 0)
	add	a, &FC
;ui_navigate.c:140: dirEntry = &dirEntries[dirIndex];
	ld	c,a
	rlc	a
	sbc	a, a
	ld	b, a
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	bc, &2500
	add	hl,bc
;ui_navigate.c:142: if (dirEntry->attributes &  &10)
	ld	de,  &000C
	add	hl, de
	bit	4,(hl)
	jr	Z,Right_00104
;ui_navigate.c:145: Select();
	jp	_Select
Right_00104:
;ui_navigate.c:149: if ( IsLastPage()==0 )
	call	_IsLastPage
	ld	a,l
	or	 a
	ret	NZ
;ui_navigate.c:151: BrowseNextPage();
	jp	_BrowseNextPage
_Right_end:
;ui_navigate.c:157: void Select()
;	---------------------------------
; Function Select
; ---------------------------------
_Select_start:
_Select:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-11
	add	hl,sp
	ld	sp,hl
;ui_navigate.c:173: dirIndex = YPos - START_Y;
	ld	a,(_YPos + 0)
	add	a, &FC
;ui_navigate.c:174: dirEntry = &dirEntries[dirIndex];
	ld	c,a
	rlc	a
	sbc	a, a
	ld	b, a
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	ld	a,l
	add	a,  &00
	ld	(ix-11 ),a
	ld	a,h
	adc	a,  &25
	ld	(ix-10 ),a
;ui_navigate.c:176: if (dirEntry->attributes &  &10)
	pop	hl
	push	hl
	ld	de,  &000C
	add	hl, de
	bit	4,(hl)
	jp	Z,Select_00120
;ui_navigate.c:179: subDir = &dirEntry->longName[0];
	ld	a,(ix-11 )
	add	a,  &15
	ld	(ix-7 ),a
	ld	a,(ix-10 )
	adc	a,  &00
	ld	(ix-6 ),a
;ui_navigate.c:181: pathLen = (unsigned char) z80_strlen( (char*)BROWSE_CURRENTPATH );
	ld	hl, &1700
	push	hl
	call	_z80_strlen
	pop	af
	ld	(ix-9 ),l
;ui_navigate.c:183: if ( pathLen && (subDir[0]=='.') && (subDir[1]=='.') )
	ld	l,(ix-7 )
	ld	h,(ix-6 )
	ld	a,(hl)
	ld	(ix-1 ), a
	sub	  &2E
	jr	NZ,Select_00167
	ld	a, &01
	jr	Select_00168
Select_00167:
	xor	a
Select_00168:
	ld	(ix-2 ),a
	ld	a,(ix-9 )
	or	 a
	jr	Z,Select_00115
	ld	a,(ix-2 )
	or	 a
	jr	Z,Select_00115
	ld	l,(ix-7 )
	ld	h,(ix-6 )
	inc	hl
	ld	a,(hl)
	sub	  &2E
	jr	NZ,Select_00115
;ui_navigate.c:185: path[pathLen-1] = 0;
	ld	l,(ix-9 )
	ld	h, &00
	ld	bc, &1700-1
	add	hl,bc
	ld	(hl), &00
;ui_navigate.c:186: while( pathLen && path[pathLen-1] != '/' )
	ld	e,(ix-9 )
Select_00102:
	ld	a,e
	or	 a
	jr	Z,Select_00104
	ld	l,e
	ld	h, &00
	ld	bc, &1700-1
	add	hl,bc
	ld	a,(hl)
	sub	  &2F
	jr	Z,Select_00104
;ui_navigate.c:188: path[pathLen-1] = 0;
	ld	(hl), &00
;ui_navigate.c:189: pathLen--;
	dec	e
	jr	Select_00102
Select_00104:
;ui_navigate.c:192: BrowsePath();
	call	_BrowsePath
	jp	Select_00122
Select_00115:
;ui_navigate.c:196: if ( subDir[0]!='.')
	ld	a,(ix-2 )
	or	 a
	jp	NZ,Select_00122
;ui_navigate.c:198: j = pathLen;
	ld	a,(ix-9 )
	ld	(ix-8 ),a
;ui_navigate.c:200: c = subDir[i];
	ld	e,(ix-1 )
;ui_navigate.c:201: while(( c >= 32 ) && (c <= 127))
	ld	(ix-5 ), &00
Select_00106:
	ld	a,e
	sub	  &20
	jr	C,Select_00108
	ld	a, &7F
	sub	 e
	jr	C,Select_00108
;ui_navigate.c:203: path[j+i] = c;
	ld	l,(ix-8 )
	ld	h, &00
	ld	c,(ix-5 )
	ld	b, &00
	add	hl,bc
	ld	bc, &1700
	add	hl,bc
	ld	(hl),e
;ui_navigate.c:204: i++;
	inc	(ix-5 )
;ui_navigate.c:205: c = subDir[i];
	ld	a,(ix-7 )
	add	a, (ix-5 )
	ld	l,a
	ld	a,(ix-6 )
	adc	a,  &00
	ld	h,a
	ld	e,(hl)
	jr	Select_00106
Select_00108:
;ui_navigate.c:208: i += j;
	ld	a,(ix-5 )
	add	a, (ix-8 )
	ld	e,a
;ui_navigate.c:210: while ( path[i-1] == 32 )
Select_00109:
	ld	(ix-4 ),e
	ld	(ix-3 ), &00
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	ld	bc, &1700-1
	add	hl,bc
	ld	a,(hl)
	sub	  &20
	jr	NZ,Select_00111
;ui_navigate.c:212: i--;
	dec	e
	jr	Select_00109
Select_00111:
;ui_navigate.c:214: path[i]='/';
	ld	hl, &1700
	ld	d, &00
	add	hl, de
	ld	(hl), &2F
;ui_navigate.c:215: path[i+1]=0;
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	ld	bc, &1700+1
	add	hl,bc
	ld	(hl), &00
;ui_navigate.c:217: BrowsePath();
	call	_BrowsePath
	jr	Select_00122
Select_00120:
;ui_navigate.c:224: slotIndex = GetSelectedSlot();
	call	_GetSelectedSlot
	ld	c,l
;ui_navigate.c:225: slot = &slots[slotIndex];
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
	ld	de, &1D00
	add	hl,de
;ui_navigate.c:227: z80_memcpy( slot, dirEntry, sizeof(struct DirectoryEntry));
	pop	de
	push	de
	push	hl
	pop	iy
	push	bc
	ld	hl, &0026
	push	hl
	push	de
	push	iy
	call	_z80_memcpy
	ld	hl, &0006
	add	hl,sp
	ld	sp,hl
	pop	bc
;ui_navigate.c:229: SetLastSetSlot(slotIndex);
	ld	a,c
	push	af
	inc	sp
	call	_SetLastSetSlot
	inc	sp
;ui_navigate.c:231: NextSlot();
	call	_NextSlot
Select_00122:
	ld	sp,ix
	pop	ix
	ret
_Select_end:

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

