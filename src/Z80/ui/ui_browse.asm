;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 8604 (May 11 2013) (MINGW32)
; This file was generated Sun Oct 15 00:38:10 2017
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
_temp_file_list_status:
	ds 9
_dir_entry:
	ds 269
_CurrentPage:
	ds 1
_EndPage:
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
;ui_browse.c:25: char GetPage()
;	---------------------------------
; Function GetPage
; ---------------------------------
_GetPage_start:
_GetPage:
;ui_browse.c:27: return CurrentPage;
	ld	iy,_CurrentPage
	ld	l,(iy+0 )
	ret
_GetPage_end:
;ui_browse.c:31: char IsFirstPage()
;	---------------------------------
; Function IsFirstPage
; ---------------------------------
_IsFirstPage_start:
_IsFirstPage:
;ui_browse.c:33: if ( CurrentPage == 0 )
	ld	a,(_CurrentPage + 0)
	or	 a
	jr	NZ,IsFirstPage_00102
;ui_browse.c:35: return 1;
	ld	l, &01
	ret
IsFirstPage_00102:
;ui_browse.c:38: return 0;
	ld	l, &00
	ret
_IsFirstPage_end:
;ui_browse.c:42: char IsLastPage()
;	---------------------------------
; Function IsLastPage
; ---------------------------------
_IsLastPage_start:
_IsLastPage:
;ui_browse.c:44: if ( EndPage == CurrentPage )
	ld	a,(_EndPage + 0)
	ld	iy,_CurrentPage
	sub	 (iy+0 )
	jr	NZ,IsLastPage_00102
;ui_browse.c:46: return 1;
	ld	l, &01
	ret
IsLastPage_00102:
;ui_browse.c:49: return 0;
	ld	l, &00
	ret
_IsLastPage_end:
;ui_browse.c:53: char IsHFEFilename(char *filename)
;	---------------------------------
; Function IsHFEFilename
; ---------------------------------
_IsHFEFilename_start:
_IsHFEFilename:
;ui_browse.c:113: __endasm;
	push ix
	ld ix, 0
	add ix, sp
	ld l, (ix+4) ; buffer
	ld h, (ix+5)
	pop ix
	SearchLoop:
	ld a, (hl)
	or a
	jr z, NotFound
	cp '.'
	jr nz, NextChar
	ld b, h
	ld c, l
	TestH:
	inc bc
	ld a, (bc)
	cp 'h'
	jr z, TestF
	cp 'H'
	jr nz, NextChar
	TestF:
	inc bc
	ld a, (bc)
	cp 'f'
	jr z, TestE
	cp 'F'
	jr nz, NextChar
	TestE:
	inc bc
	ld a, (bc)
	cp 'e'
	jr z, Found
	cp 'E'
	jr nz, NextChar
	Found:
	ld l, 1
	ret
	NextChar:
	inc hl
	jr SearchLoop
	NotFound:
	ld l, 0
	ret
	ret
_IsHFEFilename_end:
;ui_browse.c:117: char IsDSKFilename(char *filename)
;	---------------------------------
; Function IsDSKFilename
; ---------------------------------
_IsDSKFilename_start:
_IsDSKFilename:
;ui_browse.c:177: __endasm;
	push ix
	ld ix, 0
	add ix, sp
	ld l, (ix+4) ; buffer
	ld h, (ix+5)
	pop ix
	DSK_SearchLoop:
	ld a, (hl)
	or a
	jr z, DSK_NotFound
	cp '.'
	jr nz, DSK_NextChar
	ld b, h
	ld c, l
	DSK_TestD:
	inc bc
	ld a, (bc)
	cp 'd'
	jr z, DSK_TestS
	cp 'D'
	jr nz, DSK_NextChar
	DSK_TestS:
	inc bc
	ld a, (bc)
	cp 's'
	jr z, DSK_TestK
	cp 'S'
	jr nz, DSK_NextChar
	DSK_TestK:
	inc bc
	ld a, (bc)
	cp 'k'
	jr z, DSK_Found
	cp 'K'
	jr nz, DSK_NextChar
	DSK_Found:
	ld l, 1
	ret
	DSK_NextChar:
	inc hl
	jr DSK_SearchLoop
	DSK_NotFound:
	ld l, 0
	ret
	ret
_IsDSKFilename_end:
;ui_browse.c:181: void BrowsePage()
;	---------------------------------
; Function BrowsePage
; ---------------------------------
_BrowsePage_start:
_BrowsePage:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-14
	add	hl,sp
	ld	sp,hl
;ui_browse.c:199: dirListStatus = &dirListAllStatuses[CurrentPage];
	ld	hl,_CurrentPage + 0
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
	ld	bc, &0C00
	add	hl,bc
;ui_browse.c:200: nextDirListStatus = dirListStatus+1;
	ld	a,l
	add	a,  &09
	ld	(ix-14 ),a
	ld	a,h
	adc	a,  &00
	ld	(ix-13 ),a
;ui_browse.c:202: z80_memcpy( nextDirListStatus, dirListStatus, sizeof(struct fs_dir_list_status));
	pop	de
	push	de
	ld	bc, &0009
	push	bc
	push	hl
	push	de
	call	_z80_memcpy
	ld	hl, &0006
	add	hl,sp
	ld	sp,hl
