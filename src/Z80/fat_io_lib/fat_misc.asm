;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 8604 (May 11 2013) (MINGW32)
; This file was generated Sat Oct 14 23:36:37 2017
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
;fat_misc.c:42: void fatfs_lfn_cache_init(struct lfn_cache *lfn, int wipeTable)
;	---------------------------------
; Function fatfs_lfn_cache_init
; ---------------------------------
_fatfs_lfn_cache_init_start:
_fatfs_lfn_cache_init:
	push	ix
	ld	ix,0
	add	ix,sp
	push	af
;fat_misc.c:46: lfn->no_of_strings = 0;
	ld	c,(ix+4 )
	ld	b,(ix+5 )
	ld	hl, &004F
	add	hl,bc
	ld	(hl), &00
;fat_misc.c:51: if (wipeTable)
	ld	a,(ix+7 )
	or	(ix+6 )
	jr	Z,fatfs_lfn_cache_init_00106
;fat_misc.c:52: for (i=0;i<MAX_LONGFILENAME_ENTRIES;i++)
	ld	hl, &0000
	ex	(sp), hl
	ld	de, &0000
fatfs_lfn_cache_init_00104:
;fat_misc.c:53: z80_memset(lfn->String[i],  &00, MAX_LFN_ENTRY_LENGTH);
	push	bc
	pop	iy
	add	iy, de
	push	bc
	push	de
	ld	hl, &000D
	push	hl
	xor	 a
	push	af
	inc	sp
	push	iy
	call	_z80_memset
	pop	af
	pop	af
	inc	sp
	pop	de
	pop	bc
;fat_misc.c:52: for (i=0;i<MAX_LONGFILENAME_ENTRIES;i++)
	ld	hl, &000D
	add	hl,de
	ex	de,hl
	inc	(ix-2 )
	jr	NZ,fatfs_lfn_cache_init_00115
	inc	(ix-1 )
fatfs_lfn_cache_init_00115:
	ld	a,(ix-2 )
	sub	  &05
	ld	a,(ix-1 )
	rla
	ccf
	rra
	sbc	a,  &80
	jr	C,fatfs_lfn_cache_init_00104
fatfs_lfn_cache_init_00106:
	ld	sp,ix
	pop	ix
	ret
_fatfs_lfn_cache_init_end:
;fat_misc.c:61: void fatfs_lfn_cache_entry(struct lfn_cache *lfn, unsigned char *entryBuffer)
;	---------------------------------
; Function fatfs_lfn_cache_entry
; ---------------------------------
_fatfs_lfn_cache_entry_start:
_fatfs_lfn_cache_entry:
	push	ix
	ld	ix,0
	add	ix,sp
	push	af
	push	af
;fat_misc.c:64: LFNIndex = entryBuffer[0] &  &1F;
	ld	e,(ix+6 )
	ld	d,(ix+7 )
	ld	a,(de)
	and	  &1F
	ld	c,a
;fat_misc.c:67: if (LFNIndex > MAX_LONGFILENAME_ENTRIES)
	ld	a, &05
	sub	 c
;fat_misc.c:68: return ;
	jp	C,fatfs_lfn_cache_entry_00112
;fat_misc.c:71: if (LFNIndex == 0)
	ld	a,c
	or	 a
;fat_misc.c:72: return ;
	jp	Z,fatfs_lfn_cache_entry_00112
;fat_misc.c:74: if (lfn->no_of_strings == 0)
	ld	a,(ix+4 )
	ld	(ix-2 ),a
	ld	a,(ix+5 )
	ld	(ix-1 ),a
	ld	a,(ix-2 )
	add	a,  &4F
	ld	(ix-4 ),a
	ld	a,(ix-1 )
	adc	a,  &00
	ld	(ix-3 ),a
	pop	hl
	push	hl
	ld	a,(hl)
	or	 a
	jr	NZ,fatfs_lfn_cache_entry_00106
;fat_misc.c:75: lfn->no_of_strings = LFNIndex;
	pop	hl
	push	hl
	ld	(hl),c
fatfs_lfn_cache_entry_00106:
;fat_misc.c:77: lfn->String[LFNIndex-1][0] = entryBuffer[1];
	dec	c
	ld	a,c
	add	a, a
	add	a, c
	add	a, a
	add	a, a
	add	a, c
	ld	(ix-4 ), a
	add	a, (ix-2 )
	ld	c,a
	ld	a, &00
	adc	a, (ix-1 )
	ld	b,a
	ld	l, e
	ld	h, d
	inc	hl
	ld	a,(hl)
	ld	(bc),a
