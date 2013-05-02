#include <mips/regdef.h>

#define fp $30
#define jp $25

  .text
  .align 2
  .globl  shellsort_s

shellsort_s: .ent shellsort_s
  
  .frame sp,72,ra

  # setup del global pointer
  .set noreorder
  .cpload jp
  .set reorder

  # inicio ---
  subu sp,sp,72 # creamos el stack
  .cprestore 60
  sw ra,68(sp)
  sw fp,64(sp)
  #sw gp,60(sp) # reemplazada por el cprestore
  move fp,sp

  sw a0,72(sp) # guardamos los argunmentos para preservarlos
  sw a1,76(sp)

  # usamos estos registros, por eso los guardamos y al final los restauramos
  sw s0,40(sp)
  sw s1,44(sp)
  sw s2,48(sp)
  sw s3,52(sp)
  sw s4,56(sp)

  sw zero,24(sp)
  sw zero,28(sp)
  sw zero,32(sp)

  # vamos a usar estos registros como los indices de los 3 for
  # s0 = m
  # s1 = j
  # s2 = i

  srl s0,a1,1  # m = arraysize/2
  sw s0,32(sp) # guardo m

loop_m:
  lw s0,32(sp) # s0 = m
  blez s0, SALIR # si (s0 <= 0) { SALIR }
  sw s0,28(sp) # j = s0

loop_j:

  lw s1,28(sp) # s1 = j
  lw a1,76(sp)
  subu s2, a1, s1 # s2 = arraysize - j
  blez s2, SALIR_M # si (s2 <= 0) { SALIR_M }

  lw s0,32(sp)
  subu s2,s1,s0 # i = j - m
  sw s2,24(sp) # guardo el valor de i en memoria

loop_i:

  lw s2,24(sp) # s2 = i
  bltz s2, SALIR_J # i < 0 # si (s2 <= 0) { SALIR_J }

  # inicio verificacion del IF del loop_i
  lw a0,72(sp)
  lw s0,32(sp)
  addu s3,s2,s0 # s3 = i + m
  sll s4,s3,2 # s4 = s3 x 4
  addu s4, a0, s4 # words[s4]

  sll s3, s2, 2 # s3 = s2 x 4
  addu s3, a0, s3 # words[s3]
  lw a1, (s3)
  lw a0, (s4) # a0 = words[s4]

  sw s4,(sp)
  sw s3,4(sp)
  la jp, strcasecmp
  jal ra, jp

  bgez v0, SALIR_J # si (strcasecmp(a0,a1) >= 0) break;

  lw a0, (sp)
  lw a1, 4(sp)
  la jp, data_swaper
  jal ra, jp

  lw s0,32(sp) # s0 = m
  subu s2, s2, s0 # i = i - m
  sw s2,24(sp)
  b loop_i

SALIR_J:
  lw s1,28(sp) # s1 = j
  addu s1, s1, 1 # j = j + 1
  sw s1,28(sp)
  b loop_j

SALIR_M:
  lw s0,32(sp) # s0 = m
  srl s0, s0, 1 # s0 = s0 / 2
  sw s0,32(sp)
  b loop_m

SALIR:
  lw ra,68(sp)
  lw fp,64(sp)
  lw gp,60(sp)

  #restauracion de registros saved
  lw s0,40(sp)
  lw s1,44(sp)
  lw s2,48(sp)
  lw s3,52(sp)
  lw s4,56(sp)

  addu sp,sp,72 # destruccion del stack
  jr ra

  .end shellsort_s
  .size shellsort_s, .-shellsort_s

