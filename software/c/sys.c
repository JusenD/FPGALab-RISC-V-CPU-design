#include "sys.h"


char* vga_start = (char*) VGA_START;
char* color_start  = (char*) COLOR_START;
int* curosr = (int*) CURSOR;
int* offline = (int*) OFFLINE;
int   vga_line=0;
int   vga_ch=0;
int   line_end[100];
char command_line[100];
char color_data = WHITE;

void change_color(char color){
    color_data = color;
}

void set_command(){
    command_line[vga_line] = 1;
}

void vga_init(){
    vga_line = 0;
    vga_ch = 0;
    *offline = 0;
    *curosr = 0;
    color_data = WHITE;
    for(int i = 0; i < 100; i++) {
      command_line[i] = 0;
      line_end[i] = VGA_MAXCOL-1;
    }
    for(int i=0;i<VGA_MAXLINE;i++)
        for(int j=0;j<VGA_MAXCOL;j++)
            vga_start[ (i<<7)+j ] = 0;
}

void putch(char ch) {
  if(ch==8) //backspace
  {
      //TODO
      if(command_line[vga_line] && vga_ch <= 2) return;
      if(vga_ch > 0) {
        vga_ch--;
        vga_start[(vga_line<<7) + vga_ch] = 0;
        *curosr = (vga_line<<7) + vga_ch;
      }
      else if(vga_line > 0){
            vga_line--;
            vga_ch = line_end[vga_line];
            vga_start[(vga_line<<7) + vga_ch] = 0;
            *curosr = (vga_line<<7) + vga_ch;
            *offline = vga_line >= VGA_MAXLINE ? vga_line - VGA_MAXLINE + 1 : 0;
      }
      return;
  }
  if(ch==10 || ch == 13) //enter
  {
      //TODO
      vga_start[(vga_line<<7) + vga_ch] = '\n';
      line_end[vga_line] = vga_ch;
      vga_line++;
      vga_ch = 0;
      *curosr = (vga_line<<7) + vga_ch;
      *offline = vga_line >= VGA_MAXLINE ? vga_line - VGA_MAXLINE + 1 : 0;
      return;
  }
  vga_start[(vga_line<<7)+vga_ch] = ch;
  color_start[(vga_line<<7)+vga_ch] = color_data;
  vga_ch++;
  *curosr = (vga_line<<7) + vga_ch;
  if(vga_ch>=VGA_MAXCOL)
  {
     //TODO
     vga_ch = 0;
     vga_line++;
     *curosr = (vga_line<<7) + vga_ch;
     *offline = vga_line >= VGA_MAXLINE ? vga_line - VGA_MAXLINE + 1 : 0;
  }
  return;
}

void putstr(char *str){
    for(char* p=str;*p!=0;p++)
      putch(*p);
}

void putstr_const(const char *str){
    for(int i = 0; str[i] != '\0'; i++)
      putch(str[i]);
}

void putint(int num) {
    if(num == 0)
    {
      putch('0');
      return;
    }
    if (num < 0) {
        num = -num;
        putch('-');
    }
    int tmp[20];
    int i = 0;
    while (num > 0)
    {
        tmp[i] = num % 10;
        i++;
        num /= 10;
    }
    i--;
    while (i >= 0)
    {
        putch(tmp[i] + '0');
        i--;
    }
}