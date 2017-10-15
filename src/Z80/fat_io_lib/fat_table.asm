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
;fat_table.c:61: void fatfs_fat_init(struct fatfs *fs)
;	---------------------------------
; Function fatfs_fat_init
; ---------------------------------
_fatfs_fat_init_start:
_fatfs_fat_init:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-6
	add	hl,sp
	ld	sp,hl
;fat_table.c:66: fs->fat_buffer_head = NULL;
	ld	c,(ix+4 )
	ld	b,(ix+5 )
	ld	hl, &022B
	add	hl,bc
	ld	e,l
	ld	d,h
	ld	(hl), &00
	inc	hl
	ld	(hl), &00
;fat_table.c:68: for (i=0;i<FAT_BUFFERED_SECTORS;i++)
	ld	hl, &022D
	add	hl,bc
	ld	(ix-2 ),l
	ld	(ix-1 ),h
	ld	hl, &0000
	ex	(sp), hl
fatfs_fat_init_00102:
;fat_table.c:71: fs->fat_buffers[i].address = FAT32_INVALID_CLUSTER;
	ld	a,(ix-6 )
	ld	(ix-4 ),a
	ld	a,(ix-5 )
	ld	(ix-3 ),a
	ld	c,(ix-4 )
	ld	b,(ix-3 )
	ld	l, c
	ld	h, b
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	add	hl, hl
	add	hl, hl
	add	hl, hl
	ld	a,l
	add	a, (ix-2 )
	ld	c,a
	ld	a,h
	adc	a, (ix-1 )
	ld	b,a
	ld	hl, &0200
	add	hl,bc
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
;fat_table.c:72: fs->fat_buffers[i].dirty = 0;
	ld	hl, &0204
	add	hl,bc
	ld	(hl), &00
	inc	hl
	ld	(hl), &00
;fat_table.c:73: z80_memset(fs->fat_buffers[i].sector,  &00, sizeof(fs->fat_buffers[i].sector));
	push	bc
	pop	iy
	push	bc
	push	de
	ld	hl, &0200
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
;fat_table.c:76: fs->fat_buffers[i].next = fs->fat_buffer_head;
	ld	iy, &0206
	add	iy, bc
	ld	l, e
	ld	h, d
	ld	a, (hl)
	inc	hl
	ld	l,(hl)
	ld	(iy+0 ), a
	ld	(iy+1 ),l
;fat_table.c:77: fs->fat_buffer_head = &fs->fat_buffers[i];
	ld	l, e
	ld	h, d
	ld	(hl),c
	inc	hl
	ld	(hl),b
;fat_table.c:68: for (i=0;i<FAT_BUFFERED_SECTORS;i++)
	inc	(ix-6 )
	jr	NZ,fatfs_fat_init_00110
	inc	(ix-5 )
fatfs_fat_init_00110:
	ld	a,(ix-6 )
	sub	  &01
	ld	a,(ix-5 )
	rla
	ccf
	rra
	sbc	a,  &80
	jp	C,fatfs_fat_init_00102
	ld	sp,ix
	pop	ix
	ret
_fatfs_fat_init_end:
;fat_table.c:83: static struct sector_buffer	* fatfs_fat_read_sector(struct fatfs *fs, UINT32 sector)
;	---------------------------------
; Function fatfs_fat_read_sector
; ---------------------------------
_fatfs_fat_read_sector:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-12
	add	hl,sp
	ld	sp,hl
;fat_table.c:85: struct sector_buffer *last = NULL;
	ld	bc, &0000
;fat_table.c:86: struct sector_buffer *pcur = fs->fat_buffer_head;
	ld	a,(ix+4 )
	ld	(ix-6 ),a
	ld	a,(ix+5 )
	ld	(ix-5 ),a
	ld	a,(ix-6 )
	add	a,  &2B
	ld	(ix-4 ),a
	ld	a,(ix-5 )
	adc	a,  &02
	ld	(ix-3 ),a
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	ld	a,(hl)
	ld	(ix-12 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-11 ),a
;fat_table.c:89: while (pcur)
fatfs_fat_read_sector_00108:
;fat_table.c:100: last->next = NULL;
	ld	hl, &0206
	add	hl,bc
	ld	(ix-2 ),l
	ld	(ix-1 ),h
