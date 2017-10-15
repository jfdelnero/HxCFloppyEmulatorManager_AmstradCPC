
// ----------------------------------------------------------------------------
#ifndef _UI_DEFINE_H_
#define _UI_DEFINE_H_

// ----------------------------------------------------------------------------
#define TINY_TOP_SCREENPTR		0xF0A0
#define REGULAR_SCREENPTR		0xC140

// ----------------------------------------------------------------------------
#define SCREEN_MAXSLOTS			21

// also defined in config.asm
#define TINY_FONT				0x0300 // Length=0x300
#define REGULAR_FONT			0x0600 // Length=0x600

// only used at init time
#define BACKGROUNDTEMP_BUFFER	0x0C00 // also defined in config.asm !

// ----------------------------------------------------------------------------
#define PATHSLOT_BUFFER			0x1680
#define BROWSE_CURRENTPATH		0x1700
#define SCREEN_CHARPTR			0x1800
#define TINY_FONTCHARPTR		0x1900
#define REGULAR_FONTCHARPTR		0x1A00

// here check hxc_define.h
/*
#define HXC_CONFIG						0x1B00 // 512 bytes
#define HXC_SLOTS						0x1D00 // SLOTCOUNT * sizeof( DiskInDrive ) = &400
#define HXC_SECTORDATA					0x2100 // 512 bytes
#define HXC_CMDSECTOR					0x2300 // 512 bytes
*/

#define HXC_UI_DIRENTRIES		0x2500 // 0x400 bytes (SCREEN_MAXSLOTS*sizeof(DirectoryEntry))
#define HXC_UI_BROWSE_DIRSTATUS	0x0C00 // 0xA00 bytes 

// next is CoreStartAddress		equ &2900 (as defined in config.asm)

// ----------------------------------------------------------------------------
#endif // _UI_DEFINE_H_