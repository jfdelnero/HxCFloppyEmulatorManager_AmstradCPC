;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 8604 (May 11 2013) (MINGW32)
; This file was generated Sun Oct 15 00:38:05 2017
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
__files:
	ds 820
__fs:
	ds 1077
_currentfolder:
	ds 80
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
__filelib_init:
	ds 2
__filelib_valid:
	ds 2
__open_file_list:
	ds 2
__free_file_list:
	ds 2
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
;fat_filelib.c:76: static FL_FILE* _allocate_file(void)
;	---------------------------------
; Function _allocate_file
; ---------------------------------
__allocate_file:
;fat_filelib.c:79: FL_FILE* file = _free_file_list;
	ld	de,(__free_file_list)
;fat_filelib.c:81: if (file)
	ld	a,d
	or	e
	jr	Z,_allocate_file_00102
;fat_filelib.c:83: _free_file_list = file->next;
	ld	l, e
	ld	h, d
	ld	bc,  &0332
	add	hl, bc
	ld	a,(hl)
	ld	iy,__free_file_list
	ld	(iy+0 ),a
	inc	hl
	ld	a,(hl)
	ld	(__free_file_list + 1),a
;fat_filelib.c:86: file->next = _open_file_list;
	ld	hl, &0332
	add	hl,de
	ld	a,(__open_file_list + 0)
	ld	(hl),a
	inc	hl
	ld	a,(__open_file_list + 1)
	ld	(hl),a
;fat_filelib.c:87: _open_file_list = file;
	ld	(__open_file_list),de
_allocate_file_00102:
;fat_filelib.c:90: return file;
	ex	de,hl
	ret
;fat_filelib.c:118: static void _free_file(FL_FILE* file)
;	---------------------------------
; Function _free_file
; ---------------------------------
__free_file:
	push	ix
	ld	ix,0
	add	ix,sp
;fat_filelib.c:120: FL_FILE* openFile = _open_file_list;
	ld	de,(__open_file_list)
;fat_filelib.c:121: FL_FILE* lastFile = NULL;
	ld	bc, &0000
;fat_filelib.c:124: while (openFile)
_free_file_00106:
	ld	a,d
	or	e
	jr	Z,_free_file_00108
;fat_filelib.c:127: if (openFile == file)
	ld	a,(ix+4 )
	sub	 e
	jr	NZ,_free_file_00105
	ld	a,(ix+5 )
	sub	 d
	jr	NZ,_free_file_00105
;fat_filelib.c:129: if (lastFile)
	ld	a,b
	or	c
	jr	Z,_free_file_00102
;fat_filelib.c:130: lastFile->next = openFile->next;
	ld	hl, &0332
	add	hl,bc
	ld	c,l
	ld	b,h
	ex	de,hl
	ld	de,  &0332
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,e
	ld	(bc),a
	inc	bc
	ld	a,d
	ld	(bc),a
	jr	_free_file_00108
_free_file_00102:
;fat_filelib.c:132: _open_file_list = openFile->next;
	ex	de,hl
	ld	de,  &0332
	add	hl, de
	ld	a,(hl)
	ld	iy,__open_file_list
	ld	(iy+0 ),a
	inc	hl
	ld	a,(hl)
	ld	(__open_file_list + 1),a
;fat_filelib.c:134: break;
	jr	_free_file_00108
_free_file_00105:
;fat_filelib.c:137: lastFile = openFile;
	ld	c, e
	ld	b, d
;fat_filelib.c:138: openFile = openFile->next;
	ex	de,hl
	ld	de,  &0332
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	jr	_free_file_00106
_free_file_00108:
;fat_filelib.c:142: file->next = _free_file_list;
	ld	e,(ix+4 )
	ld	d,(ix+5 )
	ld	hl, &0332
	add	hl,de
	ld	a,(__free_file_list + 0)
	ld	(hl),a
	inc	hl
	ld	a,(__free_file_list + 1)
	ld	(hl),a
;fat_filelib.c:143: _free_file_list = file;
	ld	(__free_file_list),de
	pop	ix
	ret
;fat_filelib.c:154: static int _open_directory(char *path, unsigned long *pathCluster)
;	---------------------------------
; Function _open_directory
; ---------------------------------
__open_directory:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-44
	add	hl,sp
	ld	sp,hl
;fat_filelib.c:162: startcluster = fatfs_get_root_cluster(&_fs);
	ld	hl,__fs
	push	hl
	call	_fatfs_get_root_cluster
	pop	af
	ld	(ix-42 ),l
	ld	(ix-41 ),h
	ld	(ix-40 ),e
	ld	(ix-39 ),d
;fat_filelib.c:165: levels = fatfs_total_path_levels(path);
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	push	hl
	call	_fatfs_total_path_levels
	pop	af
;fat_filelib.c:168: for (sublevel=0;sublevel<(levels+1);sublevel++)
	inc	hl
	ld	c,l
	ld	b,h
	ld	hl, &0000
	ex	(sp), hl
_open_directory_00111:
	ld	a,(ix-44 )
	sub	 c
	ld	a,(ix-43 )
	sbc	a, b
	jp	PO, _open_directory_00130
	xor	  &80
_open_directory_00130:
	jp	P,_open_directory_00109
;fat_filelib.c:170: if (fatfs_get_substring(path, sublevel, currentfolder, sizeof(currentfolder)) == -1)
	ld	hl,_currentfolder
	push	bc
	ld	de, &0050
	push	de
	push	hl
	ld	l,(ix-44 )
	ld	h,(ix-43 )
	push	hl
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	push	hl
	call	_fatfs_get_substring
	pop	af
	pop	af
	pop	af
	pop	af
	pop	bc
	inc	l
	jr	NZ,_open_directory_00102
	inc	h
	jr	NZ,_open_directory_00102
;fat_filelib.c:171: return 0;
	ld	hl, &0000
	jp	_open_directory_00113
_open_directory_00102:
;fat_filelib.c:174: if (fatfs_get_file_entry(&_fs, startcluster, currentfolder,&sfEntry))
	ld	hl, &0006
	add	hl,sp
	ld	(ix-2 ),l
	ld	(ix-1 ),h
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	ld	de,_currentfolder
	push	bc
	push	hl
	push	de
	ld	l,(ix-40 )
	ld	h,(ix-39 )
	push	hl
	ld	l,(ix-42 )
	ld	h,(ix-41 )
	push	hl
	ld	hl,__fs
	push	hl
	call	_fatfs_get_file_entry
	ld	iy, &000A
	add	iy,sp
	ld	sp,iy
	pop	bc
	ld	a,d
	or	 e
	or	 h
	or	l
	jp	Z,_open_directory_00107
;fat_filelib.c:177: if (fatfs_entry_is_dir(&sfEntry))
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	push	bc
	push	hl
	call	_fatfs_entry_is_dir
	pop	af
	pop	bc
	ld	a,h
	or	l
	jr	Z,_open_directory_00104
;fat_filelib.c:178: startcluster = (((unsigned long)ENDIAN_16BIT(sfEntry.FstClusHI))<<16) | ENDIAN_16BIT(sfEntry.FstClusLO);
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	ld	de,  &0014
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	h,(hl)
	ld	l, &00
	ld	d, &00
	push	af
	ld	(ix-6 ),e
	ld	(ix-5 ),h
	ld	(ix-4 ),l
	ld	(ix-3 ),d
	pop	af
	ld	a, &10
_open_directory_00133:
	sla	(ix-6 )
	rl	(ix-5 )
	rl	(ix-4 )
	rl	(ix-3 )
	dec	a
	jr	NZ,_open_directory_00133
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	ld	de,  &001A
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	h,(hl)
	ld	l, &00
	ld	d, &00
	ld	a,e
	or	 (ix-6 )
	ld	e,a
	ld	a,h
	or	 (ix-5 )
	ld	h,a
	ld	a,l
	or	 (ix-4 )
	ld	l,a
	ld	a,d
	or	 (ix-3 )
	ld	d,a
	ld	(ix-42 ),e
	ld	(ix-41 ),h
	ld	(ix-40 ),l
	ld	(ix-39 ),d
	jr	_open_directory_00112
_open_directory_00104:
;fat_filelib.c:180: return 0;
	ld	hl, &0000
	jr	_open_directory_00113