;fat_table.c:89: while (pcur)
	ld	a,(ix-11 )
	or	(ix-12 )
	jp	Z,fatfs_fat_read_sector_00110
;fat_table.c:92: if (pcur->address == sector)
	pop	hl
	push	hl
	ld	de,  &0200
	add	hl, de
	ld	a,(hl)
	ld	(ix-10 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-9 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-8 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-7 ),a
	ld	a,(ix+6 )
	sub	 (ix-10 )
	jr	NZ,fatfs_fat_read_sector_00153
	ld	a,(ix+7 )
	sub	 (ix-9 )
	jr	NZ,fatfs_fat_read_sector_00153
	ld	a,(ix+8 )
	sub	 (ix-8 )
	jr	NZ,fatfs_fat_read_sector_00153
	ld	a,(ix+9 )
	sub	 (ix-7 )
	jr	Z,fatfs_fat_read_sector_00110
fatfs_fat_read_sector_00153:
;fat_table.c:96: if (pcur->next == NULL)
	pop	hl
	push	hl
	ld	de,  &0206
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	a, (hl)
	or	e
	jr	NZ,fatfs_fat_read_sector_00107
;fat_table.c:99: if (last)
	ld	a,b
	or	c
	jr	Z,fatfs_fat_read_sector_00104
;fat_table.c:100: last->next = NULL;
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
	jr	fatfs_fat_read_sector_00107
fatfs_fat_read_sector_00104:
;fat_table.c:103: fs->fat_buffer_head = NULL;
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
fatfs_fat_read_sector_00107:
;fat_table.c:106: last = pcur;
	pop	bc
	push	bc
;fat_table.c:107: pcur = pcur->next;
	pop	hl
	push	hl
	ld	de,  &0206
	add	hl, de
	ld	a,(hl)
	ld	(ix-12 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-11 ),a
	jp	fatfs_fat_read_sector_00108
fatfs_fat_read_sector_00110:
;fat_table.c:111: if (pcur)
	ld	a,(ix-11 )
	or	(ix-12 )
	jr	Z,fatfs_fat_read_sector_00112
;fat_table.c:112: return pcur;
	pop	hl
	push	hl
	jp	fatfs_fat_read_sector_00121
fatfs_fat_read_sector_00112:
;fat_table.c:115: pcur = last;
	inc	sp
	inc	sp
	push	bc
;fat_table.c:118: pcur->next = fs->fat_buffer_head;
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	ld	d,(hl)
	inc	hl
	ld	e,(hl)
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	ld	(hl),d
	inc	hl
	ld	(hl),e
;fat_table.c:119: fs->fat_buffer_head = pcur;
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	ld	(hl),c
	inc	hl
	ld	(hl),b
;fat_table.c:122: if (pcur->dirty)
	ld	l, c
	ld	h, b
	ld	de,  &0204
	add	hl, de
	ld	d,(hl)
	inc	hl
	ld	a, (hl)
	or	d
	jr	Z,fatfs_fat_read_sector_00118
;fat_table.c:124: if (fs->disk_io.write_sector)
	ld	e,(ix-6 )
	ld	d,(ix-5 )
	push	de
	pop	iy
	ld	a,(iy+29 )
	ld	(ix-10 ),a
	ld	a,(iy+30 )
	ld	(ix-9 ), a
	or	(ix-10 )
	jr	Z,fatfs_fat_read_sector_00116
;fat_table.c:125: if (!fs->disk_io.write_sector(pcur->address, pcur->sector))
	ld	l, c
	ld	h, b
	ld	de,  &0200
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
	ld	l,(ix-10 )
	ld	h,(ix-9 )
	call	__sdcc_call_hl
	pop	af
	pop	af
	pop	af
	ld	a,h
	or	l
	jr	NZ,fatfs_fat_read_sector_00116
;fat_table.c:126: return NULL;
	ld	hl, &0000
	jr	fatfs_fat_read_sector_00121
fatfs_fat_read_sector_00116:
;fat_table.c:129: pcur->dirty = 0;
	ld	a,(ix-12 )
	add	a,  &04
	ld	l,a
	ld	a,(ix-11 )
	adc	a,  &02
	ld	h,a
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
fatfs_fat_read_sector_00118:
;fat_table.c:133: pcur->address = sector;
	ld	a,(ix-12 )
	add	a,  &00
	ld	e,a
	ld	a,(ix-11 )
	adc	a,  &02
	ld	d,a
	push	de
	ld	hl,  &0014
	add	hl, sp
	ld	bc,  &0004
	ldir
	pop	de
