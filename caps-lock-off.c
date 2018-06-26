#include <stdio.h>
#include <X11/X.h>
#include <X11/XKBlib.h>
int main()
{
    Display *display = XOpenDisplay(NULL);
    if (display == NULL) {
        fprintf(stderr, "Couldn't open display\n");
        return 2;
    }
    Bool sent = XkbLockModifiers(display, XkbUseCoreKbd, LockMask, 0);
    if (!sent) {
        fprintf(stderr, "Couldn't send LatchLockState\n");
        return 1;
    }
    int err = XCloseDisplay(display);
    if (err) {
        fprintf(stderr, "XCloseDisplay returned %d\n", err);
        return 1;
    }
    return 0;
}
