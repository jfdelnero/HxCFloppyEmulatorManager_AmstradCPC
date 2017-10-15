
// ----------------------------------------------------------------------------
#include <string.h>

// ----------------------------------------------------------------------------
#include "config.h"
#include "platform\bios.h"
#include "hxc\hxc_struct.h"
#include "hxc\hxc_define.h"
#include "fat_io_lib\fat_filelib.h"
#include "hxc\hxc_io.h"

// ----------------------------------------------------------------------------
static unsigned long last_setlbabase;

// ----------------------------------------------------------------------------
char setlbabase( unsigned long lba )
{
	unsigned char *ptr;
	struct DirectAccessCmdSector *dacs;
	
#ifdef USE_CPCEMU
	unsigned char track = 0;
	unsigned char sector = 0xC1;
#else
	unsigned char track = 255;
	unsigned char sector = 0;
#endif

	dacs = (struct DirectAccessCmdSector *) HXC_CMDSECTOR;

	strcpy( dacs->DAHEADERSIGNATURE, "HxCFEDA" );
	dacs->cmd_code = 1; // CMD_SET_LBA

	ptr = (unsigned char*) &lba;
	dacs->parameter_0 = *ptr++;
	dacs->parameter_1 = *ptr++;
	dacs->parameter_2 = *ptr++;
	dacs->parameter_3 = *ptr++;
	dacs->parameter_4 = 0xA5;
	dacs->parameter_5 = 0x00;
	
	if ( !WriteSector( (unsigned char *) HXC_CMDSECTOR, track, sector ) )
	{
		return OPERATIONRESULT_ERROR;
	}
	
	return OPERATIONRESULT_SUCCESS;
}

// ----------------------------------------------------------------------------
void MediaInit()
{
	last_setlbabase = 0xFFFFFF00;
}

// ----------------------------------------------------------------------------
int MediaQuit()
{
#ifdef USE_CPCEMU
	if (!MoveToTrack(0))
	{
		return OPERATIONRESULT_ERROR;
	}
#else
	unsigned char *ptr;
	struct DirectAccessCmdSector *dacs;
	unsigned char track = 255;
	unsigned char sector = 0;

	dacs = (struct DirectAccessCmdSector *) HXC_CMDSECTOR;

	strcpy( dacs->DAHEADERSIGNATURE, "HxCFEDA" );
	dacs->cmd_code = 2; // CMD_SET_TRACK_POS

	dacs->parameter_0 = 0x00;
	dacs->parameter_1 = 0x00;
	dacs->parameter_2 = 0x00;
	dacs->parameter_3 = 0x00;
	dacs->parameter_4 = 0x00;
	dacs->parameter_5 = 0x00;
	
	if ( !WriteSector( (unsigned char *) HXC_CMDSECTOR, track, sector ) )
	{
		return OPERATIONRESULT_ERROR;
	}
#endif
	
	RestoreDiskDrive();

	return OPERATIONRESULT_SUCCESS;
}

// ----------------------------------------------------------------------------
int MediaRead(unsigned long lba_sector, unsigned char *buffer)
{
	unsigned long diff;
	
#ifdef USE_CPCEMU
	unsigned char track = 0;
	unsigned char sector = 0xC2;
#else
	unsigned char track = 255;
	unsigned char sector = 1;
#endif

	diff = lba_sector-last_setlbabase;
	
	if ( diff < 8 )
	{
		sector = diff+1;
	}
	else
	{
		if ( !setlbabase( lba_sector ) )
		{
			return OPERATIONRESULT_ERROR;
		}
		
		last_setlbabase = lba_sector;
	}
	
	if ( !ReadSector( buffer, track, sector ) )
	{
		return OPERATIONRESULT_ERROR;
	}
	
	return OPERATIONRESULT_SUCCESS;
}

// ----------------------------------------------------------------------------
int MediaWrite(unsigned long lba_sector, unsigned char *buffer)
{
	unsigned long diff;
	
#ifdef USE_CPCEMU
	unsigned char track = 0;
	unsigned char sector = 0xC2;
#else
	unsigned char track = 255;
	unsigned char sector = 1;
#endif

	diff = lba_sector - last_setlbabase;

	if ( diff < 8 )
	{	
		sector = diff+1;
	}
	else
	{
		setlbabase( lba_sector );
		last_setlbabase = lba_sector;
	}
	
	if ( !WriteSector( buffer, track, sector ) )
	{
		return OPERATIONRESULT_ERROR;
	}

	return OPERATIONRESULT_SUCCESS;
}
