#include<stdio.h>
#include<string.h>
#include<bits/stdc++.h>
 
void bubblesort(int a[], int n)//ц╟ещеепР 
{
	for (int i = 0; i < n - 1; i++)
		for (int j = 0; j < n - 1 - i; j++)
		{
 
			if (a[j] > a[j + 1])
			{
				int temp = a[j + 1];
				a[j + 1] = a[j];
				a[j] = temp;
			}
 
		}
	for (int i = 0; i < n - 1; i++)
	{
		printf("%d ", a[i]);
	}
	printf("%d", a[n - 1]);
}
 
int main()
{
	char str[1000] ;
	gets(str);
	int len = strlen(str);
	//printf("%d\n", len);
	int a[1000];
	int n = 0;
	int i = 0;
	while(i<len)
	{
		int k = 0;
		while (str[i] == '5'&& i < len)
		{
			
			//printf("1-----%d----%c\n",i,str[i]);
			i++;
		}
		while (str[i] != '5'&& i < len)
		{
			
			//printf("2----%d----%c----k--%d\n", i, str[i],k);
			k++;
			i++;
		}
		if (k != 0)
		{
			int num = 0;
			while (k)
			{
				num = num * 10 + (str[i - k] - '0');
				k--;
			}
			//printf("%d\n", num);
			a[n] = num;
			n++;
		}
		
	}
	bubblesort(a, n);

	return 0;
}