_open_directory_00107:
;fat_filelib.c:183: return 0;
	ld	hl, &0000
	jr	_open_directory_00113
_open_directory_00112:
;fat_filelib.c:168: for (sublevel=0;sublevel<(levels+1);sublevel++)
	inc	(ix-44 )
	jp	NZ,_open_directory_00111
	inc	(ix-43 )
	jp	_open_directory_00111
_open_directory_00109:
;fat_filelib.c:186: *pathCluster = startcluster;
	ld	e,(ix+6 )
	ld	d,(ix+7 )
	ld	hl,  &0002
	add	hl, sp
	ld	bc,  &0004
	ldir
;fat_filelib.c:187: return 1;
	ld	hl, &0001
_open_directory_00113:
	ld	sp,ix
	pop	ix
	ret
;fat_filelib.c:192: static FL_FILE* _open_file(char *path)
;	---------------------------------
; Function _open_file
; ---------------------------------
__open_file:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-38
	add	hl,sp
	ld	sp,hl
;fat_filelib.c:198: file = _allocate_file();
	call	__allocate_file
	ld	c, l
	ld	b, h
;fat_filelib.c:199: if (!file)
	ld	a,b
	or	c
	jr	NZ,_open_file_00102
;fat_filelib.c:200: return NULL;
	ld	hl, &0000
	jp	_open_file_00109
_open_file_00102:
;fat_filelib.c:204: z80_memset(file->filename, '\0', sizeof(file->filename));
	ld	hl, &0012
	add	hl,bc
	ex	de,hl
	push	de
	pop	iy
	push	bc
	push	de
	ld	hl, &0104
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
	push	de
	ld	hl, &0104
	push	hl
	push	de
	ld	hl, &0000
	push	hl
	ld	l,  &00
	push	hl
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	push	hl
	call	_fatfs_split_path
	ld	iy, &000A
	add	iy,sp
	ld	sp,iy
	pop	de
	pop	bc
	inc	l
	jr	NZ,_open_file_00104
	inc	h
	jr	NZ,_open_file_00104
;fat_filelib.c:209: _free_file(file);
	push	bc
	call	__free_file
	pop	af
;fat_filelib.c:210: return NULL;
	ld	hl, &0000
	jp	_open_file_00109
_open_file_00104:
;fat_filelib.c:220: file->parentcluster = fatfs_get_root_cluster(&_fs);
	ld	hl,__fs
	push	bc
	push	de
	push	hl
	call	_fatfs_get_root_cluster
	pop	af
	ld	(ix-1 ),d
	ld	(ix-2 ),e
	ld	(ix-3 ),h
	ld	(ix-4 ),l
	pop	de
	pop	bc
	push	de
	push	bc
	ld	e, c
	ld	d, b
	ld	hl,  &0026
	add	hl, sp
	ld	bc,  &0004
	ldir
	pop	bc
	pop	de
;fat_filelib.c:236: if (fatfs_get_file_entry(&_fs, file->parentcluster, file->filename,&sfEntry))
	ld	hl, &0000
	add	hl,sp
	ld	(ix-6 ),l
	ld	(ix-5 ),h
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	push	bc
	push	hl
	push	de
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	push	hl
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	push	hl
	ld	hl,__fs
	push	hl
	call	_fatfs_get_file_entry
	ld	iy, &000A
	add	iy,sp
	ld	sp,iy
	pop	bc
	ld	a,d
	or	 e
	or	 h
	or	l
	jp	Z,_open_file_00108
;fat_filelib.c:238: if (fatfs_entry_is_file(&sfEntry))
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	push	bc
	push	hl
	call	_fatfs_entry_is_file
	pop	af
	pop	bc
	ld	a,h
	or	l
	jp	Z,_open_file_00108
;fat_filelib.c:241: memcpy(file->shortfilename, sfEntry.Name, FAT_SFN_SIZE_FULL);
	ld	hl, &0116
	add	hl,bc
	ld	e,(ix-6 )
	ld	d,(ix-5 )
	push	bc
	ex	de, hl
	ld	bc, &000B
	ldir
	pop	bc
;fat_filelib.c:242: file->filelength = ENDIAN_32BIT(sfEntry.FileSize);
	ld	iy, &000C
	add	iy, bc
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	ld	de,  &001C
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
	ld	(iy+0 ),e
	ld	(iy+1 ),d
	ld	(iy+2 ),l
	ld	(iy+3 ),h
;fat_filelib.c:243: file->bytenum = 0;
	ld	hl, &0008
	add	hl,bc
	ld	(hl), &00
	inc	hl
	ld	(hl), &00
	inc	hl
	ld	(hl), &00
	inc	hl
	ld	(hl), &00
;fat_filelib.c:244: file->startcluster = (((unsigned long)ENDIAN_16BIT(sfEntry.FstClusHI))<<16) + ENDIAN_16BIT(sfEntry.FstClusLO);
	ld	iy, &0004
	add	iy, bc
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	ld	de,  &0014
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	h,(hl)
	ld	l, &00
	ld	d, &00
	push	af
	ld	(ix-4 ),e
	ld	(ix-3 ),h
	ld	(ix-2 ),l
	ld	(ix-1 ),d
	pop	af
	ld	a, &10
_open_file_00125:
	sla	(ix-4 )
	rl	(ix-3 )
	rl	(ix-2 )
	rl	(ix-1 )
	dec	a
	jr	NZ,_open_file_00125
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	ld	de,  &001A
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	hl, &0000
	ld	a,(ix-4 )
	add	a, e
	ld	e,a
	ld	a,(ix-3 )
	adc	a, d
	ld	d,a
	ld	a,(ix-2 )
	adc	a, l
	ld	l,a
	ld	a,(ix-1 )
	adc	a, h
	ld	h,a
	ld	(iy+0 ),e
	ld	(iy+1 ),d
	ld	(iy+2 ),l
	ld	(iy+3 ),h
;fat_filelib.c:245: file->file_data.address =  &FFFFFFFF;
	ld	hl, &0329
	add	hl,bc
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
;fat_filelib.c:246: file->file_data.dirty = 0;
	ld	hl, &032D
	add	hl,bc
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;fat_filelib.c:247: file->filelength_changed = 0;
	ld	hl, &0010
	add	hl,bc
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;fat_filelib.c:250: file->last_fat_lookup.ClusterIdx =  &FFFFFFFF;
	ld	hl, &0121
	add	hl,bc
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
;fat_filelib.c:251: file->last_fat_lookup.CurrentCluster =  &FFFFFFFF;
	ld	hl, &0125
	add	hl,bc
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
;fat_filelib.c:253: fatfs_cache_init(&_fs, file);
	ld	hl,__fs
	push	bc
	push	bc
	push	hl
	call	_fatfs_cache_init
	pop	af
	pop	af
	pop	bc
;fat_filelib.c:255: fatfs_fat_purge(&_fs);
	ld	hl,__fs
	push	bc
	push	hl
	call	_fatfs_fat_purge
	pop	af
;fat_filelib.c:257: return file;
	pop	hl
	jr	_open_file_00109
_open_file_00108:
;fat_filelib.c:260: _free_file(file);
	push	bc
	call	__free_file
	pop	af
;fat_filelib.c:261: return NULL;
	ld	hl, &0000
_open_file_00109:
	ld	sp,ix
	pop	ix
	ret
;fat_filelib.c:266: static int _read_sector(FL_FILE* file, UINT32 offset)
;	---------------------------------
; Function _read_sector
; ---------------------------------
__read_sector:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-24
	add	hl,sp
	ld	sp,hl
;fat_filelib.c:275: ClusterIdx = offset / _fs.sectors_per_cluster;
	ld	a, (__fs + 0)
	ld	e,a
	ld	d, &00
	ld	hl, &0000
	push	hl
	push	de
	push	hl
	push	de
	ld	l,(ix+8 )
	ld	h,(ix+9 )
	push	hl
	ld	l,(ix+6 )
	ld	h,(ix+7 )
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
	ld	a,(ix+6 )
	sub	 l
	ld	l,a
	ld	a,(ix+7 )
	sbc	a, h
	ld	h,a
	ld	a,(ix+8 )
	sbc	a, e
	ld	e,a
	ld	a,(ix+9 )
	sbc	a, d
	ld	d,a
	ld	(ix-12 ),l
	ld	(ix-11 ),h
	ld	(ix-10 ),e
	ld	(ix-9 ),d
