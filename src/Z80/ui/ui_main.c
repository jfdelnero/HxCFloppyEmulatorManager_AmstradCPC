
// ----------------------------------------------------------------------------
#include <string.h>

// ----------------------------------------------------------------------------
#include "config.h"
#include "platform\firmware_define.h"
#include "ui\ui_define.h"
#include "ui\ui_slot.h"
#include "ui\ui_help.h"
#include "ui\ui_init.h"
#include "ui\ui_browse.h"
#include "ui\ui_navigate.h"
#include "ui\ui_select.h"
#include "ui\ui_quit.h"
#include "ui\ui_buzzer.h"
#include "platform\bios.h"

// ----------------------------------------------------------------------------
void main()
{	
	unsigned char key;
	char isQuit;
	
__asm	
	call KL_CURR_SELECTION	
	call KL_U_ROM_DISABLE
	
	ld h, &12 ; first repeat, default is &1E
	ld l, &02 ; repeat speed, default is &02
	call KM_SET_DELAY
__endasm;
	
	InitProgram();
	
	strcpy((char*)BROWSE_CURRENTPATH, "/");
	InitNavigate();
	BrowsePath();
	
	isQuit = 0;
	
	while(isQuit==0)
	{
		key = WaitKey();
		
		if (key==0xF0) // Up
		{
			Up();
		}
		else if (key==0xF1) // Down
		{
			Down();
		}
		else if (key==0xF2) // Left
		{		
			Left();
		}
		else if (key==0xF3) // Right
		{
			Right();
		}
		else if (key==0xFA) // Ctrl+Left
		{
			PrevSlot();
		}		
		else if (key==0xFB) // Ctrl+Right
		{
			NextSlot();
		}
		else if ((key==0x20)||(key==0x8B)||(key==0x0D)) // Space, Enter, Return
		{
			Select();
		}
		else if( (key=='h')||(key=='h'))
		{
			ShowHelp();
			BrowsePage();	
		}
		else if( (key=='s')||(key=='S'))
		{
			ShowSlots();
			BrowsePage();	
		}
		else if( (key=='b')||(key=='B'))
		{
			ShowBuzzerSettings();
			BrowsePage();	
		}
		else if(key==0xFC) // ESC
		{
			isQuit = ShowQuit();
		}
	}
	
__asm
	call 0
__endasm;
}
