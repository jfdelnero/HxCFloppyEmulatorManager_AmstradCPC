
; ----------------------------------------------------------------------------
; also defined in ui_define.h
TINY_FONT_BUFFER		equ &0300 ;; Start=&0300 Length=&0300
REGULAR_FONT_BUFFER		equ TINY_FONT_BUFFER + &0300 ;; Start=&0600 Length=&0600

;; also used by HXC_UI_BROWSE_DIRSTATUS
BACKGROUNDTEMP_BUFFER	equ REGULAR_FONT_BUFFER + &0600 ;; Start=&0C00 Length=&0A00   
;; &1600

;
CoreStartAddress		equ &2900 ;; HXC_UI_DIRENTRIES=0x2500 + 0x400 bytes (length) = &2900
