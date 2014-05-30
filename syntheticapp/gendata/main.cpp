#include <stdlib.h>
#include <stdio.h>
#include "globals.h"
#include "../sysdetails/sysdetails.h"

// Allocates a matrix with random float entries.
void randomInit(float* data, int size)
{
    for (int i = 0; i < size; ++i)
        data[i] = rand() / (float)RAND_MAX;
}


int main(int argc, char** argv)
{
    if(argc != 4) {
        printf("Usage: matmul <height> <width> <output_file>\n");
        return -1;
    }
    unsigned int H, W;
    H = atoi(argv[1]);
    W = atoi(argv[2]);
    float *m = (float*) malloc (sizeof(float)*H*W);
    randomInit(m, H*W);

    saveMatrix(argv[3], m, H, W);

    free(m);

    systamp();

    return 0;
}

