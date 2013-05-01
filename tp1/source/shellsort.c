#include <stdio.h>
#include <string.h>
#include "shellsort.h"

// Print array
//void printArrayInt(int numbers[], int arraysize) {
//  printf("Array = [");
//  int i = 0;
//  for (i = 0; i < arraysize; i++) {
//    printf("%d, ",numbers[i]);
//  }
//  printf("]\n");
//}

// Print Strings array
//void printStringsArray(char ** words, int arraysize) {
//  printf("Array = [");
//  int i = 0;
//  for (i = 0; i < arraysize; i++) {
//    printf("%s, ", words[i]);
//  }
//  printf("]\n");
//}

//Shell sort algorithm
//void shellSortInt(int numbers[], int arraysize) {
//  int i = 0;
//  int j = 0;
//  int m = 0;
//  int mid = 0;
//
//  for (m = arraysize/2; m > 0; m/=2) {
//    for (j = m; j< arraysize; j++) {
//      for (i = j - m; i >= 0; i -= m) {
//        if (numbers[i + m] >= numbers[i])
//          break;
//        else {
//          mid = numbers[i];
//          numbers[i] = numbers[i + m];
//          numbers[i+m] = mid;
//        }
//      }
//    }
//  }
//}

void swap1(char **p, char **q) {
  char *tmp;
  tmp = *p;
  *p = *q;
  *q = tmp;
}

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
          swap1(&words[i + m], &words[i]);
        }
      }
    }
  }
}

//main for shellsort
//int main(int argc, char **argv) {
//  char *words[] = {"hola","chau","and","zero","void","HOLA","donde","kilo","kilometro","kil","kill","10","2","1","a","á","Á","áá","ú","u","blabla"};
//  printStringsArray(words,20);
//  shellsort(words, 20);
//  printStringsArray(words,20);
//
//
//  int nro[11] = {123,46,78,0,1,2,3,7,567,89,10};
//  printArrayInt(nro, 11);
//  shellSortInt(nro, 11);
//  printArrayInt(nro, 11);
//
//}
