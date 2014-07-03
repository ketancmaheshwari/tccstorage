#include <unistd.h>
#include <time.h>
#include <stdio.h>
#include <stdlib.h>
#define SIZE 256


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

