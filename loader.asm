bits 16
org 0x7c00

	mov si, msg
	mov ah, 0x0e	; 0x0e : Write character in TTY mode
.loop:
	lodsb		; load string [DS:SI] into AL
	test al, al
	jz halt

	int 0x10
	jmp .loop
halt:
	cli		; clear interrupt flag
	hlt

msg: db "Hello World!", 0

times 510 - ($-$$) db 0
dw 0xaa55
