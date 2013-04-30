#include <string.h>
#include <stdlib.h>
#include "buffer.h"
#include "config.h"

/*
 * Ver documentacion en el header
 */
int buffer_init(struct buffer_t* buffer) {
  buffer->size = CHAR_BUFFER_DEFAULT_SIZE;
  buffer->current = 0;
  buffer->buffer = malloc(sizeof(char) * buffer->size);
  if (!buffer->buffer) {
    LOG_DATA_DEBUG("Malloc on buffer_init returned zero");
    LOG_ERROR("Not enough memory to initialize line buffer");
    return 0;
  }
  return 1;
}

/*
 * Ver documentacion en el header
 */
int buffer_push(struct buffer_t* buffer, char c) {
  /* Si hay overflow, se suman otros CHAR_BUFFER_DEFAULT_SIZE bytes al tamanio del buffer */
  if (buffer->current >= buffer->size) {
    char* new_buffer;

    LOG_DATA_DEBUG("Overflow while pushing char to buffer. Increase buffer size");
    buffer->size += CHAR_BUFFER_DEFAULT_SIZE;
    LOG_DATA_DEBUG_IVAR(buffer->size);

    new_buffer = realloc(buffer->buffer, sizeof(char) * buffer->size);
    if (!new_buffer) {
      LOG_DATA_DEBUG("Realloc on buffer_push returned zero");
      LOG_ERROR("Not enough memory for line buffer overflow");
      return 0;
    }

    buffer->buffer = new_buffer;
  }

  buffer->buffer[buffer->current] = c;
  buffer->current++;
  return 1;
}

/*
 * Ver documentacion en el header
 */
char* buffer_reset(struct buffer_t* buffer) {
  char* data;

  data = malloc(sizeof(char) * (buffer->current + 1));
  if (!data) {
    LOG_DATA_DEBUG("Malloc on buffer_reset returned zero");
    LOG_ERROR("Not enough memory for line buffer reset");
    return 0;
  }

  memcpy(data, buffer->buffer, sizeof(char) * buffer->current);
  data[buffer->current] = '\0';

  /* Se resetea el buffer para seguir acumulando chars */
  buffer->current = 0;

  return data;
}

/*
 * Ver documentacion en el header
 */
int buffer_pending(struct buffer_t* buffer) {
  return buffer->current;
}

/*
 * Ver documentacion en el header
 */
void buffer_cleanup(struct buffer_t* buffer) {
  free(buffer->buffer);
}

