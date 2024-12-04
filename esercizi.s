esercizi basilari:

negativo numero in un registro:
rsb r1, r2, #0 : 0 -r2 = -r2

moltiplicare numero registro per 4:

add r1, r2, r2 
add r1, r1, r1  ((r2+r2) + (r2+r2))

calcola le seguenti espressioni
@r1 = 8 * r2
mov r1, r2, lsl #3

@r1 = r2/4
mov r1, r2, lsr #2

@r1 = 5*r2
add r1, r2, r2, lsl #2

@r1= 3/4 *r2 = (3*r2)/4
add r1, r2, r2, lsl #1
mov r1, r1, lsr #2 @NON VA BENE
@la seconda istruzione sovrascrive il valore di r5

sub r1 r2, r2, asr #2 @ovvero r2-r2/4

@scrivere somma dei primi tre elementi di un arrray
.data 
vettore: .word 3, 4, 2, 3

.text
ldr r0, = vettore
ldr r1, [r0]
ldr r2, [r0, #4]
add r1, r1, r2
ldr r2, [r0, #8]
add r1, r1, r2

@scrivere in r1 il valore di a[i] + a[i+1] + a[i+2] di a
@indirizzo base contenuto in r0, indice i in r2
.data
v: .word 2, 3, 4, 5, 5, 1, 3, 2, 3, 4, 5, 6, 6
i: .word 4

.text
ldr r0, =v
ldr r2, =i @indirizzo della variabile i
ldr r2, [r2] @carico variabile i
@ldr r1, [r0, r2, lsl #2] valore di a[i]
add r3, r0, r2, lsl#2 @indirizzo a[i]
ldr r1, [r3]
ldr r4, [r3,#4] @a[i]+1
add r1, r1, r4
ldr r4, [r3,#8]
add r1, r1, r4

@COSTRUTTO IF

@if (i==j) the i = i+1 else i=j fi
@ r1=i, r2=j

.text @alternativa elegante senza salti
cmp r1, r2
addeq r1, r1,#1
movne r1, r2

.text @alternativa con salti
cmp r1,r2
beq then
mov r1,r2
b fine
then: add r1,r1, #1
fine:

@COSTRUTTO WHILE DI DUE ISTRUZIONI

@while (i != 0) do i=i-1, j=j+1 od
@r1=i, r2=j

