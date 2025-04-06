#include <unistd.h>
#include <stdint.h>

char charbuf[1];
char *string = "teste789\n";

int print(const char *string)
{
  size_t count = 0;

  while (1) {
    char character = *string;

    if (character == '\0') {
      break;
    }

    size_t written = write(1, string, 1);

    count += written;

    string++;
  }

  size_t value = count;

  return value;
}

int main()
{
  size_t written = print(string);
  written += 48;

  charbuf[0] = written;

  print(charbuf);

  return 0;
}

