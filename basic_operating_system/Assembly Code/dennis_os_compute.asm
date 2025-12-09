[org 0x7c00]
[bits 16]

mov bp, 0x9000
mov sp, bp
call c
call b
call f1
call f2
call f3
call f4
jmp $

f1:
    mov si, m1
    call pr
    mov ax, 0x1234
    mov bx, 0x5678
    mov dx, ax
    call hx
    mov si, pl
    call pr
    mov dx, bx
    call hx
    mov si, eq
    call pr
    add ax, bx
    mov dx, ax
    call hx
    mov si, o
    call pr
    ret
m1: db 0xA,0xD,'[1.ADD] 0x',0
pl: db '+0x',0
eq: db '=0x',0

f2:
    mov si, m2
    call pr
    mov ax, 0xFFFF
    mov bx, 0x1111
    mov dx, ax
    call hx
    mov si, mn
    call pr
    mov dx, bx
    call hx
    mov si, eq
    call pr
    sub ax, bx
    mov dx, ax
    call hx
    mov si, o
    call pr
    ret
m2: db 0xA,0xD,'[2.SUB] 0x',0
mn: db '-0x',0

f3:
    mov si, m3
    call pr
    mov ax, 0xABCD
    mov bx, 0xABCD
    cmp ax, bx
    je .e
    mov si, ne
    jmp .d
.e: mov si, ye
.d: call pr
    mov si, o
    call pr
    ret
m3: db 0xA,0xD,'[3.CMP] ',0
ye: db 'EQUAL',0
ne: db 'NOT EQ',0

f4:
    mov si, m4
    call pr
    mov ax, 0x0010
    mov dx, ax
    call hx
    mov si, mu
    call pr
    shl ax, 1
    mov dx, ax
    call hx
    mov si, o
    call pr
    ret
m4: db 0xA,0xD,'[4.MUL] 0x',0
mu: db '*2=0x',0

c:
    mov ax, 0x0003
    int 0x10
    ret

b:
    mov si, bn
    call pr
    ret
bn: db '=== COMPUTE ENGINE ===',0xA,0xD,'By: Dennis Sharon',0xA,0xD,0

pr:
    mov ah, 0x0e
.l: lodsb
    test al, al
    jz .d
    int 0x10
    jmp .l
.d: ret

hx:
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

o: db ' OK',0xA,0xD,0

times 510-($-$$) db 0
dw 0xaa55
