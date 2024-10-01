#include<bits/stdc++.h>
#include<string>
using namespace std;

int main()
{
   int a;
   int b[100];
   b[1]=1,b[2]=2;
   for(int i=3;i<=91;i++)
   {
   	b[i]=b[i-1]+b[i-2];
   }
    while(scanf("%d",&a)!= EOF )
    { int ans=0;
       for(int i=1;i<=91;i++)
       {
       	if(b[i]==a)   {
       		ans=i; break;
		   }
	   }
	   printf("%d\n",ans);
	}
     
	

	return 0;
}