;fat_filelib.c:279: if (ClusterIdx == file->last_fat_lookup.ClusterIdx)
	ld	a,(ix+4 )
	ld	(ix-2 ),a
	ld	a,(ix+5 )
	ld	(ix-1 ),a
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	ld	de,  &0121
	add	hl, de
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	ld	a,(ix-16 )
	sub	 c
	jr	NZ,_read_sector_00111
	ld	a,(ix-15 )
	sub	 b
	jr	NZ,_read_sector_00111
	ld	a,(ix-14 )
	sub	 e
	jr	NZ,_read_sector_00111
	ld	a,(ix-13 )
	sub	 d
	jr	NZ,_read_sector_00111
;fat_filelib.c:280: Cluster = file->last_fat_lookup.CurrentCluster;
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	ld	de,  &0125
	add	hl, de
	ld	a,(hl)
	ld	(ix-20 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-19 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-18 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-17 ),a
	jp	_read_sector_00112
_read_sector_00111:
;fat_filelib.c:285: if (ClusterIdx && ClusterIdx == file->last_fat_lookup.ClusterIdx + 1)
	ld	a,(ix-13 )
	or	 (ix-14 )
	or	 (ix-15 )
	or	(ix-16 )
	jr	Z,_read_sector_00102
	ld	a,c
	add	a,  &01
	ld	(ix-6 ),a
	ld	a,b
	adc	a,  &00
	ld	(ix-5 ),a
	ld	a,e
	adc	a,  &00
	ld	(ix-4 ),a
	ld	a,d
	adc	a,  &00
	ld	(ix-3 ),a
	ld	a,(ix-16 )
	sub	 (ix-6 )
	jr	NZ,_read_sector_00102
	ld	a,(ix-15 )
	sub	 (ix-5 )
	jr	NZ,_read_sector_00102
	ld	a,(ix-14 )
	sub	 (ix-4 )
	jr	NZ,_read_sector_00102
	ld	a,(ix-13 )
	sub	 (ix-3 )
	jr	NZ,_read_sector_00102
;fat_filelib.c:287: i = file->last_fat_lookup.ClusterIdx;
;fat_filelib.c:288: Cluster = file->last_fat_lookup.CurrentCluster;
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	push	bc
	ld	bc,  &0125
	add	hl, bc
	pop	bc
	ld	a,(hl)
	ld	(ix-20 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-19 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-18 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-17 ),a
	jr	_read_sector_00125
_read_sector_00102:
;fat_filelib.c:294: i = 0;
	ld	bc, &0000
	ld	de, &0000
;fat_filelib.c:295: Cluster = file->startcluster;
	push	hl
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	push	hl
	pop	iy
	pop	hl
	ld	a,(iy+4 )
	ld	(ix-20 ),a
	ld	a,(iy+5 )
	ld	(ix-19 ),a
	ld	a,(iy+6 )
	ld	(ix-18 ),a
	ld	a,(iy+7 )
	ld	(ix-17 ),a
_read_sector_00125:
	ld	(ix-6 ),c
	ld	(ix-5 ),b
	ld	(ix-4 ),e
	ld	(ix-3 ),d
_read_sector_00116:
;fat_filelib.c:299: for ( ;i<ClusterIdx; i++)
	ld	a,(ix-6 )
	sub	 (ix-16 )
	ld	a,(ix-5 )
	sbc	a, (ix-15 )
	ld	a,(ix-4 )
	sbc	a, (ix-14 )
	ld	a,(ix-3 )
	sbc	a, (ix-13 )
	jp	NC,_read_sector_00107
;fat_filelib.c:304: if (!fatfs_cache_get_next_cluster(&_fs, file, i, &nextCluster))
	ld	hl, &0000
	add	hl,sp
	ld	(ix-8 ),l
	ld	(ix-7 ),h
	ld	de,__fs
	ld	l,(ix-8 )
	ld	h,(ix-7 )
	push	hl
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	push	hl
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	push	hl
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	push	hl
	push	de
	call	_fatfs_cache_get_next_cluster
	ld	iy, &000A
	add	iy,sp
	ld	sp,iy
	ld	a,h
	or	l
	jr	NZ,_read_sector_00106
;fat_filelib.c:307: nextCluster = fatfs_find_next_cluster(&_fs, Cluster);
	ld	de,__fs
	ld	l,(ix-18 )
	ld	h,(ix-17 )
	push	hl
	ld	l,(ix-20 )
	ld	h,(ix-19 )
	push	hl
	push	de
	call	_fatfs_find_next_cluster
	pop	af
	pop	af
	pop	af
	ex	de, hl
	ld	(ix-24 ),e
	ld	(ix-23 ),d
	ld	(ix-22 ),l
	ld	(ix-21 ),h
;fat_filelib.c:310: fatfs_cache_set_next_cluster(&_fs, file, i, nextCluster);
	ld	bc,__fs
	push	hl
	push	de
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	push	hl
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	push	hl
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	push	hl
	push	bc
	call	_fatfs_cache_set_next_cluster
	ld	hl, &000C
	add	hl,sp
	ld	sp,hl
_read_sector_00106:
;fat_filelib.c:313: Cluster = nextCluster;
	ld	hl, 4
	add	hl, sp
	ex	de, hl
	ld	hl, 0
	add	hl, sp
	ld	bc, 4
	ldir
;fat_filelib.c:299: for ( ;i<ClusterIdx; i++)
	inc	(ix-6 )
	jp	NZ,_read_sector_00116
	inc	(ix-5 )
	jp	NZ,_read_sector_00116
	inc	(ix-4 )
	jp	NZ,_read_sector_00116
	inc	(ix-3 )
	jp	_read_sector_00116
_read_sector_00107:
;fat_filelib.c:317: if (Cluster != FAT32_LAST_CLUSTER)
	ld	a,(ix-20 )
	inc	a
	jr	NZ,_read_sector_00150
	ld	a,(ix-19 )
	inc	a
	jr	NZ,_read_sector_00150
	ld	a,(ix-18 )
	inc	a
	jr	NZ,_read_sector_00150
	ld	a,(ix-17 )
	inc	a
	jr	Z,_read_sector_00112
_read_sector_00150:
;fat_filelib.c:319: file->last_fat_lookup.CurrentCluster = Cluster;
	ld	a,(ix-2 )
	add	a,  &21
	ld	e,a
	ld	a,(ix-1 )
	adc	a,  &01
	ld	d,a
	ld	a,(ix-2 )
	add	a,  &25
	ld	h,a
	ld	a,(ix-1 )
	adc	a,  &01
	ld	l,a
	push	de
	ld	e, h
	ld	d, l
	ld	hl,  &0006
	add	hl, sp
	ld	bc,  &0004
	ldir
	pop	de
;fat_filelib.c:320: file->last_fat_lookup.ClusterIdx = ClusterIdx;
	ld	hl,  &0008
	add	hl, sp
	ld	bc,  &0004
	ldir
_read_sector_00112:
;fat_filelib.c:325: if (Cluster == FAT32_LAST_CLUSTER)
	ld	a,(ix-20 )
	inc	a
	jr	NZ,_read_sector_00114
	ld	a,(ix-19 )
	inc	a
	jr	NZ,_read_sector_00114
	ld	a,(ix-18 )
	inc	a
	jr	NZ,_read_sector_00114
	ld	a,(ix-17 )
	inc	a
	jr	NZ,_read_sector_00114
;fat_filelib.c:326: return 0;
	ld	hl, &0000
	jr	_read_sector_00118
_read_sector_00114:
;fat_filelib.c:329: lba = fatfs_lba_of_cluster(&_fs, Cluster) + Sector;
	ld	de,__fs
	ld	l,(ix-18 )
	ld	h,(ix-17 )
	push	hl
	ld	l,(ix-20 )
	ld	h,(ix-19 )
	push	hl
	push	de
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
	ld	l,a
	ld	a,d
	adc	a, (ix-9 )
	ld	h,a
;fat_filelib.c:332: return fatfs_sector_read(&_fs, lba, file->file_data.sector);
	ld	a,(ix-2 )
	add	a,  &29
	ld	e,a
	ld	a,(ix-1 )
	adc	a,  &01
	ld	d,a
	push	de
	push	hl
	push	bc
	ld	hl,__fs
	push	hl
	call	_fatfs_sector_read
	pop	af
	pop	af
	pop	af
	pop	af
