
// ----------------------------------------------------------------------------
#ifndef _HXC_IO_H_
#define _HXC_IO_H_

// ----------------------------------------------------------------------------
void MediaInit();
int MediaQuit();

int MediaRead(unsigned long lba_sector, unsigned char *buffer);
int MediaWrite(unsigned long lba_sector, unsigned char *buffer);

// ----------------------------------------------------------------------------
#endif // _HXC_IO_H_