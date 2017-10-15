;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 8604 (May 11 2013) (MINGW32)
; This file was generated Sun Oct 15 00:38:02 2017
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
;fat_access.c:43: char *fat_strncpy (
;	---------------------------------
; Function fat_strncpy
; ---------------------------------
_fat_strncpy_start:
_fat_strncpy:
	push	ix
	ld	ix,0
	add	ix,sp
	push	af
	dec	sp
;fat_access.c:48: char * d1 =  d;
	ld	c,(ix+4 )
	ld	b,(ix+5 )
;fat_access.c:50: while ( n && *s )
	ld	e,(ix+8 )
	ld	d,(ix+9 )
	ld	l,(ix+6 )
	ld	h,(ix+7 )
	push	bc
	pop	iy
fat_strncpy_00102:
	ld	a,d
	or	e
	jr	Z,fat_strncpy_00114
	ld	a,(hl)
	ld	(ix-1 ), a
	or	 a
	jr	Z,fat_strncpy_00114
;fat_access.c:52: n-- ;
	dec	de
;fat_access.c:53: *d++ = *s++ ;
	ld	a,(ix-1 )
	inc	hl
	ld	(iy+0 ), a
	inc	iy
	jr	fat_strncpy_00102
;fat_access.c:55: while ( n-- )
fat_strncpy_00114:
	push	iy
	pop	hl
	inc	sp
	inc	sp
	push	de
fat_strncpy_00105:
	ld	d,(ix-3 )
	ld	e,(ix-2 )
	ld	a,(ix-3 )
	add	a, &FF
	ld	(ix-3 ),a
	ld	a,(ix-2 )
	adc	a, &FF
	ld	(ix-2 ),a
	ld	a,e
	or	d
	jr	Z,fat_strncpy_00107
;fat_access.c:57: *d++ = '\0' ;
	ld	(hl), &00
	inc	hl
	jr	fat_strncpy_00105
fat_strncpy_00107:
;fat_access.c:59: return d1;
	ld	l, c
	ld	h, b
	ld	sp,ix
	pop	ix
	ret
_fat_strncpy_end:
;fat_access.c:65: int fatfs_init(struct fatfs *fs)
;	---------------------------------
; Function fatfs_init
; ---------------------------------
_fatfs_init_start:
_fatfs_init:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-35
	add	hl,sp
	ld	sp,hl
;fat_access.c:74: unsigned char   valid_partition = 0;
	ld	(ix-32 ), &00
;fat_access.c:76: fs->currentsector.address = FAT32_INVALID_CLUSTER;
	ld	a,(ix+4 )
	ld	(ix-24 ),a
	ld	a,(ix+5 )
	ld	(ix-23 ),a
	ld	a,(ix-24 )
	add	a,  &23
	ld	l,a
	ld	a,(ix-23 )
	adc	a,  &02
	ld	h,a
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
;fat_access.c:77: fs->currentsector.dirty = 0;
	ld	a,(ix-24 )
	add	a,  &27
	ld	l,a
	ld	a,(ix-23 )
	adc	a,  &02
	ld	h,a
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;fat_access.c:79: fs->next_free_cluster = 0; // Invalid
	ld	a,(ix-24 )
	add	a,  &17
	ld	l,a
	ld	a,(ix-23 )
	adc	a,  &00
	ld	h,a
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
	inc	hl
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;fat_access.c:81: fatfs_fat_init(fs);
	ld	l,(ix-24 )
	ld	h,(ix-23 )
	push	hl
	call	_fatfs_fat_init
	pop	af
;fat_access.c:84: if (!fs->disk_io.read_sector)
	ld	a,(ix-24 )
	ld	(ix-30 ),a
	ld	a,(ix-23 )
	ld	(ix-29 ),a
	ld	a,(ix-24 )
	add	a,  &1B
	ld	(ix-2 ),a
	ld	a,(ix-23 )
	adc	a,  &00
	ld	(ix-1 ),a
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	ld	a,(hl)
	ld	(ix-6 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-5 ), a
	or	(ix-6 )
	jr	NZ,fatfs_init_00102
;fat_access.c:85: return FAT_INIT_MEDIA_ACCESS_ERROR;
	ld	hl, &FFFF
	jp	fatfs_init_00137
fatfs_init_00102:
;fat_access.c:91: if (!fs->disk_io.read_sector(0, fs->currentsector.sector))
	ld	a,(ix-24 )
	add	a,  &23
	ld	(ix-18 ),a
	ld	a,(ix-23 )
	adc	a,  &00
	ld	(ix-17 ),a
	ld	l,(ix-18 )
	ld	h,(ix-17 )
	push	hl
	ld	hl, &0000
	push	hl
	ld	hl, &0000
	push	hl
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	call	__sdcc_call_hl
	pop	af
	pop	af
	pop	af
	ld	a,h
	or	l
	jr	NZ,fatfs_init_00104
;fat_access.c:92: return FAT_INIT_MEDIA_ACCESS_ERROR;
	ld	hl, &FFFF
	jp	fatfs_init_00137
fatfs_init_00104:
;fat_access.c:96: if (fs->currentsector.sector[SIGNATURE_POSITION] !=  &55 || fs->currentsector.sector[SIGNATURE_POSITION+1] !=  &AA)
	ld	a,(ix-24 )
	add	a,  &21
	ld	(ix-6 ),a
	ld	a,(ix-23 )
	adc	a,  &02
	ld	(ix-5 ),a
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	ld	a,(hl)
	sub	  &55
	jr	NZ,fatfs_init_00105
	ld	a,(ix-24 )
	ld	(ix-4 ),a
	ld	a,(ix-23 )
	ld	(ix-3 ),a
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	ld	de,  &0222
	add	hl, de
	ld	a,(hl)
	sub	  &AA
	jr	Z,fatfs_init_00106
fatfs_init_00105:
;fat_access.c:97: return FAT_INIT_INVALID_SIGNATURE;
	ld	hl, &FFFD
	jp	fatfs_init_00137
fatfs_init_00106:
;fat_access.c:104: switch(fs->currentsector.sector[PARTITION1_TYPECODE_LOCATION])
	ld	a,(ix-24 )
	ld	(ix-4 ),a
	ld	a,(ix-23 )
	ld	(ix-3 ),a
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	ld	de,  &01E5
	add	hl, de
	ld	h,(hl)
	ld	a,h
	or	 a
	jr	Z,fatfs_init_00114
	ld	a,h
	cp	 &05
	jr	Z,fatfs_init_00113
	cp	 &06
	jr	Z,fatfs_init_00113
	cp	 &0B
	jr	Z,fatfs_init_00113
	cp	 &0C
	jr	Z,fatfs_init_00113
	cp	 &0E
	jr	Z,fatfs_init_00113
	sub	  &0F
	jr	NZ,fatfs_init_00115
;fat_access.c:111: case  &05:
fatfs_init_00113:
;fat_access.c:112: valid_partition = 1;
	ld	(ix-32 ), &01
;fat_access.c:113: break;
	jr	fatfs_init_00118
;fat_access.c:114: case  &00:
fatfs_init_00114:
;fat_access.c:115: valid_partition = 0;
	ld	(ix-32 ), &00
;fat_access.c:116: break;
	jr	fatfs_init_00118
;fat_access.c:117: default:
fatfs_init_00115:
;fat_access.c:118: if (fs->currentsector.sector[PARTITION1_TYPECODE_LOCATION] <=  &06)
	ld	a, &06
	sub	 h
	jr	C,fatfs_init_00118
;fat_access.c:119: valid_partition = 1;
	ld	(ix-32 ), &01
;fat_access.c:121: }
fatfs_init_00118:
;fat_access.c:126: fs->lba_begin = GET_32BIT_WORD(fs->currentsector.sector, PARTITION1_LBA_BEGIN_LOCATION);
	ld	a,(ix-24 )
	add	a,  &0F
	ld	(ix-4 ),a
	ld	a,(ix-23 )
	adc	a,  &00
	ld	(ix-3 ),a
;fat_access.c:123: if (valid_partition)
	ld	a,(ix-32 )
	or	 a
	jr	Z,fatfs_init_00120
;fat_access.c:126: fs->lba_begin = GET_32BIT_WORD(fs->currentsector.sector, PARTITION1_LBA_BEGIN_LOCATION);
	ld	a,(ix-24 )
	add	a,  &E9
	ld	(ix-16 ),a
	ld	a,(ix-23 )
	adc	a,  &01
	ld	(ix-15 ),a
	ld	e,(ix-16 )
	ld	d,(ix-15 )
	ld	hl,  &000D
	add	hl, sp
	ex	de, hl
	ld	bc,  &0004
	ldir
	ld	e,(ix-4 )
	ld	d,(ix-3 )
	ld	hl,  &000D
	add	hl, sp
	ld	bc,  &0004
	ldir
;fat_access.c:127: partition_size = GET_32BIT_WORD(fs->currentsector.sector, PARTITION1_SIZE_LOCATION);
	jr	fatfs_init_00121
fatfs_init_00120:
;fat_access.c:131: fs->lba_begin = 0;
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
	inc	hl
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
fatfs_init_00121:
;fat_access.c:135: if (!fs->disk_io.read_sector(fs->lba_begin, fs->currentsector.sector))
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	ld	a,(hl)
	ld	(ix-22 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-21 ),a
	ld	e,(ix-4 )
	ld	d,(ix-3 )
	ld	hl,  &0019
	add	hl, sp
	ex	de, hl
	ld	bc,  &0004
	ldir
	ld	l,(ix-18 )
	ld	h,(ix-17 )
	push	hl
	ld	l,(ix-8 )
	ld	h,(ix-7 )
	push	hl
	ld	l,(ix-10 )
	ld	h,(ix-9 )
	push	hl
	ld	l,(ix-22 )
	ld	h,(ix-21 )
	call	__sdcc_call_hl
	pop	af
	pop	af
	pop	af
	ld	a,h
	or	l
	jr	NZ,fatfs_init_00123
;fat_access.c:136: return FAT_INIT_MEDIA_ACCESS_ERROR;
	ld	hl, &FFFF
	jp	fatfs_init_00137
