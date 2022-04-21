[bits 32]
; Constant
VIDEO_MEM equ 0xb8000
WHITE_ON_BLACK equ 0xf0

; print null terminated string pointed to by EBX

print_string_32bit_pm:
	pusha
	mov edx, VIDEO_MEM

	loop:
		mov al, [ebx]
		mov ah, WHITE_ON_BLACK

		test al,al
		jz done

		mov [edx], ax

		add ebx, 1
		add edx, 2

		jmp loop

	done:
		popa
		ret


;mov ebx, MSG
;call print_str

;MSG: db "HELLO WORLD!", 0