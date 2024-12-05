.data
n: .word 3
vettore: .skip 16
.text
main: @routine
    ldr r0, =vettore
    ldr r1, =n 
    ldr r1, [r1]
    bl ciclo_nat @salta all'etichetta e salva in link register l'indirizzo di rientro
    swi 0x11 @termino il programma

ciclo_nat: @subroutine
    str r1, [r0, r1, lsl #2] @salvo il valore di n in a[n]
    subs r1, r1, #1 @decremento n, modifica bit cprs in base al risultato, come compare ma tengo risultato
    bge ciclo_nat @se n>=0 ritorno al ciclo (branch if greater or equal)
    mov pc, lr @ritorno al chiamante
.end
