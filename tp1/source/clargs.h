#ifndef __CL_ARGS_H_INCLUDED__
#define __CL_ARGS_H_INCLUDED__

/*
 * Estructura que contiene todos los flags de la linea de comandos.
 */
struct cl_args_t {
  /*
   * 1 si se requiere help, 0 en caso contrario.
   */
  int help;

  /*
   * 1 si se requiere informacion de version, 0 en caso contrario.
   */
  int version;

  /*
   * 1 si se quiere utilizar el ordenamiento por burbuja, 0 en caso contrario.
   */
  int bubblesort;

  /*
   * 1 si se quiere utilizar el ordenamiento shellsort, 0 en caso contrario.
   */
  int shellsort;

  /*
   * 1 si se quiere utilizar el ordenamiento shellsort en mips, 0 en caso contrario.
   * 0 es el default.
   */
  int mips;

  /*
   * Nombre del archivo a ordenar, si se ingreso alguno. 0 en caso contrario.
   */
  char** files;

  /*
   * Cantidad de archivos ingresados
   */
  int file_count;
};

/*
 * Funcion que extrae los parametros de la linea de comandos dada por los
 * argumentos argc y argv de una funcion main, cargando los resultados en la
 * estructura de argumentos args.
 */
int cl_args_parse(struct cl_args_t* args, int argc, char** argv);

/*
 * Funcion que valida la interaccion entre los argumentos de la linea de
 * comandos, imprimiendo un mensaje de error segun corresponda.
 */
int cl_args_validate(struct cl_args_t* args);

#endif
