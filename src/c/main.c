#include <stdint.h>

extern int print(const char *str);
extern int read_line(const char *buffer);

char charbuf[1];

int main() {
  char *buffer;

  read_line(buffer);

  uint32_t written = print(buffer);

  return written;
}
