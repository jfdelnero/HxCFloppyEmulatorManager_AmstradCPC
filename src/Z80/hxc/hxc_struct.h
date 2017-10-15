
// ----------------------------------------------------------------------------
#ifndef _HXC_STRUCT_H_
#define _HXC_STRUCT_H_

// ----------------------------------------------------------------------------
struct DirectAccessStatusSector
{
	char DAHEADERSIGNATURE[8]; // contain -> HxCFEDA\0
	char FIRMWAREVERSION[12]; // firmware version (null terminated)
	unsigned long lba_base; // Actual SDCard LBA base address
	unsigned char cmd_cnt; // Command counter – incremented at each command passed
	unsigned char read_cnt; // Read counter – incremented at each revolution.
	unsigned char write_cnt; // Write counter – incremented at each sector write.
	unsigned char last_cmd_status; // Status of the last command passed : 0=no error.
	unsigned char write_locked; // NEW! Write to the sdcard locked.
	unsigned char keys_status; // NEW! Push buttons states. 
	unsigned char sd_status; // NEW! SDCard status ->0x00 init ok ! / 0xFF non present/error
	unsigned char SD_WP; // NEW! SDCard write protect state
	unsigned char SD_CD; // NEW! SDCard card detect state 
};

// ----------------------------------------------------------------------------
struct DirectAccessCmdSector
{
	char DAHEADERSIGNATURE[8]; // Must be set to “HxCFEDA\0”
	unsigned char cmd_code; // Command code
	unsigned char parameter_0;  // Parameter 0
	unsigned char parameter_1;  // Parameter 1
	unsigned char parameter_2; // Parameter 2
	unsigned char parameter_3;  // Parameter 3
	unsigned char parameter_4; // Parameter 4
	unsigned char parameter_5; // Parameter 5
	unsigned char parameter_6; // Parameter 6
	unsigned char parameter_7; // Parameter 7
};

// ----------------------------------------------------------------------------
struct ConfigFile
{
	char signature[16]; //"HXCFECFGV1.0"
	unsigned char step_sound; //0x00 -> off 0xFF->on
	unsigned char ihm_sound; //0x00 -> off 0xFF->on
	unsigned char back_light_tmr;  //0x00 always off, 0xFF always on, other -> on x second
	unsigned char standby_tmr; //0xFF disable, other -> on x second
	unsigned char disable_drive_select;//0xFF disable the drive selection menu.
	unsigned char buzzer_duty_cycle; // Set to 0x60
	unsigned char number_of_slot;  // If != 0 -> Slot mode – total number of slot
	unsigned char slot_index; // Last slot index selected
	unsigned short update_cnt;  // Incremented at each write of the config file
	unsigned char load_last_floppy;  // 0xFF -> Do not load the last loaded image at power up.
	unsigned char buzzer_step_duration; // Set to 0xD8
	unsigned char lcd_scroll_speed;  // Default value : 0x96
};

// ----------------------------------------------------------------------------
struct DirectoryEntry
{
	unsigned char name[12]; // Short name
	unsigned char attributes; // File attribute
	unsigned long firstCluster; // File cluster
	unsigned long size; // File size
	unsigned char longName[17]; // Long name (truncated)
};

// ----------------------------------------------------------------------------
struct DiskInDrive
{
	struct DirectoryEntry DirEnt;
	unsigned char numberoftrack;
	unsigned char numberofside;
	unsigned short rpm;
	unsigned short bitrate;
	unsigned short tracklistoffset;
};

// ----------------------------------------------------------------------------
#endif // _HXC_STRUCT_H_