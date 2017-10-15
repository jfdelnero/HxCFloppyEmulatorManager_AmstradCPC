
// ----------------------------------------------------------------------------
#include "config.h"
#include "ui\ui_define.h"
#include "ui\ui_font.h"
#include "ui\ui_global.h"
#include "ui\ui_element.h"
#include "hxc\hxc_error.h"
#include "hxc\hxc_init.h"
#include "hxc\hxc_attach.h"
#include "hxc\hxc_config.h"
#include "hxc\hxc_struct.h"

// ----------------------------------------------------------------------------
void InfiniteLoop()
{
__asm
	jr _InfiniteLoop
__endasm;
}

// ----------------------------------------------------------------------------
void InitScreen()
{
__asm
	ld a, 1
	call &BC0E
__endasm;
}

// ----------------------------------------------------------------------------
void InitProgram()
{
	struct DirectAccessStatusSector *directAccessStatusSector;
	char errorCode;
	
	InitScreen();
	
	directAccessStatusSector = GetStatusSector();
	
	InitFont();
	InitUI();
	CLS();
__asm
	call &BD19

	ld bc, &BC00+6
	out (c), c
	ld bc, &BD00+25
	out (c), c
__endasm;
	
	PrintEmptyLine();
	Println(" Press H key for help");
	
	PrintEmptyLine();
	
	Println(" Initializing..");
	
	if (!HxC_Init(directAccessStatusSector, &errorCode))
	{
		StopError(errorCode);
	}
	
	PrintEmptyLine();
	Print(" Found firmware version ");
	Println(directAccessStatusSector->FIRMWAREVERSION);
	
	if (!HxC_Attach(&errorCode))
	{
		StopError(errorCode);
	}
	
	if (!HxC_ReadConfigFile(&errorCode))
	{
		StopError(errorCode);
	}
	
	SelectSlotInConfig();
}
