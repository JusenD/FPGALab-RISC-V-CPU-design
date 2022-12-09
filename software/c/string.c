#include "string.h"

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
	long long num = 0;//给一个比较大的数据类型，方便处理溢出
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
	return (int)num;
}

int strToInt(const char* str, short minus)
{
	long long num = 0;
	while (*str != '\0')
	{
		if (*str >= '0' && *str <= '9')//判断是否为有效字符
		{
			int flag = minus ? -1 : 1;//判断正负数
			num = num * 10 + flag * (*str - '0');
			if ((!minus && num > 0x7fffffff) || (minus && num < (signed int)0x80000000))
				//判断是否溢出，包括正溢出和负溢出
			{
				num = 0;
				break;
			}
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