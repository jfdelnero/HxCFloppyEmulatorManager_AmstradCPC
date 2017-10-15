
// ----------------------------------------------------------------------------
#ifndef _UI_FONT_H_
#define _UI_FONT_H_

// ----------------------------------------------------------------------------
void InitFont();
void SetRegularScreenPtr(char *screenPtr);

void PrintTiny(char *screenPtr, char *str);

void Print(char *str);
void PrintEmptyLine();
void Println(char *str);
void PrintlnTab(char *str);
void PrintUInt8(unsigned char value);
void PrintUInt8_WithZero(unsigned char value);

// ----------------------------------------------------------------------------
#endif // _UI_FONT_H_