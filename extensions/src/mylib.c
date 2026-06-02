#include <stdio.h>
#include <stdlib.h>
#include <string.h>

__attribute__((visibility("default")))
int add(int a, int b) {
    return a + b;
}

__attribute__((visibility("default")))
int multiply(int a, int b) {
    return a * b;
}

__attribute__((visibility("default")))
char* greet(const char* name) {
    if (name == NULL) return NULL;
    
    size_t len = strlen(name) + 20;
    char* result = (char*)malloc(len);
    if (result) {
        snprintf(result, len, "Hello, %s from C!", name);
    }
    return result;
}

__attribute__((visibility("default")))
void free_string(char* s) {
    free(s);
}

__attribute__((visibility("default")))
void mylib_init(void) {
    printf("mylib initialized!\n");
}