;fat_misc.c:78: lfn->String[LFNIndex-1][1] = entryBuffer[3];
	ld	a,(ix-4 )
	add	a, (ix-2 )
	ld	c,a
	ld	a, &00
	adc	a, (ix-1 )
	ld	b,a
	push	bc
	pop	iy
	inc	iy
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	ld	a,(hl)
	ld	(iy+0 ), a
;fat_misc.c:79: lfn->String[LFNIndex-1][2] = entryBuffer[5];
	push	bc
	pop	iy
	inc	iy
	inc	iy
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	inc	hl
	ld	a,(hl)
	ld	(iy+0 ), a
;fat_misc.c:80: lfn->String[LFNIndex-1][3] = entryBuffer[7];
	push	bc
	pop	iy
	inc	iy
	inc	iy
	inc	iy
	ld	l, e
	ld	h, d
	push	bc
	ld	bc,  &0007
	add	hl, bc
	pop	bc
	ld	a,(hl)
	ld	(iy+0 ), a
;fat_misc.c:81: lfn->String[LFNIndex-1][4] = entryBuffer[9];
	ld	iy, &0004
	add	iy, bc
	ld	l, e
	ld	h, d
	push	bc
	ld	bc,  &0009
	add	hl, bc
	pop	bc
	ld	a,(hl)
	ld	(iy+0 ), a
;fat_misc.c:82: lfn->String[LFNIndex-1][5] = entryBuffer[ &0E];
	ld	iy, &0005
	add	iy, bc
	ld	l, e
	ld	h, d
	push	bc
	ld	bc,  &000E
	add	hl, bc
	pop	bc
	ld	a,(hl)
	ld	(iy+0 ), a
;fat_misc.c:83: lfn->String[LFNIndex-1][6] = entryBuffer[ &10];
	ld	iy, &0006
	add	iy, bc
	ld	l, e
	ld	h, d
	push	bc
	ld	bc,  &0010
	add	hl, bc
	pop	bc
	ld	a,(hl)
	ld	(iy+0 ), a
;fat_misc.c:84: lfn->String[LFNIndex-1][7] = entryBuffer[ &12];
	ld	iy, &0007
	add	iy, bc
	ld	l, e
	ld	h, d
	push	bc
	ld	bc,  &0012
	add	hl, bc
	pop	bc
	ld	a,(hl)
	ld	(iy+0 ), a
;fat_misc.c:85: lfn->String[LFNIndex-1][8] = entryBuffer[ &14];
	ld	iy, &0008
	add	iy, bc
	ld	l, e
	ld	h, d
	push	bc
	ld	bc,  &0014
	add	hl, bc
	pop	bc
	ld	a,(hl)
	ld	(iy+0 ), a
;fat_misc.c:86: lfn->String[LFNIndex-1][9] = entryBuffer[ &16];
	ld	iy, &0009
	add	iy, bc
	ld	l, e
	ld	h, d
	push	bc
	ld	bc,  &0016
	add	hl, bc
	pop	bc
	ld	a,(hl)
	ld	(iy+0 ), a
;fat_misc.c:87: lfn->String[LFNIndex-1][10] = entryBuffer[ &18];
	ld	iy, &000A
	add	iy, bc
	ld	l, e
	ld	h, d
	push	bc
	ld	bc,  &0018
	add	hl, bc
	pop	bc
	ld	a,(hl)
	ld	(iy+0 ), a
;fat_misc.c:88: lfn->String[LFNIndex-1][11] = entryBuffer[ &1C];
	ld	iy, &000B
	add	iy, bc
	ld	l, e
	ld	h, d
	push	bc
	ld	bc,  &001C
	add	hl, bc
	pop	bc
	ld	a,(hl)
	ld	(iy+0 ), a
;fat_misc.c:89: lfn->String[LFNIndex-1][12] = entryBuffer[ &1E];
	ld	iy, &000C
	add	iy, bc
	ex	de,hl
	ld	de,  &001E
	add	hl, de
	ld	a,(hl)
	ld	(iy+0 ), a
;fat_misc.c:91: for (i=0; i<MAX_LFN_ENTRY_LENGTH; i++)
	ld	d, &00
fatfs_lfn_cache_entry_00110:
;fat_misc.c:92: if (lfn->String[LFNIndex-1][i]== &FF)
	ld	l,d
	ld	h, &00
	add	hl,bc
	ld	a,(hl)
	inc	a
	jr	NZ,fatfs_lfn_cache_entry_00111
;fat_misc.c:93: lfn->String[LFNIndex-1][i] =  &20; // Replace with spaces
	ld	(hl), &20
