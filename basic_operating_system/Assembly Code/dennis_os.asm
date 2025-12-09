[org 0x7c00]
[bits 16]

mov bp, 0x9000
mov sp, bp
call cls
call banner
call func_list
call func_move
call func_rename
call func_delete
jmp $

; FUNCTION 1: LIST - Display file system
func_list:
    mov si, h1
    call pr
    mov si, items
    call pr
    mov si, ok
    call pr
    ret
h1: db 0xA,0xD,'[1. LIST]',0xA,0xD,0
items: db ' file1.txt',0xA,0xD
       db ' file2.dat',0xA,0xD
       db ' file3.bin',0xA,0xD,0

; FUNCTION 2: MOVE - Move data in memory
func_move:
    mov si, h2
    call pr
    mov ax, [0x9500]
    mov [0x9600], ax
    mov si, moved
    call pr
    mov dx, [0x9600]
    call hex
    mov si, ok
    call pr
    ret
h2: db 0xA,0xD,'[2. MOVE]',0xA,0xD,0
moved: db ' 0x9500->0x9600: 0x',0

; FUNCTION 3: RENAME - Rename identifier
func_rename:
    mov si, h3
    call pr
    mov word [0x9700], 0xDEAD
    mov si, old
    call pr
    mov si, new
    call pr
    mov dx, [0x9700]
    call hex
    mov si, ok
    call pr
    ret
h3: db 0xA,0xD,'[3. RENAME]',0xA,0xD,0
old: db ' old.txt -> new.txt',0xA,0xD,0
new: db ' ID: 0x',0

; FUNCTION 4: DELETE - Clear memory
func_delete:
    mov si, h4
    call pr
    mov word [0x9500], 0x0000
    mov si, deleted
    call pr
    mov dx, [0x9500]
    call hex
    mov si, ok
    call pr
    ret
h4: db 0xA,0xD,'[4. DELETE]',0xA,0xD,0
deleted: db ' file1.txt cleared: 0x',0

; Helper: Clear screen
cls:
    mov ax, 0x0003
    int 0x10
    ret

; Helper: Banner
banner:
    mov si, bn
    call pr
    ret
bn: db '==========================',0xA,0xD
    db '    DENNIS OS v1.0',0xA,0xD
    db '  By: Dennis Sharon',0xA,0xD
    db '==========================',0xA,0xD,0

; Helper: Print string
pr:
    mov ah, 0x0e
.l: lodsb
    test al, al
    jz .d
    int 0x10
    jmp .l
.d: ret

; Helper: Print hex
hex:
    mov cx, 4
.l: rol dx, 4
    mov ax, dx
    and al, 0x0F
    add al, 0x30
    cmp al, 0x39
    jle .p
    add al, 7
.p: mov ah, 0x0e
    int 0x10
    dec cx
    jnz .l
    ret

ok: db ' [OK]',0xA,0xD,0

times 510-($-$$) db 0
dw 0xaa55
