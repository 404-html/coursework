#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void main() {
    FILE *fptr = fopen("/home/task3/secret.txt", "r");
    char secret[1024];
    fscanf(fptr, "%512s", secret);
    printf("Well done!\nThere you go, a wee reward: %s\n", secret);
    exit(0);
}