;ui_browse.c:206: for (i=0; i<SCREEN_MAXSLOTS; i++)
	ld	(ix-12 ), &00
	ld	(ix-11 ), &00
	ld	(ix-10 ), &00
	ld	(ix-9 ), &25
BrowsePage_00126:
;ui_browse.c:266: readdir_res = fl_list_readdir(nextDirListStatus, &dir_entry);
	ld	hl,_dir_entry
	ld	c, l
	ld	b, h
	pop	hl
	push	hl
	push	bc
	push	hl
	call	_fl_list_readdir
	pop	af
	pop	af
	ld	c, l
	ld	b, h
;ui_browse.c:268: if ( readdir_res )
	ld	a,b
	or	c
	jr	Z,BrowsePage_00114
;ui_browse.c:270: if (dir_entry.is_dir)
	ld	hl, _dir_entry + 260
	ld	h,(hl)
;ui_browse.c:274: i--;
	ld	e,(ix-12 )
	ld	d,(ix-11 )
	dec	de
;ui_browse.c:270: if (dir_entry.is_dir)
	ld	a,h
	or	 a
	jr	Z,BrowsePage_00109
;ui_browse.c:272: if ((dir_entry.filename[0]=='.')&&(dir_entry.filename[1]!='.'))
	ld	a, (_dir_entry + 0)
	sub	  &2E
	jr	NZ,BrowsePage_00115
	ld	a, (_dir_entry + 1)
	sub	  &2E
	jr	Z,BrowsePage_00115
;ui_browse.c:274: i--;
	ld	(ix-12 ),e
	ld	(ix-11 ),d
;ui_browse.c:275: continue;
	jp	BrowsePage_00124
BrowsePage_00109:
;ui_browse.c:280: if ( IsHFEFilename(dir_entry.filename) == 0 )
	ld	hl,_dir_entry
	push	bc
	push	de
	push	hl
	call	_IsHFEFilename
	pop	af
	ld	a,l
	pop	de
	pop	bc
	or	 a
	jr	NZ,BrowsePage_00115
;ui_browse.c:282: if ( IsDSKFilename(dir_entry.filename) == 0 )
	ld	hl,_dir_entry
	push	bc
	push	de
	push	hl
	call	_IsDSKFilename
	pop	af
	ld	a,l
	pop	de
	pop	bc
	or	 a
	jr	NZ,BrowsePage_00115
;ui_browse.c:284: i--;
	ld	(ix-12 ),e
	ld	(ix-11 ),d
;ui_browse.c:285: continue;
	jp	BrowsePage_00124
BrowsePage_00114:
;ui_browse.c:292: if ( i == 0 )
	ld	a,(ix-11 )
	or	(ix-12 )
	jr	NZ,BrowsePage_00115
;ui_browse.c:294: CurrentPage--;
	ld	hl, _CurrentPage+0
	dec	(hl)
;ui_browse.c:295: return;
	jp	BrowsePage_00127
BrowsePage_00115:
;ui_browse.c:299: z80_memcpy( dirEntries->longName, dir_entry.filename, 16);
	ld	a,(ix-10 )
	add	a,  &15
	ld	e,a
	ld	a,(ix-9 )
	adc	a,  &00
	ld	d,a
	push	de
	pop	iy
	push	bc
	push	de
	ld	hl, &0010
	push	hl
	ld	hl,_dir_entry
	push	hl
	push	iy
	call	_z80_memcpy
	ld	hl, &0006
	add	hl,sp
	ld	sp,hl
	pop	de
	pop	bc
;ui_browse.c:300: dirEntries->longName[16]=0;
	ld	hl, &0010
	add	hl,de
	ld	(hl), &00
;ui_browse.c:325: dirEntries->size = ENDIAN_32BIT(dir_entry.size);
	ld	a,(ix-10 )
	add	a,  &11
	ld	(ix-2 ),a
	ld	a,(ix-9 )
	adc	a,  &00
	ld	(ix-1 ),a
;ui_browse.c:302: if (readdir_res)
	ld	a,b
	or	c
	jp	Z,BrowsePage_00122
;ui_browse.c:304: if ( i == 0 )
	ld	a,(ix-11 )
	or	(ix-12 )
	jr	NZ,BrowsePage_00117
;ui_browse.c:306: CLS();
	call	_CLS
BrowsePage_00117:
;ui_browse.c:309: dir_entry.filename[34] = 0;
	ld	hl,_dir_entry + 34
	ld	(hl), &00
;ui_browse.c:311: if (dir_entry.is_dir)
	ld	hl,_dir_entry
	ld	de,  &0104
	add	hl, de
	ld	c,(hl)
;ui_browse.c:315: dirEntries->attributes =  &10;
	ld	a,(ix-10 )
	add	a,  &0C
	ld	(ix-8 ),a
	ld	a,(ix-9 )
	adc	a,  &00
	ld	(ix-7 ),a
;ui_browse.c:311: if (dir_entry.is_dir)
	ld	a,c
	or	 a
	jr	Z,BrowsePage_00119