fatfs_lfn_cache_entry_00111:
;fat_misc.c:91: for (i=0; i<MAX_LFN_ENTRY_LENGTH; i++)
	inc	d
	ld	a,d
	sub	  &0D
	jr	C,fatfs_lfn_cache_entry_00110
fatfs_lfn_cache_entry_00112:
	ld	sp,ix
	pop	ix
	ret
_fatfs_lfn_cache_entry_end:
;fat_misc.c:100: char* fatfs_lfn_cache_get(struct lfn_cache *lfn)
;	---------------------------------
; Function fatfs_lfn_cache_get
; ---------------------------------
_fatfs_lfn_cache_get_start:
_fatfs_lfn_cache_get:
;fat_misc.c:103: if (lfn->no_of_strings == MAX_LONGFILENAME_ENTRIES)
	pop	de
	pop	bc
	push	bc
	push	de
	push	bc
	pop	iy
	ld	l,(iy+79 )
	ld	a,l
	sub	  &05
	jr	NZ,fatfs_lfn_cache_get_00105
;fat_misc.c:104: lfn->Null = '\0';
	ld	hl, &004E
	add	hl,bc
	ld	(hl), &00
	jr	fatfs_lfn_cache_get_00106
fatfs_lfn_cache_get_00105:
;fat_misc.c:105: else if (lfn->no_of_strings)
	ld	a,l
	or	 a
	jr	Z,fatfs_lfn_cache_get_00102
;fat_misc.c:106: lfn->String[lfn->no_of_strings][0] = '\0';
	ld	e,l
	add	hl, hl
	add	hl, de
	add	hl, hl
	add	hl, hl
	add	hl, de
	ld	h, &00
	add	hl,bc
	ld	(hl), &00
	jr	fatfs_lfn_cache_get_00106
fatfs_lfn_cache_get_00102:
;fat_misc.c:108: lfn->String[0][0] = '\0';
	xor	 a
	ld	(bc),a
fatfs_lfn_cache_get_00106:
;fat_misc.c:110: return &lfn->String[0][0];
	ld	l, c
	ld	h, b
	ret
_fatfs_lfn_cache_get_end:
;fat_misc.c:117: int fatfs_entry_lfn_text(struct fat_dir_entry *entry)
;	---------------------------------
; Function fatfs_entry_lfn_text
; ---------------------------------
_fatfs_entry_lfn_text_start:
_fatfs_entry_lfn_text:
;fat_misc.c:119: if ((entry->Attr & FILE_ATTR_LFN_TEXT) == FILE_ATTR_LFN_TEXT)
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	de,  &000B
	add	hl, de
	ld	a,(hl)
	and	  &0F
	sub	  &0F
	jr	NZ,fatfs_entry_lfn_text_00102
;fat_misc.c:120: return 1;
	ld	hl, &0001
	ret
fatfs_entry_lfn_text_00102:
;fat_misc.c:122: return 0;
	ld	hl, &0000
	ret
_fatfs_entry_lfn_text_end:
;fat_misc.c:129: int fatfs_entry_lfn_invalid(struct fat_dir_entry *entry)
;	---------------------------------
; Function fatfs_entry_lfn_invalid
; ---------------------------------
_fatfs_entry_lfn_invalid_start:
_fatfs_entry_lfn_invalid:
;fat_misc.c:131: if ( (entry->Name[0]==FILE_HEADER_BLANK)  ||
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	a,(hl)
	or	 a
	jr	Z,fatfs_entry_lfn_invalid_00101
;fat_misc.c:132: (entry->Name[0]==FILE_HEADER_DELETED)||
	sub	  &E5
	jr	Z,fatfs_entry_lfn_invalid_00101
;fat_misc.c:133: (entry->Attr==FILE_ATTR_VOLUME_ID) ||
	ld	de,  &000B
	add	hl, de
;fat_misc.c:134: (entry->Attr & FILE_ATTR_SYSHID) )
	ld	a, (hl)
	cp	 &08
	jr	Z,fatfs_entry_lfn_invalid_00101
	and	  &06
	jr	Z,fatfs_entry_lfn_invalid_00102
fatfs_entry_lfn_invalid_00101:
;fat_misc.c:135: return 1;
	ld	hl, &0001
	ret
fatfs_entry_lfn_invalid_00102:
;fat_misc.c:137: return 0;
	ld	hl, &0000
	ret