fatfs_init_00123:
;fat_access.c:139: if (GET_16BIT_WORD(fs->currentsector.sector,  &0B) != FAT_SECTOR_SIZE)
	ld	a,(ix-24 )
	add	a,  &2E
	ld	(ix-10 ),a
	ld	a,(ix-23 )
	adc	a,  &00
	ld	(ix-9 ),a
	ld	a,(ix-10 )
	ld	(ix-10 ),a
	ld	a,(ix-9 )
	ld	(ix-9 ),a
	ld	l,(ix-10 )
	ld	h,(ix-9 )
	ld	a,(hl)
	ld	(ix-10 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-9 ),a
	ld	a,(ix-10 )
	or	 a
	jr	NZ,fatfs_init_00205
	ld	a,(ix-9 )
	sub	  &02
	jr	Z,fatfs_init_00125
fatfs_init_00205:
;fat_access.c:140: return FAT_INIT_INVALID_SECTOR_SIZE;
	ld	hl, &FFFE
	jp	fatfs_init_00137
fatfs_init_00125:
;fat_access.c:143: fs->sectors_per_cluster = fs->currentsector.sector[BPB_SECPERCLUS];
	ld	l,(ix-24 )
	ld	h,(ix-23 )
	ld	de,  &0030
	add	hl, de
	ld	a,(hl)
	ld	l,(ix-24 )
	ld	h,(ix-23 )
	ld	(hl),a
;fat_access.c:144: reserved_sectors = GET_16BIT_WORD(fs->currentsector.sector, BPB_RSVDSECCNT);
	ld	a,(ix-24 )
	add	a,  &31
	ld	(ix-10 ),a
	ld	a,(ix-23 )
	adc	a,  &00
	ld	(ix-9 ),a
	ld	a,(ix-10 )
	ld	(ix-10 ),a
	ld	a,(ix-9 )
	ld	(ix-9 ),a
	ld	l,(ix-10 )
	ld	h,(ix-9 )
	ld	a,(hl)
	ld	(ix-35 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-34 ),a
;fat_access.c:145: num_of_fats = fs->currentsector.sector[BPB_NUMFATS];
	ld	a,(ix-24 )
	ld	(ix-10 ),a
	ld	a,(ix-23 )
	ld	(ix-9 ),a
	ld	l,(ix-10 )
	ld	h,(ix-9 )
	ld	de,  &0033
	add	hl, de
	ld	a,(hl)
	ld	(ix-33 ),a
;fat_access.c:148: if(GET_16BIT_WORD(fs->currentsector.sector, BPB_FATSZ16) != 0)
	ld	a,(ix-24 )
	add	a,  &39
	ld	(ix-10 ),a
	ld	a,(ix-23 )
	adc	a,  &00
	ld	(ix-9 ),a
	ld	a,(ix-10 )
	ld	(ix-22 ),a
	ld	a,(ix-9 )
	ld	(ix-21 ),a
	ld	l,(ix-22 )
	ld	h,(ix-21 )
	ld	a,(hl)
	ld	(ix-22 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-21 ),a
;fat_access.c:149: fs->fat_sectors = GET_16BIT_WORD(fs->currentsector.sector, BPB_FATSZ16);
	ld	a,(ix-24 )
	add	a,  &13
	ld	(ix-16 ),a
	ld	a,(ix-23 )
	adc	a,  &00
	ld	(ix-15 ),a
;fat_access.c:148: if(GET_16BIT_WORD(fs->currentsector.sector, BPB_FATSZ16) != 0)
	ld	a,(ix-21 )
	or	(ix-22 )
	jr	Z,fatfs_init_00127
;fat_access.c:149: fs->fat_sectors = GET_16BIT_WORD(fs->currentsector.sector, BPB_FATSZ16);
	ld	l,(ix-10 )
	ld	h,(ix-9 )
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	bc, &0000
	ld	l,(ix-16 )
	ld	h,(ix-15 )
	ld	(hl),e
	inc	hl
	ld	(hl),d
	inc	hl
	ld	(hl),c
	inc	hl
	ld	(hl),b
	jr	fatfs_init_00128
fatfs_init_00127:
;fat_access.c:151: fs->fat_sectors = GET_32BIT_WORD(fs->currentsector.sector, BPB_FAT32_FATSZ32);
	ld	a,(ix-24 )
	add	a,  &47
	ld	(ix-10 ),a
	ld	a,(ix-23 )
	adc	a,  &00
	ld	(ix-9 ),a
	ld	e,(ix-10 )
	ld	d,(ix-9 )
	ld	hl,  &0019
	add	hl, sp
	ex	de, hl
	ld	bc,  &0004
	ldir
	ld	e,(ix-16 )
	ld	d,(ix-15 )
	ld	hl,  &0019
	add	hl, sp
	ld	bc,  &0004
	ldir
fatfs_init_00128:
;fat_access.c:154: fs->rootdir_first_cluster = GET_32BIT_WORD(fs->currentsector.sector, BPB_FAT32_ROOTCLUS);
	ld	a,(ix-24 )
	add	a,  &05
	ld	(ix-10 ),a
	ld	a,(ix-23 )
	adc	a,  &00
	ld	(ix-9 ),a
	ld	a,(ix-24 )
	add	a,  &4F
	ld	(ix-22 ),a
	ld	a,(ix-23 )
	adc	a,  &00
	ld	(ix-21 ),a
	ld	a,(ix-22 )
	ld	(ix-22 ),a
	ld	a,(ix-21 )
	ld	(ix-21 ),a
	ld	e,(ix-22 )
	ld	d,(ix-21 )
	ld	hl,  &000D
	add	hl, sp
	ex	de, hl
	ld	bc,  &0004
	ldir
	ld	e,(ix-10 )
	ld	d,(ix-9 )
	ld	hl,  &000D
	add	hl, sp
	ld	bc,  &0004
	ldir
;fat_access.c:155: fs->fs_info_sector = GET_16BIT_WORD(fs->currentsector.sector, BPB_FAT32_FSINFO);
	ld	a,(ix-24 )
	add	a,  &0D
	ld	(ix-10 ),a
	ld	a,(ix-23 )
	adc	a,  &00
	ld	(ix-9 ),a
	ld	a,(ix-24 )
	add	a,  &53
	ld	(ix-22 ),a
	ld	a,(ix-23 )
	adc	a,  &00
	ld	(ix-21 ),a
	ld	a,(ix-22 )
	ld	(ix-22 ),a
	ld	a,(ix-21 )
	ld	(ix-21 ),a
	ld	l,(ix-22 )
	ld	h,(ix-21 )
	ld	a,(hl)
	ld	(ix-22 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-21 ),a
	ld	l,(ix-10 )
	ld	h,(ix-9 )
	ld	a,(ix-22 )
	ld	(hl),a
	inc	hl
	ld	a,(ix-21 )
	ld	(hl),a
;fat_access.c:162: fs->fat_begin_lba = fs->lba_begin + reserved_sectors;
	ld	a,(ix-24 )
	add	a,  &09
	ld	(ix-10 ),a
	ld	a,(ix-23 )
	adc	a,  &00
	ld	(ix-9 ),a
	ld	e,(ix-4 )
	ld	d,(ix-3 )
	ld	hl,  &000D
	add	hl, sp
	ex	de, hl
	ld	bc,  &0004
	ldir
	ld	a,(ix-35 )
	ld	(ix-28 ),a
	ld	a,(ix-34 )
	ld	(ix-27 ),a
	ld	(ix-26 ), &00
	ld	(ix-25 ), &00
	ld	a,(ix-22 )
	add	a, (ix-28 )
	ld	(ix-28 ),a
	ld	a,(ix-21 )
	adc	a, (ix-27 )
	ld	(ix-27 ),a
	ld	a,(ix-20 )
	adc	a, (ix-26 )
	ld	(ix-26 ),a
	ld	a,(ix-19 )
	adc	a, (ix-25 )
	ld	(ix-25 ),a
	ld	e,(ix-10 )
	ld	d,(ix-9 )
	ld	hl,  &0007
	add	hl, sp
	ld	bc,  &0004
	ldir
;fat_access.c:165: fs->cluster_begin_lba = fs->fat_begin_lba;
	ld	a,(ix-24 )
	add	a,  &01
	ld	(ix-10 ),a
	ld	a,(ix-23 )
	adc	a,  &00
	ld	(ix-9 ),a
	ld	e,(ix-10 )
	ld	d,(ix-9 )
	ld	hl,  &0007
	add	hl, sp
	ld	bc,  &0004
	ldir
;fat_access.c:166: for(i=0;i<num_of_fats;i++)
	ld	a,(ix-24 )
	ld	(ix-28 ),a
	ld	a,(ix-23 )
	ld	(ix-27 ),a
	ld	(ix-31 ), &00
fatfs_init_00135:
	ld	a,(ix-31 )
	sub	 (ix-33 )
	jr	NC,fatfs_init_00129
;fat_access.c:168: fs->cluster_begin_lba=fs->cluster_begin_lba+fs->fat_sectors;
	ld	e,(ix-10 )
	ld	d,(ix-9 )
	ld	hl,  &000D
	add	hl, sp
	ex	de, hl
	ld	bc,  &0004
	ldir
	ld	l,(ix-28 )
	ld	h,(ix-27 )
	ld	de,  &0013
	add	hl, de
	ld	a,(hl)
	ld	(ix-14 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-13 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-12 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-11 ),a
	ld	a,(ix-22 )
	add	a, (ix-14 )
	ld	(ix-14 ),a
	ld	a,(ix-21 )
	adc	a, (ix-13 )
	ld	(ix-13 ),a
	ld	a,(ix-20 )
	adc	a, (ix-12 )
	ld	(ix-12 ),a
	ld	a,(ix-19 )
	adc	a, (ix-11 )
	ld	(ix-11 ),a
	ld	e,(ix-10 )
	ld	d,(ix-9 )
	ld	hl,  &0015
	add	hl, sp
	ld	bc,  &0004
	ldir
;fat_access.c:166: for(i=0;i<num_of_fats;i++)
	inc	(ix-31 )
	jr	fatfs_init_00135
fatfs_init_00129:
;fat_access.c:171: if (GET_16BIT_WORD(fs->currentsector.sector,  &1FE) !=  &AA55) // This signature should be AA55
	ld	a,(ix-6 )
	ld	(ix-14 ),a
	ld	a,(ix-5 )
	ld	(ix-13 ),a
	ld	a,(ix-14 )
	ld	(ix-14 ),a
	ld	a,(ix-13 )
	ld	(ix-13 ),a
	ld	l,(ix-14 )
	ld	h,(ix-13 )
	ld	a,(hl)
	ld	(ix-14 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-13 ),a
	ld	a,(ix-14 )
	sub	  &55
	jr	NZ,fatfs_init_00206
	ld	a,(ix-13 )
	sub	  &AA
	jr	Z,fatfs_init_00131
