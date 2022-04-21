; GDT

gdt_start:

gdt_null:			; Mandatory Null Descriptor
	dd 0x0			; dd: Double Word (32 bits - 4 byte)
	dd 0x0

gdt_code:			; Code Segment
	dw 0xffff		; Segment Limit (0 - 15)
	dw 0x0			; Base (0 - 15)
	db 0x0			; Base (16-23)
	db 10011010b	; 1st flags, type flags
	db 11001111b	; 2nd flags, Limit (bits 16-19)
	db 0x0			; Base (bits 24-31)

gdt_data:			; Data Segment
	dw 0xffff		; Limit (0-15)
	dw 0x0			; Base (0-15)
	db 0x0			; Base (16-23)
	db 10010010b	; 1st flags, type flags
	db 11001111b	; 2nd flags, Limit (16-19)
	db 0x0			; Base (24-31)

gdt_end:


gdt_descriptor:
	dw gdt_end-gdt_start-1 	; Start of GDT
	dd gdt_start


; Constants
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start