
; ----------------------------------------------------------------------------
include "fat_io_lib\fat_access.asm"
include "fat_io_lib\fat_cache.asm"
include "fat_io_lib\fat_filelib.asm"
include "fat_io_lib\fat_misc.asm"
include "fat_io_lib\fat_string.asm"
include "fat_io_lib\fat_table.asm"
include "fat_io_lib\fat_write.asm"

; ----------------------------------------------------------------------------
__sdcc_call_hl:
	jp (hl)
	
__mullong_rrx_s:
	jp __mullong
        
__divulong_rrx_s:
	jp __divulong
        