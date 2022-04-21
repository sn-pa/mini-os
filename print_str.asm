; Make sure SI is pointing to String
; Make sure 

print_string_16bit:
	pusha
	mov si, bx		; BX is passed as an argument
	mov ah, 0x0e 	; TTY mode
	
	str_16bit_loop:
		lodsb		; MOV [DS:SI], AL
		test al, al
		jz exit
		int 0x10	; int 16 - BIOS Print Interuppt
		jmp str_16bit_loop
	exit:
		popa
		ret