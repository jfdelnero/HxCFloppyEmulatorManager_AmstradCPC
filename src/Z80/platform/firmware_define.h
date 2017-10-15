
// ----------------------------------------------------------------------------
#ifndef _FIRMWARE_DEFINE_H_
#define _FIRMWARE_DEFINE_H_

// ----------------------------------------------------------------------------
#define AMSDOS_RESERVED_AREA_PTR	0xBE7D
#define DISC_RETRIES				0xBE66
#define DISC_ERROR_MESSAGE_FLAG		0xBE78

#define	KL_INIT_BACK 		0xBCCE
#define KL_U_ROM_ENABLE		0xB900
#define KL_U_ROM_DISABLE	0xB903
#define KL_L_ROM_DISABLE	0xB909
#define	KL_ROM_RESTORE	 	0xB90C
#define	KL_ROM_SELECT 		0xB90F
#define KL_CURR_SELECTION	0xB912

#define KL_FIND_COMMAND		0xBCD4

#define KM_INITIALISE 		0xBB00
#define KM_RESET	 		0xBB03
#define KM_READ_CHAR 		0xBB09
#define KM_CHAR_RETURN		0xBB0C
#define KM_SET_DELAY		0xBB3F
#define KM_GET_DELAY		0xBB42
#define KM_ARM_BREAK		0xBB45
#define KM_DISARM_BREAK		0xBB48

#define TXT_OUTPUT			0xBB5A
#define TXT_SET_PEN			0xBB90
#define TXT_SET_PAPER		0xBB96

#define	KL_U_ROM_DISABLE 	0xB903
#define	KL_ROM_DESELECT 	0xB918

#define SCR_SET_OFFSET		0xBC05
#define SCR_SET_MODE		0xBC0E
#define SCR_GET_MODE		0xBC11
#define SCR_DOT_POSITION	0xBC1D
#define SCR_NEXT_LINE		0xBC26
#define SCR_SET_INK 		0xBC32
#define SCR_GET_INK 		0xBC35
#define SCR_SET_BORDER		0xBC38
#define SCR_GET_BORDER		0xBC3B

#define KL_ROM_WALK			0xBCCB
#define KL_INIT_BACK		0xBCCE
#define KL_NEW_FRAME_FLY	0xBCD7
#define KL_DEL_FRAME_FLY	0xBCDD

#define MC_WAIT_FLYBACK		0xBD19
#define KM_FLUSH			0xBD3D // 664-6128 specific

#define BIOS_SETUP_DISC 	0xC036
#define BIOS_MOVE_TRACK 	0xC045
#define BIOS_READ_SECTOR 	0xC03C
#define BIOS_WRITE_SECTOR 	0xC03F

// ----------------------------------------------------------------------------
#endif // _FIRMWARE_DEFINE_H_