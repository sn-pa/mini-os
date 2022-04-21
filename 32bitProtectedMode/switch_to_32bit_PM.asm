[bits 16]

switch_to_pm:				; Switch to 32 bit Protected Mode (PM)
	cli						; clear Interrupts

	lgdt [gdt_descriptor]	; Load GDT Descriptor table

	mov eax, cr0			; Switch to PM by setting 1 in cr0
	or eax, 0x01
	mov cr0, eax

	jmp CODE_SEG:init_pm	; Far jmp



[bits 32]
; Initialize registers and stack
init_pm:
	mov ax, DATA_SEG		;
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000		; stack
	mov esp, ebp

	call begin_pm