fatfs_init_00206:
;fat_access.c:172: return FAT_INIT_INVALID_SIGNATURE;
	ld	hl, &FFFD
	jr	fatfs_init_00137
fatfs_init_00131:
;fat_access.c:185: if (fs->sectors_per_cluster == 0)
	ld	l,(ix-30 )
	ld	h,(ix-29 )
	ld	a,(hl)
	or	 a
	jr	NZ,fatfs_init_00133
;fat_access.c:186: return FAT_INIT_WRONG_FILESYS_TYPE;
	ld	hl, &FFFB
	jr	fatfs_init_00137
fatfs_init_00133:
;fat_access.c:190: return FAT_INIT_OK;
	ld	hl, &0000
fatfs_init_00137:
	ld	sp,ix
	pop	ix
	ret
_fatfs_init_end:
;fat_access.c:196: UINT32 fatfs_lba_of_cluster(struct fatfs *fs, UINT32 Cluster_Number)
;	---------------------------------
; Function fatfs_lba_of_cluster
; ---------------------------------
_fatfs_lba_of_cluster_start:
_fatfs_lba_of_cluster:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-8
	add	hl,sp
	ld	sp,hl
;fat_access.c:198: return ((fs->cluster_begin_lba + ((Cluster_Number-2)*fs->sectors_per_cluster)));
	ld	e,(ix+4 )
	ld	d,(ix+5 )
	ld	l, e
	ld	h, d
	inc	hl
	ld	a,(hl)
	ld	(ix-8 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-7 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-6 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-5 ),a
	ld	a,(ix+6 )
	add	a, &FE
	ld	(ix-4 ),a
	ld	a,(ix+7 )
	adc	a, &FF
	ld	(ix-3 ),a
	ld	a,(ix+8 )
	adc	a, &FF
	ld	(ix-2 ),a
	ld	a,(ix+9 )
	adc	a, &FF
	ld	(ix-1 ),a
	ld	a,(de)
	ld	e,a
	ld	d, &00
	ld	hl, &0000
	push	hl
	push	de
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	push	hl
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	push	hl
	call	__mullong_rrx_s
	pop	af
	pop	af
	pop	af
	pop	af
	ld	a,(ix-8 )
	add	a, l
	ld	l,a
	ld	a,(ix-7 )
	adc	a, h
	ld	h,a
	ld	a,(ix-6 )
	adc	a, e
	ld	e,a
	ld	a,(ix-5 )
	adc	a, d
	ld	d,a
	ld	sp,ix
	pop	ix
	ret
_fatfs_lba_of_cluster_end:
;fat_access.c:203: int fatfs_sector_read(struct fatfs *fs, UINT32 lba, unsigned char *target)
;	---------------------------------
; Function fatfs_sector_read
; ---------------------------------
_fatfs_sector_read_start:
_fatfs_sector_read:
;fat_access.c:205: return fs->disk_io.read_sector(lba, target);
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	de,  &001B
	add	hl, de
	ld	d,(hl)
	inc	hl
	ld	e,(hl)
	ld	hl, 8
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	ld	iy,6
	add	iy,sp
	ld	l,(iy+2 )
	ld	h,(iy+3 )
	push	hl
	ld	l,(iy+0 )
	ld	h,(iy+1 )
	push	hl
	ld	l, d
	ld	h, e
	call	__sdcc_call_hl
	pop	af
	pop	af
	pop	af
	ret
_fatfs_sector_read_end:
;fat_access.c:210: int fatfs_sector_write(struct fatfs *fs, UINT32 lba, unsigned char *target)
;	---------------------------------
; Function fatfs_sector_write
; ---------------------------------
_fatfs_sector_write_start:
_fatfs_sector_write:
;fat_access.c:212: return fs->disk_io.write_sector(lba, target);
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	de,  &001D
	add	hl, de
	ld	d,(hl)
	inc	hl
	ld	e,(hl)
	ld	hl, 8
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	ld	iy,6
	add	iy,sp
	ld	l,(iy+2 )
	ld	h,(iy+3 )
	push	hl
	ld	l,(iy+0 )
	ld	h,(iy+1 )
	push	hl
	ld	l, d
	ld	h, e
	call	__sdcc_call_hl
	pop	af
	pop	af
	pop	af
	ret
_fatfs_sector_write_end:
;fat_access.c:218: int fatfs_sector_reader(struct fatfs *fs, UINT32 start_cluster, UINT32 offset, unsigned char *target)
;	---------------------------------
; Function fatfs_sector_reader
; ---------------------------------
_fatfs_sector_reader_start:
_fatfs_sector_reader:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-24
	add	hl,sp
	ld	sp,hl
;fat_access.c:222: UINT32 cluster_chain = 0;
	xor	 a
	ld	(ix-24 ),a
	ld	(ix-23 ),a
	ld	(ix-22 ),a
	ld	(ix-21 ),a
;fat_access.c:228: cluster_chain = start_cluster;
	ld	hl, 0
	add	hl, sp
	ex	de, hl
	ld	hl, 30
	add	hl, sp
	ld	bc, 4
	ldir
;fat_access.c:231: cluster_to_read = offset / fs->sectors_per_cluster;
	ld	a,(ix+4 )
	ld	(ix-2 ),a
	ld	a,(ix+5 )
	ld	(ix-1 ),a
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	ld	e,(hl)
	ld	d, &00
	ld	hl, &0000
	push	hl
	push	de
	push	hl
	push	de
	ld	l,(ix+12 )
	ld	h,(ix+13 )
	push	hl
	ld	l,(ix+10 )
	ld	h,(ix+11 )
	push	hl
	call	__divulong_rrx_s
	pop	af
	pop	af
	pop	af
	pop	af
	ld	(ix-13 ),d
	ld	(ix-14 ),e
	ld	(ix-15 ),h
	ld	(ix-16 ),l
	ld	l,(ix-14 )
	ld	h,(ix-13 )
	push	hl
	ld	l,(ix-16 )
	ld	h,(ix-15 )
	push	hl
	call	__mullong_rrx_s
	pop	af
	pop	af
	pop	af
	pop	af
	ld	a,(ix+10 )
	sub	 l
	ld	l,a
	ld	a,(ix+11 )
	sbc	a, h
	ld	h,a
	ld	a,(ix+12 )
	sbc	a, e
	ld	e,a
	ld	a,(ix+13 )
	sbc	a, d
	ld	d,a
	ld	(ix-12 ),l
	ld	(ix-11 ),h
	ld	(ix-10 ),e
	ld	(ix-9 ),d
;fat_access.c:235: for (i=0; i<cluster_to_read; i++)
	xor	 a
	ld	(ix-20 ),a
	ld	(ix-19 ),a
	ld	(ix-18 ),a
	ld	(ix-17 ),a
fatfs_sector_reader_00113:
	ld	a,(ix-20 )
	sub	 (ix-16 )
	ld	a,(ix-19 )
	sbc	a, (ix-15 )
	ld	a,(ix-18 )
	sbc	a, (ix-14 )
	ld	a,(ix-17 )
	sbc	a, (ix-13 )
	jp	NC,fatfs_sector_reader_00103
;fat_access.c:238: if (!fatfs_browse_cache_get_next_cluster(fs, i, &cluster_chain))
	ld	hl, &0000
	add	hl,sp
	push	hl
	ld	l,(ix-18 )
	ld	h,(ix-17 )
	push	hl
	ld	l,(ix-20 )
	ld	h,(ix-19 )
	push	hl
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	push	hl
	call	_fatfs_browse_cache_get_next_cluster
	pop	af
	pop	af
	pop	af
	pop	af
	ld	a,h
	or	l
	jr	NZ,fatfs_sector_reader_00114
;fat_access.c:241: cluster_chain = fatfs_find_next_cluster(fs, cluster_chain);
	ld	l,(ix-22 )
	ld	h,(ix-21 )
	push	hl
	ld	l,(ix-24 )
	ld	h,(ix-23 )
	push	hl
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	push	hl
	call	_fatfs_find_next_cluster
	pop	af
	pop	af
	pop	af
	ex	de, hl
	ld	(ix-24 ),e
	ld	(ix-23 ),d
	ld	(ix-22 ),l
	ld	(ix-21 ),h
;fat_access.c:244: fatfs_browse_cache_set_next_cluster(fs, i, cluster_chain);
	push	hl
	push	de
	ld	l,(ix-18 )
	ld	h,(ix-17 )
	push	hl
	ld	l,(ix-20 )
	ld	h,(ix-19 )
	push	hl
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	push	hl
	call	_fatfs_browse_cache_set_next_cluster
	ld	hl, &000A
	add	hl,sp
	ld	sp,hl
fatfs_sector_reader_00114:
;fat_access.c:235: for (i=0; i<cluster_to_read; i++)
	inc	(ix-20 )
	jp	NZ,fatfs_sector_reader_00113
	inc	(ix-19 )
	jp	NZ,fatfs_sector_reader_00113
	inc	(ix-18 )
	jp	NZ,fatfs_sector_reader_00113
	inc	(ix-17 )
	jp	fatfs_sector_reader_00113
fatfs_sector_reader_00103:
;fat_access.c:250: if (cluster_chain == FAT32_LAST_CLUSTER)
	ld	a,(ix-24 )
	inc	a
	jr	NZ,fatfs_sector_reader_00105
	ld	a,(ix-23 )
	inc	a
	jr	NZ,fatfs_sector_reader_00105
	ld	a,(ix-22 )
	inc	a
	jr	NZ,fatfs_sector_reader_00105
	ld	a,(ix-21 )
	inc	a
	jr	NZ,fatfs_sector_reader_00105
;fat_access.c:251: return 0;
	ld	hl, &0000
	jp	fatfs_sector_reader_00115
fatfs_sector_reader_00105:
;fat_access.c:254: lba = fatfs_lba_of_cluster(fs, cluster_chain)+sector_to_read;
	ld	l,(ix-22 )
	ld	h,(ix-21 )
	push	hl
	ld	l,(ix-24 )
	ld	h,(ix-23 )
	push	hl
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	push	hl
	call	_fatfs_lba_of_cluster
	pop	af
	pop	af
	pop	af
	ld	a,l
	add	a, (ix-12 )
	ld	c,a
	ld	a,h
	adc	a, (ix-11 )
	ld	b,a
	ld	a,e
	adc	a, (ix-10 )
	ld	e,a
	ld	a,d
	adc	a, (ix-9 )
	ld	d,a
