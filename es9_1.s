.data
n: .word 6 @lunghezza del vettore
vettore: .skip 24 @vettore di 6 elementi 24:4 = 6 locazioni

.text
ldr r0, =vettore @carico l'indirizzo di vettore in r0
ldr r1, =n @carico il valore di n in r1
ldr r1, [r1] @carico il valore di n in r1
@mov r2, #0 contatore di valore i / useless
mov r3, r0 @indirizzo a[i]

ciclo:
cmp r2, r1 @r2-r1
beq fine @se è uguale salto alla fine
ldr r4, [r3] @in r4 valore a[i]
mov r4, r2 @ pongo a[i] = i
str r4, [r3] @salvo il nuovo valore di a[i] nel vettore
add r3, r3, #4 @punto a a[i+1]
add r2, r2, #1 @incremento i
blt ciclo @ritorno al ciclo


fine: swi 0x11 @termino il programma
.end