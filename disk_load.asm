; load DH sectors to ES:BX from drive DL
disk_load:
	mov bx, 0x1000
	push dx

	mov ah, 0x02		; BIOS read sector function
	mov al, dh			; Read DH sectors
	mov ch, 0x00		; Select cylinder 0
	mov dh, 0x00		; Select head 0
	mov cl, 0x02 		; Start reading from 2nd sector (i.e. after boot sector)

	int 0x13			; BIOS interrupt

	jc disk_error		; if carry flag set - jmp label

	pop dx				; Restore dx
	cmp dh, al			; if AL (sectors read) != DH (sectors expected)
	jne disk_error

	ret

disk_error:
	mov bx, MSG_DISK_ERROR
	call print_string_16bit
	jmp $				; hang


; Variables
MSG_DISK_ERROR db "Disk read error!", 0
