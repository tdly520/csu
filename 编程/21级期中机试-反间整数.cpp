#include<bits/stdc++.h>
#include<string>
using namespace std;

void inv(char x[], int n)//������һ���������ݵ���a������׵�ַ����ַ���ݽ���ı������ֵ��ԭ���Ƕ���ָ��ͬһ�ڴ浥Ԫ����ı�һ��ָ������ݽ���ı���ڴ浥Ԫ��ֵ
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
//�β�������x������ʵ��������Ԫ��a[0]�ĵ�ַ
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





//����2����ָ�������ʵ��




