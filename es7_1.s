.data
    n1: .word -3
    n2: .word -4
    n3: .word -6
    n4: .word 2
.text
inizializzo:
    ldr r5, =n1
    ldr r5, [r5] @carico in r5 il valore di n1
    ldr r6, =n2
    ldr r6, [r6] @carico in r6 il valore di n2
    ldr r7, =n3
    ldr r7, [r7] @carico in r7 il valore di n3
    ldr r8, =n4
    ldr r8, [r8] @carico in r8 il valore di n4
somma:
    mov r0, r5 @carico in r0 il valore di n1
    add r0, r6
    add r0, r7
    add r0, r8 @sommo i valori di n1, n2, n3 e n4
media:
    mov r1, r0, asr #2 @divido per 4
risultato:
    mov r2, r5
    add r2, r5, lsl 10 @moltiplico n1 per 1024
    @add r2, r2, r5, lsl 10 moltiplico n2 per 1024, in un unico comando
