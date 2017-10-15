;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 8604 (May 11 2013) (MINGW32)
; This file was generated Sun Oct 15 00:38:09 2017
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
;hxc_config.c:72: char ReadConfigFile()
;	---------------------------------
; Function ReadConfigFile
; ---------------------------------
_ReadConfigFile_start:
_ReadConfigFile:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-6
	add	hl,sp
	ld	sp,hl
;hxc_config.c:80: MediaInit();
	call	_MediaInit
;hxc_config.c:82: file = fl_fopen( "/HXCSDFE.CFG", "r" );
	ld	hl,__str_hxc_config_0
	ld	bc,__str_hxc_config_1
	push	bc
	push	hl
	call	_fl_fopen
	pop	af
	pop	af
;hxc_config.c:83: if ( !file )
	ld	a,h
;hxc_config.c:85: return OPERATIONRESULT_ERROR;
	or	l
	jr	NZ,ReadConfigFile_00102
	ld	l,a
	jp	ReadConfigFile_00108
ReadConfigFile_00102:
;hxc_config.c:88: fl_fread( HXC_CONFIG, 1, 512, file );
	ld	c, l
	ld	b, h
	push	bc
	push	bc
	ld	hl, &0200
	push	hl
	ld	hl, &0001
	push	hl
	ld	hl, &1B00
	push	hl
	call	_fl_fread
	ld	hl, &0008
	add	hl,sp
	ld	sp,hl
	ld	hl, &02E0
	push	hl
	xor	 a
	push	af
	inc	sp
	ld	hl, &1D00
	push	hl
	call	_z80_memset
	pop	af
	pop	af
	inc	sp
	pop	bc
;hxc_config.c:95: fl_fseek( file, 1024, SEEK_SET );
	push	bc
	ld	hl, &0000
	push	hl
	ld	hl, &0000
	push	hl
	ld	hl, &0400
	push	hl
	push	bc
	call	_fl_fseek
	ld	hl, &0008
	add	hl,sp
	ld	sp,hl
	pop	bc
;hxc_config.c:96: fl_fread( HXC_SECTORDATA, 1, 512 , file );
	push	bc
	push	bc
	ld	hl, &0200
	push	hl
	ld	hl, &0001
	push	hl
	ld	hl, &2100
	push	hl
	call	_fl_fread
	ld	hl, &0008
	add	hl,sp
	ld	sp,hl
	pop	bc
;hxc_config.c:101: do
	ld	de, &0001
	ld	(ix-2 ), &2E
	ld	(ix-1 ), &00
ReadConfigFile_00105:
;hxc_config.c:103: if( !( iSlot & 3 ) )
	ld	a,e
	and	  &03
	ld	(ix-4 ),a
	ld	(ix-3 ),  &00
	ld	a,  &00
	or	(ix-4 )
	jr	NZ,ReadConfigFile_00104
;hxc_config.c:105: fl_fread( HXC_SECTORDATA, 1, 512 , file );
	push	bc
	push	de
	push	bc
	ld	hl, &0200
	push	hl
	ld	hl, &0001
	push	hl
	ld	hl, &2100
	push	hl
	call	_fl_fread
	ld	hl, &0008
	add	hl,sp
	ld	sp,hl
	pop	de
	pop	bc
ReadConfigFile_00104:
;hxc_config.c:108: memcpy( &slots[ iSlot ], &sectorData[ ( iSlot & 3 ) * 128 ], sizeof(struct DiskInDrive) );		
	ld	a,(ix-2 )
	add	a,  &00
	ld	h,a
	ld	a,(ix-1 )
	adc	a,  &1D
	ld	(ix-6 ), h
	ld	(ix-5 ), a
	ld	l,(ix-4 )
	ld	h,(ix-3 )
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	add	hl, hl
	push	de
	ld	de, &2100
	add	hl, de
	push	bc
	ld	e,(ix-6 )
	ld	d,(ix-5 )
	ld	bc, &002E
	ldir
	pop	bc
	pop	de
;hxc_config.c:109: iSlot++;
	ld	a,(ix-2 )
	add	a,  &2E
	ld	(ix-2 ),a
	ld	a,(ix-1 )
	adc	a,  &00
	ld	(ix-1 ),a
	inc	de
;hxc_config.c:110: } while ( iSlot < configFile->number_of_slot );
	ld	hl, &1B16
	ld	h,(hl)
	ld	l, &00
	ld	a,e
	sub	 h
	ld	a,d
	sbc	a, l
	jr	C,ReadConfigFile_00105
