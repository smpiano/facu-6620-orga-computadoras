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

//Shell sort algorithm
void shellSort(int numbers[], int array_size) {
  int i = 0; 
  int j = 0;
  int m = 0;
  int mid = 0;

  for (m = array_size/2; m > 0; m/=2) {
    for (j = m; j< array_size; j++) {
      for (i = j - m; i >= 0; i -= m) {
        if (numbers[i + m] >= numbers[i])
          break;
        else {
          mid = numbers[i];
          numbers[i] = numbers[i + m];
          numbers[i+m] = mid;
        }
      }
    }
  }
}

//main for shellsort
int main(int argc, char **argv) {
  int nro[11] = {123,46,78,0,1,2,3,7,567,89,10};
  printArray(nro, 11);
  shellSort(nro, 11);
  printArray(nro, 11);
}
