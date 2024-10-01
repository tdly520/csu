#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
    int a,b,num;
    while(scanf("%d",&a)!= EOF )
    {    int num=0;
    	for(int i=1;i<=a;i++)
    	{
    		scanf("%d",&b);
    		if(b>=100)  num+=b/100;b=b%100;
          	if(b>=50)   num+=b/50;b=b%50;
          	if(b>=10)    num+=b/10;b=b%10;
          	if(b>=5)     num+=b/5;b=b%5;
          	if(b>=2)     num+=b/2;b=b%2;
          	if(b>=1)     num+=b/1;b=b%1;
		}
		printf("%d\n",num);
	}

	return 0;
}
