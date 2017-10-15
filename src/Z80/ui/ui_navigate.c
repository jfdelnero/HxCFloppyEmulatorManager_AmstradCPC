
// ----------------------------------------------------------------------------
#include "config.h"
#include "crt\crt.h"
#include "hxc\hxc_define.h"
#include "hxc\hxc_struct.h"
#include "ui\ui_element.h"
#include "ui\ui_define.h"
#include "ui\ui_global.h"
#include "ui\ui_slot.h"
#include "ui\ui_browse.h"

// ----------------------------------------------------------------------------
#define START_Y		4
#define END_Y		4+SCREEN_MAXSLOTS-1

// ----------------------------------------------------------------------------
static char YPos;

// ----------------------------------------------------------------------------
char IsDirEntryEmpty(char yPos)
{
	struct DirectoryEntry *dirEntries;
	
	yPos -= START_Y;
	
	dirEntries = (struct DirectoryEntry *) HXC_UI_DIRENTRIES;
	
	if ( dirEntries[yPos].longName[0] == 0 )
	{
		return 1;
	}
	
	return 0;
}

// ----------------------------------------------------------------------------
void InitNavigate()
{
	YPos = START_Y;
}

// ----------------------------------------------------------------------------
void UpdateNavigate()
{
	while ( IsDirEntryEmpty( YPos ) == 1 )
	{
		YPos--;
	}
	
	InvertLine(YPos);
}

// ----------------------------------------------------------------------------
void Up()
{
	if (YPos==START_Y)
	{
		if ( IsFirstPage()==0 )
		{
			YPos = END_Y;
		}
		Left();
		return;
	}
	
	InvertLine(YPos);
	YPos--;
	InvertLine(YPos);
}

// ----------------------------------------------------------------------------
void Down()
{
	char prevPage;
	
	if (YPos==END_Y)
	{
		prevPage = GetPage();
		
		YPos = START_Y;
		BrowseNextPage();
		
		if ( prevPage == GetPage() )
		{
			YPos=END_Y;
		}
		return;
	}
	
	if (IsDirEntryEmpty(YPos+1)==1)
	{
		return;
	}
	
	InvertLine(YPos);
	YPos++;
	InvertLine(YPos);
}

// ----------------------------------------------------------------------------
void Left()
{
	unsigned char pathLen;
	char *path;
	
	if ( IsFirstPage()==1 )
	{
		pathLen = (unsigned char) z80_strlen( (char*)BROWSE_CURRENTPATH );
		
		if ( pathLen>1 )
		{
			path = (char*)BROWSE_CURRENTPATH;
		
			path[pathLen-1] = 0;
			while( pathLen && path[pathLen-1] != '/' )
			{
				path[pathLen-1] = 0;
				pathLen--;
			}
			
			BrowsePath();
		}
	}
	else
	{
		BrowsePrevPage();
	}
}

// ----------------------------------------------------------------------------
void Right()
{
	struct DirectoryEntry *dirEntries;
	struct DirectoryEntry *dirEntry;
	char dirIndex;
	
	dirEntries = (struct DirectoryEntry *) HXC_UI_DIRENTRIES;
	dirIndex = YPos - START_Y;
	dirEntry = &dirEntries[dirIndex];
	
	if (dirEntry->attributes & 0x10)
	{
		// folder, browse this one
		Select();
	}
	else
	{
		if ( IsLastPage()==0 )
		{
			BrowseNextPage();
		}
	}
}

// ----------------------------------------------------------------------------
void Select()
{
	struct DirectoryEntry *dirEntries;
	struct DirectoryEntry *dirEntry;
	struct DiskInDrive *slots;
	struct DiskInDrive *slot;
	char dirIndex;
	char slotIndex;
	unsigned char pathLen;
	char *path;
	char *subDir;
	unsigned char i;
	unsigned char j;
	unsigned char c;
	
	dirEntries = (struct DirectoryEntry *) HXC_UI_DIRENTRIES;	
	dirIndex = YPos - START_Y;
	dirEntry = &dirEntries[dirIndex];
	
	if (dirEntry->attributes & 0x10)
	{
		path = (char*)BROWSE_CURRENTPATH;
		subDir = &dirEntry->longName[0];
		
		pathLen = (unsigned char) z80_strlen( (char*)BROWSE_CURRENTPATH );
		
		if ( pathLen && (subDir[0]=='.') && (subDir[1]=='.') )
		{
			path[pathLen-1] = 0;
			while( pathLen && path[pathLen-1] != '/' )
			{
				path[pathLen-1] = 0;
				pathLen--;
			}
			
			BrowsePath();
		}
		else
		{		
			if ( subDir[0]!='.')
			{
				j = pathLen;
				i = 0;
				c = subDir[i];
				while(( c >= 32 ) && (c <= 127))
				{
					path[j+i] = c;
					i++;
					c = subDir[i];
				}
	
				i += j;
	
				while ( path[i-1] == 32 )
				{
					i--;
				}
				path[i]='/';
				path[i+1]=0;
				
				BrowsePath();
			}
		}
	}
	else
	{
		slots = (struct DiskInDrive*) HXC_SLOTS;
		slotIndex = GetSelectedSlot();
		slot = &slots[slotIndex];
		
		z80_memcpy( slot, dirEntry, sizeof(struct DirectoryEntry));
		
		SetLastSetSlot(slotIndex);
		
		NextSlot();
	}
}
