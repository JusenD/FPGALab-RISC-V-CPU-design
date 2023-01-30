#include "string.h"

int strlen(const char* str)
{
	int len = 0;
	while(str[len] != '\0') len++;
	return len;
}

int strcmp(const char* str1, const char* str2)
{
	int ret = 0;
	while(!(ret=*(unsigned char*)str1-*(unsigned char*)str2) && *str1)
	{
		str1++;
		str2++;
	}
	if (ret < 0)
	{
		return -1;
	}
	else if (ret > 0)
	{
		return 1;
	}
	return 0;
}

int strToInt(const char* str, short minus);

int atoi(const char* str)
{
	int num = 0;//给一个比较大的数据类型，方便处理溢出
	if (str != 0 && *str != '\0')//判断指针是否为空，以及是否有有效字符
	{
		short minus = 0;//是否为负数
		if (*str == '+')
		{
			++str;
		}
		else if (*str == '-')
		{
			++str;
			minus = 1;
		}
		if (*str != '\0')
		{
			num = strToInt(str, minus);
		}
	}
	return num;
}

int strToInt(const char* str, short minus)
{
	int num = 0;
	while (*str != '\0')
	{
		if (*str >= '0' && *str <= '9')//判断是否为有效字符
		{
			int flag = minus ? -1 : 1;//判断正负数
			num = num * 10 + flag * (*str - '0');
			++str;
		}
		else
		{
			num = 0;
			break;
		}
	}
	return num;
}