_read_sector_00118:
	ld	sp,ix
	pop	ix
	ret
;fat_filelib.c:342: void fl_init(void)
;	---------------------------------
; Function fl_init
; ---------------------------------
_fl_init_start:
_fl_init:
;fat_filelib.c:347: for (i=0;i<FATFS_MAX_OPEN_FILES;i++)
	ld	de, &0000
fl_init_00102:
;fat_filelib.c:349: _files[i].next = _free_file_list;
	ld	l, e
	ld	h, d
	ld	c, l
	ld	b, h
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	ld	a,__files & 255
	add	a, l
	ld	c,a
	ld	a,__files / 256
	adc	a, h
	ld	b,a
	ld	hl, &0332
	add	hl,bc
	ld	a,(__free_file_list + 0)
	ld	(hl),a
	inc	hl
	ld	a,(__free_file_list + 1)
	ld	(hl),a
;fat_filelib.c:350: _free_file_list = &_files[i];
	ld	(__free_file_list),bc
;fat_filelib.c:347: for (i=0;i<FATFS_MAX_OPEN_FILES;i++)
	inc	de
	ld	a,e
	sub	  &01
	ld	a,d
	rla
	ccf
	rra
	sbc	a,  &80
	jr	C,fl_init_00102
;fat_filelib.c:353: _filelib_init = 1;
	ld	hl,__filelib_init + 0
	ld	(hl),  &01
	ld	hl,__filelib_init + 1
	ld	(hl),  &00
	ret
_fl_init_end:
;fat_filelib.c:358: int fl_attach_media(fn_diskio_read rd, fn_diskio_write wr)
;	---------------------------------
; Function fl_attach_media
; ---------------------------------
_fl_attach_media_start:
_fl_attach_media:
;fat_filelib.c:363: CHECK_FL_INIT();
	ld	a,(__filelib_init + 1)
	ld	hl,__filelib_init + 0
	or	(hl)
	jr	NZ,fl_attach_media_00102
	call	_fl_init
fl_attach_media_00102:
;fat_filelib.c:365: _fs.disk_io.read_sector = rd;
	ld	hl,__fs + 27
	ld	iy,2
	add	iy,sp
	ld	a,(iy+0 )
	ld	(hl),a
	inc	hl
	ld	a,(iy+1 )
	ld	(hl),a
;fat_filelib.c:366: _fs.disk_io.write_sector = wr;
	ld	hl,__fs + 29
	ld	iy,4
	add	iy,sp
	ld	a,(iy+0 )
	ld	(hl),a
	inc	hl
	ld	a,(iy+1 )
	ld	(hl),a
;fat_filelib.c:369: if ((res = fatfs_init(&_fs)) != FAT_INIT_OK)
	ld	hl,__fs
	push	hl
	call	_fatfs_init
	pop	af
	ld	d,l
	ld	a,h
	ld	e,a
	or	l
	jr	Z,fl_attach_media_00104
;fat_filelib.c:372: return res;
	ld	l, d
	ld	h, e
	ret
fl_attach_media_00104:
;fat_filelib.c:375: _filelib_valid = 1;
	ld	hl,__filelib_valid + 0
	ld	(hl),  &01
	ld	hl,__filelib_valid + 1
	ld	(hl),  &00
;fat_filelib.c:376: return FAT_INIT_OK;
	ld	hl, &0000
	ret
_fl_attach_media_end:
;fat_filelib.c:381: void fl_shutdown(void)
;	---------------------------------
; Function fl_shutdown
; ---------------------------------
_fl_shutdown_start:
_fl_shutdown:
;fat_filelib.c:384: CHECK_FL_INIT();
	ld	a,(__filelib_init + 1)
	ld	hl,__filelib_init + 0
	or	(hl)
	jr	NZ,fl_shutdown_00102
	call	_fl_init
fl_shutdown_00102:
;fat_filelib.c:387: fatfs_fat_purge(&_fs);
	ld	hl,__fs
	push	hl
	call	_fatfs_fat_purge
	pop	af
	ret
_fl_shutdown_end:
;fat_filelib.c:393: void* fl_fopen(char *path, const char *mode)
;	---------------------------------
; Function fl_fopen
; ---------------------------------
_fl_fopen_start:
_fl_fopen:
;fat_filelib.c:399: CHECK_FL_INIT();
	ld	a,(__filelib_init + 1)
	ld	hl,__filelib_init + 0
	or	(hl)
	jr	NZ,fl_fopen_00102
	call	_fl_init
fl_fopen_00102:
;fat_filelib.c:401: if (!_filelib_valid)
	ld	a,(__filelib_valid + 1)
	ld	hl,__filelib_valid + 0
	or	(hl)
	jr	NZ,fl_fopen_00104
;fat_filelib.c:402: return NULL;
	ld	hl, &0000
	ret
fl_fopen_00104:
;fat_filelib.c:404: if (!path || !mode)
	ld	hl, 2+1
	add	hl, sp
	ld	a, (hl)
	dec	hl
	or	(hl)
	jr	Z,fl_fopen_00105
	ld	hl, 4+1
	add	hl, sp
	ld	a, (hl)
	dec	hl
	or	(hl)
	jr	NZ,fl_fopen_00106
fl_fopen_00105:
;fat_filelib.c:405: return NULL;
	ld	hl, &0000
	ret
fl_fopen_00106:
;fat_filelib.c:421: file = _open_file(path);
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	call	__open_file
	pop	af
	ex	de,hl
;fat_filelib.c:424: if (file)
	ld	a,d
	or	e
	jr	Z,fl_fopen_00109
;fat_filelib.c:425: file->flags = flags;
	ld	hl, &0331
	add	hl,de
	ld	(hl), &01
fl_fopen_00109:
;fat_filelib.c:428: return file;
	ex	de,hl
	ret
_fl_fopen_end:
;fat_filelib.c:511: void fl_fclose(void *f)
;	---------------------------------
; Function fl_fclose
; ---------------------------------
_fl_fclose_start:
_fl_fclose:
	push	ix
	ld	ix,0
	add	ix,sp
	push	af
;fat_filelib.c:513: FL_FILE *file = (FL_FILE *)f;
	ld	c,(ix+4 )
	ld	b,(ix+5 )
;fat_filelib.c:516: CHECK_FL_INIT();
	ld	a,(__filelib_init + 1)
	ld	iy,__filelib_init
	or	(iy+0 )
	jr	NZ,fl_fclose_00102
	push	bc
	call	_fl_init
	pop	bc
fl_fclose_00102:
;fat_filelib.c:518: if (file)
	ld	a,b
	or	c
	jr	Z,fl_fclose_00107
;fat_filelib.c:526: if (file->filelength_changed)
	ld	hl, &0010
	add	hl,bc
	ex	(sp), hl
	pop	hl
	push	hl
	ld	d,(hl)
	inc	hl
	ld	a, (hl)
	or	d
	jr	Z,fl_fclose_00104
;fat_filelib.c:528: file->filelength_changed = 0;
	pop	hl
	push	hl
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
fl_fclose_00104:
;fat_filelib.c:531: file->bytenum = 0;
	ld	hl, &0008
	add	hl,bc
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
	inc	hl
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;fat_filelib.c:532: file->filelength = 0;
	ld	hl, &000C
	add	hl,bc
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
	inc	hl
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;fat_filelib.c:533: file->startcluster = 0;
	ld	hl, &0004
	add	hl,bc
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
	inc	hl
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;fat_filelib.c:534: file->file_data.address =  &FFFFFFFF;
	ld	hl, &0129
	add	hl,bc
	ex	de,hl
	ld	hl, &0200
	add	hl,de
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
;fat_filelib.c:535: file->file_data.dirty = 0;
	ld	hl, &0204
	add	hl,de
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;fat_filelib.c:536: file->filelength_changed = 0;
	pop	hl
	push	hl
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;fat_filelib.c:539: _free_file(file);
	push	bc
	call	__free_file
;fat_filelib.c:541: fatfs_fat_purge(&_fs);
	ld	hl, __fs
	ex	(sp),hl
	call	_fatfs_fat_purge
	pop	af
