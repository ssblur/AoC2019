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
    long lastFuel = 0;
    long moduleFuel = 0;

    FILE * file = fopen("input.txt", "r");
    if(file == NULL){
        printf("Cannot open file input.txt");
        return 1;
    }

    while(fgets(line, sizeof(line), file)) {
        moduleFuel = fuel(atoi(line));
        lastFuel = moduleFuel;
        while((lastFuel = fuel(lastFuel))>0){
            moduleFuel += lastFuel;
        }
        fuelTotal += moduleFuel;
    }

    fclose(file);
    free(line);

    printf("Total Fuel: %d", fuelTotal);

    return 0;
}