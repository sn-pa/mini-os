clear_register_16bits:
	xor ax, ax
	mov ds, ax
	mov es, ax
	mov ss, ax
	ret