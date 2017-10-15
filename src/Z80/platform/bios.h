
// ----------------------------------------------------------------------------
#ifndef _BIOS_H_
#define _BIOS_H_

// ----------------------------------------------------------------------------
void ConfigDiskDrive();
void RestoreDiskDrive();

char ReadSector(unsigned char *buffer, unsigned char track, unsigned char sector);
char WriteSector(unsigned char *buffer, unsigned char track, unsigned char sector);
char MoveToTrack(unsigned char track);

// ----------------------------------------------------------------------------
#endif // _BIOS_H_