fl_fclose_00107:
	ld	sp,ix
	pop	ix
	ret
_fl_fclose_end:
;fat_filelib.c:549: int fl_fread(void * buffer, int size, int length, void *f )
;	---------------------------------
; Function fl_fread
; ---------------------------------
_fl_fread_start:
_fl_fread:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-28
	add	hl,sp
	ld	sp,hl
;fat_filelib.c:554: int count = size * length;
	ld	l,(ix+8 )
	ld	h,(ix+9 )
	push	hl
	ld	l,(ix+6 )
	ld	h,(ix+7 )
	push	hl
	call	__mulint_rrx_s
	pop	af
	pop	af
	ld	(ix-26 ),l
	ld	(ix-25 ),h
;fat_filelib.c:555: int bytesRead = 0;
	ld	(ix-20 ), &00
	ld	(ix-19 ), &00
;fat_filelib.c:560: FL_FILE *file = (FL_FILE *)f;
	ld	a,(ix+10 )
	ld	(ix-18 ),a
	ld	a,(ix+11 )
	ld	(ix-17 ),a
;fat_filelib.c:563: CHECK_FL_INIT();
	ld	a,(__filelib_init + 1)
	ld	iy,__filelib_init
	or	(iy+0 )
	jr	NZ,fl_fread_00102
	call	_fl_init
fl_fread_00102:
;fat_filelib.c:565: if (buffer==NULL || file==NULL)
	ld	a,(ix+5 )
	or	(ix+4 )
	jr	Z,fl_fread_00103
	ld	a,(ix-17 )
	or	(ix-18 )
	jr	NZ,fl_fread_00104
fl_fread_00103:
;fat_filelib.c:566: return -1;
	ld	hl, &FFFF
	jp	fl_fread_00126
fl_fread_00104:
;fat_filelib.c:569: if (!(file->flags & FILE_READ))
	ld	l,(ix-18 )
	ld	h,(ix-17 )
	ld	de,  &0331
	add	hl, de
	ld	a,(hl)
	rrca
	jr	C,fl_fread_00107
;fat_filelib.c:570: return -1;
	ld	hl, &FFFF
	jp	fl_fread_00126
fl_fread_00107:
;fat_filelib.c:573: if (!count)
	ld	a,(ix-25 )
	or	(ix-26 )
	jr	NZ,fl_fread_00109
;fat_filelib.c:574: return 0;
	ld	hl, &0000
	jp	fl_fread_00126
fl_fread_00109:
;fat_filelib.c:577: if (file->bytenum >= file->filelength)
	ld	a,(ix-18 )
	add	a,  &08
	ld	(ix-14 ),a
	ld	a,(ix-17 )
	adc	a,  &00
	ld	(ix-13 ),a
	ld	e,(ix-14 )
	ld	d,(ix-13 )
	ld	hl,  &0014
	add	hl, sp
	ex	de, hl
	ld	bc,  &0004
	ldir
	ld	c,(ix-18 )
	ld	b,(ix-17 )
	push	bc
	pop	iy
	ld	a,(iy+12 )
	ld	(ix-4 ),a
	ld	a,(iy+13 )
	ld	(ix-3 ),a
	ld	a,(iy+14 )
	ld	(ix-2 ),a
	ld	a,(iy+15 )
	ld	(ix-1 ),a
	ld	a,(ix-8 )
	sub	 (ix-4 )
	ld	a,(ix-7 )
	sbc	a, (ix-3 )
	ld	a,(ix-6 )
	sbc	a, (ix-2 )
	ld	a,(ix-5 )
	sbc	a, (ix-1 )
	jr	C,fl_fread_00111
;fat_filelib.c:578: return -1;
	ld	hl, &FFFF
	jp	fl_fread_00126
fl_fread_00111:
;fat_filelib.c:581: if ( (file->bytenum + count) > file->filelength )
	ld	l,(ix-26 )
	ld	h,(ix-25 )
	ld	a,(ix-25 )
	rla
	sbc	a, a
	ld	e,a
	ld	d,a
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
	ld	a,(ix-4 )
	sub	 l
	ld	a,(ix-3 )
	sbc	a, h
	ld	a,(ix-2 )
	sbc	a, e
	ld	a,(ix-1 )
	sbc	a, d
	jr	NC,fl_fread_00113
;fat_filelib.c:582: count = file->filelength - file->bytenum;
	ld	a,(ix-4 )
	sub	 (ix-8 )
	ld	(ix-4 ),a
	ld	a,(ix-3 )
	sbc	a, (ix-7 )
	ld	(ix-3 ),a
	ld	a,(ix-2 )
	sbc	a, (ix-6 )
	ld	(ix-2 ),a
	ld	a,(ix-1 )
	sbc	a, (ix-5 )
	ld	(ix-1 ),a
	ld	a,(ix-4 )
	ld	(ix-26 ),a
	ld	a,(ix-3 )
	ld	(ix-25 ),a
fl_fread_00113:
;fat_filelib.c:585: sector = file->bytenum / FAT_SECTOR_SIZE;
	push	af
	ld	a,(ix-8 )
	ld	(ix-4 ),a
	ld	a,(ix-7 )
	ld	(ix-3 ),a
	ld	a,(ix-6 )
	ld	(ix-2 ),a
	ld	a,(ix-5 )
	ld	(ix-1 ),a
	pop	af
	ld	b, &09
fl_fread_00171:
	srl	(ix-1 )
	rr	(ix-2 )
	rr	(ix-3 )
	rr	(ix-4 )
	djnz	fl_fread_00171
;fat_filelib.c:588: offset = file->bytenum % FAT_SECTOR_SIZE;
	ld	a,(ix-8 )
	ld	(ix-24 ),a
	ld	a,(ix-7 )
	and	  &01
	ld	(ix-23 ),a
	ld	(ix-22 ), &00
	ld	(ix-21 ), &00
;fat_filelib.c:590: while (bytesRead < count)
fl_fread_00123:
	ld	a,(ix-20 )
	sub	 (ix-26 )
	ld	a,(ix-19 )
	sbc	a, (ix-25 )
	jp	PO, fl_fread_00173
	xor	  &80
fl_fread_00173:
	jp	P,fl_fread_00125
;fat_filelib.c:593: if (file->file_data.address != sector)
	ld	a,(ix-18 )
	add	a,  &29
	ld	(ix-8 ),a
	ld	a,(ix-17 )
	adc	a,  &01
	ld	(ix-7 ),a
	ld	a,(ix-8 )
	add	a,  &00
	ld	e,a
	ld	a,(ix-7 )
	adc	a,  &02
	ld	d,a
	push	de
	ld	hl,  &0012
	add	hl, sp
	ex	de, hl
	ld	bc,  &0004
	ldir
	pop	de
	ld	a,(ix-4 )
	sub	 (ix-12 )
	jr	NZ,fl_fread_00174
	ld	a,(ix-3 )
	sub	 (ix-11 )
	jr	NZ,fl_fread_00174
	ld	a,(ix-2 )
	sub	 (ix-10 )
	jr	NZ,fl_fread_00174
	ld	a,(ix-1 )
	sub	 (ix-9 )
	jr	Z,fl_fread_00117
fl_fread_00174:
;fat_filelib.c:600: if (!_read_sector(file, sector))
	push	de
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	push	hl
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	push	hl
	ld	l,(ix-18 )
	ld	h,(ix-17 )
	push	hl
	call	__read_sector
	pop	af
	pop	af
	pop	af
	pop	de
	ld	a,h
	or	l
	jp	Z,fl_fread_00125
;fat_filelib.c:604: file->file_data.address = sector;
	ld	hl,  &0018
	add	hl, sp
	ld	bc,  &0004
	ldir
;fat_filelib.c:605: file->file_data.dirty = 0;
	ld	a,(ix-8 )
	add	a,  &04
	ld	l,a
	ld	a,(ix-7 )
	adc	a,  &02
	ld	h,a
	ld	(hl), &00
	inc	hl
	ld	(hl), &00
fl_fread_00117:
;fat_filelib.c:609: copyCount = FAT_SECTOR_SIZE - offset;
	xor	 a
	sub	 (ix-24 )
	ld	h,a
	ld	a, &02
	sbc	a, (ix-23 )
	ld	l,a
	ld	a, &00
	sbc	a, (ix-22 )
	ld	d,a
	ld	a, &00
	sbc	a, (ix-21 )
	ld	e,a
	ld	(ix-28 ),h
	ld	(ix-27 ),l
