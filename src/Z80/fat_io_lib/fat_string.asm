;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.3.0 8604 (May 11 2013) (MINGW32)
; This file was generated Sat Oct 14 23:36:38 2017
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
;fat_string.c:47: int fatfs_total_path_levels(char *path)
;	---------------------------------
; Function fatfs_total_path_levels
; ---------------------------------
_fatfs_total_path_levels_start:
_fatfs_total_path_levels:
	push	ix
	ld	ix,0
	add	ix,sp
	push	af
;fat_string.c:50: int length = (int)strlen(path);
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	push	hl
	call	_strlen
	pop	af
;fat_string.c:53: if (!path)
	ld	a,(ix+5 )
	or	(ix+4 )
	jr	NZ,fatfs_total_path_levels_00102
;fat_string.c:54: return -1;
	ld	hl, &FFFF
	jp	fatfs_total_path_levels_00119
fatfs_total_path_levels_00102:
;fat_string.c:59: if (*path == '/')
	ld	e,(ix+4 )
	ld	d,(ix+5 )
	ld	a,(de)
	sub	  &2F
	jr	NZ,fatfs_total_path_levels_00108
;fat_string.c:61: expectedchar = '/';
	ld	c, &2F
;fat_string.c:62: path++;
	inc	de
	ld	(ix+4 ),e
	ld	(ix+5 ),d
	jr	fatfs_total_path_levels_00128
fatfs_total_path_levels_00108:
;fat_string.c:64: else if (path[1] == ':' || path[2] == '\\')
	ld	l, e
	ld	h, d
	inc	hl
	ld	a,(hl)
	sub	  &3A
	jr	Z,fatfs_total_path_levels_00103
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a,(hl)
	sub	  &5C
	jr	NZ,fatfs_total_path_levels_00104
fatfs_total_path_levels_00103:
;fat_string.c:66: expectedchar = '\\';
	ld	c, &5C
;fat_string.c:67: path += 3;
	inc	de
	inc	de
	inc	de
	ld	(ix+4 ),e
	ld	(ix+5 ),d
	jr	fatfs_total_path_levels_00128
fatfs_total_path_levels_00104:
;fat_string.c:70: return -1;
	ld	hl, &FFFF
	jr	fatfs_total_path_levels_00119
;fat_string.c:73: while (*path)
fatfs_total_path_levels_00128:
	ld	hl, &0000
	ex	(sp), hl
fatfs_total_path_levels_00113:
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	ld	a,(hl)
	or	 a
	jr	Z,fatfs_total_path_levels_00115
;fat_string.c:76: for (*path; *path;)
fatfs_total_path_levels_00117:
	ld	d,(hl)
	ld	a,d
	or	 a
	jr	Z,fatfs_total_path_levels_00112
;fat_string.c:79: if (*path == expectedchar) { path++; break; }
	inc	hl
	ld	e,l
	ld	b,h
	ld	a,c
	sub	 d
	jr	NZ,fatfs_total_path_levels_00111
	ld	(ix+4 ),e
	ld	(ix+5 ),b
	jr	fatfs_total_path_levels_00112
fatfs_total_path_levels_00111:
;fat_string.c:80: *path++;
	ld	l, e
	ld	h, b
	ld	(ix+4 ),e
	ld	(ix+5 ),b
	jr	fatfs_total_path_levels_00117
fatfs_total_path_levels_00112:
;fat_string.c:84: levels++;
	inc	(ix-2 )
	jr	NZ,fatfs_total_path_levels_00113
	inc	(ix-1 )
	jr	fatfs_total_path_levels_00113
fatfs_total_path_levels_00115:
;fat_string.c:88: return levels-1;
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	dec	hl
fatfs_total_path_levels_00119:
	ld	sp,ix
	pop	ix
	ret
_fatfs_total_path_levels_end:
;fat_string.c:96: int fatfs_get_substring(char *path, int levelreq, char *output, int max_len)
;	---------------------------------
; Function fatfs_get_substring
; ---------------------------------
_fatfs_get_substring_start:
_fatfs_get_substring:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-17
	add	hl,sp
	ld	sp,hl
