
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
char YesNo()
{
	char key;
	do
	{
		key = WaitKey();
	} while ((key!='y')&&(key!='Y')&&(key!='n')&&(key!='N'));
	
	if ((key=='y')||(key=='Y'))
	{
		return 1;
	}
	
	return 0;
}

// ----------------------------------------------------------------------------
void ShowBuzzerSettings()
{
	char isYes;
	struct ConfigFile *configFile;
	
	configFile = (struct ConfigFile *) HXC_CONFIG;
	
	CLS();
	
	PrintEmptyLine();
	Println(" Buzzer settings");
	PrintEmptyLine();
	
	Print(" Emits beep for UI operations ? (Y/N) ");
	isYes = YesNo();
	if (isYes==1)
	{
		configFile->ihm_sound = 0xFF;
		Println("Y");
	}
	else
	{
		configFile->ihm_sound = 0x00;
		Println("N");
	}
	
	Print(" Emits beep for disc access ? (Y/N) ");
	isYes = YesNo();
	if (isYes==1)
	{
		configFile->step_sound = 0xFF;
		Println("Y");
	}
	else
	{
		configFile->step_sound = 0x00;
		Println("N");
	}
}
