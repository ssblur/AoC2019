#define BUFFER_SIZE 255

#include <stdio.h>
#include <stdlib.h>
 
int fuel(int f) {
    return (f/3)-2;
}

int main() {
    char line[BUFFER_SIZE];
    size_t file_size = 0;
    ssize_t bytes;
    long fuelTotal = 0;

    FILE * file = fopen("input.txt", "r");
    if(file == NULL){
        printf("Cannot open file input.txt");
        return 1;
    }

    while(fgets(line, sizeof(line), file)) {
        fuelTotal += fuel(atoi(line));
    }

    fclose(file);
    free(line);

    printf("Total Fuel: %d", fuelTotal)

    return 0;
}