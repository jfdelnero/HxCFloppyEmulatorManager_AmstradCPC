
// ----------------------------------------------------------------------------
#ifndef _CRT_H_
#define _CRT_H_

// ----------------------------------------------------------------------------
void uitoa(unsigned int value, char* string, unsigned char radix);
char *z80_strcpy( char *d, const char *s);
unsigned short z80_strlen ( const char *str );
void *z80_memcpy( void *dst, void *src, unsigned short acount );
void * z80_memset( void *dst, char value, int acount );

// ----------------------------------------------------------------------------
#endif // _CRT_H_