;fat_access.c:258: if (target)
	ld	a,(ix+15 )
	or	(ix+14 )
	jr	Z,fatfs_sector_reader_00110
;fat_access.c:259: return fs->disk_io.read_sector(lba, target);
	push	hl
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	push	hl
	pop	iy
	pop	hl
	ld	a,(iy+27 )
	ld	(ix-8 ),a
	ld	a,(iy+28 )
	ld	(ix-7 ),a
	ld	l,(ix+14 )
	ld	h,(ix+15 )
	push	hl
	push	de
	push	bc
	ld	l,(ix-8 )
	ld	h,(ix-7 )
	call	__sdcc_call_hl
	pop	af
	pop	af
	pop	af
	jp	fatfs_sector_reader_00115
fatfs_sector_reader_00110:
;fat_access.c:261: else if (lba != fs->currentsector.address)
	ld	iy, &0023
	push	bc
	ld	c,(ix-2 )
	ld	b,(ix-1 )
	add	iy, bc
	pop	bc
	ld	a,(ix-2 )
	add	a,  &23
	ld	(ix-8 ),a
	ld	a,(ix-1 )
	adc	a,  &02
	ld	(ix-7 ),a
	push	de
	push	bc
	ld	e,(ix-8 )
	ld	d,(ix-7 )
	ld	hl,  &0016
	add	hl, sp
	ex	de, hl
	ld	bc,  &0004
	ldir
	pop	bc
	pop	de
	ld	a,c
	sub	 (ix-6 )
	jr	NZ,fatfs_sector_reader_00139
	ld	a,b
	sub	 (ix-5 )
	jr	NZ,fatfs_sector_reader_00139
	ld	a,e
	sub	 (ix-4 )
	jr	NZ,fatfs_sector_reader_00139
	ld	a,d
	sub	 (ix-3 )
	jr	Z,fatfs_sector_reader_00107
fatfs_sector_reader_00139:
;fat_access.c:263: fs->currentsector.address = lba;
	ld	l,(ix-8 )
	ld	h,(ix-7 )
	ld	(hl),c
	inc	hl
	ld	(hl),b
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
;fat_access.c:264: return fs->disk_io.read_sector(fs->currentsector.address, fs->currentsector.sector);
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	push	bc
	ld	bc,  &001B
	add	hl, bc
	pop	bc
	ld	a,(hl)
	ld	(ix-6 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-5 ),a
	push	iy
	push	de
	push	bc
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	call	__sdcc_call_hl
	pop	af
	pop	af
	pop	af
	jr	fatfs_sector_reader_00115
fatfs_sector_reader_00107:
;fat_access.c:267: return 1;
	ld	hl, &0001
fatfs_sector_reader_00115:
	ld	sp,ix
	pop	ix
	ret
_fatfs_sector_reader_end:
;fat_access.c:273: int fatfs_read_sector(struct fatfs *fs, UINT32 cluster, UINT32 sector, unsigned char *target)
;	---------------------------------
; Function fatfs_read_sector
; ---------------------------------
_fatfs_read_sector_start:
_fatfs_read_sector:
	push	ix
	ld	ix,0
	add	ix,sp
	push	af
	push	af
;fat_access.c:284: return fs->disk_io.read_sector(lba, target);
	ld	a,(ix+4 )
	ld	(ix-2 ),a
	ld	a,(ix+5 )
	ld	(ix-1 ),a
;fat_access.c:278: if (target)
	ld	a,(ix+15 )
	or	(ix+14 )
	jr	Z,fatfs_read_sector_00102
;fat_access.c:281: UINT32 lba = fatfs_lba_of_cluster(fs, cluster) + sector;
	ld	l,(ix+8 )
	ld	h,(ix+9 )
	push	hl
	ld	l,(ix+6 )
	ld	h,(ix+7 )
	push	hl
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	push	hl
	call	_fatfs_lba_of_cluster
	pop	af
	pop	af
	pop	af
	ld	a,l
	add	a, (ix+10 )
	ld	l,a
	ld	a,h
	adc	a, (ix+11 )
	ld	b,a
	ld	a,e
	adc	a, (ix+12 )
	ld	e,a
	ld	a,d
	adc	a, (ix+13 )
	ld	d,a
	ld	c,l
;fat_access.c:284: return fs->disk_io.read_sector(lba, target);
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	push	bc
	ld	bc,  &001B
	add	hl, bc
	pop	bc
	ld	a,(hl)
	ld	(ix-4 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-3 ),a
	ld	l,(ix+14 )
	ld	h,(ix+15 )
	push	hl
	push	de
	push	bc
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	call	__sdcc_call_hl
	pop	af
	pop	af
	pop	af
	jp	fatfs_read_sector_00104
fatfs_read_sector_00102:
;fat_access.c:289: fs->currentsector.address = fatfs_lba_of_cluster(fs, cluster)+sector;
	ld	a,(ix-2 )
	add	a,  &23
	ld	(ix-4 ),a
	ld	a,(ix-1 )
	adc	a,  &02
	ld	(ix-3 ),a
	ld	l,(ix+8 )
	ld	h,(ix+9 )
	push	hl
	ld	l,(ix+6 )
	ld	h,(ix+7 )
	push	hl
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	push	hl
	call	_fatfs_lba_of_cluster
	pop	af
	pop	af
	pop	af
	ld	a,l
	add	a, (ix+10 )
	ld	c,a
	ld	a,h
	adc	a, (ix+11 )
	ld	b,a
	ld	a,e
	adc	a, (ix+12 )
	ld	e,a
	ld	a,d
	adc	a, (ix+13 )
	ld	d,a
	pop	hl
	push	hl
	ld	(hl),c
	inc	hl
	ld	(hl),b
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
;fat_access.c:292: return fs->disk_io.read_sector(fs->currentsector.address, fs->currentsector.sector);
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	de,  &001B
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	iy, &0023
	ld	c,(ix-2 )
	ld	b,(ix-1 )
	add	iy, bc
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	bc,  &0223
	add	hl, bc
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	inc	hl
	ld	a,(hl)
	dec	hl
	ld	l,(hl)
	ld	h,a
	push	iy
	push	hl
	push	bc
	ex	de,hl
	call	__sdcc_call_hl
	pop	af
	pop	af
	pop	af
fatfs_read_sector_00104:
	ld	sp,ix
	pop	ix
	ret
_fatfs_read_sector_end:
;fat_access.c:301: int fatfs_write_sector(struct fatfs *fs, UINT32 cluster, UINT32 sector, unsigned char *target)
;	---------------------------------
; Function fatfs_write_sector
; ---------------------------------
_fatfs_write_sector_start:
_fatfs_write_sector:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-12
	add	hl,sp
	ld	sp,hl
;fat_access.c:304: if (!fs->disk_io.write_sector)
	ld	a,(ix+4 )
	ld	(ix-8 ),a
	ld	a,(ix+5 )
	ld	(ix-7 ),a
	ld	c,(ix-8 )
	ld	b,(ix-7 )
	push	bc
	pop	iy
	ld	a,(iy+29 )
	ld	(ix-6 ),a
	ld	a,(iy+30 )
	ld	(ix-5 ), a
	or	(ix-6 )
	jr	NZ,fatfs_write_sector_00102
;fat_access.c:305: return 0;
	ld	hl, &0000
	jp	fatfs_write_sector_00106
fatfs_write_sector_00102:
;fat_access.c:309: if (target)
	ld	a,(ix+15 )
	or	(ix+14 )
	jp	Z,fatfs_write_sector_00104
;fat_access.c:312: UINT32 lba = fatfs_lba_of_cluster(fs, cluster) + sector;
	ld	l,(ix+8 )
	ld	h,(ix+9 )
	push	hl
	ld	l,(ix+6 )
	ld	h,(ix+7 )
	push	hl
	ld	l,(ix-8 )
	ld	h,(ix-7 )
	push	hl
	call	_fatfs_lba_of_cluster
	pop	af
	pop	af
	pop	af
	ld	(ix-1 ),d
	ld	(ix-2 ),e
	ld	(ix-3 ),h
	ld	(ix-4 ), l
	ld	a, l
	add	a, (ix+10 )
	ld	(ix-12 ),a
	ld	a,(ix-3 )
	adc	a, (ix+11 )
	ld	(ix-11 ),a
	ld	a,(ix-2 )
	adc	a, (ix+12 )
	ld	(ix-10 ),a
	ld	a,(ix-1 )
	adc	a, (ix+13 )
	ld	(ix-9 ),a
;fat_access.c:315: return fs->disk_io.write_sector(lba, target);
	ld	a,(ix-8 )
	ld	(ix-4 ),a
	ld	a,(ix-7 )
	ld	(ix-3 ),a
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	ld	de,  &001D
	add	hl, de
	ld	a,(hl)
	ld	(ix-4 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-3 ),a
	ld	l,(ix+14 )
	ld	h,(ix+15 )
	push	hl
	ld	l,(ix-10 )
	ld	h,(ix-9 )
	push	hl
	ld	l,(ix-12 )
	ld	h,(ix-11 )
	push	hl
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	call	__sdcc_call_hl
	pop	af
	pop	af
	pop	af
	jp	fatfs_write_sector_00106
fatfs_write_sector_00104:
;fat_access.c:320: fs->currentsector.address = fatfs_lba_of_cluster(fs, cluster)+sector;
	ld	a,(ix-8 )
	add	a,  &23
	ld	(ix-4 ),a
	ld	a,(ix-7 )
	adc	a,  &02
	ld	(ix-3 ),a
	ld	l,(ix+8 )
	ld	h,(ix+9 )
	push	hl
	ld	l,(ix+6 )
	ld	h,(ix+7 )
	push	hl
	ld	l,(ix-8 )
	ld	h,(ix-7 )
	push	hl
	call	_fatfs_lba_of_cluster
	pop	af
	pop	af
	pop	af
	ld	a,l
	add	a, (ix+10 )
	ld	c,a
	ld	a,h
	adc	a, (ix+11 )
	ld	b,a
	ld	a,e
	adc	a, (ix+12 )
	ld	e,a
	ld	a,d
	adc	a, (ix+13 )
	ld	d,a
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	ld	(hl),c
	inc	hl
	ld	(hl),b
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),d
;fat_access.c:323: return fs->disk_io.write_sector(fs->currentsector.address, fs->currentsector.sector);
	ld	l,(ix-8 )
	ld	h,(ix-7 )
	ld	de,  &001D
	add	hl, de
	ld	a,(hl)
	ld	(ix-4 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-3 ),a
	ld	a,(ix-8 )
	add	a,  &23
	ld	c,a
	ld	a,(ix-7 )
	adc	a,  &00
	ld	b,a
	ld	l,(ix-8 )
	ld	h,(ix-7 )
	ld	de,  &0223
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	inc	hl
	ld	a,(hl)
	dec	hl
	ld	l,(hl)
	ld	h,a
	push	bc
	push	hl
	push	de
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	call	__sdcc_call_hl
	pop	af
	pop	af
	pop	af
