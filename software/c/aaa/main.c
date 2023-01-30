#include "sys.h"

extern void welcome();
int main();

//setup the entry point
void entry()
{
    asm("lui sp, 0x00120"); //set stack to high address of the dmem
    asm("addi sp, sp, -4");
    main();
}
int main()
{
    welcome();
    while (1)
    {
    };
    return 0;
}