.data
n = .word 4
v = .skip 64

.text
ldr r0, =v
ldr r1, =n
ldr r1, [r1] @r1=n



.end