;hxc_config.c:112: fl_fclose( file );
	push	bc
	call	_fl_fclose
	pop	af
;hxc_config.c:114: return OPERATIONRESULT_SUCCESS;
	ld	l, &01
ReadConfigFile_00108:
	ld	sp,ix
	pop	ix
	ret
_ReadConfigFile_end:
__str_hxc_config_0:
	db "/HXCSDFE.CFG"
	db  &00
__str_hxc_config_1:
	db "r"
	db  &00
;hxc_config.c:118: char WriteConfigFile()
;	---------------------------------
; Function WriteConfigFile
; ---------------------------------
_WriteConfigFile_start:
_WriteConfigFile:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-26
	add	hl,sp
	ld	sp,hl
;hxc_config.c:133: file = fl_fopen( "/HXCSDFE.CFG", "r" );
	ld	hl,__str_hxc_config_2
	ld	bc,__str_hxc_config_3
	push	bc
	push	hl
	call	_fl_fopen
	pop	af
	pop	af
	ld	(ix-23 ),l
;hxc_config.c:134: if ( !file )
	ld	(ix-22 ), h
	ld	a, h
	or	(ix-23 )
	jr	NZ,WriteConfigFile_00102
;hxc_config.c:136: return OPERATIONRESULT_ERROR;
	ld	l, &00
	jp	WriteConfigFile_00120
WriteConfigFile_00102:
;hxc_config.c:141: real_slot_index = configFile->slot_index;
	ld	a,( &1B17)
	ld	(ix-2 ),a
	ld	(ix-1 ), &00
;hxc_config.c:143: slot_index = GetLastSetSlot();
	call	_GetLastSetSlot
	ld	(ix-21 ),l
;hxc_config.c:145: iSlot = 1;
	ld	(ix-16 ), &01
	ld	(ix-15 ), &00
;hxc_config.c:148: sdfecfg_file = HXC_SECTORDATA;
	ld	(ix-18 ), &00
	ld	(ix-17 ), &21
;hxc_config.c:150: floppySelectorIndex = 128; // first slot offset
	ld	(ix-20 ), &80
	ld	(ix-19 ), &00
;hxc_config.c:151: z80_memset( sdfecfg_file, 0, 512 ); // clear sector
	ld	hl, &0200
	push	hl
	xor	 a
	push	af
	inc	sp
	ld	h,  &21
	push	hl
	call	_z80_memset
	pop	af
	pop	af
	inc	sp
;hxc_config.c:152: sect_nb = 2; // slots sector offset
	ld	(ix-5 ), &02
;hxc_config.c:154: do
	ld	(ix-12 ), &02
	ld	(ix-14 ), &01
	ld	(ix-13 ), &00
	ld	(ix-24 ), &01
	ld	(ix-4 ), &2E
	ld	(ix-3 ), &00
WriteConfigFile_00111:
;hxc_config.c:157: slot = &slots[i];
	ld	a,(ix-4 )
	add	a,  &00
	ld	(ix-26 ),a
	ld	a,(ix-3 )
	adc	a,  &1D
	ld	(ix-25 ),a
;hxc_config.c:159: if (slot->DirEnt.size) // valid slot found
	ld	a,(ix-26 )
	ld	(ix-7 ),a
	ld	a,(ix-25 )
	ld	(ix-6 ),a
	ld	l,(ix-7 )
	ld	h,(ix-6 )
	ld	de,  &0011
	add	hl, de
	ld	a,(hl)
	ld	(ix-11 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-10 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-9 ),a
	inc	hl
	ld	a,(hl)
	ld	(ix-8 ),a
;hxc_config.c:174: if (fl_fswrite((unsigned char*)sdfecfg_file, 1, sect_nb, file ) != 1)
	ld	a,(ix-23 )
	ld	(ix-7 ),a
	ld	a,(ix-22 )
	ld	(ix-6 ),a
;hxc_config.c:159: if (slot->DirEnt.size) // valid slot found
	ld	a,(ix-8 )
	or	 (ix-9 )
	or	 (ix-10 )
	or	(ix-11 )
	jp	Z,WriteConfigFile_00110
;hxc_config.c:162: z80_memcpy( &sdfecfg_file[floppySelectorIndex], slot, sizeof(struct DiskInDrive));
	pop	de
	push	de
	ld	a,(ix-20 )
	add	a, (ix-18 )
	ld	l,a
	ld	a,(ix-19 )
	adc	a, (ix-17 )
	ld	h,a
	ld	bc, &002E
	push	bc
	push	de
	push	hl
	call	_z80_memcpy
	ld	hl, &0006
	add	hl,sp
	ld	sp,hl