;fat_table.c:136: if (!fs->disk_io.read_sector(pcur->address, pcur->sector))
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	ld	bc,  &001B
	add	hl, bc
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	push	de
	ld	l,(ix-12 )
	ld	h,(ix-11 )
	push	hl
	ld	l,(ix+8 )
	ld	h,(ix+9 )
	push	hl
	ld	l,(ix+6 )
	ld	h,(ix+7 )
	push	hl
	ld	l, c
	ld	h, b
	call	__sdcc_call_hl
	pop	af
	pop	af
	pop	af
	pop	de
	ld	a,h
	or	l
	jr	NZ,fatfs_fat_read_sector_00120
;fat_table.c:139: pcur->address = FAT32_INVALID_CLUSTER;
	ld	a, &FF
	ld	(de),a
	inc	de
	ld	a, &FF
	ld	(de),a
	inc	de
	ld	a, &FF
	ld	(de),a
	inc	de
	ld	a, &FF
	ld	(de),a
;fat_table.c:140: return NULL;
	ld	hl, &0000
	jr	fatfs_fat_read_sector_00121
fatfs_fat_read_sector_00120:
;fat_table.c:143: return pcur;
	pop	hl
	push	hl
fatfs_fat_read_sector_00121:
	ld	sp,ix
	pop	ix
	ret
;fat_table.c:148: int fatfs_fat_purge(struct fatfs *fs)
;	---------------------------------
; Function fatfs_fat_purge
; ---------------------------------
_fatfs_fat_purge_start:
_fatfs_fat_purge:
	push	ix
	ld	ix,0
	add	ix,sp
	push	af
	push	af
;fat_table.c:150: struct sector_buffer *pcur = fs->fat_buffer_head;
	ld	c,(ix+4 )
	ld	b,(ix+5 )
	ld	l, c
	ld	h, b
	ld	de,  &022B
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
;fat_table.c:153: while (pcur)
	ld	(ix-2 ),c
	ld	(ix-1 ),b
fatfs_fat_purge_00107:
	ld	a,d
	or	e
	jr	Z,fatfs_fat_purge_00109
;fat_table.c:156: if (pcur->dirty) 
	ld	l, e
	ld	h, d
	ld	bc,  &0204
	add	hl, bc
	ld	b,(hl)
	inc	hl
	ld	a, (hl)
	or	b
	jr	Z,fatfs_fat_purge_00106
;fat_table.c:158: if (fs->disk_io.write_sector)
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	ld	bc,  &001D
	add	hl, bc
	ld	a,(hl)
	ld	(ix-4 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-3 ), a
	or	(ix-4 )
	jr	Z,fatfs_fat_purge_00104
;fat_table.c:159: if (!fs->disk_io.write_sector(pcur->address, pcur->sector))
	ld	l, e
	ld	h, d
	ld	bc,  &0200
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
	push	de
	push	de
	push	hl
	push	bc
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	call	__sdcc_call_hl
	pop	af
	pop	af
	pop	af
	pop	de
	ld	a,h
	or	l
	jr	NZ,fatfs_fat_purge_00104
;fat_table.c:160: return 0;
	ld	hl, &0000
	jr	fatfs_fat_purge_00110
fatfs_fat_purge_00104:
;fat_table.c:162: pcur->dirty = 0;
	ld	hl, &0204
	add	hl,de
	xor	 a
	ld	(hl), a
	inc	hl
	ld	(hl), a
fatfs_fat_purge_00106:
;fat_table.c:164: pcur = pcur->next;
	ex	de,hl
	ld	de,  &0206
	add	hl, de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	jr	fatfs_fat_purge_00107
fatfs_fat_purge_00109:
;fat_table.c:167: return 1;
	ld	hl, &0001
fatfs_fat_purge_00110:
	ld	sp,ix
	pop	ix
	ret
_fatfs_fat_purge_end:
;fat_table.c:178: UINT32 fatfs_find_next_cluster(struct fatfs *fs, UINT32 current_cluster)
;	---------------------------------
; Function fatfs_find_next_cluster
; ---------------------------------
_fatfs_find_next_cluster_start:
_fatfs_find_next_cluster:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-18
	add	hl,sp
	ld	sp,hl
