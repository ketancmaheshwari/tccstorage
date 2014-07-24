#ifndef __GLOBALS__
#define __GLOBALS__
#include <stdlib.h>
#include <stdio.h>

//#define DEBUG
//#define PROF

int safeOpen(const char *pathname,int flags, mode_t mode);
int safeOpen(const char *pathname,int flags);
ssize_t safeRead(int fd, void *buf, size_t count, const char* marker);
ssize_t safeWrite(int fd, const void *buf, size_t count, const char* marker);
void iotime();

float* loadMatrix(const char* filename, size_t height, size_t width);
float* saveMatrix(const char* filename, float* buf, size_t height, size_t width);

#endif
