[org 0x7c00]

	mov bp, 0x9000			; stack
	mov sp, bp

	mov bx, MSG_REAL_MODE
	call print_string_16bit

	call switch_to_pm

	jmp $					; Never come here! Kept for DBG

%include "../print_str.asm"
%include "gdt.asm"
%include "print_str_32bit_pm.asm"
%include "switch_to_32bit_PM.asm"

[bits 32]

begin_pm:
	mov ebx, MSG_PROT_MODE
	call print_string_32bit_pm

	jmp $


; Global Var
MSG_REAL_MODE: db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE: db "Successfully landed in 32 bit PM", 0

; Bootsector Padding
times 510-($-$$) db 0
dw 0xaa55