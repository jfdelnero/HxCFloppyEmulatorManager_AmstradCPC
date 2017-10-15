
// ----------------------------------------------------------------------------
#include <string.h>

// ----------------------------------------------------------------------------
#include "config.h"
#include "crt\crt.h"
#include "platform\bios.h"
#include "platform\firmware.h"
#include "ui\ui_define.h"
#include "ui\ui_font.h"
#include "ui\ui_element.h"
#include "ui\ui_slot.h"
#include "ui\ui_help.h"
#include "ui\ui_init.h"
#include "hxc\hxc_struct.h"
#include "hxc\hxc_define.h"

// ----------------------------------------------------------------------------
static struct DirectAccessStatusSector StatusSector;
static char SelectedSlot;
static char LastSetSlot;

// ----------------------------------------------------------------------------
struct DirectAccessStatusSector *GetStatusSector()
{
	return &StatusSector;
}

// ----------------------------------------------------------------------------
char GetSelectedSlot()
{
	return SelectedSlot;
}

// ----------------------------------------------------------------------------
char SetSelectedSlot(char selectedSlot)
{
	SelectedSlot = selectedSlot;
}

// ----------------------------------------------------------------------------
char GetLastSetSlot()
{
	return LastSetSlot;
}

// ----------------------------------------------------------------------------
char SetLastSetSlot(char lastSetSlot)
{
	LastSetSlot = lastSetSlot;
}
