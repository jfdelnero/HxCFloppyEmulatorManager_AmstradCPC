
// ----------------------------------------------------------------------------
#include "config.h"
#include "ui\ui_font.h"
#include "ui\ui_element.h"
#include "hxc\hxc_attach.h"
#include "hxc\hxc_config.h"

// ----------------------------------------------------------------------------
char ShowQuit()
{
	char errorCode;
	char key;
	
	CLS();
	
	PrintEmptyLine();
	Print(" Save ? (Y/N) ");
	
	do
	{
		key = WaitKey();
	} while ((key!='y')&&(key!='Y')&&(key!='n')&&(key!='N'));
	
	if ((key=='y')||(key=='Y'))
	{
		Println("Y");	
		PrintEmptyLine();
		
		Println(" Saving..");
		
		if (!HxC_WriteConfigFile(&errorCode))
		{
			StopError(errorCode);
		}
	}
	else
	{
		Println("N");	
		PrintEmptyLine();

		Println(" Exiting..");		
	}
			
	if (!HxC_Detach(&errorCode))
	{
		StopError(errorCode);
	}
	
	return 1;
}
