#include <stdint.h>

extern int print(const char *str);

char charbuf[1];

int main() {
    uint32_t written = print("teste789\n");

    written += 48;

    charbuf[0] = written;

    print(charbuf);

    return 0;
}