fatfs_write_sector_00106:
	ld	sp,ix
	pop	ix
	ret
_fatfs_write_sector_end:
;fat_access.c:331: UINT32 fatfs_get_root_cluster(struct fatfs *fs)
;	---------------------------------
; Function fatfs_get_root_cluster
; ---------------------------------
_fatfs_get_root_cluster_start:
_fatfs_get_root_cluster:
	push	ix
	ld	ix,0
	add	ix,sp
;fat_access.c:334: return fs->rootdir_first_cluster;
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	ld	de,  &0005
	add	hl, de
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	l,c
	ld	h,b
	pop	ix
	ret
_fatfs_get_root_cluster_end:
;fat_access.c:339: UINT32 fatfs_get_file_entry(struct fatfs *fs, UINT32 Cluster, char *name_to_find, struct fat_dir_entry *sfEntry)
;	---------------------------------
; Function fatfs_get_file_entry
; ---------------------------------
_fatfs_get_file_entry_start:
_fatfs_get_file_entry:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-127
	add	hl,sp
	ld	sp,hl
;fat_access.c:351: fatfs_lfn_cache_init(&lfn, TRUE);
	ld	hl, &0014
	add	hl,sp
	ld	(ix-16 ),l
	ld	(ix-15 ),h
	ld	l,(ix-16 )
	ld	h,(ix-15 )
	ld	bc, &0001
	push	bc
	push	hl
	call	_fatfs_lfn_cache_init
	pop	af
	pop	af
;fat_access.c:354: while (TRUE)
	ld	a,(ix+4 )
	ld	(ix-8 ),a
	ld	a,(ix+5 )
	ld	(ix-7 ),a
	ld	(ix-112 ), &00
	ld	(ix-111 ), &00
fatfs_get_file_entry_00131:
;fat_access.c:357: if (fatfs_sector_reader(fs, Cluster, x++, FALSE)) // If sector read was successfull
	ld	e,(ix-112 )
	ld	d,(ix-111 )
	inc	(ix-112 )
	jr	NZ,fatfs_get_file_entry_00194
	inc	(ix-111 )
fatfs_get_file_entry_00194:
	ld	a,d
	rla
	sbc	a, a
	ld	l,a
	ld	h,a
	ld	bc, &0000
	push	bc
	push	hl
	push	de
	ld	l,(ix+8 )
	ld	h,(ix+9 )
	push	hl
	ld	l,(ix+6 )
	ld	h,(ix+7 )
	push	hl
	ld	l,(ix-8 )
	ld	h,(ix-7 )
	push	hl
	call	_fatfs_sector_reader
	ld	iy, &000C
	add	iy,sp
	ld	sp,iy
	ld	c,l
	ld	a, h
	or	c
	jp	Z,fatfs_get_file_entry_00132
;fat_access.c:360: for (item = 0; item < FAT_DIR_ENTRIES_PER_SECTOR; item++)
	ld	a,(ix-16 )
	ld	(ix-2 ),a
	ld	a,(ix-15 )
	ld	(ix-1 ),a
	ld	a,(ix-16 )
	ld	(ix-4 ),a
	ld	a,(ix-15 )
	ld	(ix-3 ),a
	ld	hl, &0000
	add	hl,sp
	ld	(ix-10 ),l
	ld	(ix-9 ),h
	ld	a,(ix-10 )
	ld	(ix-12 ),a
	ld	a,(ix-9 )
	ld	(ix-11 ),a
	ld	a,(ix-16 )
	ld	(ix-6 ),a
	ld	a,(ix-15 )
	ld	(ix-5 ),a
	ld	a,(ix-16 )
	ld	(ix-14 ),a
	ld	a,(ix-15 )
	ld	(ix-13 ),a
	ld	a,(ix-16 )
	ld	(ix-22 ),a
	ld	a,(ix-15 )
	ld	(ix-21 ),a
	ld	a,(ix-16 )
	ld	(ix-25 ),a
	ld	a,(ix-15 )
	ld	(ix-24 ),a
	ld	a,(ix-8 )
	add	a,  &23
	ld	(ix-18 ),a
	ld	a,(ix-7 )
	adc	a,  &00
	ld	(ix-17 ),a
	ld	(ix-110 ), &00
fatfs_get_file_entry_00137:
;fat_access.c:363: recordoffset = FAT_DIR_ENTRY_SIZE * item;
	ld	l,(ix-110 )
	ld	h, &00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
;fat_access.c:366: directoryEntry = (struct fat_dir_entry*)(fs->currentsector.sector+recordoffset);
	ld	e,(ix-18 )
	ld	d,(ix-17 )
	add	hl,de
	ld	(ix-109 ),l
	ld	(ix-108 ),h
;fat_access.c:370: if (fatfs_entry_lfn_text(directoryEntry) )
	push	hl
	ld	c,(ix-109 )
	ld	b,(ix-108 )
	push	bc
	call	_fatfs_entry_lfn_text
	pop	af
	ld	d,l
	ld	b,h
	pop	hl
	ld	a,b
	or	d
	jr	Z,fatfs_get_file_entry_00124
;fat_access.c:371: fatfs_lfn_cache_entry(&lfn, fs->currentsector.sector+recordoffset);
	ld	e,(ix-25 )
	ld	d,(ix-24 )
	push	hl
	push	de
	call	_fatfs_lfn_cache_entry
	pop	af
	pop	af
	jp	fatfs_get_file_entry_00138
fatfs_get_file_entry_00124:
;fat_access.c:374: else if (fatfs_entry_lfn_invalid(directoryEntry) )
	ld	l,(ix-109 )
	ld	h,(ix-108 )
	push	hl
	call	_fatfs_entry_lfn_invalid
	pop	af
	ld	a,h
	or	l
	jr	Z,fatfs_get_file_entry_00121
;fat_access.c:375: fatfs_lfn_cache_init(&lfn, FALSE);
	ld	l,(ix-22 )
	ld	h,(ix-21 )
	ld	bc, &0000
	push	bc
	push	hl
	call	_fatfs_lfn_cache_init
	pop	af
	pop	af
	jp	fatfs_get_file_entry_00138
fatfs_get_file_entry_00121:
;fat_access.c:378: else if (fatfs_entry_lfn_exists(&lfn, directoryEntry) )
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	ld	c,(ix-109 )
	ld	b,(ix-108 )
	push	bc
	push	hl
	call	_fatfs_entry_lfn_exists
	pop	af
	pop	af
;fat_access.c:385: memcpy(sfEntry,directoryEntry,sizeof(struct fat_dir_entry));
	ld	a,(ix+12 )
	ld	(ix-20 ),a
	ld	a,(ix+13 )
	ld	(ix-19 ),a
	ld	a,(ix-109 )
	ld	(ix-27 ),a
	ld	a,(ix-108 )
	ld	(ix-26 ),a
;fat_access.c:378: else if (fatfs_entry_lfn_exists(&lfn, directoryEntry) )
	ld	a,h
	or	l
	jr	Z,fatfs_get_file_entry_00118
;fat_access.c:380: long_filename = fatfs_lfn_cache_get(&lfn);
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	push	hl
	call	_fatfs_lfn_cache_get
	pop	af
;fat_access.c:383: if (fatfs_compare_names(long_filename, name_to_find))
	ld	c,(ix+10 )
	ld	b,(ix+11 )
	push	bc
	push	hl
	call	_fatfs_compare_names
	pop	af
	pop	af
	ld	a,h
	or	l
	jr	Z,fatfs_get_file_entry_00102
;fat_access.c:385: memcpy(sfEntry,directoryEntry,sizeof(struct fat_dir_entry));
	ld	e,(ix-20 )
	ld	d,(ix-19 )
	ld	l,(ix-27 )
	ld	h,(ix-26 )
	ld	bc, &0020
	ldir
;fat_access.c:386: return 1;
	ld	hl, &0001
	ld	de, &0000
	jp	fatfs_get_file_entry_00139
fatfs_get_file_entry_00102:
;fat_access.c:389: fatfs_lfn_cache_init(&lfn, FALSE);
	ld	l,(ix-14 )
	ld	h,(ix-13 )
	ld	bc, &0000
	push	bc
	push	hl
	call	_fatfs_lfn_cache_init
	pop	af
	pop	af
	jp	fatfs_get_file_entry_00138
fatfs_get_file_entry_00118:
;fat_access.c:394: if (fatfs_entry_sfn_only(directoryEntry) )
	ld	l,(ix-109 )
	ld	h,(ix-108 )
	push	hl
	call	_fatfs_entry_sfn_only
	pop	af
	ld	a,h
	or	l
	jp	Z,fatfs_get_file_entry_00138
;fat_access.c:396: z80_memset(short_filename, 0, sizeof(short_filename));
	ld	e,(ix-10 )
	ld	d,(ix-9 )
	ld	hl, &000D
	push	hl
	xor	 a
	push	af
	inc	sp
	push	de
	call	_z80_memset
	pop	af
	pop	af
	inc	sp
;fat_access.c:399: for (i=0; i<8; i++)
	ld	e, &00
fatfs_get_file_entry_00133:
;fat_access.c:400: short_filename[i] = directoryEntry->Name[i];
	ld	a,(ix-10 )
	add	a, e
	ld	c,a
	ld	a,(ix-9 )
	adc	a,  &00
	ld	b,a
	ld	l,(ix-109 )
	ld	h,(ix-108 )
	ld	d, &00
	add	hl, de
	ld	a,(hl)
	ld	(bc),a
;fat_access.c:399: for (i=0; i<8; i++)
	inc	e
	ld	a,e
	sub	  &08
	jr	C,fatfs_get_file_entry_00133
;fat_access.c:403: dotRequired = 0;
	ld	(ix-114 ), &00
	ld	(ix-113 ), &00
