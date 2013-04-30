#include "cltext.h"
#include <stdio.h>

/*
 * Ver documentacion en el header
 */
void cl_text_help() {
  puts("tp1 [OPTIONS] [FILE]");
  puts("-h, --help        display this help and exit");
  puts("-v, --version     display version information and exit");
  puts("-b, --bubble      use the implementation of the bubble sorting algorithm");
  puts("-s, --sel         use the implementation of the shell sorting algorithm");
}

/*
 * Ver documentacion en el header
 */
void cl_text_version() {
  puts("tp1 1.0.0");
}
