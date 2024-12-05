@dati due interi positivi a ed m in r0, r1, in r0 approssimazione log 

.data
a: .word 2
m: .word 8

.text
main:
ldr r0, =a
ldr r0, [r0]
ldr r1, =m
ldr r1, [r1]
mov, r2, #0 @esponente
mov r3, #1 @risultato
bl log
swi 0x11

log:
mul r3, r0, r3
cmp r1, r3
blt fine_log @concludo se m^(n+1)-a < 0
add r2, r2, #1
b log

fine_log:
mov r0, r2
mov pc, lr
.end