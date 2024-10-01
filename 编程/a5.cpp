#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
   int a;
    while(scanf("%d",&a)!= EOF )
    {  int c=a;
    int b[4]={};
    	if(a>=38)  b[1]=a/38;a=a%38;
		if(a>=18)  b[2]=a/18;a=a%18;
		if(a>=8)   b[3]=a/8;a=a%8;
		if(c-a>68) b[3]+=1;
		printf("%d\n",b[1]+b[2]+b[3]);
	}
     
	

	return 0;
}