;fat_string.c:104: if (!path || max_len <= 0)
	ld	a,(ix+5 )
	or	(ix+4 )
	jr	Z,fatfs_get_substring_00101
	xor	 a
	cp	 (ix+10 )
	sbc	a, (ix+11 )
	jp	PO, fatfs_get_substring_00157
	xor	  &80
fatfs_get_substring_00157:
	jp	M,fatfs_get_substring_00102
fatfs_get_substring_00101:
;fat_string.c:105: return -1;
	ld	hl, &FFFF
	jp	fatfs_get_substring_00124
fatfs_get_substring_00102:
;fat_string.c:110: if (*path == '/')
	ld	e,(ix+4 )
	ld	d,(ix+5 )
	ld	a,(de)
	sub	  &2F
	jr	NZ,fatfs_get_substring_00109
;fat_string.c:112: expectedchar = '/';
	ld	(ix-9 ), &2F
;fat_string.c:113: path++;
	inc	de
	ld	(ix+4 ),e
	ld	(ix+5 ),d
	jr	fatfs_get_substring_00110
fatfs_get_substring_00109:
;fat_string.c:115: else if (path[1] == ':' || path[2] == '\\')
	ld	l, e
	ld	h, d
	inc	hl
	ld	a,(hl)
	sub	  &3A
	jr	Z,fatfs_get_substring_00104
	ld	l, e
	ld	h, d
	inc	hl
	inc	hl
	ld	a,(hl)
	sub	  &5C
	jr	NZ,fatfs_get_substring_00105
fatfs_get_substring_00104:
;fat_string.c:117: expectedchar = '\\';
	ld	(ix-9 ), &5C
;fat_string.c:118: path += 3;
	inc	de
	inc	de
	inc	de
	ld	(ix+4 ),e
	ld	(ix+5 ),d
	jr	fatfs_get_substring_00110
fatfs_get_substring_00105:
;fat_string.c:121: return -1;
	ld	hl, &FFFF
	jp	fatfs_get_substring_00124
fatfs_get_substring_00110:
;fat_string.c:124: pathlen = (int)strlen (path);
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	push	hl
	call	_strlen
	pop	af
	inc	sp
	inc	sp
	push	hl
;fat_string.c:127: for (i = 0; i<pathlen; i++)
	ld	a,(ix+10 )
	add	a, &FF
	ld	(ix-4 ),a
	ld	a,(ix+11 )
	adc	a, &FF
	ld	(ix-3 ),a
	ld	(ix-11 ), &00
	ld	(ix-10 ), &00
	ld	(ix-15 ), &00
	ld	(ix-14 ), &00
	ld	a,(ix+4 )
	ld	(ix-2 ),a
	ld	a,(ix+5 )
	ld	(ix-1 ),a
	ld	(ix-13 ), &00
	ld	(ix-12 ), &00
fatfs_get_substring_00122:
	ld	a,(ix-13 )
	sub	 (ix-17 )
	ld	a,(ix-12 )
	sbc	a, (ix-16 )
	jp	PO, fatfs_get_substring_00163
	xor	  &80
fatfs_get_substring_00163:
	jp	P,fatfs_get_substring_00117
;fat_string.c:130: if (*path == expectedchar) levels++;
	ld	l,(ix-2 )
	ld	h,(ix-1 )
	ld	a,(hl)
	ld	(ix-7 ), a
	sub	 (ix-9 )
	jr	NZ,fatfs_get_substring_00164
	ld	a, &01
	jr	fatfs_get_substring_00165
fatfs_get_substring_00164:
	xor	a
fatfs_get_substring_00165:
	ld	(ix-8 ), a
	or	 a
	jr	Z,fatfs_get_substring_00112
	inc	(ix-11 )
	jr	NZ,fatfs_get_substring_00166
	inc	(ix-10 )