;fat_table.c:185: if (current_cluster == 0) 
	ld	a,(ix+9 )
	or	 (ix+8 )
	or	 (ix+7 )
	or	(ix+6 )
	jr	NZ,fatfs_find_next_cluster_00102
;fat_table.c:186: current_cluster = 2;
	ld	(ix+6 ), &02
	xor	 a
	ld	(ix+7 ),a
	ld	(ix+8 ),a
	ld	(ix+9 ),a
fatfs_find_next_cluster_00102:
;fat_table.c:188: fat_sector_offset = current_cluster / 128;
	push	af
	ld	a,(ix+6 )
	ld	(ix-14 ),a
	ld	a,(ix+7 )
	ld	(ix-13 ),a
	ld	a,(ix+8 )
	ld	(ix-12 ),a
	ld	a,(ix+9 )
	ld	(ix-11 ),a
	pop	af
	ld	b, &07
fatfs_find_next_cluster_00122:
	srl	(ix-11 )
	rr	(ix-12 )
	rr	(ix-13 )
	rr	(ix-14 )
	djnz	fatfs_find_next_cluster_00122
;fat_table.c:191: pbuf = fatfs_fat_read_sector(fs, fs->fat_begin_lba+fat_sector_offset);
	ld	a,(ix+4 )
	ld	(ix-2 ),a
	ld	a,(ix+5 )
	ld	(ix-1 ),a
	ld	a,(ix-2 )
	ld	(ix-8 ),a
	ld	a,(ix-1 )
	ld	(ix-7 ),a
	ld	l,(ix-8 )
	ld	h,(ix-7 )
	ld	de,  &0009
	add	hl, de
	ld	a,(hl)
	ld	(ix-6 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-5 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-4 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-3 ),a
	ld	a,(ix-6 )
	add	a, (ix-14 )
	ld	e,a
	ld	a,(ix-5 )
	adc	a, (ix-13 )
	ld	d,a
	ld	a,(ix-4 )
	adc	a, (ix-12 )
	ld	l,a
	ld	a,(ix-3 )
	adc	a, (ix-11 )
	ld	h,a
	push	hl
	push	de
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	push	hl
	call	_fatfs_fat_read_sector
	pop	af
	pop	af
	pop	af
	ld	(ix-10 ),l
;fat_table.c:192: if (!pbuf)
	ld	(ix-9 ), h
	ld	a, h
	or	(ix-10 )
	jr	NZ,fatfs_find_next_cluster_00104
;fat_table.c:193: return (FAT32_LAST_CLUSTER); 
	ld	hl, &FFFF
	ld	e,l
	ld	d,h
	jp	fatfs_find_next_cluster_00108
fatfs_find_next_cluster_00104:
;fat_table.c:197: position = (current_cluster - (fat_sector_offset * 128)) * 4; 
	push	af
	ld	l,(ix-14 )
	ld	h,(ix-13 )
	ld	e,(ix-12 )
	ld	d,(ix-11 )
	pop	af
	ld	b, &07
fatfs_find_next_cluster_00124:
	add	hl, hl
	rl	e
	rl	d
	djnz	fatfs_find_next_cluster_00124
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
	ld	b, &02
fatfs_find_next_cluster_00126:
	add	hl, hl
	rl	e
	rl	d
	djnz	fatfs_find_next_cluster_00126
;fat_table.c:200: nextcluster = FAT32_GET_32BIT_WORD(pbuf, (UINT16)position);	 
	ld	e,(ix-10 )
	ld	d,(ix-9 )
	add	hl,de
	ex	de,hl
	ld	hl,  &0000
	add	hl, sp
	ex	de, hl
	ld	bc,  &0004
	ldir
;fat_table.c:203: nextcluster = nextcluster &  &0FFFFFFF;
	ld	a,(ix-15 )
	and	  &0F
	ld	(ix-15 ),a
;fat_table.c:206: if (nextcluster >=  &0FFFFFF8 && nextcluster <=  &0FFFFFFF) 
	ld	a,(ix-18 )
	sub	  &F8
	ld	a,(ix-17 )
	sbc	a,  &FF
	ld	a,(ix-16 )
	sbc	a,  &FF
	ld	a,(ix-15 )
	sbc	a,  &0F
	jr	C,fatfs_find_next_cluster_00106
	ld	a,(ix-15 )
	and	  &F0
	jr	NZ,fatfs_find_next_cluster_00106