;hxc_config.c:164: if ( i == slot_index )
	ld	a,(ix-24 )
	sub	 (ix-21 )
	jr	NZ,WriteConfigFile_00104
;hxc_config.c:166: real_slot_index = (unsigned short) iSlot;
	ld	a,(ix-14 )
	ld	(ix-2 ),a
	ld	a,(ix-13 )
	ld	(ix-1 ),a
WriteConfigFile_00104:
;hxc_config.c:169: iSlot++;
	inc	(ix-14 )
	jr	NZ,WriteConfigFile_00154
	inc	(ix-13 )
WriteConfigFile_00154:
	ld	a,(ix-14 )
	ld	(ix-16 ),a
	ld	a,(ix-13 )
	ld	(ix-15 ),a
;hxc_config.c:170: floppySelectorIndex = (floppySelectorIndex+128)& &1FF;
	ld	a,(ix-20 )
	add	a,  &80
	ld	h,a
	ld	a,(ix-19 )
	adc	a,  &00
	ld	l,a
	ld	(ix-20 ),h
	ld	a,l
	and	  &01
	ld	(ix-19 ),a
;hxc_config.c:172: if ( !(iSlot& &3) ) // need to change to next sector
	ld	a,(ix-14 )
	and	  &03
	jr	NZ,WriteConfigFile_00110
;hxc_config.c:174: if (fl_fswrite((unsigned char*)sdfecfg_file, 1, sect_nb, file ) != 1)
	ld	l,(ix-12 )
	ld	h, &00
	ld	c,(ix-7 )
	ld	b,(ix-6 )
	push	bc
	push	hl
	ld	hl, &0001
	push	hl
	ld	l,(ix-18 )
	ld	h,(ix-17 )
	push	hl
	call	_fl_fswrite
	pop	af
	pop	af
	pop	af
	pop	af
	dec	l
	jr	NZ,WriteConfigFile_00157
	ld	a,h
	or	 a
	jr	Z,WriteConfigFile_00106
WriteConfigFile_00157:
;hxc_config.c:176: return OPERATIONRESULT_ERROR;
	ld	l, &00
	jp	WriteConfigFile_00120
WriteConfigFile_00106:
;hxc_config.c:179: sect_nb++;
	inc	(ix-12 )
	ld	a,(ix-12 )
	ld	(ix-5 ),a
;hxc_config.c:181: z80_memset( sdfecfg_file, 0, 512 ); // clear next sector
	ld	a,(ix-18 )
	ld	(ix-11 ),a
	ld	a,(ix-17 )
	ld	(ix-10 ),a
	ld	hl, &0200
	push	hl
	xor	 a
	push	af
	inc	sp
	ld	l,(ix-11 )
	ld	h,(ix-10 )
	push	hl
	call	_z80_memset
	pop	af
	pop	af
	inc	sp
WriteConfigFile_00110:
;hxc_config.c:185: i++;
	ld	a,(ix-4 )
	add	a,  &2E
	ld	(ix-4 ),a
	ld	a,(ix-3 )
	adc	a,  &00
	ld	(ix-3 ),a
	inc	(ix-24 )
;hxc_config.c:186: } while( i < SLOTCOUNT );
	ld	a,(ix-24 )
	sub	  &10
	jp	C,WriteConfigFile_00111
;hxc_config.c:188: if ( iSlot& &3 )
	ld	a,(ix-16 )
	and	  &03
	jr	Z,WriteConfigFile_00117
;hxc_config.c:190: if (fl_fswrite( (unsigned char*)sdfecfg_file, 1, sect_nb, file) != 1)
	ld	a,(ix-5 )
	ld	(ix-11 ),a
	ld	(ix-10 ), &00
	ld	l,(ix-7 )
	ld	h,(ix-6 )
	push	hl
	ld	l,(ix-11 )
	ld	h,(ix-10 )
	push	hl
	ld	hl, &0001
	push	hl
	ld	l,(ix-18 )
	ld	h,(ix-17 )
	push	hl
	call	_fl_fswrite
	pop	af
	pop	af
	pop	af
	pop	af
	ld	(ix-10 ),h
	ld	(ix-11 ), l
	ld	a, l
	dec	a
	jr	NZ,WriteConfigFile_00159
	ld	a,(ix-10 )
	or	 a
	jr	Z,WriteConfigFile_00117
WriteConfigFile_00159:
;hxc_config.c:192: return OPERATIONRESULT_ERROR;
	ld	l, &00
	jr	WriteConfigFile_00120