fatfs_get_substring_00166:
fatfs_get_substring_00112:
;fat_string.c:133: if ( (levels == levelreq) && (*path != expectedchar) && (copypnt < (max_len-1))) 
	ld	a,(ix-11 )
	sub	 (ix+6 )
	jr	NZ,fatfs_get_substring_00114
	ld	a,(ix-10 )
	sub	 (ix+7 )
	jr	NZ,fatfs_get_substring_00114
	ld	a,(ix-8 )
	or	 a
	jr	NZ,fatfs_get_substring_00114
	ld	a,(ix-15 )
	sub	 (ix-4 )
	ld	a,(ix-14 )
	sbc	a, (ix-3 )
	jp	PO, fatfs_get_substring_00169
	xor	  &80
fatfs_get_substring_00169:
	jp	P,fatfs_get_substring_00114
;fat_string.c:134: output[copypnt++] = *path;
	ld	a,(ix-15 )
	ld	(ix-6 ),a
	ld	a,(ix-14 )
	ld	(ix-5 ),a
	inc	(ix-15 )
	jr	NZ,fatfs_get_substring_00170
	inc	(ix-14 )
fatfs_get_substring_00170:
	ld	a,(ix+8 )
	add	a, (ix-6 )
	ld	(ix-6 ),a
	ld	a,(ix+9 )
	adc	a, (ix-5 )
	ld	(ix-5 ),a
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	ld	a,(ix-7 )
	ld	(hl),a
fatfs_get_substring_00114:
;fat_string.c:137: *path++;
	inc	(ix-2 )
	jr	NZ,fatfs_get_substring_00171
	inc	(ix-1 )
fatfs_get_substring_00171:
;fat_string.c:127: for (i = 0; i<pathlen; i++)
	inc	(ix-13 )
	jp	NZ,fatfs_get_substring_00122
	inc	(ix-12 )
	jp	fatfs_get_substring_00122
fatfs_get_substring_00117:
;fat_string.c:141: output[copypnt] = '\0';
	ld	a,(ix-15 )
	add	a, (ix+8 )
	ld	l,a
	ld	a,(ix-14 )
	adc	a, (ix+9 )
	ld	h,a
	ld	(hl), &00
;fat_string.c:144: if (output[0] != '\0') 
	ld	l,(ix+8 )
	ld	h,(ix+9 )
	ld	a,(hl)
	or	 a
	jr	Z,fatfs_get_substring_00119
;fat_string.c:145: return 0;	// OK
	ld	hl, &0000
	jr	fatfs_get_substring_00124
fatfs_get_substring_00119:
;fat_string.c:147: return -1;	// Error
	ld	hl, &FFFF
fatfs_get_substring_00124:
	ld	sp,ix
	pop	ix
	ret
_fatfs_get_substring_end:
;fat_string.c:155: int fatfs_split_path(char *full_path, char *path, int max_path, char *filename, int max_filename)
;	---------------------------------
; Function fatfs_split_path
; ---------------------------------
_fatfs_split_path_start:
_fatfs_split_path:
	push	ix
	ld	ix,0
	add	ix,sp
;fat_string.c:160: int levels = fatfs_total_path_levels(full_path);
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	push	hl
	call	_fatfs_total_path_levels
	pop	af
	ld	c, l
	ld	b, h
;fat_string.c:161: if (levels == -1)
	ld	a,c
	inc	a
	jr	NZ,fatfs_split_path_00102
	ld	a,b
	inc	a
	jr	NZ,fatfs_split_path_00102
;fat_string.c:162: return -1;
	ld	hl, &FFFF
	jp	fatfs_split_path_00114
fatfs_split_path_00102:
;fat_string.c:165: if (fatfs_get_substring(full_path, levels, filename, max_filename) != 0)
	push	bc
	ld	l,(ix+12 )
	ld	h,(ix+13 )
	push	hl
	ld	l,(ix+10 )
	ld	h,(ix+11 )
	push	hl
	push	bc
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	push	hl
	call	_fatfs_get_substring
	pop	af
	pop	af
	pop	af
	pop	af
	pop	bc
	ld	a,h
	or	l
	jr	Z,fatfs_split_path_00104
;fat_string.c:166: return -1;
	ld	hl, &FFFF
	jr	fatfs_split_path_00114
