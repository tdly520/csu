#include<bits/stdc++.h>
#include<string>

#include<stdio.h>
using namespace std;

void replace(char*);


int main()
{
   char a[1001],ch;
    while(gets(a) )
    { 
   //ch = getchar();
     replace(a);
	  printf("%s\n",a);
	}
     
	

	return 0;
}
void replace(char *p)
{
    int i;
	for (i = 0; p[i] != '\0'; i++)
		if (p[i] == 'T')	p[i] = 'U';	
}
