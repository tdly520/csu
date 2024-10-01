#include<bits/stdc++.h>
#include<string>
using namespace std;

void inv(char x[], int n)//函数第一个参数传递的是a数组的首地址，地址传递将会改变数组的值，原因是都是指向同一内存单元，则改变一个指向的内容将会改变该内存单元的值
{
	char temp, i, j, m = (n - 1) / 2;
	for (i = 0; i <= m; i++)
	{
		j = n - 1 - i;
		temp = x[i]; x[i] = x[j]; x[j] = temp;
	}
	
}

int main()
{
    char a[1011];
    while(gets(a) )
    { 
	int len=strlen(a);	
	int c[33]={},sum=0;
     
     char b[1011]={};
     strcpy(b,a);
     inv(a,len);
     bool q=1;
	 
	 
	 for(int i=0;i<=len-1;i++)
	 {c[a[i]-'a']++;
	 	if(a[i]!=b[i])    {
	 		q=0;break;
		 }
	 }	
	 for(int i=0;i<=32;i++)
	 {
	     if(c[i]>0)  sum++;	
	 }
	 if(q)   printf("YES %d\n",sum);
	 else printf("NO\n");
	 }

	return 0;
}





//程序2：用指针变量作实参