fatfs_split_path_00104:
;fat_string.c:169: if (levels == 0)
	ld	a,b
	or	c
	jr	NZ,fatfs_split_path_00112
;fat_string.c:171: if(path)
	ld	a,(ix+7 )
	or	(ix+6 )
	jr	Z,fatfs_split_path_00113
;fat_string.c:172: path[0] = '\0';
	ld	l,(ix+6 )
	ld	h,(ix+7 )
	ld	(hl), &00
	jr	fatfs_split_path_00113
fatfs_split_path_00112:
;fat_string.c:176: strindex = (int)strlen(full_path) - (int)strlen(filename);
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	push	hl
	call	_strlen
	ex	(sp),hl
	ld	c,(ix+10 )
	ld	b,(ix+11 )
	push	bc
	call	_strlen
	pop	af
	ex	de,hl
	pop	hl
	cp	 a
	sbc	hl, de
	ld	c, l
	ld	b, h
;fat_string.c:177: if (strindex > max_path)
	ld	a,(ix+8 )
	sub	 c
	ld	a,(ix+9 )
	sbc	a, b
	jp	PO, fatfs_split_path_00136
	xor	  &80
fatfs_split_path_00136:
	jp	P,fatfs_split_path_00108
;fat_string.c:178: strindex = max_path;
	ld	c,(ix+8 )
	ld	b,(ix+9 )
fatfs_split_path_00108:
;fat_string.c:179: if(path)
	ld	a,(ix+7 )
	or	(ix+6 )
	jr	Z,fatfs_split_path_00110
;fat_string.c:180: z80_memcpy(path, full_path, strindex);
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	ld	e,(ix+6 )
	ld	d,(ix+7 )
	push	bc
	push	bc
	push	hl
	push	de
	call	_z80_memcpy
	ld	hl, &0006
	add	hl,sp
	ld	sp,hl
	pop	bc
fatfs_split_path_00110:
;fat_string.c:181: path[strindex-1] = '\0';
	dec	bc
	ld	l,(ix+6 )
	ld	h,(ix+7 )
	add	hl,bc
	ld	(hl), &00
fatfs_split_path_00113:
;fat_string.c:184: return 0;
	ld	hl, &0000
fatfs_split_path_00114:
	pop	ix
	ret
_fatfs_split_path_end:
;fat_string.c:189: static int FileString_StrCmpNoCase(char *s1, char *s2, int n)
;	---------------------------------
; Function FileString_StrCmpNoCase
; ---------------------------------
_FileString_StrCmpNoCase:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-9
	add	hl,sp
	ld	sp,hl
;fat_string.c:194: while (n)
	ld	a,(ix+8 )
	ld	(ix-8 ),a
	ld	a,(ix+9 )
	ld	(ix-7 ),a
	ld	a,(ix+4 )
	ld	(ix-5 ),a
	ld	a,(ix+5 )
	ld	(ix-4 ),a
	ld	a,(ix+6 )
	ld	(ix-3 ),a
	ld	a,(ix+7 )
	ld	(ix-2 ),a
FileString_StrCmpNoCase_00112:
	ld	a,(ix-7 )
	or	(ix-8 )
	jp	Z,FileString_StrCmpNoCase_00114
;fat_string.c:196: n--;
	ld	l,(ix-8 )
	ld	h,(ix-7 )
	dec	hl
	ld	(ix-8 ),l
	ld	(ix-7 ),h
;fat_string.c:197: a = *s1;
	ld	l,(ix-5 )
	ld	h,(ix-4 )
	ld	a,(hl)
	ld	(ix-1 ), a
	ld	(ix-9 ),a
;fat_string.c:198: b = *s2;
	ld	l,(ix-3 )
	ld	h,(ix-2 )
	ld	a,(hl)
	ld	(ix-6 ), a
	ld	e, a
;fat_string.c:201: if ((a>='A') && (a<='Z'))
	ld	a,(ix-9 )
	xor	  &80
	sub	  &C1
	jr	C,FileString_StrCmpNoCase_00102
	ld	a, &5A
	sub	 (ix-9 )
	jp	PO, FileString_StrCmpNoCase_00144
	xor	  &80
