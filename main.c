#include <stdio.h>
#include "utf8.h"

int main() {
  char result[256] = "ÄãºÃya";
  char utf8[256];
  gb_to_utf8(result, utf8, 256);
  printf("%s\n", utf8);

  return 0;
}
