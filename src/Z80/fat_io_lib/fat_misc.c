//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
//					        FAT16/32 File IO Library
//								    V2.6
// 	  							 Rob Riglar
//						    Copyright 2003 - 2010
//
//   					  Email: rob@robriglar.com
//
//								License: GPL
//   If you would like a version with a more permissive license for use in
//   closed source commercial applications please contact me for details.
//-----------------------------------------------------------------------------
//
// This file is part of FAT File IO Library.
//
// FAT File IO Library is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// FAT File IO Library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with FAT File IO Library; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
//-----------------------------------------------------------------------------
//-----------------------------------------------------------------------------
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "fat_io_lib\fat_misc.h"

void * z80_memset( void *dst, char value, int acount );

//-----------------------------------------------------------------------------
// fatfs_lfn_cache_init: Clear long file name cache
//-----------------------------------------------------------------------------
void fatfs_lfn_cache_init(struct lfn_cache *lfn, int wipeTable)
{
	int i = 0;

	lfn->no_of_strings = 0;

#if FATFS_INC_LFN_SUPPORT

	// Zero out buffer also
	if (wipeTable)
		for (i=0;i<MAX_LONGFILENAME_ENTRIES;i++)
			z80_memset(lfn->String[i], 0x00, MAX_LFN_ENTRY_LENGTH);
#endif
}
//-----------------------------------------------------------------------------
// fatfs_lfn_cache_entry - Function extracts long file name text from sector
// at a specific offset
//-----------------------------------------------------------------------------
#if FATFS_INC_LFN_SUPPORT
void fatfs_lfn_cache_entry(struct lfn_cache *lfn, unsigned char *entryBuffer)
{
	unsigned char LFNIndex, i;
	LFNIndex = entryBuffer[0] & 0x1F;

	// Limit file name to cache size!
	if (LFNIndex > MAX_LONGFILENAME_ENTRIES)
		return ;

	// This is an error condition
	if (LFNIndex == 0)
		return ;

	if (lfn->no_of_strings == 0)
		lfn->no_of_strings = LFNIndex;

	lfn->String[LFNIndex-1][0] = entryBuffer[1];
	lfn->String[LFNIndex-1][1] = entryBuffer[3];
	lfn->String[LFNIndex-1][2] = entryBuffer[5];
	lfn->String[LFNIndex-1][3] = entryBuffer[7];
	lfn->String[LFNIndex-1][4] = entryBuffer[9];
	lfn->String[LFNIndex-1][5] = entryBuffer[0x0E];
	lfn->String[LFNIndex-1][6] = entryBuffer[0x10];
	lfn->String[LFNIndex-1][7] = entryBuffer[0x12];
	lfn->String[LFNIndex-1][8] = entryBuffer[0x14];
	lfn->String[LFNIndex-1][9] = entryBuffer[0x16];
	lfn->String[LFNIndex-1][10] = entryBuffer[0x18];
	lfn->String[LFNIndex-1][11] = entryBuffer[0x1C];
	lfn->String[LFNIndex-1][12] = entryBuffer[0x1E];

	for (i=0; i<MAX_LFN_ENTRY_LENGTH; i++)
		if (lfn->String[LFNIndex-1][i]==0xFF)
			lfn->String[LFNIndex-1][i] = 0x20; // Replace with spaces
}
#endif
//-----------------------------------------------------------------------------
// fatfs_lfn_cache_get: Get a reference to the long filename
//-----------------------------------------------------------------------------
#if FATFS_INC_LFN_SUPPORT
char* fatfs_lfn_cache_get(struct lfn_cache *lfn)
{
	// Null terminate long filename
	if (lfn->no_of_strings == MAX_LONGFILENAME_ENTRIES)
		lfn->Null = '\0';
	else if (lfn->no_of_strings)
		lfn->String[lfn->no_of_strings][0] = '\0';
	else
		lfn->String[0][0] = '\0';

	return &lfn->String[0][0];
}
#endif
//-----------------------------------------------------------------------------
// fatfs_entry_lfn_text: If LFN text entry found
//-----------------------------------------------------------------------------
#if FATFS_INC_LFN_SUPPORT
int fatfs_entry_lfn_text(struct fat_dir_entry *entry)
{
	if ((entry->Attr & FILE_ATTR_LFN_TEXT) == FILE_ATTR_LFN_TEXT)
		return 1;
	else
		return 0;
}
#endif
//-----------------------------------------------------------------------------
// fatfs_entry_lfn_invalid: If SFN found not relating to LFN
//-----------------------------------------------------------------------------
#if FATFS_INC_LFN_SUPPORT
int fatfs_entry_lfn_invalid(struct fat_dir_entry *entry)
{
	if ( (entry->Name[0]==FILE_HEADER_BLANK)  ||
		 (entry->Name[0]==FILE_HEADER_DELETED)||
		 (entry->Attr==FILE_ATTR_VOLUME_ID) ||
		 (entry->Attr & FILE_ATTR_SYSHID) )
		return 1;
	else
		return 0;
}
#endif
//-----------------------------------------------------------------------------
// fatfs_entry_lfn_exists: If LFN exists and correlation SFN found
//-----------------------------------------------------------------------------
#if FATFS_INC_LFN_SUPPORT
int fatfs_entry_lfn_exists(struct lfn_cache *lfn, struct fat_dir_entry *entry)
{
	if ( (entry->Attr!=FILE_ATTR_LFN_TEXT) &&
		 (entry->Name[0]!=FILE_HEADER_BLANK) &&
		 (entry->Name[0]!=FILE_HEADER_DELETED) &&
		 (entry->Attr!=FILE_ATTR_VOLUME_ID) &&
		 (!(entry->Attr&FILE_ATTR_SYSHID)) &&
		 (lfn->no_of_strings) )
		return 1;
	else
		return 0;
}
#endif
//-----------------------------------------------------------------------------
// fatfs_entry_sfn_only: If SFN only exists
//-----------------------------------------------------------------------------
int fatfs_entry_sfn_only(struct fat_dir_entry *entry)
{
	if ( (entry->Attr!=FILE_ATTR_LFN_TEXT) &&
		 (entry->Name[0]!=FILE_HEADER_BLANK) &&
		 (entry->Name[0]!=FILE_HEADER_DELETED) &&
		 (entry->Attr!=FILE_ATTR_VOLUME_ID) &&
		 (!(entry->Attr&FILE_ATTR_SYSHID)) )
		return 1;
	else
		return 0;
}
// TODO: FILE_ATTR_SYSHID ?!?!??!
//-----------------------------------------------------------------------------
// fatfs_entry_is_dir: Returns 1 if a directory
//-----------------------------------------------------------------------------
int fatfs_entry_is_dir(struct fat_dir_entry *entry)
{
	if (entry->Attr & FILE_TYPE_DIR)
		return 1;
	else
		return 0;
}
//-----------------------------------------------------------------------------
// fatfs_entry_is_file: Returns 1 is a file entry
//-----------------------------------------------------------------------------
int fatfs_entry_is_file(struct fat_dir_entry *entry)
{
	if (entry->Attr & FILE_TYPE_FILE) 
		return 1;
	else 
		return 0;
}
