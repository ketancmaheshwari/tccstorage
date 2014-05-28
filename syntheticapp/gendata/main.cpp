#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include "globals.h"
#include <time.h>
#define SIZE 256

// Allocates a matrix with random float entries.
void randomInit(float* data, int size)
{
    for (int i = 0; i < size; ++i)
        data[i] = rand() / (float)RAND_MAX;
}

void systamp()
{
    char buffer[SIZE];
    char hostname[1024];
    char *tzone, *format;
    time_t timestamp;
    timestamp = time(NULL);
    // Format string
    format = "%a %e %b %Y %r %Z %n";
    tzone="TZ=UTC";
    putenv(tzone);
    strftime(buffer, SIZE, format, localtime(&timestamp));
    fputs(buffer, stdout);
    gethostname(hostname, 1024);
    puts(hostname);
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

