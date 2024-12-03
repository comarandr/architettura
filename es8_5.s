@algoritmo di ricerca lineare
.data
v: .word 8, 15, -23, 45, 39 @vettore
n: .word 5 @dimensione del vettore
x: .word 3 @target

.text @inizializzazione
inizializzazione:
    ldr r0, =v @ndirizzo del primo elemento di v
    mov r1, #0 @i = 0
    ldr r2, =n @indirizzo di n
    ldr r2, [r2] @r2 = n
    ldr r3, =x @indirizzo di x
    ldr r3, [r3] @r3 = x
loop:
    cmp r1, r2  @r2 - r1, cioè n - i
    bge not_found @se r1 >= r2, salta a not_found, ovvero se i >= n
    