FileString_StrCmpNoCase_00144:
	jp	M,FileString_StrCmpNoCase_00102
;fat_string.c:202: a+= 32;
	ld	a,(ix-9 )
	add	a,  &20
	ld	(ix-9 ),a
FileString_StrCmpNoCase_00102:
;fat_string.c:203: if ((b>='A') && (b<='Z'))
	ld	a,e
	xor	  &80
	sub	  &C1
	jr	C,FileString_StrCmpNoCase_00105
	ld	a, &5A
	sub	 e
	jp	PO, FileString_StrCmpNoCase_00145
	xor	  &80
FileString_StrCmpNoCase_00145:
	jp	M,FileString_StrCmpNoCase_00105
;fat_string.c:204: b+= 32;
	ld	a,e
	add	a,  &20
	ld	e,a
FileString_StrCmpNoCase_00105:
;fat_string.c:206: diff = a - b;
	ld	l,(ix-9 )
	ld	a,(ix-9 )
	rla
	sbc	a, a
	ld	h,a
	ld	a,e
	rla
	sbc	a, a
	ld	d,a
	cp	 a
	sbc	hl, de
;fat_string.c:209: if (diff)
	ld	a,h
	or	l
;fat_string.c:210: return diff;
	jr	NZ,FileString_StrCmpNoCase_00115
;fat_string.c:213: if ( (*s1 == 0) || (*s2 == 0) )
	ld	a,(ix-1 )
	or	 a
	jr	Z,FileString_StrCmpNoCase_00114
	ld	a,(ix-6 )
	or	 a
	jr	Z,FileString_StrCmpNoCase_00114
;fat_string.c:216: s1++;
	inc	(ix-5 )
	jr	NZ,FileString_StrCmpNoCase_00146
	inc	(ix-4 )
FileString_StrCmpNoCase_00146:
;fat_string.c:217: s2++;
	inc	(ix-3 )
	jp	NZ,FileString_StrCmpNoCase_00112
	inc	(ix-2 )
	jp	FileString_StrCmpNoCase_00112
FileString_StrCmpNoCase_00114:
;fat_string.c:219: return 0;
	ld	hl, &0000
FileString_StrCmpNoCase_00115:
	ld	sp,ix
	pop	ix
	ret
;fat_string.c:225: static int FileString_GetExtension(char *str)
;	---------------------------------
; Function FileString_GetExtension
; ---------------------------------
_FileString_GetExtension:
	push	ix
	ld	ix,0
	add	ix,sp
;fat_string.c:227: int dotPos = -1;
	ld	de, &FFFF
;fat_string.c:228: char *strSrc = str;
	ld	l,(ix+4 )
	ld	h,(ix+5 )
;fat_string.c:231: while (*strSrc)
FileString_GetExtension_00103:
	ld	a,(hl)
	or	 a
	jr	Z,FileString_GetExtension_00105
;fat_string.c:233: if (*strSrc=='.')
	sub	  &2E
	jr	NZ,FileString_GetExtension_00102
;fat_string.c:234: dotPos = (int)(strSrc-str);
	ld	a,l
	sub	 (ix+4 )
	ld	e,a
	ld	a,h
	sbc	a, (ix+5 )
	ld	d,a
FileString_GetExtension_00102:
;fat_string.c:236: *strSrc++;
	inc	hl
	jr	FileString_GetExtension_00103
FileString_GetExtension_00105:
;fat_string.c:239: return dotPos;
	ex	de,hl
	pop	ix
	ret
;fat_string.c:245: static int FileString_TrimLength(char *str, int strLen)
;	---------------------------------
; Function FileString_TrimLength
; ---------------------------------
_FileString_TrimLength:
	push	ix
	ld	ix,0
	add	ix,sp
;fat_string.c:247: int length = strLen;
	ld	c,(ix+6 )
	ld	b,(ix+7 )
;fat_string.c:248: char *strSrc = str+strLen-1;
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	add	hl,bc
	dec	hl
