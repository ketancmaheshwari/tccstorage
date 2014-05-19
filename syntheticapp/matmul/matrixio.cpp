
#include "globals.h"
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>

float* loadMatrix(const char* filename, size_t height, size_t width)
{
    int fd = safeOpen(filename, O_RDONLY);
    size_t count = width * height;
    float* buf = (float*) malloc(sizeof(float)*count);
    ssize_t num = safeRead(fd, buf, count, "load matrix");
    close(fd);
    return buf;
}

float* saveMatrix(const char* filename, float* buf, size_t height, size_t width)
{
    int fd = safeOpen(filename, O_WRONLY|O_CREAT, 0777);
    size_t count = width * height * sizeof(float);
    ssize_t num = safeWrite(fd, buf, count, "save matrix");
    close(fd);
    return buf;
}

