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
_browse_cluster_cache_idx:
	ds 64
_browse_cluster_cache_data:
	ds 64
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
;fat_cache.c:48: int	fatfs_cache_init(struct fatfs *fs, FL_FILE *file)
;	---------------------------------
; Function fatfs_cache_init
; ---------------------------------
_fatfs_cache_init_start:
_fatfs_cache_init:
;fat_cache.c:60: return 1;
	ld	hl, &0001
	ret
_fatfs_cache_init_end:
;fat_cache.c:65: int	fatfs_cache_get_next_cluster(struct fatfs *fs, FL_FILE *file, UINT32 clusterIdx, UINT32 *pNextCluster)
;	---------------------------------
; Function fatfs_cache_get_next_cluster
; ---------------------------------
_fatfs_cache_get_next_cluster_start:
_fatfs_cache_get_next_cluster:
;fat_cache.c:77: return 0;
	ld	hl, &0000
	ret
_fatfs_cache_get_next_cluster_end:
;fat_cache.c:82: int	fatfs_cache_set_next_cluster(struct fatfs *fs, FL_FILE *file, UINT32 clusterIdx, UINT32 nextCluster)
;	---------------------------------
; Function fatfs_cache_set_next_cluster
; ---------------------------------
_fatfs_cache_set_next_cluster_start:
_fatfs_cache_set_next_cluster:
;fat_cache.c:96: return 1;
	ld	hl, &0001
	ret
_fatfs_cache_set_next_cluster_end:
;fat_cache.c:105: int	fatfs_browse_cache_init(struct fatfs *fs)
;	---------------------------------
; Function fatfs_browse_cache_init
; ---------------------------------
_fatfs_browse_cache_init_start:
_fatfs_browse_cache_init:
	push	ix
;fat_cache.c:110: for (i=0;i<FAT_BROWSE_CLUSTER_CACHE_ENTRIES;i++)
	ld	de, &0000
fatfs_browse_cache_init_00102:
;fat_cache.c:112: browse_cluster_cache_idx[i] =  &FFFFFFFF; // Not used
	ld	c, e
	ld	b, d
	sla	c
	rl	b
	sla	c
	rl	b
	ld	hl,_browse_cluster_cache_idx
	add	hl,bc
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
	inc	hl
	ld	(hl), &FF
;fat_cache.c:113: browse_cluster_cache_data[i] = 0; 
	ld	hl,_browse_cluster_cache_data
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
;fat_cache.c:110: for (i=0;i<FAT_BROWSE_CLUSTER_CACHE_ENTRIES;i++)
	inc	de
	ld	a,e
	sub	  &10
	ld	a,d
	rla
	ccf
	rra
	sbc	a,  &80
	jr	C,fatfs_browse_cache_init_00102
;fat_cache.c:117: return 1;
	ld	hl, &0001
	pop	ix
	ret
_fatfs_browse_cache_init_end:
;fat_cache.c:122: int	fatfs_browse_cache_get_next_cluster(struct fatfs *fs, UINT32 clusterIdx, UINT32 *pNextCluster)
;	---------------------------------
; Function fatfs_browse_cache_get_next_cluster
; ---------------------------------
_fatfs_browse_cache_get_next_cluster_start:
_fatfs_browse_cache_get_next_cluster:
	push	ix
	ld	ix,0
	add	ix,sp
	push	af
	push	af
;fat_cache.c:125: UINT32 slot = clusterIdx % FAT_BROWSE_CLUSTER_CACHE_ENTRIES;
	ld	a,(ix+6 )
	and	  &0F
	ld	e,a
	ld	d, &00
	ld	bc, &0000
;fat_cache.c:127: if (browse_cluster_cache_idx[slot] == clusterIdx)
	ld	hl,_browse_cluster_cache_idx
	push	af
	ld	(ix-4 ),e
	ld	(ix-3 ),d
	ld	(ix-2 ),c
	ld	(ix-1 ),b
	pop	af
	ld	a, &02
fatfs_browse_cache_get_next_cluster_00108:
	sla	(ix-4 )
	rl	(ix-3 )
	rl	(ix-2 )
	rl	(ix-1 )
	dec	a
	jr	NZ,fatfs_browse_cache_get_next_cluster_00108
	pop	de
	push	de
	add	hl,de
	ld	e,(hl)
	inc	hl
	ld	d,(hl)
	inc	hl
	ld	c,(hl)
	inc	hl
	ld	b,(hl)
	ld	a,(ix+6 )
	sub	 e
	jr	NZ,fatfs_browse_cache_get_next_cluster_00102
	ld	a,(ix+7 )
	sub	 d
	jr	NZ,fatfs_browse_cache_get_next_cluster_00102
	ld	a,(ix+8 )
	sub	 c
	jr	NZ,fatfs_browse_cache_get_next_cluster_00102
	ld	a,(ix+9 )
	sub	 b
	jr	NZ,fatfs_browse_cache_get_next_cluster_00102