;fat_filelib.c:612: if (copyCount > (count - bytesRead))
	ld	a,(ix-26 )
	sub	 (ix-20 )
	ld	(ix-12 ),a
	ld	a,(ix-25 )
	sbc	a, (ix-19 )
	ld	(ix-11 ),a
	ld	a,(ix-12 )
	sub	 (ix-28 )
	ld	a,(ix-11 )
	sbc	a, (ix-27 )
	jp	PO, fl_fread_00175
	xor	  &80
fl_fread_00175:
	jp	P,fl_fread_00119
;fat_filelib.c:613: copyCount = (count - bytesRead);
	ld	a,(ix-12 )
	ld	(ix-12 ),a
	ld	a,(ix-11 )
	ld	(ix-11 ),a
	ld	a,(ix-12 )
	ld	(ix-28 ),a
	ld	a,(ix-11 )
	ld	(ix-27 ),a
fl_fread_00119:
;fat_filelib.c:619: dst=(unsigned char*)((unsigned char*)buffer + bytesRead);
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	ld	e,(ix-20 )
	ld	d,(ix-19 )
	add	hl,de
	ld	(ix-16 ),l
	ld	(ix-15 ),h
;fat_filelib.c:620: src=(unsigned char*)(file->file_data.sector + offset);
	ld	a,(ix-8 )
	add	a, (ix-24 )
	ld	c,a
	ld	a,(ix-7 )
	adc	a, (ix-23 )
	ld	b,a
;fat_filelib.c:622: do
	ld	de, &0000
fl_fread_00120:
;fat_filelib.c:625: dst[c]=src[c];
	push	hl
	ld	l,(ix-16 )
	ld	h,(ix-15 )
	push	hl
	pop	iy
	pop	hl
	add	iy, de
	ld	l, e
	ld	h, d
	add	hl,bc
	ld	a,(hl)
	ld	(iy+0 ), a
;fat_filelib.c:626: c++;
	inc	de
;fat_filelib.c:627: }while(c<copyCount);
	ld	a,e
	sub	 (ix-28 )
	ld	a,d
	sbc	a, (ix-27 )
	jp	PO, fl_fread_00176
	xor	  &80
fl_fread_00176:
	jp	M,fl_fread_00120
;fat_filelib.c:630: bytesRead += copyCount;
	ld	a,(ix-20 )
	add	a, (ix-28 )
	ld	(ix-20 ),a
	ld	a,(ix-19 )
	adc	a, (ix-27 )
	ld	(ix-19 ),a
;fat_filelib.c:633: file->bytenum += copyCount;
	ld	l,(ix-14 )
	ld	h,(ix-13 )
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	inc	hl
	ld	b,(hl)
	dec	hl
	ld	l,(hl)
	ld	a,(ix-28 )
	ld	(ix-12 ),a
	ld	a,(ix-27 )
	ld	(ix-11 ),a
	ld	a,(ix-27 )
	rla
	sbc	a, a
	ld	(ix-10 ),a
	ld	(ix-9 ),a
	ld	a,e
	add	a, (ix-12 )
	ld	c,a
	ld	a,d
	adc	a, (ix-11 )
	ld	d,a
	ld	a,l
	adc	a, (ix-10 )
	ld	e,a
	ld	a,b
	adc	a, (ix-9 )
	ld	b,a
	ld	l,(ix-14 )
	ld	h,(ix-13 )
	ld	(hl),c
	inc	hl
	ld	(hl),d
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),b
;fat_filelib.c:636: sector++;
	inc	(ix-4 )
	jr	NZ,fl_fread_00177
	inc	(ix-3 )
	jr	NZ,fl_fread_00177
	inc	(ix-2 )
	jr	NZ,fl_fread_00177
	inc	(ix-1 )
fl_fread_00177:
;fat_filelib.c:637: offset = 0;
	xor	 a
	ld	(ix-24 ),a
	ld	(ix-23 ),a
	ld	(ix-22 ),a
	ld	(ix-21 ),a
	jp	fl_fread_00123
fl_fread_00125:
;fat_filelib.c:640: return bytesRead;
	ld	l,(ix-20 )
	ld	h,(ix-19 )
fl_fread_00126:
	ld	sp,ix
	pop	ix
	ret
_fl_fread_end:
;fat_filelib.c:644: int fl_fswrite(unsigned char * buffer, int size,int start_sector, void *f)
;	---------------------------------
; Function fl_fswrite
; ---------------------------------
_fl_fswrite_start:
_fl_fswrite:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-10
	add	hl,sp
	ld	sp,hl
;fat_filelib.c:649: FL_FILE *file = (FL_FILE *)f;
	ld	e,(ix+10 )
	ld	d,(ix+11 )
;fat_filelib.c:652: CHECK_FL_INIT();
	ld	a,(__filelib_init + 1)
	ld	hl,__filelib_init + 0
	or	(hl)
	jr	NZ,fl_fswrite_00102
	push	de
	call	_fl_init
	pop	de
fl_fswrite_00102:
;fat_filelib.c:654: if (buffer==NULL || file==NULL)
	ld	a,(ix+5 )
	or	(ix+4 )
	jr	Z,fl_fswrite_00103
	ld	a,d
	or	e
	jr	NZ,fl_fswrite_00104
fl_fswrite_00103:
;fat_filelib.c:655: return -1;
	ld	hl, &FFFF
	jp	fl_fswrite_00113
fl_fswrite_00104:
;fat_filelib.c:658: if (file->bytenum >= file->filelength)
	ld	l, e
	ld	h, d
	ld	bc,  &0008
	add	hl, bc
	ld	a,(hl)
	ld	(ix-4 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-3 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-2 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-1 ),a
	ld	l, e
	ld	h, d
	ld	bc,  &000C
	add	hl, bc
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	inc	hl
	ld	a,(hl)
	dec	hl
	ld	h,(hl)
	ld	l,a
	ld	a,(ix-4 )
	sub	 c
	ld	a,(ix-3 )
	sbc	a, b
	ld	a,(ix-2 )
	sbc	a, h
	ld	a,(ix-1 )
	sbc	a, l
	jr	C,fl_fswrite_00107
;fat_filelib.c:659: return -1;
	ld	hl, &FFFF
	jp	fl_fswrite_00113
fl_fswrite_00107:
;fat_filelib.c:662: sector = start_sector;//file->bytenum / FAT_SECTOR_SIZE;
	ld	a,(ix+8 )
	ld	(ix-4 ),a
	ld	a,(ix+9 )
	ld	(ix-3 ),a
	ld	a,(ix+9 )
	rla
	sbc	a, a
	ld	(ix-2 ),a
	ld	(ix-1 ),a
;fat_filelib.c:663: cnt=size;
	ld	c,(ix+6 )
	ld	b,(ix+7 )
;fat_filelib.c:664: while (cnt)
	inc	sp
	inc	sp
	push	de
	ld	e,(ix+4 )
	ld	d,(ix+5 )
fl_fswrite_00110:
	ld	a,b
	or	c
	jr	Z,fl_fswrite_00112
;fat_filelib.c:666: if (!fatfs_write_sector(&_fs, file->startcluster, sector, buffer))
	pop	hl
	push	hl
	inc	hl
	inc	hl
	inc	hl
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
	push	bc
	push	de
	push	de
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	push	hl
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	push	hl
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	push	hl
	ld	l,(ix-8 )
	ld	h,(ix-7 )
	push	hl
	ld	hl,__fs
	push	hl
	call	_fatfs_write_sector
	ld	iy, &000C
	add	iy,sp
	ld	sp,iy
	pop	de
	pop	bc
	ld	a,h
	or	l
	jr	NZ,fl_fswrite_00109
;fat_filelib.c:668: return -1;
	ld	hl, &FFFF
	jr	fl_fswrite_00113
fl_fswrite_00109:
;fat_filelib.c:671: buffer=buffer+512;
	ld	hl, &0200
	add	hl,de
	ex	de,hl