;fat_string.c:251: while (strLen != 0)
	ld	e, c
	ld	d, b
FileString_TrimLength_00104:
	ld	a,d
	or	e
	jr	Z,FileString_TrimLength_00106
;fat_string.c:253: if (*strSrc == ' ')
	ld	a,(hl)
	sub	  &20
	jr	NZ,FileString_TrimLength_00106
;fat_string.c:254: length = (int)(strSrc - str);
	ld	a,l
	sub	 (ix+4 )
	ld	c,a
	ld	a,h
	sbc	a, (ix+5 )
	ld	b,a
;fat_string.c:258: strSrc--;
	dec	hl
;fat_string.c:259: strLen--;
	dec	de
	jr	FileString_TrimLength_00104
FileString_TrimLength_00106:
;fat_string.c:262: return length;
	ld	l, c
	ld	h, b
	pop	ix
	ret
;fat_string.c:268: int fatfs_compare_names(char* strA, char* strB)
;	---------------------------------
; Function fatfs_compare_names
; ---------------------------------
_fatfs_compare_names_start:
_fatfs_compare_names:
	push	ix
	ld	ix,0
	add	ix,sp
	ld	hl,-12
	add	hl,sp
	ld	sp,hl
;fat_string.c:276: ext1Pos = FileString_GetExtension(strA);
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	push	hl
	call	_FileString_GetExtension
;fat_string.c:277: ext2Pos = FileString_GetExtension(strB);
	ex	(sp),hl
	ld	l,(ix+6 )
	ld	h,(ix+7 )
	push	hl
	call	_FileString_GetExtension
	pop	af
	pop	de
	ld	(ix-8 ),l
	ld	(ix-7 ),h
;fat_string.c:282: if ((ext1Pos==-1) && (ext2Pos!=-1))
	ld	a,(ix-8 )
	inc	a
	jr	NZ,fatfs_compare_names_00148
	ld	a,(ix-7 )
	inc	a
	jr	NZ,fatfs_compare_names_00148
	ld	a, &01
	jr	fatfs_compare_names_00149
fatfs_compare_names_00148:
	xor	a
fatfs_compare_names_00149:
	ld	l,a
	ld	a,e
	inc	a
	jr	NZ,fatfs_compare_names_00150
	ld	a,d
	inc	a
	jr	NZ,fatfs_compare_names_00150
	ld	a, &01
	jr	fatfs_compare_names_00151
fatfs_compare_names_00150:
	xor	a
fatfs_compare_names_00151:
	ld	c,a
	or	 a
	jr	Z,fatfs_compare_names_00102
	ld	a,l
	or	 a
	jr	NZ,fatfs_compare_names_00102
;fat_string.c:283: return 0;
	ld	hl, &0000
	jp	fatfs_compare_names_00119
fatfs_compare_names_00102:
;fat_string.c:284: if ((ext2Pos==-1) && (ext1Pos!=-1))
	ld	a,l
	or	 a
	jr	Z,fatfs_compare_names_00105
	ld	a,c
	or	 a
	jr	NZ,fatfs_compare_names_00105
;fat_string.c:285: return 0;
	ld	hl, &0000
	jp	fatfs_compare_names_00119
fatfs_compare_names_00105:
;fat_string.c:288: if (ext1Pos!=-1)
	ld	a,c
	or	 a
	jp	NZ,fatfs_compare_names_00112
;fat_string.c:291: ext1 = strA+ext1Pos+1;
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	add	hl,de
	inc	hl
	ld	c,l
	ld	b,h
;fat_string.c:292: ext2 = strB+ext2Pos+1;
	ld	a,(ix+6 )
	add	a, (ix-8 )
	ld	l,a
	ld	a,(ix+7 )
	adc	a, (ix-7 )
	ld	h,a
	inc	hl
	ld	(ix-6 ),l
	ld	(ix-5 ),h
