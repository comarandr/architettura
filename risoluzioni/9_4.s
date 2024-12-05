.data 
    n: .word 13
    v: .word 2, 3, 4, 5, 12, 16, 17, 5, 3, 2, 1, 5, 6
    p: .word 3
.text
    main:
    ldr r0, =n 
    ldr r0, [r0]
    ldr r1, =v 
    ldr r2, =p 
    ldr r2, [r2] 
    bl c_zero_p
    swi 0x11
c_zero_p:
    mov r5, #0
    mov r3, r0, lsl #2
    add r4, r1, r3
    add r1, r1, r2, lsl #2
azzera_cp:
    add r1, r1, r2, lsl #2
    cmp r4, r1
    blt uscita_czp
    str r5, [r1]
    b azzera_czp
uscita_czp:
    mov pc, lr
.end
