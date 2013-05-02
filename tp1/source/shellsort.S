#include <mips/regdef.h>

#define fp $30
#define jp $25

  .text
  .align 2
  .globl  shellsort_s

shellsort_s: .ent shellsort_s
  .frame sp,56,ra

  # setup del global pointer
  .set noreorder
  .cpload jp
  .set reorder

  # inicio ---
	subu sp,sp,56 # creamos el stack
  .cprestore 40
	sw ra,48(sp)
  sw fp,44(sp)
  #sw gp,40(sp) # reemplazada por el cprestore
  move fp,sp

  sw a0,56(sp) # guardamos los argunmentos para preservarlos
  sw a1,60(sp)

  sw zero,24(sp)
  sw zero,28(sp)
  sw zero,32(sp)

  # vamos a usar estos temporales como los indices de los 3 for
  # t0 = m
  # t1 = j
  # t2 = i

  #lw t0,32(sp) # guardo el valor de m en t0 // t0 = m
  srl t0,a1,1  # m = arraysize/2
  sw t0,32(sp) # guardo m

loop_m:
  lw t0,32(sp) # t0 = m
  blez t0, SALIR # si (t0 <= 0) { SALIR }
  sw t0,28(sp) # j = t0

loop_j:

  lw t1,28(sp) # t1 = j
  lw a1,60(sp)
  subu t2, a1, t1 # t2 = arraysize - j
  blez t2, SALIR_M # si (t2 <= 0) { SALIR_M }

  lw t0,32(sp)
  subu t2,t1,t0 # i = j - m
  sw t2,24(sp) # guardo el valor de i en memoria

loop_i:

  lw t2,24(sp) # t2 = i
  bltz t2, SALIR_J # i < 0 # si (t2 <= 0) { SALIR_J }

  # hghgjhgjhgjh

  lw t0,32(sp) # t0 = m
  subu t2, t2, t0 # i = i - m
  sw t2,24(sp)
  b loop_i

SALIR_J:
  lw t1,28(sp) # t1 = j
  addu t1, t1, 1 # j = j + 1
  sw t1,28(sp)
  b loop_j

SALIR_M:
  lw t0,32(sp) # t0 = m
  srl t0, t0, 1 # t0 = t0 / 2
  b loop_m


SALIR:
  lw ra,48(sp)
  lw fp,44(sp)
  lw gp,40(sp)

  addu sp,sp,56
  jr ra


  .end shellsort_s
  .size shellsort_s, .-shellsort_s
