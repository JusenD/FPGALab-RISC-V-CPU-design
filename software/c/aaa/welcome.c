#include "sys.h"

int strlen(char* str)
{
	int len = 0;
	while(str[len] != '\0') len++;
	return len;
}
static char* vga_start = (char*) VGA_START;
static int* TIME = (int*)(0x00400000);
char s1[] = "HAPPYCHINESENEWYEAR!";
char s2[] = "SOSADICANNOTFINDBIGBUGINKEYBOARD";
char s3[] = "WELCOMETOSENSOPEARATINGSYSTEM";
char s4[] = "ITJUSTLOOKSLIKEPYTHONBUTREALLYREALLYSIMPLE";
char s5[] = "INEARLYABANDONMYDREAMTOSTUDYABROAD";
char s6[] = "HOWCANIEARNMUCHMONEYANDBEHAPPY?";
char s7[] = "AREYOUHAPPYMYFRIEND";
char s8[] = "WISHYOUGOODLUCKANDBEHAPPYEVERYDAY!";
char* all_str[16] = { s1, s2, s3, s4, s5, s6, s7, s8, s1, s2, s3, s4, s5, s6, s7, s8 };
int location[16] = { -15, 0, -5, 0, -5, -10, -15, -5 };
int x[16] = { 0, 4, 9, 13, 18, 22, 27, 31, 35, 40, 45, 49, 54, 59, 64, 69 };
// 70-16=54 = 4*9 + 3*6
// s1--3--s2-4-s3-3-s4-4-s5-3-s6-4-s7-3-s8-3-s1-4-s2-4-s3-3-s4-4-s5-4-s6-4-s7-4-s8
// start:
// s1:-15
// s2:0
// s3:-5
// s4:0
// s5:-5
// s6:-10
// s7:-15
// s8:-5
// move 1 step downward per 0.05s
void welcome()
{
    // wait
    int t = *TIME;
    while(t < 3000) t = *TIME;
	for (int i = 0; i < 60; i++)
	{
        int last_time = *TIME;
		// set loaction
		for (int j = 0; j < 16; j++)
		{
			char* s = all_str[j];
			int column = x[j];
			int len = strlen(s);
			for (int index = 0, v = location[j];index < len; index++, v--)
			{
				if (v >= 0 && v < 70)
				{
                    vga_start[(v << 7)+column] = s[index];
				}
			}
			location[j]++;
		}
		//refresh
		for (int i = 0; i < 30; i++)
		{
			for (int j = 0; j < 70; j++) vga_start[(i << 7)+j] = 0;
		}
        int time_now = *TIME;
        while(time_now - last_time < 50) time_now = *TIME;
	}
}