;fat_string.c:295: if (strlen(ext1) != strlen(ext2))
	push	bc
	push	de
	push	bc
	call	_strlen
	pop	af
	ld	(ix-3 ),h
	ld	(ix-4 ),l
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	push	hl
	call	_strlen
	pop	af
	ld	(ix-1 ),h
	ld	(ix-2 ),l
	pop	de
	pop	bc
	ld	a,(ix-2 )
	sub	 (ix-4 )
	jr	NZ,fatfs_compare_names_00152
	ld	a,(ix-1 )
	sub	 (ix-3 )
	jr	Z,fatfs_compare_names_00108
fatfs_compare_names_00152:
;fat_string.c:296: return 0;
	ld	hl, &0000
	jp	fatfs_compare_names_00119
fatfs_compare_names_00108:
;fat_string.c:299: if (FileString_StrCmpNoCase(ext1, ext2, (int)strlen(ext1))!=0) 
	push	bc
	push	de
	push	bc
	call	_strlen
	pop	af
	pop	de
	pop	bc
	push	de
	push	hl
	ld	l,(ix-6 )
	ld	h,(ix-5 )
	push	hl
	push	bc
	call	_FileString_StrCmpNoCase
	pop	af
	pop	af
	pop	af
	pop	de
	ld	a,h
	or	l
	jr	Z,fatfs_compare_names_00110
;fat_string.c:300: return 0;
	ld	hl, &0000
	jp	fatfs_compare_names_00119
fatfs_compare_names_00110:
;fat_string.c:303: file1Len = ext1Pos;
	ld	(ix-10 ),e
	ld	(ix-9 ),d
;fat_string.c:304: file2Len = ext2Pos;
	ld	a,(ix-8 )
	ld	(ix-12 ),a
	ld	a,(ix-7 )
	ld	(ix-11 ),a
	jr	fatfs_compare_names_00113
fatfs_compare_names_00112:
;fat_string.c:310: file1Len = (int)strlen(strA);
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	push	hl
	call	_strlen
	pop	af
	ld	(ix-10 ),l
	ld	(ix-9 ),h
;fat_string.c:311: file2Len = (int)strlen(strB);
	ld	l,(ix+6 )
	ld	h,(ix+7 )
	push	hl
	call	_strlen
	pop	af
	inc	sp
	inc	sp
	push	hl
fatfs_compare_names_00113:
;fat_string.c:315: file1Len = FileString_TrimLength(strA, file1Len);
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	push	hl
	call	_FileString_TrimLength
	pop	af
	pop	af
	ld	(ix-10 ),l
	ld	(ix-9 ),h
;fat_string.c:316: file2Len = FileString_TrimLength(strB, file2Len);
	pop	hl
	push	hl
	push	hl
	ld	l,(ix+6 )
	ld	h,(ix+7 )
	push	hl
	call	_FileString_TrimLength
	pop	af
	pop	af
	inc	sp
	inc	sp
	push	hl
;fat_string.c:319: if (file1Len!=file2Len)
	ld	a,(ix-10 )
	sub	 (ix-12 )
	jr	NZ,fatfs_compare_names_00153
	ld	a,(ix-9 )
	sub	 (ix-11 )
	jr	Z,fatfs_compare_names_00115
fatfs_compare_names_00153:
;fat_string.c:320: return 0;
	ld	hl, &0000
	jr	fatfs_compare_names_00119
fatfs_compare_names_00115:
;fat_string.c:323: if (FileString_StrCmpNoCase(strA, strB, file1Len)!=0)
	pop	bc
	pop	hl
	push	hl
	push	bc
	push	hl
	ld	l,(ix+6 )
	ld	h,(ix+7 )
	push	hl
	ld	l,(ix+4 )
	ld	h,(ix+5 )
	push	hl
	call	_FileString_StrCmpNoCase
	pop	af
	pop	af
	pop	af
	ld	a,h
	or	l
	jr	Z,fatfs_compare_names_00117
;fat_string.c:324: return 0;
	ld	hl, &0000
	jr	fatfs_compare_names_00119
fatfs_compare_names_00117:
;fat_string.c:326: return 1;
	ld	hl, &0001
fatfs_compare_names_00119:
	ld	sp,ix
	pop	ix
	ret
_fatfs_compare_names_end:

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