;fat_table.c:207: return (FAT32_LAST_CLUSTER); 
	ld	hl, &FFFF
	ld	e,l
	ld	d,h
	jr	fatfs_find_next_cluster_00108
fatfs_find_next_cluster_00106:
;fat_table.c:211: return (nextcluster);						 
	ld	l,(ix-18 )
	ld	h,(ix-17 )
	ld	e,(ix-16 )
	ld	d,(ix-15 )
fatfs_find_next_cluster_00108:
	ld	sp,ix
	pop	ix
	ret
_fatfs_find_next_cluster_end:
;fat_table.c:216: void fatfs_set_fs_info_next_free_cluster(struct fatfs *fs, UINT32 newValue)
;	---------------------------------
; Function fatfs_set_fs_info_next_free_cluster
; ---------------------------------
_fatfs_set_fs_info_next_free_cluster_start:
_fatfs_set_fs_info_next_free_cluster:
	push	ix
	ld	ix,0
	add	ix,sp
	push	af
	push	af
;fat_table.c:219: struct sector_buffer *pbuf = fatfs_fat_read_sector(fs, fs->lba_begin+fs->fs_info_sector);
	ld	c,(ix+4 )
	ld	b,(ix+5 )
	ld	l, c
	ld	h, b
	ld	de,  &000F
	add	hl, de
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
	ld	l, c
	ld	h, b
	ld	de,  &000D
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
	push	bc
	push	hl
	push	de
	push	bc
	call	_fatfs_fat_read_sector
	pop	af
	pop	af
	pop	af
	pop	bc
	ex	de,hl
;fat_table.c:220: if (!pbuf)
	ld	a,d
	or	e
;fat_table.c:221: return ;
	jr	Z,fatfs_set_fs_info_next_free_cluster_00103
;fat_table.c:224: FAT32_SET_32BIT_WORD(pbuf, 492, newValue);
	ld	hl, &01EC
	add	hl,de
	push	de
	push	bc
	ex	de,hl
	ld	hl,  &000E
	add	hl, sp
	ld	bc,  &0004
	ldir
	pop	bc
	pop	de
	ld	hl, &0204
	add	hl,de
	ld	(hl), &01
	inc	hl
	ld	(hl), &00
;fat_table.c:226: fs->next_free_cluster = newValue;
	ld	hl, &0017
	add	hl,bc
	ex	de,hl
	ld	hl,  &000A
	add	hl, sp
	ld	bc,  &0004
	ldir
fatfs_set_fs_info_next_free_cluster_00103:
	ld	sp,ix
	pop	ix
	ret
_fatfs_set_fs_info_next_free_cluster_end:
;fat_table.c:364: UINT32 fatfs_count_free_clusters(struct fatfs *fs)
;	---------------------------------
; Function fatfs_count_free_clusters
; ---------------------------------
_fatfs_count_free_clusters_start:
_fatfs_count_free_clusters:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-24
	add	hl,sp
	ld	sp,hl
;fat_table.c:367: UINT32 count = 0;
	xor	 a
	ld	(ix-14 ),a
	ld	(ix-13 ),a
	ld	(ix-12 ),a
	ld	(ix-11 ),a
;fat_table.c:370: for (i = 0; i < fs->fat_sectors; i++)
	ld	a,(ix+4 )
	ld	(ix-2 ),a
	ld	a,(ix+5 )
	ld	(ix-1 ),a
	ld	a,(ix-2 )
	ld	(ix-6 ),a
	ld	a,(ix-1 )
	ld	(ix-5 ),a
	xor	 a
	ld	(ix-22 ),a
	ld	(ix-21 ),a
	ld	(ix-20 ),a
	ld	(ix-19 ),a
fatfs_count_free_clusters_00110:
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	ld	de,  &0013
	add	hl, de
	ld	d,(hl)
	inc	hl
	ld	e,(hl)
	inc	hl
	ld	b,(hl)
	inc	hl
	ld	h,(hl)
	ld	a,(ix-22 )
	sub	 d
	ld	a,(ix-21 )
	sbc	a, e
	ld	a,(ix-20 )
	sbc	a, b
	ld	a,(ix-19 )
	sbc	a, h
	jp	NC,fatfs_count_free_clusters_00106
