#include <stdio.h>
#include <string.h>
#include "bubblesort.h"

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
void printStringsArray(char ** words, unsigned int arraysize) {
  printf("Array = [");
  int i = 0;
  for (i = 0; i < arraysize; i++) {
    printf("%s, ", words[i],words[i][0],words[i][0]);
  }
  printf("]\n");
}

//Bubble sort algorithm
//void bubbleSortInt(int numbers[], int arraysize) {
//  int i = 0;
//  int j = 0;
//  int temp = 0;
//  for (i = (arraysize - 1); i > 0; i--) {
//    for (j = 1; j <= i; j++) {
//      if (numbers[j-1] > numbers[j]) {
//        temp = numbers[j-1];
//        numbers[j-1] = numbers[j];
//        numbers[j] = temp;
//      }
//    }
//  }
//}

void swap(char **p, char **q) {
  char *tmp;
  tmp = *p;
  *p = *q;
  *q = tmp;
}

void bubblesort(char** words, unsigned int arraysize) {
 int i = 0;
 int j = 0;
 printStringsArray(words, arraysize);
 for(i = 0; i < arraysize; ++i)
    for(j = i + 1; j < arraysize; ++j)
      if(strcmp(words[i], words[j]) >= 0)
        swap(&words[i], &words[j]);
}

//main for bubblesort
//int main(int argc, char **argv) {
//  char *words[] = {"hola","chau","and","zero","void","HOLA","donde","kilo","kilometro","kil","kill","10","2","1","a","á","Á","áá","ú","u","blabla"};
//  printStringsArray(words,20);
//  bubbleSort(words, 20);
//  printStringsArray(words,20);
//
//  int nro[11] = {123,46,78,0,1,2,3,7,567,89,10};
//  printArrayInt(nro, 11);
//  bubbleSortInt(nro, 11);
//  printArrayInt(nro, 11);
//}
