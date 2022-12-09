#define VGA_START    0x00200000
#define COLOR_START  0x00500000
#define VGA_LINE_O   0x00210000
#define VGA_MAXLINE  30
#define LINE_MASK    0x003f
#define VGA_MAXCOL   70
#define CURSOR       0x002FFFFF
#define OFFLINE      0x002FFFFE
#define RED          4
#define GREEN        2
#define BLUE         1
#define WHITE        7
#define LED_LOW      0x00600000
#define LED_HIGH     0x00600001
#define LED_ALL      0x00600002
#define CHOOSE_LOW   0
#define CHOOSE_HIGH  1
#define CHOOSE_ALL   2

void change_color(char color);
void putstr(char* str);
void putstr_const(const char *str);
void putch(char ch);
void putint(int num);
void set_command();

void vga_init(void);