;fat_table.c:373: pbuf = fatfs_fat_read_sector(fs, fs->fat_begin_lba + i);
	ld	a,(ix-2 )
	ld	(ix-4 ),a
	ld	a,(ix-1 )
	ld	(ix-3 ),a
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	ld	de,  &0009
	add	hl, de
	ld	a,(hl)
	ld	(ix-10 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-9 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-8 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-7 ),a
	ld	a,(ix-10 )
	add	a, (ix-22 )
	ld	(ix-10 ),a
	ld	a,(ix-9 )
	adc	a, (ix-21 )
	ld	(ix-9 ),a
	ld	a,(ix-8 )
	adc	a, (ix-20 )
	ld	(ix-8 ),a
	ld	a,(ix-7 )
	adc	a, (ix-19 )
	ld	(ix-7 ),a
	ld	l,(ix-8 )
	ld	h,(ix-7 )
	push	hl
	ld	l,(ix-10 )
	ld	h,(ix-9 )
	push	hl
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	push	hl
	call	_fatfs_fat_read_sector
	pop	af
	pop	af
	pop	af
	inc	sp
	inc	sp
	push	hl
;fat_table.c:374: if (!pbuf)
	ld	a,(ix-23 )
	or	(ix-24 )
	jp	Z,fatfs_count_free_clusters_00106
;fat_table.c:377: for (j = 0; j < FAT_SECTOR_SIZE; )
	ld	hl, 14
	add	hl, sp
	ex	de, hl
	ld	hl, 10
	add	hl, sp
	ld	bc, 4
	ldir
	xor	 a
	ld	(ix-18 ),a
	ld	(ix-17 ),a
	ld	(ix-16 ),a
	ld	(ix-15 ),a
fatfs_count_free_clusters_00107:
;fat_table.c:379: if (FAT32_GET_32BIT_WORD(pbuf, (UINT16)j) == 0)
	ld	l,(ix-18 )
	ld	h,(ix-17 )
	pop	de
	push	de
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	a, (hl)
	or	 c
	or	 d
	or	e
	jr	NZ,fatfs_count_free_clusters_00104
;fat_table.c:380: count++;
	inc	(ix-10 )
	jr	NZ,fatfs_count_free_clusters_00134
	inc	(ix-9 )
	jr	NZ,fatfs_count_free_clusters_00134
	inc	(ix-8 )
	jr	NZ,fatfs_count_free_clusters_00134
	inc	(ix-7 )
fatfs_count_free_clusters_00134:
fatfs_count_free_clusters_00104:
;fat_table.c:382: j += 4;
	ld	a,(ix-18 )
	add	a,  &04
	ld	(ix-18 ),a
	ld	a,(ix-17 )
	adc	a,  &00
	ld	(ix-17 ),a
	ld	a,(ix-16 )
	adc	a,  &00
	ld	(ix-16 ),a
	ld	a,(ix-15 )
	adc	a,  &00
	ld	(ix-15 ),a
;fat_table.c:377: for (j = 0; j < FAT_SECTOR_SIZE; )
	ld	a,(ix-17 )
	and	  &FE
	jr	NZ,fatfs_count_free_clusters_00135
	ld	a,(ix-16 )
	or	 a
	jr	NZ,fatfs_count_free_clusters_00135
	ld	a,(ix-15 )
	or	 a
	jr	Z,fatfs_count_free_clusters_00107
fatfs_count_free_clusters_00135:
;fat_table.c:370: for (i = 0; i < fs->fat_sectors; i++)
	ld	hl, 10
	add	hl, sp
	ex	de, hl
	ld	hl, 14
	add	hl, sp
	ld	bc, 4
	ldir
	inc	(ix-22 )
	jp	NZ,fatfs_count_free_clusters_00110
	inc	(ix-21 )
	jp	NZ,fatfs_count_free_clusters_00110
	inc	(ix-20 )
	jp	NZ,fatfs_count_free_clusters_00110
	inc	(ix-19 )
	jp	fatfs_count_free_clusters_00110
fatfs_count_free_clusters_00106:
;fat_table.c:386: return count;
	ld	l,(ix-14 )
	ld	h,(ix-13 )
	ld	e,(ix-12 )
	ld	d,(ix-11 )
	ld	sp,ix
	pop	ix
	ret
_fatfs_count_free_clusters_end:
