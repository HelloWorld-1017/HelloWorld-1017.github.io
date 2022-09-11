#include<stdio.h>

int main(void)
{	
	char name1[5] = "Tommy";
	char name2[4] = "Tommy";

	char name3[6] = "Tommy";
	char name4[] = "Tommy";

	printf("%s.\n%s.\n%s.\n%s.\n", name1, name2, name3, name4);
	return 0;
};