;fat_filelib.c:674: sector++;
	inc	(ix-4 )
	jr	NZ,fl_fswrite_00133
	inc	(ix-3 )
	jr	NZ,fl_fswrite_00133
	inc	(ix-2 )
	jr	NZ,fl_fswrite_00133
	inc	(ix-1 )
fl_fswrite_00133:
;fat_filelib.c:675: cnt--;
	dec	bc
	jr	fl_fswrite_00110
fl_fswrite_00112:
;fat_filelib.c:678: return size;
	ld	l,(ix+6 )
	ld	h,(ix+7 )
fl_fswrite_00113:
	ld	sp,ix
	pop	ix
	ret
_fl_fswrite_end:
;fat_filelib.c:685: int fl_fseek( void *f, long offset, int origin )
;	---------------------------------
; Function fl_fseek
; ---------------------------------
_fl_fseek_start:
_fl_fseek:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-17
	add	hl,sp
	ld	sp,hl
;fat_filelib.c:687: FL_FILE *file = (FL_FILE *)f;
	ld	a,(ix+4 )
	ld	(ix-15 ),a
	ld	a,(ix+5 )
	ld	(ix-14 ),a
;fat_filelib.c:691: CHECK_FL_INIT();
	ld	a,(__filelib_init + 1)
	ld	iy,__filelib_init
	or	(iy+0 )
	jr	NZ,fl_fseek_00102
	call	_fl_init
fl_fseek_00102:
;fat_filelib.c:693: if (!file)
	ld	a,(ix-14 )
	or	(ix-15 )
	jr	NZ,fl_fseek_00104
;fat_filelib.c:694: return -1;
	ld	hl, &FFFF
	jp	fl_fseek_00127
fl_fseek_00104:
;fat_filelib.c:696: if (origin == SEEK_END && offset != 0)
	ld	a,(ix+10 )
	sub	  &02
	jr	NZ,fl_fseek_00162
	ld	a,(ix+11 )
	or	 a
	jr	NZ,fl_fseek_00162
	ld	a, &01
	jr	fl_fseek_00163
fl_fseek_00162:
	xor	a
fl_fseek_00163:
	ld	(ix-13 ), a
	or	 a
	jr	Z,fl_fseek_00106
	ld	a,(ix+9 )
	or	 (ix+8 )
	or	 (ix+7 )
	or	(ix+6 )
	jr	Z,fl_fseek_00106
;fat_filelib.c:697: return -1;
	ld	hl, &FFFF
	jp	fl_fseek_00127
fl_fseek_00106:
;fat_filelib.c:702: file->file_data.address =  &FFFFFFFF;
	ld	a,(ix-15 )
	add	a,  &29
	ld	(ix-2 ),a
	ld	a,(ix-14 )
	adc	a,  &01
	ld	(ix-1 ),a
	ld	a,(ix-2 )
	add	a,  &00
	ld	(ix-4 ),a
	ld	a,(ix-1 )
	adc	a,  &02
	ld	(ix-3 ),a
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
;fat_filelib.c:703: file->file_data.dirty = 0;
	ld	a,(ix-2 )
	add	a,  &04
	ld	(ix-4 ),a
	ld	a,(ix-1 )
	adc	a,  &02
	ld	(ix-3 ),a
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
;fat_filelib.c:707: file->bytenum = (unsigned long)offset;
	ld	a,(ix-15 )
	add	a,  &08
	ld	(ix-4 ),a
	ld	a,(ix-14 )
	adc	a,  &00
	ld	(ix-3 ),a
	ld	hl, 9
	add	hl, sp
	ex	de, hl
	ld	hl, 23
	add	hl, sp
	ld	bc, 4
	ldir
;fat_filelib.c:705: if (origin == SEEK_SET)
	ld	a,(ix+11 )
	or	(ix+10 )
	jr	NZ,fl_fseek_00125
;fat_filelib.c:707: file->bytenum = (unsigned long)offset;
	ld	e,(ix-4 )
	ld	d,(ix-3 )
	ld	hl,  &0009
	add	hl, sp
	ld	bc,  &0004
	ldir
;fat_filelib.c:709: if (file->bytenum > file->filelength)
	pop	bc
	pop	iy
	push	iy
	push	bc
	ld	a,(iy+12 )
	ld	(ix-12 ),a
	ld	a,(iy+13 )
	ld	(ix-11 ),a
	ld	a,(iy+14 )
	ld	(ix-10 ),a
	ld	a,(iy+15 )
	ld	(ix-9 ),a
	ld	a,(ix-12 )
	sub	 (ix-8 )
	ld	a,(ix-11 )
	sbc	a, (ix-7 )
	ld	a,(ix-10 )
	sbc	a, (ix-6 )
	ld	a,(ix-9 )
	sbc	a, (ix-5 )
	jr	NC,fl_fseek_00109
;fat_filelib.c:710: file->bytenum = file->filelength;
	ld	e,(ix-4 )
	ld	d,(ix-3 )
	ld	hl,  &0005
	add	hl, sp
	ld	bc,  &0004
	ldir
fl_fseek_00109:
;fat_filelib.c:712: res = 0;
	ld	hl, &0000
	ex	(sp), hl
	jp	fl_fseek_00126
fl_fseek_00125:
;fat_filelib.c:714: else if (origin == SEEK_CUR)
	ld	a,(ix+10 )
	dec	a
	jp	NZ,fl_fseek_00122
	ld	a,(ix+11 )
	or	 a
	jp	NZ,fl_fseek_00122
;fat_filelib.c:719: file->bytenum += offset;
	ld	e,(ix-4 )
	ld	d,(ix-3 )
	ld	hl,  &0005
	add	hl, sp
	ex	de, hl
	ld	bc,  &0004
	ldir
;fat_filelib.c:717: if (offset >= 0)
	bit	7, (ix+9 )
	jr	NZ,fl_fseek_00116
;fat_filelib.c:719: file->bytenum += offset;
	ld	a,(ix-12 )
	add	a, (ix-8 )
	ld	(ix-8 ),a
	ld	a,(ix-11 )
	adc	a, (ix-7 )
	ld	(ix-7 ),a
	ld	a,(ix-10 )
	adc	a, (ix-6 )
	ld	(ix-6 ),a
	ld	a,(ix-9 )
	adc	a, (ix-5 )
	ld	(ix-5 ),a
	ld	e,(ix-4 )
	ld	d,(ix-3 )
	ld	hl,  &0009
	add	hl, sp
	ld	bc,  &0004
	ldir
;fat_filelib.c:721: if (file->bytenum > file->filelength)
	pop	bc
	pop	hl
	push	hl
	push	bc
	ld	de,  &000C
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	a,e
	sub	 (ix-8 )
	ld	a,d
	sbc	a, (ix-7 )
	ld	a,c
	sbc	a, (ix-6 )
	ld	a,b
	sbc	a, (ix-5 )
	jp	NC,fl_fseek_00117
;fat_filelib.c:722: file->bytenum = file->filelength;
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	ld	(hl),e
	inc	hl
	ld	(hl),d
	inc	hl
	ld	(hl),c
	inc	hl
	ld	(hl),b
	jp	fl_fseek_00117
fl_fseek_00116:
;fat_filelib.c:728: offset = -offset;
	xor	 a
	sub	 (ix+6 )
	ld	(ix+6 ),a
	ld	a,  &00
	sbc	a, (ix+7 )
	ld	(ix+7 ),a
	ld	a,  &00
	sbc	a, (ix+8 )
	ld	(ix+8 ),a
	ld	a,  &00
	sbc	a, (ix+9 )
	ld	(ix+9 ),a
;fat_filelib.c:731: if ((unsigned long)offset > file->bytenum)
	ld	hl, 9
	add	hl, sp
	ex	de, hl
	ld	hl, 23
	add	hl, sp
	ld	bc, 4
	ldir
	ld	a,(ix-12 )
	sub	 (ix-8 )
	ld	a,(ix-11 )
	sbc	a, (ix-7 )
	ld	a,(ix-10 )
	sbc	a, (ix-6 )
	ld	a,(ix-9 )
	sbc	a, (ix-5 )
	jr	NC,fl_fseek_00113
;fat_filelib.c:732: file->bytenum = 0;
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	ld	(hl), &00
	inc	hl
	ld	(hl), &00
	inc	hl
	ld	(hl), &00
	inc	hl
	ld	(hl), &00
	jr	fl_fseek_00117