_fatfs_entry_lfn_invalid_end:
;fat_misc.c:144: int fatfs_entry_lfn_exists(struct lfn_cache *lfn, struct fat_dir_entry *entry)
;	---------------------------------
; Function fatfs_entry_lfn_exists
; ---------------------------------
_fatfs_entry_lfn_exists_start:
_fatfs_entry_lfn_exists:
;fat_misc.c:146: if ( (entry->Attr!=FILE_ATTR_LFN_TEXT) &&
	ld	hl, 4
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	push	de
	pop	iy
	ld	b,(iy+11 )
	ld	a,b
	sub	  &0F
	jr	Z,fatfs_entry_lfn_exists_00102
;fat_misc.c:147: (entry->Name[0]!=FILE_HEADER_BLANK) &&
	ld	a,(de)
	or	 a
	jr	Z,fatfs_entry_lfn_exists_00102
;fat_misc.c:148: (entry->Name[0]!=FILE_HEADER_DELETED) &&
	sub	  &E5
	jr	Z,fatfs_entry_lfn_exists_00102
;fat_misc.c:149: (entry->Attr!=FILE_ATTR_VOLUME_ID) &&
;fat_misc.c:150: (!(entry->Attr&FILE_ATTR_SYSHID)) &&
	ld	a,b
	cp	 &08
	jr	Z,fatfs_entry_lfn_exists_00102
	and	  &06
	jr	NZ,fatfs_entry_lfn_exists_00102
;fat_misc.c:151: (lfn->no_of_strings) )
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	de,  &004F
	add	hl, de
	ld	a,(hl)
	or	 a
	jr	Z,fatfs_entry_lfn_exists_00102
;fat_misc.c:152: return 1;
	ld	hl, &0001
	ret
fatfs_entry_lfn_exists_00102:
;fat_misc.c:154: return 0;
	ld	hl, &0000
	ret
_fatfs_entry_lfn_exists_end:
;fat_misc.c:160: int fatfs_entry_sfn_only(struct fat_dir_entry *entry)
;	---------------------------------
; Function fatfs_entry_sfn_only
; ---------------------------------
_fatfs_entry_sfn_only_start:
_fatfs_entry_sfn_only:
;fat_misc.c:162: if ( (entry->Attr!=FILE_ATTR_LFN_TEXT) &&
	pop	bc
	pop	de
	push	de
	push	bc
	push	de
	pop	iy
	ld	b,(iy+11 )
	ld	a,b
	sub	  &0F
	jr	Z,fatfs_entry_sfn_only_00102
;fat_misc.c:163: (entry->Name[0]!=FILE_HEADER_BLANK) &&
	ld	a,(de)
	or	 a
	jr	Z,fatfs_entry_sfn_only_00102
;fat_misc.c:164: (entry->Name[0]!=FILE_HEADER_DELETED) &&
	sub	  &E5
	jr	Z,fatfs_entry_sfn_only_00102
;fat_misc.c:165: (entry->Attr!=FILE_ATTR_VOLUME_ID) &&
;fat_misc.c:166: (!(entry->Attr&FILE_ATTR_SYSHID)) )
	ld	a,b
	cp	 &08
	jr	Z,fatfs_entry_sfn_only_00102
	and	  &06
	jr	NZ,fatfs_entry_sfn_only_00102
;fat_misc.c:167: return 1;
	ld	hl, &0001
	ret
fatfs_entry_sfn_only_00102:
;fat_misc.c:169: return 0;
	ld	hl, &0000
	ret
_fatfs_entry_sfn_only_end:
;fat_misc.c:175: int fatfs_entry_is_dir(struct fat_dir_entry *entry)
;	---------------------------------
; Function fatfs_entry_is_dir
; ---------------------------------
_fatfs_entry_is_dir_start:
_fatfs_entry_is_dir:
;fat_misc.c:177: if (entry->Attr & FILE_TYPE_DIR)
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	de,  &000B
	add	hl, de
	bit	4,(hl)
	jr	Z,fatfs_entry_is_dir_00102
;fat_misc.c:178: return 1;
	ld	hl, &0001
	ret
fatfs_entry_is_dir_00102:
;fat_misc.c:180: return 0;
	ld	hl, &0000
	ret
_fatfs_entry_is_dir_end:
;fat_misc.c:185: int fatfs_entry_is_file(struct fat_dir_entry *entry)
;	---------------------------------
; Function fatfs_entry_is_file
; ---------------------------------
_fatfs_entry_is_file_start:
_fatfs_entry_is_file:
;fat_misc.c:187: if (entry->Attr & FILE_TYPE_FILE) 
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	de,  &000B
	add	hl, de
	bit	5,(hl)
	jr	Z,fatfs_entry_is_file_00102
;fat_misc.c:188: return 1;
	ld	hl, &0001
	ret
fatfs_entry_is_file_00102:
;fat_misc.c:190: return 0;
	ld	hl, &0000
	ret
_fatfs_entry_is_file_end:
