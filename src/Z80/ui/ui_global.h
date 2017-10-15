
// ----------------------------------------------------------------------------
#ifndef _UI_GLOBAL_H_
#define _UI_GLOBAL_H_

// ----------------------------------------------------------------------------
struct DirectAccessStatusSector *GetStatusSector();
char GetSelectedSlot();
char SetSelectedSlot(char selectedSlot);
char GetLastSetSlot();
char SetLastSetSlot(char lastSetSlot);

// ----------------------------------------------------------------------------
#endif // _UI_GLOBAL_H_