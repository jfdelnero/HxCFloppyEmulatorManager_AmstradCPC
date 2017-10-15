
; ----------------------------------------------------------------------------
	include "config.asm"
	
; ----------------------------------------------------------------------------
	org CoreStartAddress
	
; ----------------------------------------------------------------------------
EntryPoint:
	jp _main
	
; ----------------------------------------------------------------------------
	include "platform\bios.asm"
	include "platform\firmware.asm"
	
	include "fat_io_lib\fat_io_lib.asm"
	include "hxc\hxc_error.asm"
	include "hxc\hxc_io.asm"
	include "hxc\hxc_config.asm"
	include "hxc\hxc_attach.asm"
	include "hxc\hxc_init.asm"
	
	include "ui\ui_font.asm"
	include "ui\ui_element.asm"
	include "ui\ui_slot.asm"
	include "ui\ui_help.asm"
	include "ui\ui_init.asm"
	include "ui\ui_pathSlotBar.asm"
	include "ui\ui_global.asm"
	include "ui\ui_browse.asm"	
	include "ui\ui_navigate.asm"
	include "ui\ui_select.asm"
	include "ui\ui_main.asm"
	include "ui\ui_quit.asm"
	include "ui\ui_buzzer.asm"
	include "ui\ui_dirFlush.asm"
	
	include "crt\_memcpy.asm"
	include "crt\_memset.asm"
	include "crt\_mullong.asm"
	include "crt\_divulong.asm"
	include "crt\_strcmp.asm"
	include "crt\_uitoa.asm"
	include "crt\_strlen.asm"
	include "crt\_strcpy.asm"
	