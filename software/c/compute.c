#include "sys.h"
#include "string.h"

extern char error[];
typedef struct
{
    char symbols[30];
    int size;
} symbol_stack;

typedef struct
{
    int numbers[30];
    int size;
} number_stack;

// 1+2*3-2*(3-1)
// 1 2 3 * + 2 3 1 - * -
void compute(char* args[])
{
    if (args[0] == 0 || args[1] != 0)
    {
        putstr(error);
        return;
    }
    char* expr = args[0];
    int n = strlen(expr);
    // stack initalize
    symbol_stack s_s;
    s_s.size = -1;
    number_stack n_s;
    n_s.size = -1;
    int former_number = 0;
    for (int i = 0; i < n; i++)
    {
        char now = expr[i];
        if (now >= '0' && now <= '9')
        {
            if (former_number)
            {
                n_s.numbers[n_s.size] = n_s.numbers[n_s.size] * 10 + now - '0';
            }
            else
            {
                n_s.numbers[++n_s.size] = now - '0';
                former_number = 1;
            }
            continue;
        }
        else if (now == '*' || now == '/' || now == '(')
        {
            s_s.symbols[++s_s.size] = now;
        }
        else if (now == '-' && (i == 0 || expr[i-1] == '('))
        {
            s_s.symbols[++s_s.size] = now;
            n_s.numbers[++n_s.size] = 0;
        }
        else if (now == '+' || now == '-')
        {
            while (s_s.size >= 0 && (s_s.symbols[s_s.size] == '*' || s_s.symbols[s_s.size] == '/'))
            {
                char symbol = s_s.symbols[s_s.size];
                int src1 = n_s.numbers[n_s.size--], src2 = n_s.numbers[n_s.size];
                if (symbol == '*') src1 = src1 * src2;
                else src1 = src2 / src1;
                n_s.numbers[n_s.size] = src1;
                s_s.size--;
            }
            s_s.symbols[++s_s.size] = now;
        }
        else if (now == ')')
        {
            while (s_s.size >= 0 && s_s.symbols[s_s.size] != '(')
            {
                char symbol = s_s.symbols[s_s.size];
                int src1 = n_s.numbers[n_s.size--], src2 = n_s.numbers[n_s.size];
                if (symbol == '*') src1 = src2 * src1;
                else if (symbol == '/') src1 = src2 / src1;
                else if (symbol == '+') src1 = src2 + src1;
                else if (symbol == '-') src1 = src2 - src1;
                n_s.numbers[n_s.size] = src1;
                s_s.size--;
            }
            if (s_s.size == -1)
            {
                putstr(error);
                return;
            }
            else s_s.size--;
        }
        else
        {
            putstr(error);
            return;
        }
        former_number = 0;
    }
    while (s_s.size >= 0 && n_s.size >= 1)
    {
        char symbol = s_s.symbols[s_s.size];
        int src1 = n_s.numbers[n_s.size--], src2 = n_s.numbers[n_s.size];
        if (symbol == '*') src1 = src2 * src1;
        else if (symbol == '/') src1 = src2 / src1;
        else if (symbol == '+') src1 = src2 + src1;
        else if (symbol == '-') src1 = src2 - src1;
        n_s.numbers[n_s.size] = src1;
        s_s.size--;
    }
    if (s_s.size != -1 || n_s.size != 0)
    {
        putstr(error);
        return;
    }
    putint(n_s.numbers[0]);
}

void trick()
{
    putstr("Just enter a charactor\n");
    char key = getchar();
	putstr("  ");
	for(int i = 0; i < 3; i++) putch(key);
	putstr("    ");
	for(int i = 0; i < 3; i++) putch(key);
	putch('\n'); putch(' ');
	for(int i = 0; i < 5; i++) putch(key);
	putch(' '); putch(' ');
	for(int i = 0; i < 5; i++) putch(key);
	putch('\n');
	for(int i = 0; i < 14; i++) putch(key);
	putch('\n');
	for(int i = 0; i < 14; i++) putch(key);
	putch('\n'); putch(' ');
	for(int i = 0; i < 12; i++) putch(key);
	putch('\n'); putstr("    ");
	for(int i = 0; i < 6; i++) putch(key);
	putch('\n'); putstr("      ");
	putch(key); putch(key); putch('\n');
}