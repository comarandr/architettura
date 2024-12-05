.data
    n: .word 4
    v: .word 9, 8, 6, 7
.text
main:
    mov r5, #0
    ldr r0, =v
    ldr r1, =n
    ldr r1, [r1]
    bl c_zero
    swi 0x11
c_zero:
    sub r1, r1, #1 @per non finire fuori dall'array
    ldr r2, [r0, r1, lsl #2]
    tst r2, #0x01 @bitwise AND tra r2 e 1
    streq r5, [r0, r1, lsl #2] @se bit Z è uguale a 1, ovvero risultanto AND bitwise è 0
    cmp r1, #0
    bgt c_zero
    mov pc,lr
.end