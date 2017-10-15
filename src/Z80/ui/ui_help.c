
// ----------------------------------------------------------------------------
#include "config.h"
#include "ui\ui_font.h"
#include "ui\ui_element.h"

// ----------------------------------------------------------------------------
void ShowHelp()
{
	CLS();
	
	PrintEmptyLine();
	Println(" Keys");
	Println("  Up/Down/Left/Right: navigate");
	Println("  Ctrl+Left/Ctrl+Right: prev/next slot");
	Println("  Space/Enter: select");
	Println("  S: slot list");
	Println("  B: buzzer settings");
	Println("  ESC: quit");
	PrintEmptyLine();
	Println(" Credits");
	Println("  V3.5 by NoRecess/Ced (Condense)");
	Println("  Original by JF Del Nero (HxC2001)");
	PrintEmptyLine();
	Println(" Press a key..");
	
	WaitKey();
}