;fat_cache.c:129: *pNextCluster = browse_cluster_cache_data[slot];
	ld	e,(ix+10 )
	ld	d,(ix+11 )
	ld	hl,_browse_cluster_cache_data
	pop	bc
	push	bc
	add	hl,bc
	push	de
	ex	de,hl
	ld	hl,  &0002
	add	hl, sp
	ex	de, hl
	ld	bc,  &0004
	ldir
	pop	de
	ld	hl,  &0000
	add	hl, sp
	ld	bc,  &0004
	ldir
;fat_cache.c:130: return 1;
	ld	hl, &0001
	jr	fatfs_browse_cache_get_next_cluster_00103
fatfs_browse_cache_get_next_cluster_00102:
;fat_cache.c:134: return 0;
	ld	hl, &0000
fatfs_browse_cache_get_next_cluster_00103:
	ld	sp,ix
	pop	ix
	ret
_fatfs_browse_cache_get_next_cluster_end:
;fat_cache.c:139: int	fatfs_browse_cache_set_next_cluster(struct fatfs *fs, UINT32 clusterIdx, UINT32 nextCluster)
;	---------------------------------
; Function fatfs_browse_cache_set_next_cluster
; ---------------------------------
_fatfs_browse_cache_set_next_cluster_start:
_fatfs_browse_cache_set_next_cluster:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-8
	add	hl,sp
	ld	sp,hl
;fat_cache.c:142: UINT32 slot = clusterIdx % FAT_BROWSE_CLUSTER_CACHE_ENTRIES;
	ld	a,(ix+6 )
	and	  &0F
	ld	d,a
	ld	e, &00
	ld	bc, &0000
;fat_cache.c:144: if (browse_cluster_cache_idx[slot] == clusterIdx)
	push	af
	ld	(ix-4 ),d
	ld	(ix-3 ),e
	ld	(ix-2 ),c
	ld	(ix-1 ),b
	pop	af
	ld	a, &02
fatfs_browse_cache_set_next_cluster_00109:
	sla	(ix-4 )
	rl	(ix-3 )
	rl	(ix-2 )
	rl	(ix-1 )
	dec	a
	jr	NZ,fatfs_browse_cache_set_next_cluster_00109
	ld	a,(ix-4 )
	add	a, _browse_cluster_cache_idx & 255
	ld	e,a
	ld	a,(ix-3 )
	adc	a, _browse_cluster_cache_idx / 256
	ld	d,a
	push	de
	ld	hl,  &0002
	add	hl, sp
	ex	de, hl
	ld	bc,  &0004
	ldir
	pop	de
	ld	a,(ix-8 )
	sub	 (ix+6 )
	jr	NZ,fatfs_browse_cache_set_next_cluster_00102
	ld	a,(ix-7 )
	sub	 (ix+7 )
	jr	NZ,fatfs_browse_cache_set_next_cluster_00102
	ld	a,(ix-6 )
	sub	 (ix+8 )
	jr	NZ,fatfs_browse_cache_set_next_cluster_00102
	ld	a,(ix-5 )
	sub	 (ix+9 )
	jr	NZ,fatfs_browse_cache_set_next_cluster_00102
;fat_cache.c:145: browse_cluster_cache_data[slot] = nextCluster;
	ld	hl,_browse_cluster_cache_data
	ld	e,(ix-4 )
	ld	d,(ix-3 )
	add	hl,de
	ex	de,hl
	ld	hl,  &0012
	add	hl, sp
	ld	bc,  &0004
	ldir
	jr	fatfs_browse_cache_set_next_cluster_00103
fatfs_browse_cache_set_next_cluster_00102:
;fat_cache.c:148: browse_cluster_cache_idx[slot] = clusterIdx;
	ld	hl,  &000E
	add	hl, sp
	ld	bc,  &0004
	ldir
;fat_cache.c:149: browse_cluster_cache_data[slot] = nextCluster;
	ld	hl,_browse_cluster_cache_data
	ld	e,(ix-4 )
	ld	d,(ix-3 )
	add	hl,de
	ex	de,hl
	ld	hl,  &0012
	add	hl, sp
	ld	bc,  &0004
	ldir
fatfs_browse_cache_set_next_cluster_00103:
;fat_cache.c:153: return 1;
	ld	hl, &0001
	ld	sp,ix
	pop	ix
	ret
_fatfs_browse_cache_set_next_cluster_end:
