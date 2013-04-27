#include <stdio.h>
#include <string.h>

// Print array
void printArray(int numbers[], int array_size) {
  printf("Array = [");
  int i = 0;
  for (i = 0; i < array_size; i++) {
    printf("%d, ",numbers[i]);
  }
  printf("]\n");
}

//Bubble sort algorithm
void bubbleSort(int numbers[], int array_size) {
  int i = 0;
  int j = 0;
  int temp = 0;
 
  for (i = (array_size - 1); i > 0; i--) {
    for (j = 1; j <= i; j++) {
      if (numbers[j-1] > numbers[j]) {
        temp = numbers[j-1];
        numbers[j-1] = numbers[j];
        numbers[j] = temp;
      }
    }
  }
}

//main for bubblesort
int main(int argc, char **argv) {
  int nro[11] = {123,46,78,0,1,2,3,7,567,89,10};
  printArray(nro, 11);
  bubbleSort(nro, 11);
  printArray(nro, 11);
}