;fat_access.c:404: for (i=8; i<11; i++)
	ld	l, &08
fatfs_get_file_entry_00135:
;fat_access.c:406: short_filename[i+1] = directoryEntry->Name[i];
	ld	a,l
	inc	a
	ld	(ix-23 ),a
	ld	a,(ix-10 )
	add	a, (ix-23 )
	ld	e,a
	ld	a,(ix-9 )
	adc	a,  &00
	ld	d,a
	ld	a,(ix-109 )
	add	a, l
	ld	c,a
	ld	a,(ix-108 )
	adc	a,  &00
	ld	b,a
	ld	a,(bc)
	ld	(de),a
;fat_access.c:407: if (directoryEntry->Name[i] != (unsigned char)' ')
	ld	a,(bc)
	sub	  &20
	jr	Z,fatfs_get_file_entry_00136
;fat_access.c:408: dotRequired = 1;
	ld	(ix-114 ), &01
	ld	(ix-113 ), &00
fatfs_get_file_entry_00136:
;fat_access.c:404: for (i=8; i<11; i++)
	ld	l,(ix-23 )
	ld	a,(ix-23 )
	sub	  &0B
	jr	C,fatfs_get_file_entry_00135
;fat_access.c:416: short_filename[8] = '.';
	ld	a,(ix-10 )
	add	a,  &08
	ld	e,a
	ld	a,(ix-9 )
	adc	a,  &00
	ld	d,a
;fat_access.c:412: if (dotRequired)
	ld	a,(ix-113 )
	or	(ix-114 )
	jr	Z,fatfs_get_file_entry_00111
;fat_access.c:415: if (short_filename[0]!='.')
	ld	l,(ix-10 )
	ld	h,(ix-9 )
	ld	a,(hl)
	sub	  &2E
	jr	Z,fatfs_get_file_entry_00108
;fat_access.c:416: short_filename[8] = '.';
	ld	a, &2E
	ld	(de),a
	jr	fatfs_get_file_entry_00112
fatfs_get_file_entry_00108:
;fat_access.c:418: short_filename[8] = ' ';
	ld	a, &20
	ld	(de),a
	jr	fatfs_get_file_entry_00112
fatfs_get_file_entry_00111:
;fat_access.c:421: short_filename[8] = ' ';
	ld	a, &20
	ld	(de),a
fatfs_get_file_entry_00112:
;fat_access.c:424: if (fatfs_compare_names(short_filename, name_to_find))
	ld	l,(ix-12 )
	ld	h,(ix-11 )
	ld	c,(ix+10 )
	ld	b,(ix+11 )
	push	bc
	push	hl
	call	_fatfs_compare_names
	pop	af
	pop	af
	ld	a,h
	or	l
	jr	Z,fatfs_get_file_entry_00114
;fat_access.c:426: memcpy(sfEntry,directoryEntry,sizeof(struct fat_dir_entry));
	ld	e,(ix-20 )
	ld	d,(ix-19 )
	ld	l,(ix-27 )
	ld	h,(ix-26 )
	ld	bc, &0020
	ldir
;fat_access.c:427: return 1;
	ld	hl, &0001
	ld	de, &0000
	jr	fatfs_get_file_entry_00139
fatfs_get_file_entry_00114:
;fat_access.c:430: fatfs_lfn_cache_init(&lfn, FALSE);
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	ld	bc, &0000
	push	bc
	push	hl
	call	_fatfs_lfn_cache_init
	pop	af
	pop	af
fatfs_get_file_entry_00138:
;fat_access.c:360: for (item = 0; item < FAT_DIR_ENTRIES_PER_SECTOR; item++)
	inc	(ix-110 )
	ld	a,(ix-110 )
	sub	  &10
	jp	C,fatfs_get_file_entry_00137
	jp	fatfs_get_file_entry_00131
;fat_access.c:435: break;
fatfs_get_file_entry_00132:
;fat_access.c:438: return 0;
	ld	hl, &0000
	ld	e,l
	ld	d,h
fatfs_get_file_entry_00139:
	ld	sp,ix
	pop	ix
	ret
_fatfs_get_file_entry_end:
;fat_access.c:444: void fatfs_list_directory_start(struct fatfs *fs, struct fs_dir_list_status *dirls, UINT32 StartCluster)
;	---------------------------------
; Function fatfs_list_directory_start
; ---------------------------------
_fatfs_list_directory_start_start:
_fatfs_list_directory_start:
;fat_access.c:446: dirls->cluster = StartCluster;
	ld	hl, 4
	add	hl, sp
	ld	e, (hl)
	inc	hl
	ld	d, (hl)
	ld	hl, &0004
	add	hl,de
	push	de
	ex	de,hl
	ld	hl,  &0008
	add	hl, sp
	ld	bc,  &0004
	ldir
	pop	de
;fat_access.c:447: dirls->sector = 0;
	ld	l, e
	ld	h, d
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
	inc	hl
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;fat_access.c:448: dirls->offset = 0;
	ld	hl, &0008
	add	hl,de
	ld	(hl), &00
	ret
_fatfs_list_directory_start_end:
;fat_access.c:456: int fatfs_list_directory_next(struct fatfs *fs, struct fs_dir_list_status *dirls, struct fs_dir_ent *entry)
;	---------------------------------
; Function fatfs_list_directory_next
; ---------------------------------
_fatfs_list_directory_next_start:
_fatfs_list_directory_next:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-138
	add	hl,sp
	ld	sp,hl
;fat_access.c:470: fatfs_lfn_cache_init(&lfn, FALSE);
	ld	hl, &0011
	add	hl,sp
	ld	(ix-32 ),l
	ld	(ix-31 ),h
	ld	l,(ix-32 )
	ld	h,(ix-31 )
	ld	bc, &0000
	push	bc
	push	hl
	call	_fatfs_lfn_cache_init
	pop	af
	pop	af
;fat_access.c:472: while (TRUE)
	ld	a,(ix+4 )
	ld	(ix-12 ),a
	ld	a,(ix+5 )
	ld	(ix-11 ),a
fatfs_list_directory_next_00136:
;fat_access.c:475: if (fatfs_sector_reader(fs, dirls->cluster, dirls->sector, FALSE))
	ld	a,(ix+6 )
	ld	(ix-2 ),a
	ld	a,(ix+7 )
	ld	(ix-1 ),a
	ld	e,(ix-2 )
	ld	d,(ix-1 )
	ld	hl,  &0080
	add	hl, sp
	ex	de, hl
	ld	bc,  &0004
	ldir
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	ld	de,  &0004
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	hl, &0000
	push	hl
	ld	l,(ix-8 )
	ld	h,(ix-7 )
	push	hl
	ld	l,(ix-10 )
	ld	h,(ix-9 )
	push	hl
	push	bc
	push	de
	ld	l,(ix-12 )
	ld	h,(ix-11 )
	push	hl
	call	_fatfs_sector_reader
	ld	iy, &000C
	add	iy,sp
	ld	sp,iy
	ld	(ix-9 ),h
	ld	(ix-10 ),l
	ld	a,(ix-9 )
	or	(ix-10 )
	jp	Z,fatfs_list_directory_next_00137
;fat_access.c:480: for (item = dirls->offset; item < FAT_DIR_ENTRIES_PER_SECTOR; item++)
	ld	a,(ix-2 )
	add	a,  &08
	ld	(ix-10 ),a
	ld	a,(ix-1 )
	adc	a,  &00
	ld	(ix-9 ),a
	ld	l,(ix-10 )
	ld	h,(ix-9 )
	ld	a,(hl)
	ld	(ix-40 ),a
	ld	a,(ix-12 )
	add	a,  &23
	ld	(ix-30 ),a
	ld	a,(ix-11 )
	adc	a,  &00
	ld	(ix-29 ),a
	ld	a,(ix-32 )
	ld	(ix-18 ),a
	ld	a,(ix-31 )
	ld	(ix-17 ),a
	ld	a,(ix-32 )
	ld	(ix-34 ),a
	ld	a,(ix-31 )
	ld	(ix-33 ),a
	ld	a,(ix-32 )
	ld	(ix-20 ),a
	ld	a,(ix-31 )
	ld	(ix-19 ),a
	ld	a,(ix-40 )
	ld	(ix-6 ),a
fatfs_list_directory_next_00143:
	ld	a,(ix-6 )
	sub	  &10
	jp	NC,fatfs_list_directory_next_00131
;fat_access.c:483: recordoffset = FAT_DIR_ENTRY_SIZE * item;
	ld	l,(ix-6 )
	ld	h, &00
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
;fat_access.c:486: directoryEntry = (struct fat_dir_entry*)(fs->currentsector.sector+recordoffset);
	ld	e,(ix-30 )
	ld	d,(ix-29 )
	add	hl,de
	ld	(ix-123 ),l
	ld	(ix-122 ),h
;fat_access.c:490: if ( fatfs_entry_lfn_text(directoryEntry) )
	push	hl
	ld	c,(ix-123 )
	ld	b,(ix-122 )
	push	bc
	call	_fatfs_entry_lfn_text
	pop	af
	ld	d,l
	ld	b,h
	pop	hl
	ld	a,b
	or	d
	jr	Z,fatfs_list_directory_next_00129
;fat_access.c:491: fatfs_lfn_cache_entry(&lfn, fs->currentsector.sector+recordoffset);
	ld	e,(ix-20 )
	ld	d,(ix-19 )
	push	hl
	push	de
	call	_fatfs_lfn_cache_entry
	pop	af
	pop	af
	jp	fatfs_list_directory_next_00144
fatfs_list_directory_next_00129:
;fat_access.c:493: else if(directoryEntry->Name[0]==FILE_HEADER_BLANK)
	ld	l,(ix-123 )
	ld	h,(ix-122 )
	ld	a,(hl)
	or	 a
	jr	NZ,fatfs_list_directory_next_00126
;fat_access.c:494: return 0;
	ld	hl, &0000
	jp	fatfs_list_directory_next_00145
fatfs_list_directory_next_00126:
;fat_access.c:497: else if ( fatfs_entry_lfn_invalid(directoryEntry) )
	ld	l,(ix-123 )
	ld	h,(ix-122 )
	push	hl
	call	_fatfs_entry_lfn_invalid
	pop	af
	ld	a,h
	or	l
	jr	Z,fatfs_list_directory_next_00123
