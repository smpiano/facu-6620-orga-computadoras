#include <stdio.h>
#include <string.h>
#include "shellsort.h"
#include "data.h"

/**
 * Ver documentacion en el header
 */
void shellsort(char** words, unsigned int arraysize) {
  int i = 0;
  int j = 0;
  int m = 0;

  for (m = arraysize/2; m > 0; m/=2) {
    for (j = m; j< arraysize; j++) {
      for (i = j - m; i >= 0; i -= m) {
        if(strcasecmp(words[i + m], words[i]) >= 0)
          break;
        else {
          data_swaper(&words[i + m], &words[i]);
        }
      }
    }
  }
}
