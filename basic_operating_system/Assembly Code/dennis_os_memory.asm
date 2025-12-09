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
    mov word [0x9500], 0xABCD
    mov si, a1
    call pr
    mov dx, 0xABCD
    call hx
    mov si, o
    call pr
    ret
m1: db 0xA,0xD,'[1.ALLOC]',0xA,0xD,0
a1: db ' 0x9500=0x',0

f2:
    mov si, m2
    call pr
    mov dx, [0x9500]
    mov si, a2
    call pr
    call hx
    mov si, o
    call pr
    ret
m2: db 0xA,0xD,'[2.READ]',0xA,0xD,0
a2: db ' 0x9500=0x',0

f3:
    mov si, m3
    call pr
    mov ax, [0x9500]
    mov [0x9600], ax
    mov dx, ax
    mov si, a3
    call pr
    call hx
    mov si, o
    call pr
    ret
m3: db 0xA,0xD,'[3.COPY]',0xA,0xD,0
a3: db ' 9500->9600=0x',0

f4:
    mov si, m4
    call pr
    mov word [0x9500], 0
    mov si, a4
    call pr
    mov dx, [0x9500]
    call hx
    mov si, o
    call pr
    ret
m4: db 0xA,0xD,'[4.CLEAR]',0xA,0xD,0
a4: db ' 0x9500=0x',0

c:
    mov ax, 0x0003
    int 0x10
    ret

b:
    mov si, bn
    call pr
    ret
bn: db '=== MEMORY MANAGER ===',0xA,0xD,'By: Dennis Sharon',0xA,0xD,0

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
