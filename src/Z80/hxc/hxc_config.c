
// ----------------------------------------------------------------------------
#include <string.h>

// ----------------------------------------------------------------------------
#include "config.h"
#include "platform\bios.h"
#include "crt\crt.h"
#include "fat_io_lib\fat_filelib.h"
#include "hxc\hxc_struct.h"
#include "hxc\hxc_define.h"
#include "hxc\hxc_io.h"
#include "ui\ui_element.h"
#include "ui\ui_global.h"

// ----------------------------------------------------------------------------
#ifdef USE_CPCEMU
void CreateFakeConfig()
{
	struct ConfigFile *configFile;
	
	configFile = (struct ConfigFile *) HXC_CONFIG;
	strcpy(configFile->signature, "HXCFECFGV1.0");
	configFile->step_sound = 0xFF;
	configFile->ihm_sound = 0xFF;
	configFile->back_light_tmr = 2;
	configFile->standby_tmr = 0xFF;
	configFile->disable_drive_select = 0xFF;
	configFile->buzzer_duty_cycle = 0x60;
	configFile->number_of_slot = SLOTCOUNT;
	configFile->slot_index = 1;
	configFile->update_cnt = 0;
	configFile->load_last_floppy = 0xFF;
	configFile->buzzer_step_duration = 0xD8;
	configFile->lcd_scroll_speed = 0x96;
}
struct DiskInDrive diskInDrive;
void CreateFakeSlots()
{
	struct ConfigFile *configFile;
	struct DiskInDrive *slots;
	char i;
	
	configFile = (struct ConfigFile *) HXC_CONFIG;
	slots = (struct DiskInDrive*) HXC_SLOTS;
	
	//strcpy(slots[0].DirEnt.longName, "Autoboot.hfe");
	strcpy(slots[1].DirEnt.longName, "Relentless (UK)");
	strcpy(slots[2].DirEnt.longName, "BatmanForEver.hf");
	strcpy(slots[3].DirEnt.longName, "Pheelone.hfe");
	strcpy(slots[4].DirEnt.longName, "R-TYPE_128K.HFE");
	strcpy(slots[5].DirEnt.longName, "Phat 2.hfe");
	strcpy(slots[6].DirEnt.longName, "Phat.hfe");
	strcpy(slots[7].DirEnt.longName, "Wakeup.hfe");
	strcpy(slots[8].DirEnt.longName, "Phortem.hfe");
	strcpy(slots[9].DirEnt.longName, "Kris - EMC2.hfe");
	strcpy(slots[10].DirEnt.longName, "ZapTBalls.hfe");
	strcpy(slots[11].DirEnt.longName, "TitusClassic1.hf");
	strcpy(slots[12].DirEnt.longName, "TitusClassic2.hf");
	strcpy(slots[13].DirEnt.longName, "FaceHuggerUltima");
	strcpy(slots[14].DirEnt.longName, "FruityFrank.hfe");
	strcpy(slots[15].DirEnt.longName, "BombJack.hfe");
	
	for ( i = 1; i<15; i++ )
	{
		slots[i].DirEnt.size = strlen(slots[i].DirEnt.longName);
	}
}
#endif

// ----------------------------------------------------------------------------
char ReadConfigFile()
{	
	FL_FILE *file;
	unsigned short iSlot;
	struct DiskInDrive *slots;
	unsigned char *sectorData;
	struct ConfigFile *configFile;
	
	MediaInit();
	
	file = fl_fopen( "/HXCSDFE.CFG", "r" );
	if ( !file )
	{
		return OPERATIONRESULT_ERROR;
	}
	
	fl_fread( HXC_CONFIG, 1, 512, file );
	
	configFile = (struct ConfigFile *) HXC_CONFIG;	
	slots = (struct DiskInDrive*) HXC_SLOTS;
	
	z80_memset( slots, 0, sizeof(struct DiskInDrive) * SLOTCOUNT );
	
	fl_fseek( file, 1024, SEEK_SET );
	fl_fread( HXC_SECTORDATA, 1, 512 , file );
	
	sectorData = (unsigned char *) HXC_SECTORDATA;
	
	iSlot = 1;
	do
	{
		if( !( iSlot & 3 ) )
		{
			fl_fread( HXC_SECTORDATA, 1, 512 , file );
		}

		memcpy( &slots[ iSlot ], &sectorData[ ( iSlot & 3 ) * 128 ], sizeof(struct DiskInDrive) );		
		iSlot++;
	} while ( iSlot < configFile->number_of_slot );
	
	fl_fclose( file );
	
	return OPERATIONRESULT_SUCCESS;
}

