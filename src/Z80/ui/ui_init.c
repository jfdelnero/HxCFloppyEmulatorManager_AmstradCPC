
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
	
	call &BD19
	
	ld bc, &0000
	call &BC38
	
	xor a
SetBlackPaletteLoop:
	ld bc, 0
	push af
	call &BC32
	pop af
	inc a
	cp 4
	jr nz, SetBlackPaletteLoop
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
	ld hl, &E000+80+80+80
	ld (hl), 255
	ld d, h
	ld e, l
	inc de
	ld bc, 80-1
	ldir
	ld hl, &E800+80+80+80
	ld (hl), 255
	ld d, h
	ld e, l
	inc de
	ld bc, 80-1
	ldir
__endasm;
	
	PrintEmptyLine();
	Println(" Press H key for help");
	
	PrintEmptyLine();
	
	Println(" Init..");
	
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
