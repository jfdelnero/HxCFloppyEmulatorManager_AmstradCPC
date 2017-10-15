
// ----------------------------------------------------------------------------
#ifndef _HXC_DEFINE_H_
#define _HXC_DEFINE_H_

// ----------------------------------------------------------------------------
#define SLOTCOUNT						16

// ----------------------------------------------------------------------------
#define SECTORSIZE						512

// ----------------------------------------------------------------------------
#define OPERATIONRESULT_ERROR 			0
#define OPERATIONRESULT_SUCCESS			1

// ----------------------------------------------------------------------------
#define HXC_CONFIG						0x1B00 // 512 bytes
#define HXC_SLOTS						0x1D00 // SLOTCOUNT * sizeof( DiskInDrive ) = &400
#define HXC_SECTORDATA					0x2100 // 512 bytes
#define HXC_CMDSECTOR					0x2300 // 512 bytes

// ----------------------------------------------------------------------------
#define HXCERROR_OK						0
#define	HXCERROR_FLOPPYACCESSERROR		1
#define HXCERROR_BADSIGNATURE			2
#define HXCERROR_ATTACHMEDIAFAILED		3
#define HXCERROR_READCONFIGFILEERROR	4
#define HXCERROR_CMDSETTRACKPOS			5

// ----------------------------------------------------------------------------
#endif // _HXC_DEFINE_H_