#include <stdio.h>
#include <stdlib.h>
#include <memory.h>
#include "globals.h"
#include "../sysdetails/sysdetails.h"

extern void computeGold(float* C, const float* A, const float* B, unsigned int hA, unsigned int wA, unsigned int wB);

int main(int argc, char** argv)
{
    if(argc != 7){
        printf("Usage: matmul <heightA> <widthA> <widthB> <file_MA> <file_MB> <output_file>\n");
        return -1;
    }
    unsigned int HA, WA, WB;
    HA = atoi(argv[1]);
    WA = atoi(argv[2]);
    WB = atoi(argv[3]);
    float* h_A = loadMatrix(argv[4], HA, WA);
    float* h_B = loadMatrix(argv[5], WA, WB);
    float* h_C = (float*) malloc(sizeof(float)*HA*WB);
    
    computeGold(h_C, h_A, h_B, HA, WA, WB);

    saveMatrix(argv[6], h_C, HA, WB);

    free(h_A);
    free(h_B);
    free(h_C);
    systamp();
    return 0;
}

