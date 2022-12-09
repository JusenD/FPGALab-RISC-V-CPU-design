#include "sys.h"
#include "string.h"

#define KEY 0x00300000;

char hello[]="Hello World!\n";
char error[]="Instrction Error!\n";
char unknown[]="Unknown Command\n";
int main();

//setup the entry point
void entry()
{
    asm("lui sp, 0x00120"); //set stack to high address of the dmem
    asm("addi sp, sp, -4");
    main();
}

void Hello(char* args[]) {
    if (args[1] != 0) putstr(error);
    else if (args[0]) {
        if (strcmp(args[0], "PINK") == 0) {
            change_color(RED | BLUE);
        }
        else if (strcmp(args[0], "BLUE") == 0) {
            change_color(BLUE);
        }
        else if (strcmp(args[0], "RED") == 0) {
            change_color(RED);
        }
        else if (strcmp(args[0], "GREEN") == 0) {
            change_color(GREEN);
        }
        else if (strcmp(args[0], "YELLOW") == 0) {
            change_color(RED | GREEN);
        }
        else if (strcmp(args[0], "SKY") == 0) {
            change_color(BLUE | GREEN);
        }
        else {
            putstr(error);
            return;
        }
    }
    putstr(hello);
    change_color(WHITE);
}

int fib_cal(int n) {
    if (n == 0 || n == 1) return 1;
    else return fib_cal(n - 1) + fib_cal(n - 2);
}

void fib(char* args[]) {
    // check only one argument is given
    if (args[0] == 0 || args[1] != 0) putstr(error);
    else {
        int num = atoi(args[0]);
        int ans = fib_cal(num);
        putint(ans);
    }
}

void time(char* args[]) {
    if (args[0] != 0) putstr(error);
    int* TIME = (int*)(0x00400000);
    int time = *TIME;
    putint(time);
}

void display(char* args[]) {
    if(args[0] == 0 || args[1] == 0 || args[2] != 0){
        putstr(error);
        return;
    }
    int choice = atoi(args[0]);
    int num = atoi(args[1]);
    int* LED = (int*)LED_ALL;
    if(choice == CHOOSE_HIGH) LED = (int*)LED_HIGH;
    else if(choice == CHOOSE_LOW) LED = (int*)LED_LOW;
    *LED = num;
}

void execute(char* command) {
    // split args
    char* args[10] = { 0 };
    char* single_arg;
    char* function = command;
    int i = 0, j = 0;
    while (command[i] != '\0') {
        if (command[i] == ' ') {
            single_arg = &command[i + 1];
            command[i] = '\0';
            args[j] = single_arg;
            j++;
            i = 0;
            command = single_arg;
            continue;
        }
        i++;
    }
    if (strcmp(function, "hello") == 0) {
        Hello(args);
    }
    else if (strcmp(function, "fib") == 0) {
        fib(args);
    }
    else if (strcmp(function, "time") == 0) {
        time(args);
    }
    else if(strcmp(function, "display") == 0){
        display(args);
    }
    else {
        putch('\n');
        putstr(unknown);
    }
}

int main()
{
    vga_init();
    char* key = (char*)KEY;
    char command[100];
    int i = 0;
    putstr_const(">>");
    set_command();
    while (1)
    {
        char key_now = *key;
        if(key_now != 0){
            putch(key_now);
            // end of command
            if(key_now == '\n' || key_now == 13){
                command[i] = '\0';
                i = 0;
                execute(command);
                putstr_const("\n>>");
                set_command();
            }
            else if(key_now == 8 && i > 0){
                command[i] = 0;
                i--;
            }
            else {
                command[i] = key_now;
                i++;
            }
        }
    };
    return 0;
}