// ----------------------------------------------------------------------------
char WriteConfigFile()
{	
	FL_FILE *file;
	unsigned short iSlot;
	unsigned char i;
	unsigned char sect_nb;
	struct DiskInDrive *slots;
	struct DiskInDrive *slot;
	unsigned char *sectorData;
	struct ConfigFile *configFile;
	unsigned char *sdfecfg_file;
	unsigned short floppySelectorIndex;
	unsigned char slot_index;
	unsigned short real_slot_index;
	
	file = fl_fopen( "/HXCSDFE.CFG", "r" );
	if ( !file )
	{
		return OPERATIONRESULT_ERROR;
	}
	
	configFile = (struct ConfigFile *) HXC_CONFIG;
	
	real_slot_index = configFile->slot_index;
	
	slot_index = GetLastSetSlot();
	
	iSlot = 1;
	i = 1;
	
	sdfecfg_file = HXC_SECTORDATA;

	floppySelectorIndex = 128; // first slot offset
	z80_memset( sdfecfg_file, 0, 512 ); // clear sector
	sect_nb = 2; // slots sector offset

	do
	{
		slots = (struct DiskInDrive*) HXC_SLOTS;
		slot = &slots[i];
		
		if (slot->DirEnt.size) // valid slot found
		{
			// Copy it to the actual file sector
			z80_memcpy( &sdfecfg_file[floppySelectorIndex], slot, sizeof(struct DiskInDrive));
		
			if ( i == slot_index )
			{
				real_slot_index = (unsigned short) iSlot;
			}
	
			iSlot++;
			floppySelectorIndex = (floppySelectorIndex+128)&0x1FF;
	
			if ( !(iSlot&0x3) ) // need to change to next sector
			{
				if (fl_fswrite((unsigned char*)sdfecfg_file, 1, sect_nb, file ) != 1)
				{
					return OPERATIONRESULT_ERROR;
				}
				
				sect_nb++;
				
				z80_memset( sdfecfg_file, 0, 512 ); // clear next sector
			}
		}

		i++;
	} while( i < SLOTCOUNT );

	if ( iSlot&0x3 )
	{
		if (fl_fswrite( (unsigned char*)sdfecfg_file, 1, sect_nb, file) != 1)
		{
			return OPERATIONRESULT_ERROR;
		}
    }

	fl_fseek( file, 0, SEEK_SET );

	configFile->number_of_slot = iSlot;
	configFile->slot_index = real_slot_index;

	if (fl_fswrite( (unsigned char*)configFile, 1, 0, file ) != 1)
	{
		return OPERATIONRESULT_ERROR;
	}
	
	fl_fclose(file);

	return OPERATIONRESULT_SUCCESS;
}

// ----------------------------------------------------------------------------
char HxC_ReadConfigFile(char *errorCode)
{
#ifdef USE_CPCEMU
	CreateFakeConfig();
	CreateFakeSlots();
#else
	if ( !ReadConfigFile() )
	{
		*errorCode = HXCERROR_READCONFIGFILEERROR;
		return OPERATIONRESULT_ERROR;
	}
#endif

	*errorCode = HXCERROR_OK;
	return OPERATIONRESULT_SUCCESS;
}

// ----------------------------------------------------------------------------
char HxC_WriteConfigFile(char *errorCode)
{
#ifdef USE_CPCEMU
#else
	if ( !WriteConfigFile() )
	{
		*errorCode = HXCERROR_READCONFIGFILEERROR;
		return OPERATIONRESULT_ERROR;
	}
#endif

	*errorCode = HXCERROR_OK;
	return OPERATIONRESULT_SUCCESS;
}
