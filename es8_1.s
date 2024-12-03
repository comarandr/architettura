@definire un vettore di 4 valori uguali a 0 e nella sezione. text un programma che sostituisce il vettore con 
.data
vettore: .word 0,0,0,0
.text
    main:
        ldr r0, = vettore 
        mov r1, #1
        str r1, [r0]
        mov r1, #2
        str r1, [r0, #4]
        mov r1, #3
        str r1, [r0, #8]
        mov r1, #4
        str r1, [r0, #12]
        swi 0x11