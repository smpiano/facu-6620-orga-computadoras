#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include "bubblesort.h"
#include "data.h"

/**
 * Ver documentacion en el header
 */
void bubblesort(char** words, unsigned int arraysize) {
  int i = 0;
  int j = 0;
  for(i = 0; i < arraysize; ++i)
    for(j = i + 1; j < arraysize; ++j)
      if(strcasecmp(words[i], words[j]) >= 0)
        data_swaper(&words[i], &words[j]);
}