;fat_access.c:498: fatfs_lfn_cache_init(&lfn, FALSE);
	ld	l,(ix-34 )
	ld	h,(ix-33 )
	ld	bc, &0000
	push	bc
	push	hl
	call	_fatfs_lfn_cache_init
	pop	af
	pop	af
	jp	fatfs_list_directory_next_00144
fatfs_list_directory_next_00123:
;fat_access.c:501: else if (fatfs_entry_lfn_exists(&lfn, directoryEntry) )
	ld	l,(ix-18 )
	ld	h,(ix-17 )
	ld	c,(ix-123 )
	ld	b,(ix-122 )
	push	bc
	push	hl
	call	_fatfs_entry_lfn_exists
	pop	af
	pop	af
;fat_access.c:505: fat_strncpy(entry->filename, long_filename, FATFS_MAX_LONG_FILENAME-1);
	ld	a,(ix+8 )
	ld	(ix-39 ),a
	ld	a,(ix+9 )
	ld	(ix-38 ),a
;fat_access.c:508: entry->is_dir = 1;
	ld	a,(ix-39 )
	add	a,  &04
	ld	(ix-36 ),a
	ld	a,(ix-38 )
	adc	a,  &01
	ld	(ix-35 ),a
;fat_access.c:516: dirls->offset = item + 1;
	ld	a,(ix-40 )
	inc	a
	ld	(ix-3 ),a
;fat_access.c:512: entry->size = ENDIAN_32BIT(directoryEntry->FileSize);
	ld	a,(ix-39 )
	add	a,  &09
	ld	(ix-22 ),a
	ld	a,(ix-38 )
	adc	a,  &01
	ld	(ix-21 ),a
;fat_access.c:513: entry->cluster = (((unsigned long)ENDIAN_16BIT(directoryEntry->FstClusHI))<<16) | ENDIAN_16BIT(directoryEntry->FstClusLO);
	ld	a,(ix-39 )
	add	a,  &05
	ld	(ix-5 ),a
	ld	a,(ix-38 )
	adc	a,  &01
	ld	(ix-4 ),a
;fat_access.c:501: else if (fatfs_entry_lfn_exists(&lfn, directoryEntry) )
	ld	a,h
	or	l
	jp	Z,fatfs_list_directory_next_00120
;fat_access.c:504: long_filename = fatfs_lfn_cache_get(&lfn);
	ld	l,(ix-32 )
	ld	h,(ix-31 )
	push	hl
	call	_fatfs_lfn_cache_get
	pop	af
;fat_access.c:505: fat_strncpy(entry->filename, long_filename, FATFS_MAX_LONG_FILENAME-1);
	ld	bc, &0103
	push	bc
	push	hl
	ld	l,(ix-39 )
	ld	h,(ix-38 )
	push	hl
	call	_fat_strncpy
	ld	hl, &0006
	add	hl,sp
	ld	sp,hl
;fat_access.c:507: if (fatfs_entry_is_dir(directoryEntry))
	ld	l,(ix-123 )
	ld	h,(ix-122 )
	push	hl
	call	_fatfs_entry_is_dir
	pop	af
	ld	a,h
	or	l
	jr	Z,fatfs_list_directory_next_00102
;fat_access.c:508: entry->is_dir = 1;
	ld	l,(ix-36 )
	ld	h,(ix-35 )
	ld	(hl), &01
	jr	fatfs_list_directory_next_00103
fatfs_list_directory_next_00102:
;fat_access.c:510: entry->is_dir = 0;
	ld	l,(ix-36 )
	ld	h,(ix-35 )
	ld	(hl), &00
fatfs_list_directory_next_00103:
;fat_access.c:512: entry->size = ENDIAN_32BIT(directoryEntry->FileSize);
	ld	l,(ix-123 )
	ld	h,(ix-122 )
	ld	de,  &001C
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	l,(ix-22 )
	ld	h,(ix-21 )
	ld	(hl),e
	inc	hl
	ld	(hl),d
	inc	hl
	ld	(hl),c
	inc	hl
	ld	(hl),b
;fat_access.c:513: entry->cluster = (((unsigned long)ENDIAN_16BIT(directoryEntry->FstClusHI))<<16) | ENDIAN_16BIT(directoryEntry->FstClusLO);
	ld	l,(ix-123 )
	ld	h,(ix-122 )
	ld	de,  &0014
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	bc, &0000
	ld	a, &10
fatfs_list_directory_next_00203:
	sla	e
	rl	d
	rl	c
	rl	b
	dec	a
	jr	NZ,fatfs_list_directory_next_00203
	ld	l,(ix-123 )
	ld	h,(ix-122 )
	push	bc
	ld	bc,  &001A
	add	hl, bc
	pop	bc
	ld	a, (hl)
	inc	hl
	ld	l,(hl)
	ld	(ix-26 ), a
	ld	(ix-25 ),l
	ld	(ix-24 ), &00
	ld	(ix-23 ), &00
	ld	a,e
	or	 (ix-26 )
	ld	e,a
	ld	a,d
	or	 (ix-25 )
	ld	d,a
	ld	a,c
	or	 (ix-24 )
	ld	c,a
	ld	a,b
	or	 (ix-23 )
	ld	b,a
	ld	l,(ix-5 )
	ld	h,(ix-4 )
	ld	(hl),e
	inc	hl
	ld	(hl),d
	inc	hl
	ld	(hl),c
	inc	hl
	ld	(hl),b
;fat_access.c:516: dirls->offset = item + 1;
	ld	l,(ix-10 )
	ld	h,(ix-9 )
	ld	a,(ix-3 )
	ld	(hl),a
;fat_access.c:518: return 1;
	ld	hl, &0001
	jp	fatfs_list_directory_next_00145
fatfs_list_directory_next_00120:
;fat_access.c:523: if ( fatfs_entry_sfn_only(directoryEntry) )
	ld	l,(ix-123 )
	ld	h,(ix-122 )
	push	hl
	call	_fatfs_entry_sfn_only
	pop	af
	ld	a,h
	or	l
	jp	Z,fatfs_list_directory_next_00144
;fat_access.c:525: fatfs_lfn_cache_init(&lfn, FALSE);
	ld	l,(ix-32 )
	ld	h,(ix-31 )
	ld	bc, &0000
	push	bc
	push	hl
	call	_fatfs_lfn_cache_init
	pop	af
	pop	af
;fat_access.c:527: z80_memset(short_filename, 0, sizeof(short_filename));
	ld	hl, &0002
	add	hl,sp
	ld	(ix-26 ),l
	ld	(ix-25 ),h
	ex	de,hl
	ld	hl, &000D
	push	hl
	xor	 a
	push	af
	inc	sp
	push	de
	call	_z80_memset
	pop	af
	pop	af
	inc	sp
;fat_access.c:530: for (i=0; i<8; i++)
	ld	(ix-41 ), &00
fatfs_list_directory_next_00138:
;fat_access.c:531: short_filename[i] = directoryEntry->Name[i];
	ld	a,(ix-26 )
	add	a, (ix-41 )
	ld	e,a
	ld	a,(ix-25 )
	adc	a,  &00
	ld	d,a
	ld	a,(ix-123 )
	add	a, (ix-41 )
	ld	l,a
	ld	a,(ix-122 )
	adc	a,  &00
	ld	h,a
	ld	a,(hl)
	ld	(de),a
;fat_access.c:530: for (i=0; i<8; i++)
	inc	(ix-41 )
	ld	a,(ix-41 )
	sub	  &08
	jr	C,fatfs_list_directory_next_00138
;fat_access.c:534: dotRequired = 0;
	ld	hl, &0000
	ex	(sp), hl
;fat_access.c:535: for (i=8; i<11; i++)
	ld	l, &08
fatfs_list_directory_next_00140:
;fat_access.c:537: short_filename[i+1] = directoryEntry->Name[i];
	ld	a,l
	inc	a
	ld	(ix-37 ),a
	ld	a,(ix-26 )
	add	a, (ix-37 )
	ld	e,a
	ld	a,(ix-25 )
	adc	a,  &00
	ld	d,a
	ld	a,(ix-123 )
	add	a, l
	ld	c,a
	ld	a,(ix-122 )
	adc	a,  &00
	ld	b,a
	ld	a,(bc)
	ld	(de),a
;fat_access.c:538: if (directoryEntry->Name[i] != (unsigned char)' ')
	ld	a,(bc)
	sub	  &20
	jr	Z,fatfs_list_directory_next_00141
;fat_access.c:539: dotRequired = 1;
	ld	hl, &0001
	ex	(sp), hl
fatfs_list_directory_next_00141:
;fat_access.c:535: for (i=8; i<11; i++)
	ld	l,(ix-37 )
	ld	a,(ix-37 )
	sub	  &0B
	jr	C,fatfs_list_directory_next_00140
;fat_access.c:547: short_filename[8] = '.';
	ld	a,(ix-26 )
	add	a,  &08
	ld	(ix-28 ),a
	ld	a,(ix-25 )
	adc	a,  &00
	ld	(ix-27 ),a
;fat_access.c:543: if (dotRequired)
	ld	hl, 0+1
	add	hl, sp
	ld	a, (hl)
	dec	hl
	or	(hl)
	jr	Z,fatfs_list_directory_next_00112
;fat_access.c:546: if (short_filename[0]!='.')
	ld	l,(ix-26 )
	ld	h,(ix-25 )
	ld	a,(hl)
	ld	(ix-37 ), a
	sub	  &2E
	jr	Z,fatfs_list_directory_next_00109
;fat_access.c:547: short_filename[8] = '.';
	ld	l,(ix-28 )
	ld	h,(ix-27 )
	ld	(hl), &2E
	jr	fatfs_list_directory_next_00113
fatfs_list_directory_next_00109:
;fat_access.c:549: short_filename[8] = ' ';
	ld	l,(ix-28 )
	ld	h,(ix-27 )
	ld	(hl), &20
	jr	fatfs_list_directory_next_00113
fatfs_list_directory_next_00112:
;fat_access.c:552: short_filename[8] = ' ';
	ld	l,(ix-28 )
	ld	h,(ix-27 )
	ld	(hl), &20
fatfs_list_directory_next_00113:
;fat_access.c:554: fat_strncpy(entry->filename, short_filename, FATFS_MAX_LONG_FILENAME-1);
	ld	a,(ix-26 )
	ld	(ix-28 ),a
	ld	a,(ix-25 )
	ld	(ix-27 ),a
	ld	hl, &0103
	push	hl
	ld	l,(ix-28 )
	ld	h,(ix-27 )
	push	hl
	ld	l,(ix-39 )
	ld	h,(ix-38 )
	push	hl
	call	_fat_strncpy
	ld	hl, &0006
	add	hl,sp
	ld	sp,hl