WriteConfigFile_00117:
;hxc_config.c:196: fl_fseek( file, 0, SEEK_SET );
	ld	hl, &0000
	push	hl
	ld	hl, &0000
	push	hl
	ld	hl, &0000
	push	hl
	ld	l,(ix-7 )
	ld	h,(ix-6 )
	push	hl
	call	_fl_fseek
	ld	hl, &0008
	add	hl,sp
	ld	sp,hl
;hxc_config.c:198: configFile->number_of_slot = iSlot;
	ld	a,(ix-16 )
	ld	hl, &1B16
	ld	(hl),a
;hxc_config.c:199: configFile->slot_index = real_slot_index;
	ld	a,(ix-2 )
	ld	l,  &17
	ld	(hl),a
;hxc_config.c:201: if (fl_fswrite( (unsigned char*)configFile, 1, 0, file ) != 1)
	ld	l,(ix-7 )
	ld	h,(ix-6 )
	push	hl
	ld	hl, &0000
	push	hl
	ld	l,  &01
	push	hl
	ld	hl, &1B00
	push	hl
	call	_fl_fswrite
	pop	af
	pop	af
	pop	af
	pop	af
	dec	l
	jr	NZ,WriteConfigFile_00160
	ld	a,h
	or	 a
	jr	Z,WriteConfigFile_00119
WriteConfigFile_00160:
;hxc_config.c:203: return OPERATIONRESULT_ERROR;
	ld	l, &00
	jr	WriteConfigFile_00120
WriteConfigFile_00119:
;hxc_config.c:206: fl_fclose(file);
	ld	l,(ix-7 )
	ld	h,(ix-6 )
	push	hl
	call	_fl_fclose
	pop	af
;hxc_config.c:208: return OPERATIONRESULT_SUCCESS;
	ld	l, &01
WriteConfigFile_00120:
	ld	sp,ix
	pop	ix
	ret
_WriteConfigFile_end:
__str_hxc_config_2:
	db "/HXCSDFE.CFG"
	db  &00
__str_hxc_config_3:
	db "r"
	db  &00
;hxc_config.c:212: char HxC_ReadConfigFile(char *errorCode)
;	---------------------------------
; Function HxC_ReadConfigFile
; ---------------------------------
_HxC_ReadConfigFile_start:
_HxC_ReadConfigFile:
;hxc_config.c:218: if ( !ReadConfigFile() )
	call	_ReadConfigFile
;hxc_config.c:220: *errorCode = HXCERROR_READCONFIGFILEERROR;
	pop	bc
	pop	de
	push	de
	push	bc
;hxc_config.c:218: if ( !ReadConfigFile() )
	ld	a,l
	or	 a
	jr	NZ,HxC_ReadConfigFile_00102
;hxc_config.c:220: *errorCode = HXCERROR_READCONFIGFILEERROR;
	ld	a, &04
	ld	(de),a
;hxc_config.c:221: return OPERATIONRESULT_ERROR;
	ld	l, &00
	ret
HxC_ReadConfigFile_00102:
;hxc_config.c:225: *errorCode = HXCERROR_OK;
	xor	 a
	ld	(de),a
;hxc_config.c:226: return OPERATIONRESULT_SUCCESS;
	ld	l, &01
	ret
_HxC_ReadConfigFile_end:
;hxc_config.c:230: char HxC_WriteConfigFile(char *errorCode)
;	---------------------------------
; Function HxC_WriteConfigFile
; ---------------------------------
_HxC_WriteConfigFile_start:
_HxC_WriteConfigFile:
;hxc_config.c:234: if ( !WriteConfigFile() )
	call	_WriteConfigFile
;hxc_config.c:236: *errorCode = HXCERROR_READCONFIGFILEERROR;
	pop	bc
	pop	de
	push	de
	push	bc
;hxc_config.c:234: if ( !WriteConfigFile() )
	ld	a,l
	or	 a
	jr	NZ,HxC_WriteConfigFile_00102
;hxc_config.c:236: *errorCode = HXCERROR_READCONFIGFILEERROR;
	ld	a, &04
	ld	(de),a
;hxc_config.c:237: return OPERATIONRESULT_ERROR;
	ld	l, &00
	ret
HxC_WriteConfigFile_00102:
;hxc_config.c:241: *errorCode = HXCERROR_OK;
	xor	 a
	ld	(de),a
;hxc_config.c:242: return OPERATIONRESULT_SUCCESS;
	ld	l, &01
	ret
_HxC_WriteConfigFile_end:
