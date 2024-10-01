#include<bits/stdc++.h>
#include<string>
#include<stdio.h>
using namespace std;
int main()
{
   char a[32];
    while(scanf("%s",a)!=EOF)
    {  
    int len;
	len=strlen(a);
	char *s=a;
	//*s=&a[0];
	bool shu=0,d=0,x=0,t=0;
	while(len>=8) 
	{
		for(;*s!='\0';s++ )
		{
			if(*s>='0'&&*s<='9')  shu=1;
			else if(*s>='a'&&*s<='z') x=1;
			else if(*s>='A'&&*s<='Z') d=1;
			else if(*s=='!' ||*s=='@'||*s=='#'||*s=='$'||*s=='*'||*s=='~')  t=1;
		}
		break;
	}
	int sum=0;
	if(shu) sum++;
	if(x) sum++;
	if(d) sum++;
	if(t) sum++;
	if(sum>=3)  printf("yes\n");
		else printf("no\n");
	}
     
	

	return 0;
}
