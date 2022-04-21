[bits 32]				; Already in 32bit PM
[extern _kmain]			; Func name to call from kernel.c

	call _kmain			; invoke main() from kernel.c
	jmp $				; Hang, when return