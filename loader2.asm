[bits 16]
[org 0x7c00]

%include "print_str.asm"

mov si, MSG
pusha
call print_str
popa

MSG: db "Hello World!",0

times 510 - ($ - $$) db 0
dw 0xaa55