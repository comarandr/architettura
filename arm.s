CARATTERISTICHE GENERALI
assembly non distingue maiuscolo/minuscolo
memoria principale - 4GB ~ 2^32 byte (32 bit)
registri - 16 registri r0,...,r12 general purpose
                        r13 : sp (stack pointer)
                        r14 : lr (link register)
                        r15 : pc (program counter)
Ogni registro è di 32 bit

LISTA COMANDI
numeri possono espressi in #cifra oppure con #0x notazione esadecimale 0 1 2 3 4 5 6 7 8 9 A=10 B=11 C=12 D=13 E=14 F=15 (es 15 = #0xF)
decimali: #0, #1, ... , #9
binari: #0b1101
ottali: #0h777
esadecimali: #0xFDE7e
gli interi sono espressi in complemento a 2 (cambio di segno negando i bit e sommando 1)
+9 = 0 0 0 0 1 0 0 1
-9 = 1 1 1 1 0 1 1 1    
Rappresentati in 12 bit 

somma:  add r0, r1, r2 ; scrive su r0 la somma r1+r2
        add r0, r1, #8 ; soltanto il terzp argomento può essere una costante

sottrazione: 
        sub r0, r1, r4 ; pone in r0 la sottrazione r1-r4   
        rsb r0, r1, r4 ; pone in r0 la sottrazione r4-r1
        NOTA, costante accettata solo come terzo argomento 
        sub r0, r1, #7 ; r1-#7
        rsb r0, r1, #7 ; #-r1

moltiplicazione 
        mul r0, r2, r3 ; scrive in r0 la moltiplicazione r2 * r3
        NON ammette argomento costante

operazioni con il carry
somma   adc r0, r1, r4 ; scrive in r0 r1 + r4 + c se presente riporto nel cprs
sottrazione sbc r0, r1, r4 ; scrive in r0 = r1 - r4 (- 1) se carry = 0 se presente riporto nel cprs
            rsc r0, r1, r4 ; scrive in r0 = r4 - r1 ( - 1 se carry = 0)

        perché - 1 se carry = 0?

moltiplicazione estesa
unsigned    umull r0, r1, r2, r4 ; calcola r2*r4 a 64 bit senza segno , scrive cifre più significative in r1 e quelle meno in r0 r2*r4 = r1r0
signed      smull r0, r1, r2, r4 ; calcola r2*r4 a 64 bit in complemento a 2, scrive cifre più significative in r1 e quelle meno in r0 r2*r4 = r1r0

operatori logici

        and r0, r2, r3 ; in r0 = r2 AND r3 
        orr r0, r2, r3 ; in r0 = r2 OR r3 
        eor r0, r2, #5 ; in r0 = r2 XOR 5 Exclusive OR 
        bic r0, r2, r3 ; in r0 = r2 and NOT(r3) and not

copiare registri (move)
        mov r0, r2     ; r2 copiato in r0, r2 -> r0 ; r0 = r2
        mvn r0, r2     ; r0 = NOT(r2), cioè move negate

rappresentazioni costanti
        #5 : decimali
        #0b1010: binario
        #0h777: ottali
        #0xFDE: esadecimali

traslazioni ( parte dell'argomento)
sx      lsl traslazione a sinistra che elimina i bit più significativi
                               
dx      lsr traslazione a destra che elimina i bit meno sigificativi
        asr mantiene il segno del numero, equivale a una divisione per 2^n, elimina i bit meno significativi
        ror #n n bit usciti a destra rientrano a sinistra
        rrx rotazione a destra includendo il bit di carry

accesso alla memoria
lettura         ldr 
                ldr r3, [r0] copia in r3 una word (32b~4B) a partire dall'INDIRIZZO in r0 
                ldr r3, [r0, #8] ... dall'indirizzo contenuto in r0 + 8B (cioè offset)
                ldr r3, [r0, r1, lsl #3 ] ... r3 destinazione, in r0 indirizzo, in r1 indicato offset che andrà traslato di 3b

scrittura       str 

aggiornamento   ldr r3, [r0, #8] nessun aggiornamento
                ldr r3, [r0, #8]! pre-aggiornamento (prima aggiorno, poi dato)
                ldr r3, [r0], #8 post aggiornamento

NB: solo su parole allineate, indirizzo del primo byte multiplo di 4
ARM: little-endian (ma bi-endian)

[...]

STRUTTURA DEL PROGRAMMA

file.s
etichette - identificano indirizzo
direttive - indicazioni su come comportarsi
                .text testo successivo sono le ostruzioni
                .data testo che segue costanti
                .end fine modulo
        
        possono specificare anche tipo di dato (etichettabili)
                .word ogni dato allineato su 4 locazioni
                .byte ogni dato occupa una locazione (1 B)
                .ascii ogni char in ASCII in una locazione
                .asciz ogni char ASCII + locazione 0
                .skip allocazione n locazioni inizializzate 0




PSEUDO-ISTRUZIONI : carica nel registro indirizzo memoria etichettato
COMMENTO INLINE: preceduto da char @

CONTROLLO DI FLUSSO (COSTRUTTI)

non si usano costrutti, bensì salto (anche condizionato)
salto relativo : b #costante
NOTA: argomento b spesso etichetta (specie se condizionato)

CONDIZIONI

suffisso di 1 o 2 lettere: specifica condizione per eseguire istruzione

condizione dipende da cprs

s: suffisso condizionante, operazione modifica registro stato

CONDIZIONI CPRS:
Z : zero
C: presenza carry
N: negativo
V: overflow 

CONDIZIONI:
eq : equal, Z==0
ne : not equal
ISTRUZIONI DI CONFRONTO (modificano CPRS)

comparazione: cmp r0, r1 ; compara r0 con r1, aggiorna come subs r r0 r1; cioè r0-r1 = 0

comparazione negativo: cmn r0, r1 ; confronto r0 con -r1, aggiorna come adds r r0, r1 ; r0+r1 = 0

test: tst r0, r1 ; aggiorna i flag come ands r r0 r1

test equal: teq r0, r2 ; aggiorna come eors r r0 r1 (or esclusivo)


TRADUZIONE DEI COSTRUTTI 

COSTRUTTO IF-ELSE

if(boolean){
        then com1
} else {
        com2
}
fi

assembly:
        Eval boolean (valuta boolean)
        b_cond then
        com2
        b fine
then : com1
fine: (proseguo programma immagino)

COSTRUTTO IF-THEN

if(boolean){
        then com1
}
fi

assembly:
        Eval NOT boolean 
        b_cond fine
        com1
fine: (proseguo programma immagino)

COSTRUTTO WHILE

while (boolean){
        do com1
}

assembly:

while:  Eval not boolean
        b_cond fine
        com1
        b while

fine:   instr...

esempio:
while (i != 0){
        i = i -1;
        j = j + 1;
}
i in r1, j in r2;

versione con salti
while: cmp r1, #0 ; compara r1 con #0
        beq fine  ; salta se condizione equal verificata, vai a fine
        sub r1, r1, #1 ;salva in r1 il valore in r1 - 1
        addne r2, r2, #1 ; condizione non eq (nel ciclo) salva in r2 il valore in r2 + 1
        bne while ; se condizione nequal verificata, rimani in while (etichetta)

fine:   instr... 

versione senza salti (elegante)
while:  cmp r1, #0 ; compara r1 con #0
        subne r1, r1, #1 ; se cond nequal verificata fai sub
        addne r2, r2, #1 ; se con nequal verificata fai add
        bne while ; se cond nequal verificata fai while (etichetta)
        instru