fl_fseek_00113:
;fat_filelib.c:734: file->bytenum-= offset;
	ld	a,(ix-12 )
	sub	 (ix-8 )
	ld	d,a
	ld	a,(ix-11 )
	sbc	a, (ix-7 )
	ld	e,a
	ld	a,(ix-10 )
	sbc	a, (ix-6 )
	ld	b,a
	ld	a,(ix-9 )
	sbc	a, (ix-5 )
	ld	c,a
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	ld	(hl),d
	inc	hl
	ld	(hl),e
	inc	hl
	ld	(hl),b
	inc	hl
	ld	(hl),c
fl_fseek_00117:
;fat_filelib.c:737: res = 0;
	ld	hl, &0000
	ex	(sp), hl
	jr	fl_fseek_00126
fl_fseek_00122:
;fat_filelib.c:739: else if (origin == SEEK_END)
	ld	a,(ix-13 )
	or	 a
	jr	Z,fl_fseek_00119
;fat_filelib.c:741: file->bytenum = file->filelength;
	pop	bc
	pop	iy
	push	iy
	push	bc
	ld	a,(iy+12 )
	ld	(ix-12 ),a
	ld	a,(iy+13 )
	ld	(ix-11 ),a
	ld	a,(iy+14 )
	ld	(ix-10 ),a
	ld	a,(iy+15 )
	ld	(ix-9 ),a
	ld	e,(ix-4 )
	ld	d,(ix-3 )
	ld	hl,  &0005
	add	hl, sp
	ld	bc,  &0004
	ldir
;fat_filelib.c:742: res = 0;
	ld	hl, &0000
	ex	(sp), hl
	jr	fl_fseek_00126
fl_fseek_00119:
;fat_filelib.c:745: res = -1;
	ld	hl, &FFFF
	ex	(sp), hl
fl_fseek_00126:
;fat_filelib.c:749: return res;
	pop	hl
	push	hl
fl_fseek_00127:
	ld	sp,ix
	pop	ix
	ret
_fl_fseek_end:
;fat_filelib.c:759: int fl_list_opendir( char *path, struct fs_dir_list_status *dirls)
;	---------------------------------
; Function fl_list_opendir
; ---------------------------------
_fl_list_opendir_start:
_fl_list_opendir:
	ld	hl,-8
	add	hl,sp
	ld	sp,hl
;fat_filelib.c:762: UINT32 cluster = FAT32_INVALID_CLUSTER;
	ld	iy,0
	add	iy,sp
	ld	(iy+0 ), &FF
	ld	(iy+1 ), &FF
	ld	(iy+2 ), &FF
	ld	(iy+3 ), &FF
;fat_filelib.c:765: CHECK_FL_INIT();
	ld	a,(__filelib_init + 1)
	ld	hl,__filelib_init + 0
	or	(hl)
	jr	NZ,fl_list_opendir_00102
	call	_fl_init
fl_list_opendir_00102:
;fat_filelib.c:769: levels = fatfs_total_path_levels((char*)path) + 1;
	ld	hl, 10
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	call	_fatfs_total_path_levels
	pop	af
	inc	hl
	ld	c,l
;fat_filelib.c:772: if (levels == 0)
	ld	a, h
	or	c
	jr	NZ,fl_list_opendir_00104
;fat_filelib.c:773: cluster = fatfs_get_root_cluster(&_fs);
	ld	hl,__fs
	push	hl
	call	_fatfs_get_root_cluster
	pop	af
	ld	iy,4
	add	iy,sp
	ld	(iy+3 ),d
	ld	(iy+2 ),e
	ld	(iy+1 ),h
	ld	(iy+0 ),l
	ld	hl, 0
	add	hl, sp
	ex	de, hl
	ld	hl, 4
	add	hl, sp
	ld	bc, 4
	ldir
	jr	fl_list_opendir_00105
fl_list_opendir_00104:
;fat_filelib.c:776: _open_directory((char*)path, &cluster);
	ld	hl, &0000
	add	hl,sp
	push	hl
	ld	hl, 12
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	call	__open_directory
	pop	af
	pop	af
fl_list_opendir_00105:
;fat_filelib.c:778: fatfs_browse_cache_init(&_fs);
	ld	hl,__fs
	push	hl
	call	_fatfs_browse_cache_init
	pop	af
;fat_filelib.c:780: fatfs_list_directory_start(&_fs, dirls, cluster);
	ld	de,__fs
	ld	iy,0
	add	iy,sp
	ld	l,(iy+2 )
	ld	h,(iy+3 )
	push	hl
	ld	l,(iy+0 )
	ld	h,(iy+1 )
	push	hl
	ld	hl, 16
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	push	de
	call	_fatfs_list_directory_start
	ld	hl, &0008
	add	hl,sp
	ld	sp,hl
;fat_filelib.c:784: return cluster != FAT32_INVALID_CLUSTER ? 1 : 0;
	ld	iy,0
	add	iy,sp
	ld	a,(iy+0 )
	inc	a
	jr	NZ,fl_list_opendir_00119
	ld	a,(iy+1 )
	inc	a
	jr	NZ,fl_list_opendir_00119
	ld	a,(iy+2 )
	inc	a
	jr	NZ,fl_list_opendir_00119
	ld	a,(iy+3 )
	inc	a
	jr	NZ,fl_list_opendir_00119
	xor	a
	jr	fl_list_opendir_00120
fl_list_opendir_00119:
	ld	a, &01
fl_list_opendir_00120:
	or	 a
	jr	Z,fl_list_opendir_00108
	ld	l, &01
	jr	fl_list_opendir_00109
fl_list_opendir_00108:
	ld	l, &00
fl_list_opendir_00109:
	ld	h, &00
	ld	iy,8
	add	iy,sp
	ld	sp,iy
	ret
_fl_list_opendir_end:
;fat_filelib.c:791: int fl_list_readdir(struct fs_dir_list_status *dirls, struct fs_dir_ent *entry)
;	---------------------------------
; Function fl_list_readdir
; ---------------------------------
_fl_list_readdir_start:
_fl_list_readdir:
;fat_filelib.c:796: CHECK_FL_INIT();
	ld	a,(__filelib_init + 1)
	ld	hl,__filelib_init + 0
	or	(hl)
	jr	NZ,fl_list_readdir_00102
	call	_fl_init
fl_list_readdir_00102:
;fat_filelib.c:800: res = fatfs_list_directory_next(&_fs, dirls, entry);
	ld	hl,__fs
	ld	iy,4
	add	iy,sp
	ld	c,(iy+0 )
	ld	b,(iy+1 )
	push	bc
	ld	iy,4
	add	iy,sp
	ld	c,(iy+0 )
	ld	b,(iy+1 )
	push	bc
	push	hl
	call	_fatfs_list_directory_next
	pop	af
	pop	af
	pop	af
;fat_filelib.c:804: return res;
	ret
_fl_list_readdir_end:
;fat_filelib.c:810: int fl_is_dir(char *path)
;	---------------------------------
; Function fl_is_dir
; ---------------------------------
_fl_is_dir_start:
_fl_is_dir:
	push	af
	push	af
;fat_filelib.c:812: unsigned long cluster = 0;
	xor	 a
	ld	iy,0
	add	iy,sp
	ld	(iy+0 ),a
	ld	(iy+1 ),a
	ld	(iy+2 ),a
	ld	(iy+3 ),a
;fat_filelib.c:814: if (_open_directory((char*)path, &cluster))
	ld	hl, &0000
	add	hl,sp
	push	hl
	ld	hl, 8
	add	hl, sp
	ld	c, (hl)
	inc	hl
	ld	b, (hl)
	push	bc
	call	__open_directory
	pop	af
	pop	af
	ld	a,h
	or	l
	jr	Z,fl_is_dir_00102
;fat_filelib.c:815: return 1;
	ld	hl, &0001
	jr	fl_is_dir_00104
fl_is_dir_00102:
;fat_filelib.c:817: return 0;
	ld	hl, &0000
fl_is_dir_00104:
	pop	af
	pop	af
	ret
_fl_is_dir_end:
__xinit___filelib_init:
	dw  &0000
__xinit___filelib_valid:
	dw  &0000
__xinit___open_file_list:
	dw  &0000
__xinit___free_file_list:
	dw  &0000

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