;ui_browse.c:313: Print("<DIR> ");
	ld	hl,__str_ui_browse_0
	push	hl
	call	_Print
	pop	af
;ui_browse.c:315: dirEntries->attributes =  &10;
	ld	l,(ix-8 )
	ld	h,(ix-7 )
	ld	(hl), &10
	jr	BrowsePage_00120
BrowsePage_00119:
;ui_browse.c:319: dirEntries->attributes =  &00;
	ld	l,(ix-8 )
	ld	h,(ix-7 )
	ld	(hl), &00
BrowsePage_00120:
;ui_browse.c:322: PrintlnTab( dir_entry.filename );
	ld	hl,_dir_entry
	push	hl
	call	_PrintlnTab
	pop	af
;ui_browse.c:324: dirEntries->firstCluster = ENDIAN_32BIT(dir_entry.cluster);
	ld	a,(ix-10 )
	add	a,  &0D
	ld	e,a
	ld	a,(ix-9 )
	adc	a,  &00
	ld	d,a
	push	de
	ld	de, _dir_entry + 261
	ld	hl,  &000A
	add	hl, sp
	ex	de, hl
	ld	bc,  &0004
	ldir
	pop	de
	ld	hl,  &0008
	add	hl, sp
	ld	bc,  &0004
	ldir
;ui_browse.c:325: dirEntries->size = ENDIAN_32BIT(dir_entry.size);
	ld	de, (_dir_entry + 265)
	ld	bc, (_dir_entry + 267)
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	ld	(hl),e
	inc	hl
	ld	(hl),d
	inc	hl
	ld	(hl),c
	inc	hl
	ld	(hl),b
	jr	BrowsePage_00123
BrowsePage_00122:
;ui_browse.c:329: dirEntries->longName[0]=0;
	xor	 a
	ld	(de),a
;ui_browse.c:330: dirEntries->size=0;
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
	inc	hl
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;ui_browse.c:332: EndPage = CurrentPage;
	ld	a,(_CurrentPage + 0)
	ld	(_EndPage + 0),a
BrowsePage_00123:
;ui_browse.c:335: dirEntries += 1;
	ld	a,(ix-10 )
	add	a,  &26
	ld	(ix-10 ),a
	ld	a,(ix-9 )
	adc	a,  &00
	ld	(ix-9 ),a
BrowsePage_00124:
;ui_browse.c:206: for (i=0; i<SCREEN_MAXSLOTS; i++)
	inc	(ix-12 )
	jr	NZ,BrowsePage_00168
	inc	(ix-11 )
BrowsePage_00168:
	ld	a,(ix-12 )
	sub	  &15
	ld	a,(ix-11 )
	rla
	ccf
	rra
	sbc	a,  &80
	jp	C,BrowsePage_00126
;ui_browse.c:338: UpdateNavigate();
	call	_UpdateNavigate
BrowsePage_00127:
	ld	sp,ix
	pop	ix
	ret
_BrowsePage_end:
__str_ui_browse_0:
	db "<DIR> "
	db  &00
;ui_browse.c:342: void BrowsePath()
;	---------------------------------
; Function BrowsePath
; ---------------------------------
_BrowsePath_start:
_BrowsePath:
;ui_browse.c:349: z80_memset(dirEntries, 0,  &400); // sizeof(struct DirectoryEntry)*SCREEN_MAXSLOTS
	ld	hl, &0400
	push	hl
	xor	 a
	push	af
	inc	sp
	ld	h,  &25
	push	hl
	call	_z80_memset
	pop	af
	pop	af
	inc	sp
;ui_browse.c:355: RefreshPathSlot();
	call	_RefreshPathSlot
;ui_browse.c:359: fl_list_opendir(path, dirListStatus);
	ld	hl, &0C00
	push	hl
	ld	h,  &17
	push	hl
	call	_fl_list_opendir
	pop	af
	pop	af
;ui_browse.c:362: CurrentPage = 0;
	ld	hl,_CurrentPage + 0
	ld	(hl),  &00
;ui_browse.c:363: EndPage = 255;
	ld	hl,_EndPage + 0
	ld	(hl),  &FF
;ui_browse.c:365: BrowsePage();
	jp	_BrowsePage
_BrowsePath_end:
;ui_browse.c:369: void BrowsePrevPage()
;	---------------------------------
; Function BrowsePrevPage
; ---------------------------------
_BrowsePrevPage_start:
_BrowsePrevPage:
;ui_browse.c:371: CurrentPage--;		
	ld	hl, _CurrentPage+0
	dec	(hl)
;ui_browse.c:372: BrowsePage();
	jp	_BrowsePage
_BrowsePrevPage_end:
;ui_browse.c:376: void BrowseNextPage()
;	---------------------------------
; Function BrowseNextPage
; ---------------------------------
_BrowseNextPage_start:
_BrowseNextPage:
;ui_browse.c:378: CurrentPage++;
	ld	hl, _CurrentPage+0
	inc	(hl)
;ui_browse.c:379: BrowsePage();
	jp	_BrowsePage
_BrowseNextPage_end:
