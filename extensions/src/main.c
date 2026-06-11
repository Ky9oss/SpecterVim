// #include "mylib.h"
#include <dirent.h>
#include <limits.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <unistd.h>

#if !defined PATH_MAX
#define PATH_MAX 1024 * 16
#endif


/* SOLUTION 1 */
void simple_puts_cwd() {
  size_t size = PATH_MAX;
  char buf[size];

  char *cwd = getcwd(buf, size);
  puts(cwd);
}

int main() {
  simple_puts_cwd();
}
