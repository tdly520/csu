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
/*
void inv(char *x, int n)
{
char *p, temp, *i, *j, m = (n - 1) / 2;
//形参数组名x接收了实参数组首元素a[0]的地址
i = x; j = x + n - 1; p = x + m;
for (; i <= p; i++, j--)
{
temp = *i;
*i = *j;
*j = temp;
}
//return 0;
}*/
int main()
{
    char a[1011];
    while(gets(a) )
    { bool fu=0,tou=0;
	int len=strlen(a);
	if(a[0]=='-'){
	 fu=1;
	
     
     for(int i=0;i<len;i++)
     {
     	a[i]=a[i+1];
	 }
	 len-=1;	
	}
     int c[1011]={};
     char b[1011]={};
     strcpy(b,a);
     inv(a,len);
     for(int i=len-1;i>=0;i--)
     {
     	c[i]=c[i]+int(a[i]-'0')+int(b[i]-'0');
     	if(c[i]>9) {
		 if(i==0){
     	c[i]=c[i]-10;tou=1;	
		 }
		 else{c[i]=c[i]-10;c[i-1]=1;
		 }
     	
		 }
	 }
	 if(fu)
	 {
	 	cout<<'-';
	 	if(tou)  cout<<1;
		 for(int i=0;i<=len-1;i++)
	 {
	 	cout<<c[i];
	 }
	 }
	 else{
	 		if(tou)  cout<<1;
	 for(int i=0;i<=len-1;i++)
	 {
	 	cout<<c[i];
	 }	
	 }
	 
     printf("\n");
     
	
    }

	return 0;
}





//程序2：用指针变量作实参