;fat_access.c:556: if (fatfs_entry_is_dir(directoryEntry)) 
	ld	l,(ix-123 )
	ld	h,(ix-122 )
	push	hl
	call	_fatfs_entry_is_dir
	pop	af
	ld	a,h
	or	l
	jr	Z,fatfs_list_directory_next_00115
;fat_access.c:557: entry->is_dir = 1; 
	ld	l,(ix-36 )
	ld	h,(ix-35 )
	ld	(hl), &01
	jr	fatfs_list_directory_next_00116
fatfs_list_directory_next_00115:
;fat_access.c:559: entry->is_dir = 0;
	ld	l,(ix-36 )
	ld	h,(ix-35 )
	ld	(hl), &00
fatfs_list_directory_next_00116:
;fat_access.c:561: entry->size = ENDIAN_32BIT(directoryEntry->FileSize);
	ld	c,(ix-123 )
	ld	b,(ix-122 )
	push	bc
	pop	iy
	ld	a,(iy+28 )
	ld	(ix-26 ),a
	ld	a,(iy+29 )
	ld	(ix-25 ),a
	ld	a,(iy+30 )
	ld	(ix-24 ),a
	ld	a,(iy+31 )
	ld	(ix-23 ),a
	ld	e,(ix-22 )
	ld	d,(ix-21 )
	ld	hl,  &0070
	add	hl, sp
	ld	bc,  &0004
	ldir
;fat_access.c:562: entry->cluster = (((unsigned long)ENDIAN_16BIT(directoryEntry->FstClusHI))<<16) | ENDIAN_16BIT(directoryEntry->FstClusLO);
	ld	a,(ix-123 )
	ld	(ix-28 ),a
	ld	a,(ix-122 )
	ld	(ix-27 ),a
	ld	l,(ix-28 )
	ld	h,(ix-27 )
	ld	de,  &0014
	add	hl, de
	ld	a,(hl)
	ld	(ix-28 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-27 ),a
	ld	a,(ix-28 )
	ld	(ix-26 ),a
	ld	a,(ix-27 )
	ld	(ix-25 ),a
	ld	(ix-24 ), &00
	ld	(ix-23 ), &00
	push	af
	pop	af
	ld	b, &10
fatfs_list_directory_next_00207:
	sla	(ix-26 )
	rl	(ix-25 )
	rl	(ix-24 )
	rl	(ix-23 )
	djnz	fatfs_list_directory_next_00207
	ld	a,(ix-123 )
	ld	(ix-28 ),a
	ld	a,(ix-122 )
	ld	(ix-27 ),a
	ld	l,(ix-28 )
	ld	h,(ix-27 )
	ld	de,  &001A
	add	hl, de
	ld	a,(hl)
	ld	(ix-28 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-27 ),a
	ld	a,(ix-28 )
	ld	(ix-16 ),a
	ld	a,(ix-27 )
	ld	(ix-15 ),a
	ld	(ix-14 ), &00
	ld	(ix-13 ), &00
	ld	a,(ix-16 )
	or	 (ix-26 )
	ld	(ix-16 ),a
	ld	a,(ix-15 )
	or	 (ix-25 )
	ld	(ix-15 ),a
	ld	a,(ix-14 )
	or	 (ix-24 )
	ld	(ix-14 ),a
	ld	a,(ix-13 )
	or	 (ix-23 )
	ld	(ix-13 ),a
	ld	e,(ix-5 )
	ld	d,(ix-4 )
	ld	hl,  &007A
	add	hl, sp
	ld	bc,  &0004
	ldir
;fat_access.c:564: dirls->offset = item + 1;
	ld	l,(ix-10 )
	ld	h,(ix-9 )
	ld	a,(ix-3 )
	ld	(hl),a
;fat_access.c:566: return 1;			
	ld	hl, &0001
	jr	fatfs_list_directory_next_00145
fatfs_list_directory_next_00144:
;fat_access.c:480: for (item = dirls->offset; item < FAT_DIR_ENTRIES_PER_SECTOR; item++)
	inc	(ix-6 )
	ld	a,(ix-6 )
	ld	(ix-40 ),a
	jp	fatfs_list_directory_next_00143
fatfs_list_directory_next_00131:
;fat_access.c:571: dirls->sector++;
	ld	e,(ix-2 )
	ld	d,(ix-1 )
	ld	hl,  &007A
	add	hl, sp
	ex	de, hl
	ld	bc,  &0004
	ldir
	inc	(ix-16 )
	jr	NZ,fatfs_list_directory_next_00209
	inc	(ix-15 )
	jr	NZ,fatfs_list_directory_next_00209
	inc	(ix-14 )
	jr	NZ,fatfs_list_directory_next_00209
	inc	(ix-13 )
fatfs_list_directory_next_00209:
	ld	e,(ix-2 )
	ld	d,(ix-1 )
	ld	hl,  &007A
	add	hl, sp
	ld	bc,  &0004
	ldir
;fat_access.c:572: dirls->offset = 0;
	ld	l,(ix-10 )
	ld	h,(ix-9 )
	ld	(hl), &00
	jp	fatfs_list_directory_next_00136
;fat_access.c:575: break;
fatfs_list_directory_next_00137:
;fat_access.c:578: return result;
	ld	hl, &0000
fatfs_list_directory_next_00145:
	ld	sp,ix
	pop	ix
	ret
_fatfs_list_directory_next_end:

IF NOT DEFINED __divsuchar_rrx_s

; divmixed.s
__divsuchar_rrx_s:
	ld hl, 2+1
	add hl, sp        
	ld e, ( hl )
	dec hl
	ld l, ( hl )
	ld h, 0
	jp __div_signexte

__divuschar_rrx_s:
	ld hl, 2+1
	ld d, h
	add hl,sp
	ld e, ( hl )
	dec hl
	ld l, ( hl )
	ld a, l
	rlca
	sbc a, a
	ld h, a
	jp __div16
	
ENDIF


IF NOT DEFINED __divsint_rrx_s

; divsigned.s
__divsint_rrx_s:
	pop af
	pop hl
	pop de
	push de
	push hl
	push af
	jp __div16

__divschar_rrx_s:
	ld hl, 2+1
	add hl, sp
	ld e, ( hl )
	dec hl
	ld l, ( hl )        
__divschar_rrx_hds:
__div8:
	ld a, l
	rlca
	sbc a, a
	ld h, a
__div_signexte:
	ld a, e
	rlca
	sbc a, a
	ld d, a
__divsint_rrx_hds:
__div16:
	ld a, h
	xor d
	rla
	ld a, h
	push af
	rla
	jr nc, .chkde
	sub a
	sub l
	ld l, a
	sbc a, a
	sub h
	ld h, a
.chkde:
	bit 7, d
	jr z, .dodiv
	sub a
	sub e
	ld e, a
	sbc a, a
	sub d
	ld d, a
        
.dodiv:
	call __divu16

.fix_quotient:
	pop af
	ret nc
	ld b, a
	sub a
	sub l
	ld l, a
	sbc a, a
	sub h
	ld h, a
	ld a, b
	ret

__get_remainder:
    rla
	ex de, hl
	ret nc
	sub a
	sub l
	ld l, a
	sbc a, a
	sub h
	ld h, a
	ret
	
ENDIF


IF NOT DEFINED __divuint_rrx_s

; divunsigned.s
__divuint_rrx_s:
	pop af
	pop hl
	pop de
	push de
	push hl
	push af
	jr __divu16

__divuchar_rrx_s:
	ld hl, 2+1
	add hl, sp
	ld e, ( hl )
	dec hl
	ld l, ( hl )
__divuchar_rrx_hds:
__divu8:
	ld h, 0
	ld d, h
__divuint_rrx_hds:
__divu16:
	ld a, e
	or d
	and &80
	jr nz, .morethan7bits
	or d
	jr nz, .morethan7bits        
.atmost7bits:
	ld b, 16
	adc hl, hl
.dvloop7:
	rla
	sub e
	jr nc, .nodrop7
	add a, e
.nodrop7:
	ccf
	adc hl, hl
	djnz .dvloop7
	ld e, a
	ret

.morethan7bits:
	ld b, 9
	ld a, l
	ld l, h
	ld h, 0
	rr l
.dvloop:
	adc hl,hl
	sbc hl,de
	jr nc, .nodrop
	add hl, de
.nodrop:
	ccf
	rla
	djnz .dvloop
	rl b
	ld d, b
	ld e, a
	ex de, hl
	ret

ENDIF


IF NOT DEFINED __mulint_rrx_s

; mul.s
__mulint_rrx_s:
	pop af
	pop hl
	pop de
	push de
	push hl
	push af	
__muluchar_rrx_hds:
__mulint_rrx_hds:
	ld b, h
	ld c, l
__mul16:
	xor a
	ld l, a
	or b
	ld b, 16
	jr nz, __mul162
	ld b, 8
	ld a, c
__mul161:
	add hl, hl
__mul162:
	rl c
	rla
	jr nc, __mul163
	add hl, de
__mul163:
	djnz __mul161
	ret

ENDIF


IF NOT DEFINED __muluchar_rrx_s

; mulchar.s
__muluchar_rrx_s:
	ld hl, 2+1
	ld d, h
	add hl, sp
	ld e, ( hl )
	dec hl
	ld h, ( hl )
	ld l, d
	ld b, 8
muluchar_rrx_s_loop:
	add hl, hl
	jr nc, muluchar_rrx_s_noadd
	add hl, de
muluchar_rrx_s_noadd:
	djnz muluchar_rrx_s_loop
	ret

__mulsuchar_rrx_s:
	ld hl, 2+1
	ld b, h
	add hl, sp
	ld e, ( hl )
	dec hl
	ld c, ( hl )
	jr signexte

__muluschar_rrx_s:
	ld hl, 2
	ld b, h
	add hl, sp
	ld e, ( hl )
	inc hl
	ld c, ( hl )
	jr signexte

__mulschar_rrx_s:
	ld hl, 2+1
	add hl, sp
	ld e, ( hl )
	dec hl
	ld l, ( hl )
__mulschar_rrx_hds:
	ld c, l
	ld a, l
	rla
	sbc a, a
	ld b, a
signexte:
	ld a, e
	rla
	sbc a, a
	ld d, a
	jp __mul16

ENDIF

