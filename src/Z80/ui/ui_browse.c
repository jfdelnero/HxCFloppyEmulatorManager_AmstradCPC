
// ----------------------------------------------------------------------------
#include <string.h>

// ----------------------------------------------------------------------------
#include "fat_io_lib\fat_opts.h"
#include "fat_io_lib\fat_misc.h" // ENDIAN_32BIT

// ----------------------------------------------------------------------------
#include "config.h"
#include "crt\crt.h"
#include "ui\ui_define.h"
#include "ui\ui_font.h"
#include "fat_io_lib\fat_filelib.h"
#include "ui\ui_navigate.h"
#include "hxc\hxc_struct.h"

// ----------------------------------------------------------------------------
static struct fs_dir_list_status temp_file_list_status;
static struct fs_dir_ent dir_entry;
static char CurrentPage;
static char EndPage;

// ----------------------------------------------------------------------------
char GetPage()
{
	return CurrentPage;
}

// ----------------------------------------------------------------------------
char IsFirstPage()
{
	if ( CurrentPage == 0 )
	{
		return 1;
	}

	return 0;
}

// ----------------------------------------------------------------------------
char IsLastPage()
{
	if ( EndPage == CurrentPage )
	{
		return 1;
	}

	return 0;
}

// ----------------------------------------------------------------------------
char IsHFEFilename(char *filename)
{
	filename;
	
__asm
	push ix
	ld	ix, 0
	add	ix, sp
	
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
__endasm;
}

// ----------------------------------------------------------------------------
char IsDSKFilename(char *filename)
{
	filename;
	
__asm
	push ix
	ld	ix, 0
	add	ix, sp
	
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
__endasm;
}

// ----------------------------------------------------------------------------
void BrowsePage()
{
	int i;
	int readdir_res;	
	struct DirectoryEntry *dirEntries;
	struct fs_dir_list_status *dirListAllStatuses;
	struct fs_dir_list_status *dirListStatus;
	struct fs_dir_list_status *nextDirListStatus;
	
#ifdef USE_CPCEMU
	char dotFolderGenerated;
	char notHFEGenerated;

	dotFolderGenerated = 0;
	notHFEGenerated = 0;
#endif

	dirListAllStatuses = (struct fs_dir_list_status *) HXC_UI_BROWSE_DIRSTATUS;
	dirListStatus = &dirListAllStatuses[CurrentPage];
	nextDirListStatus = dirListStatus+1;
		
	z80_memcpy( nextDirListStatus, dirListStatus, sizeof(struct fs_dir_list_status));
	
	dirEntries = (struct DirectoryEntry *) HXC_UI_DIRENTRIES;
	
	for (i=0; i<SCREEN_MAXSLOTS; i++)
	{			
#ifdef USE_CPCEMU
		/*strcpy( dir_entry.filename, "Test.hfe");
		if ((notHFEGenerated==0)&&(i==4))
		{
			strcpy( dir_entry.filename, "Testbilly.dhfe");
			notHFEGenerated = 1;
		}
		dir_entry.is_dir = i&1;
		dir_entry.size = 666;
		if ((dotFolderGenerated==0)&&(i==1))
		{
			strcpy( dir_entry.filename, ".");
			dir_entry.size = 0;
			dotFolderGenerated = 1;
		}
		else if (i==3)
		{
			strcpy( dir_entry.filename, "..");
			dir_entry.size = 0;
		}
		readdir_res = 1;
		if (i>15)
		{
			readdir_res = 0;
		}*/
		readdir_res = 1;
		if(i==0)
		{
			strcpy( dir_entry.filename, "AUTOBOOT.HFE");
			dir_entry.is_dir = 0;	
			dir_entry.size = 666;
		}
		else if (i>14)
		{		
			readdir_res = 0;
		}
		else
		{
			dir_entry.is_dir = 1;	
			dir_entry.size = 0;
			
			if (i==1) { strcpy( dir_entry.filename, "APPLICATIONS"); }
			else if (i==2) { strcpy( dir_entry.filename, "COMPILS"); }
			else if (i==3) { strcpy( dir_entry.filename, "DEMOS"); }
			else if (i==4) { strcpy( dir_entry.filename, "DISKMAGS"); }
			else if (i==5) { strcpy( dir_entry.filename, "GAMES"); }
			else if (i==6) { strcpy( dir_entry.filename, "LISTINGS"); }
			else if (i==7) { strcpy( dir_entry.filename, "MISC"); }
			else if (i==8) { strcpy( dir_entry.filename, "MUSIC"); }
			else if (i==9) { strcpy( dir_entry.filename, "MUSICDISKS"); }
			else if (i==10) { strcpy( dir_entry.filename, "PEOPLE"); }
			else if (i==11) { strcpy( dir_entry.filename, "PREVIEWS"); }
			else if (i==12) { strcpy( dir_entry.filename, "ROMS"); }
			else if (i==13) { strcpy( dir_entry.filename, "SLIDESHOWS"); }
			else if (i==14) { strcpy( dir_entry.filename, "WORK"); }
		}
		
#else
		readdir_res = fl_list_readdir(nextDirListStatus, &dir_entry);
#endif
		if ( readdir_res )
		{
			if (dir_entry.is_dir)
			{
				if ((dir_entry.filename[0]=='.')&&(dir_entry.filename[1]!='.'))
				{
					i--;
					continue;
				}
			}
			else
			{
				if ( IsHFEFilename(dir_entry.filename) == 0 )
				{
					if ( IsDSKFilename(dir_entry.filename) == 0 )
					{
						i--;
						continue;
					}
				}
			}
		}
		else
		{
			if ( i == 0 )
			{
				CurrentPage--;
				return;
			}
		}
		
		z80_memcpy( dirEntries->longName, dir_entry.filename, 16);
		dirEntries->longName[16]=0;
	
		if (readdir_res)
		{
			if ( i == 0 )
			{
				CLS();
			}
			
			dir_entry.filename[34] = 0;
			
			if (dir_entry.is_dir)
			{
				Print("<DIR> ");
				
				dirEntries->attributes = 0x10;
			}
			else
			{
				dirEntries->attributes = 0x00;
			}
			
			PrintlnTab( dir_entry.filename );
			
			dirEntries->firstCluster = ENDIAN_32BIT(dir_entry.cluster);
			dirEntries->size = ENDIAN_32BIT(dir_entry.size);
		}
		else
		{
			dirEntries->longName[0]=0;
			dirEntries->size=0;
			
			EndPage = CurrentPage;
		}
		
		dirEntries += 1;
	}
	
	UpdateNavigate();
}
	
// ----------------------------------------------------------------------------
void BrowsePath()
{
	char *path;
	struct DirectoryEntry *dirEntries;
	struct fs_dir_list_status *dirListStatus;
		
	dirEntries = (struct DirectoryEntry *) HXC_UI_DIRENTRIES;
	z80_memset(dirEntries, 0, 0x400); // sizeof(struct DirectoryEntry)*SCREEN_MAXSLOTS
	
	dirListStatus = (struct fs_dir_list_status *) HXC_UI_BROWSE_DIRSTATUS;
	
	path = (char*)BROWSE_CURRENTPATH;
	
	RefreshPathSlot();
		
#ifdef USE_CPCEMU
#else
	fl_list_opendir(path, dirListStatus);
#endif
	
	CurrentPage = 0;
	EndPage = 255;
	
	BrowsePage();
}

// ----------------------------------------------------------------------------
void BrowsePrevPage()
{
	CurrentPage--;		
	BrowsePage();
}

// ----------------------------------------------------------------------------
void BrowseNextPage()
{
	CurrentPage++;
	BrowsePage();
}
