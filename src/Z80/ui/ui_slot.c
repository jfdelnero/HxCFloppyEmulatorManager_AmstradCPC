
// ----------------------------------------------------------------------------
#include <string.h>

// ----------------------------------------------------------------------------
#include "config.h"
#include "hxc\hxc_define.h"
#include "ui\ui_font.h"
#include "ui\ui_define.h"
#include "ui\ui_global.h"
#include "ui\ui_element.h"
#include "hxc\hxc_struct.h"
#include "hxc\hxc_define.h"
#include "crt\crt.h"

// ----------------------------------------------------------------------------
void ShowSlots()
{
	char slotLabel[24];
	unsigned char len;
	struct ConfigFile *configFile;
	struct DiskInDrive *slots;
	struct DiskInDrive *slot;
	int iSlot;
	unsigned long dirEntSize;
	
	configFile = (struct ConfigFile *) HXC_CONFIG;
	slots = (struct DiskInDrive*) HXC_SLOTS;
	
	CLS();
	
	PrintEmptyLine();
	Println(" Slot list");
	PrintEmptyLine();
	
	for (iSlot = 1; iSlot < SLOTCOUNT; iSlot++ )
	{
		slot = &slots[ iSlot ];
		
		Print(" ");
		PrintUInt8_WithZero(iSlot);
		Print(" ");
		
		if (slot->DirEnt.size>0)
		{
			z80_memcpy(slotLabel, slot->DirEnt.longName, 16 );
			slotLabel[16]=0;
			Println(slotLabel);
		}
		else
		{
			PrintEmptyLine();	
		}
	}
	
	PrintEmptyLine();
	Println(" Press a key..");
	
	WaitKey();
}

// ----------------------------------------------------------------------------
void PrevSlot()
{
	char selectedSlot;
	
	selectedSlot = GetSelectedSlot();
	
	if (selectedSlot==1)
	{
		selectedSlot = SLOTCOUNT-1;
	}
	else
	{
		selectedSlot--;
	}
	
	SetSelectedSlot(selectedSlot);
	
	RefreshPathSlot();
}

// ----------------------------------------------------------------------------
void NextSlot()
{
	char selectedSlot;
	
	selectedSlot = GetSelectedSlot();
	
	if (selectedSlot==SLOTCOUNT-1)
	{
		selectedSlot = 1;
	}
	else
	{
		selectedSlot++;
	}
	
	SetSelectedSlot(selectedSlot);
	
	RefreshPathSlot();
}

// ----------------------------------------------------------------------------
void SelectSlotInConfig()
{
	unsigned char slot;
	struct ConfigFile *configFile;	
	
	configFile = (struct ConfigFile *) HXC_CONFIG;
		
	slot = configFile->slot_index;
	
	if (slot!=0)
	{
		SetSelectedSlot(slot);
	}
	else
	{
		SetSelectedSlot(1);
	}
}
