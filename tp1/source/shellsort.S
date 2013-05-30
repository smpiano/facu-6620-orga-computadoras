#include <mips/regdef.h>

#define fp $30
#define jp $25

  .text
  .align 2

/************************************************************************
Definicion de la funcion compare_s. Esta funcion es una implementacion propia
de la funcion de la libreria estandar strcmp, determinando el orden
lexicografico entre dos cadenas. Devuelve un numero negativo si la primer
cadena es anterior a la segunda, 0 si son equivalentes y un numero positivo si
la segunda cadena es anterior a la primera.

El prototipo en C es como sigue:

int compare_s(char* start, char* end);
************************************************************************/
compare_s: .ent compare_s

  # Frame size
  #   + 8 bytes SRA: gp, fp
  .frame sp,8,ra

  # Set up del global pointer
  .set noreorder
  .cpload jp
  .set reorder

  # Expandimos el stack
  subu sp, sp, 8

  # Grabamos los registros a preservar
  .cprestore 4
  sw fp, 0(sp)

COMP_LOOP:
  # Se cargan los bytes apuntados por los argumentos
  lb t0, (a0)
  lb t1, (a1)
  # Si el primer caracter es menor que el segundo, la primer cadena es anterior
  # a la segunda
  subu v0, t0, t1
  bltz v0, COMP_RETURN
  # Si ambos son iguales, significa que tienen la misma longitud y ninguno de
  # los caracteres recorridos hasta el momento fueron distintos.
  beqz v0, COMP_EQUALS
  # Si llegamos aqui es porque el primer caracter es superior al segundo y la
  # primer cadena es posterior a la segunda. Continuamos en la siguiente
  # seccion
  b COMP_RETURN

COMP_EQUALS:
  # Si llegamos aqui es porque los caracteres son iguales. Si ambos son cero,
  # todos los caracteres procesados fueron iguales y llegamos simultaneamente
  # al final de ambas cadenas, por lo que las cadenas son iguales.
  beq t0, zero, COMP_RETURN
  # Si llegamos aqui es porque todavia hay mas caracteres que comparar, por lo
  # que avanzamos los punteros a los caracteres subsiguientes y continuamos
  addu a0, a0, 1
  addu a1, a1, 1
  b COMP_LOOP

COMP_RETURN:
  # Teardown del stack
  lw fp, 0(sp)

  addu sp, sp, 8

  jr ra
.end compare_s
.size compare_s, .-compare_s

/************************************************************************
Definicion de la funcion swap_s. Esta funcion intercambia dos punteros ubicados
en dos indices dados de un array de strings determinado.

El prototipo en C es como sigue:

void swap_c(char **data, unsigned int a, unsigned int b);
************************************************************************/
swap_s: .ent swap_s

  # Frame size
  #   + 8 bytes SRA: gp, fp
  .frame sp,8,ra

  # Set up del global pointer
  .set noreorder
  .cpload jp
  .set reorder

  # Expandimos el stack
  subu sp, sp, 8

  # Grabamos los registros a preservar
  .cprestore 4
  sw fp, 0(sp)

  # Se computa la direccion en memoria donde se encuentra el primer elemento a
  # intercambiar: a1 = a0 + (a1 * 4)
  sll t0, a1, 2
  addu a1, a0, t0

  # Se computa la direccion en memoria donde se encuentra el segundo elemento a
  # intercambiar: a2 = a0 + (a2 * 4)
  sll t0, a2, 2
  addu a2, a0, t0

  # Se cargan en memoria los valores a intercambiar
  lw t0, (a1)
  lw t1, (a2)

  # Se guardan nuevamente en orden inverso
  sw t0, (a2)
  sw t1, (a1)

  # Teardown del stack
  lw fp, 0(sp)

  addu sp, sp, 8

  jr ra
.end swap_s
.size swap_s, .-swap_s


  .globl  shellsort_s

shellsort_s: .ent shellsort_s
  
  .frame sp,64,ra

  # setup del global pointer
  .set noreorder
  .cpload jp
  .set reorder

  # inicio ---
  subu sp,sp,64 # creamos el stack
  .cprestore 52
  sw ra,60(sp)
  sw fp,56(sp)
  #sw gp,60(sp) # reemplazada por el cprestore
  move fp,sp

  sw a0,64(sp) # guardamos los argunmentos para preservarlos
  sw a1,68(sp)

  # usamos estos registros, por eso los guardamos y al final los restauramos
  sw s0,32(sp)
  sw s1,36(sp)
  sw s2,40(sp)
  sw s3,44(sp)
  sw s4,48(sp)

  sw zero,16(sp)
  sw zero,20(sp)
  sw zero,24(sp)

  # vamos a usar estos registros como los indices de los 3 for
  # s0 = m
  # s1 = j
  # s2 = i

  srl s0,a1,1  # m = arraysize/2
  sw s0,24(sp) # guardo m

loop_m:
  lw s0,24(sp) # s0 = m
  blez s0, SALIR # si (s0 <= 0) { SALIR }
  sw s0,20(sp) # j = s0

loop_j:

  lw s1,20(sp) # s1 = j
  lw a1,68(sp)
  subu s2, a1, s1 # s2 = arraysize - j
  blez s2, SALIR_M # si (s2 <= 0) { SALIR_M }

  lw s0,24(sp)
  subu s2,s1,s0 # i = j - m
  sw s2,16(sp) # guardo el valor de i en memoria

loop_i:

  lw s2,16(sp) # s2 = i
  bltz s2, SALIR_J # i < 0 # si (s2 <= 0) { SALIR_J }

  # inicio verificacion del IF del loop_i
  lw a0,64(sp)
  lw s0,24(sp)
  addu s3,s2,s0 # s3 = i + m
  sll s4,s3,2 # s4 = s3 x 4
  addu s4, a0, s4 # words[s4]

  sll s3, s2, 2 # s3 = s2 x 4
  addu s3, a0, s3 # words[s3]
  lw a1, (s3)
  lw a0, (s4) # a0 = words[s4]

  sw s4,(sp)
  sw s3,4(sp)
  la jp, compare_s
  jal ra, jp

  bgez v0, SALIR_J # si (compare_s(a0,a1) >= 0) break;

  lw a0, (sp)
  lw a1, 4(sp)
  la jp, swap_s
  jal ra, jp

  lw s0,24(sp) # s0 = m
  subu s2, s2, s0 # i = i - m
  sw s2,16(sp)
  b loop_i

SALIR_J:
  lw s1,20(sp) # s1 = j
  addu s1, s1, 1 # j = j + 1
  sw s1,20(sp)
  b loop_j

SALIR_M:
  lw s0,24(sp) # s0 = m
  srl s0, s0, 1 # s0 = s0 / 2
  sw s0,24(sp)
  b loop_m

SALIR:
  lw ra,60(sp)
  lw fp,56(sp)
  lw gp,52(sp)

  #restauracion de registros saved
  lw s0,32(sp)
  lw s1,36(sp)
  lw s2,40(sp)
  lw s3,44(sp)
  lw s4,48(sp)

  addu sp,sp,64 # destruccion del stack
  jr ra

  .end shellsort_s
  .size shellsort_s, .-shellsort_s

