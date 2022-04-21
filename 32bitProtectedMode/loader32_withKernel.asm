[org 0x7c00]
[bits 16]
KERNEL_OFFSET equ 0x1000

	call clear_register_16bits

	mov [BOOT_DRIVE], dl	; BIOS stores our boot drive in DL

	mov bp, 0x9000			; stack
	mov sp, bp

	mov bx, MSG_REAL_MODE
	call print_string_16bit

	call load_kernel		; Load kernel

	call switch_to_pm

	jmp $					; Never come here! Kept for DBG

%include "../clear_register_16bits.asm"
%include "../print_str.asm"
%include "../disk_load.asm"
%include "gdt.asm"
%include "print_str_32bit_pm.asm"
%include "switch_to_32bit_PM.asm"

[bits 16]
;load kernel

load_kernel:
	mov bx, MSG_LOAD_KERNEL		; print
	call print_string_16bit

	; Parameters for disk_load func: bx, dh, dl
	mov bx, KERNEL_OFFSET		; To this address
	mov dh, 15					; load first 15 sectors
	mov dl, [BOOT_DRIVE]		; boot disk
	call disk_load

	ret



[bits 32]

begin_pm:
	mov ebx, MSG_PROT_MODE
	call print_string_32bit_pm

	call KERNEL_OFFSET

	jmp $


; Global Var
BOOT_DRIVE 		db 0
MSG_REAL_MODE: 	db "Started in 16-bit Real Mode",13,10,0
MSG_PROT_MODE: 	db "Successfully landed in 32 bit PM",13,10,0
MSG_LOAD_KERNEL: db "Loading kernel into memroy...",13,10,0

; Bootsector Padding
times 510-($-$$) db 0
dw 0xaa55