CC=gcc

caps-lock-off: caps-lock-off.c
     $(CC) -lX11 -o caps-lock-off caps-lock-off.c
