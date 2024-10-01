#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
   int a;
    while(scanf("%d",&a)!= EOF )
    {int b[a+1][a+1];
    for(int i=1;i<=a;i++)
    {
    	for(int j=1;j<=a;j++)
    	{
    		scanf("%d",&b[i][j]);
		}
	}
	
	for(int i=1;i<=a;i++)
    {
    	for(int j=1;j<=a;j++)
    	{
    		printf("%d ",b[j][i]);
    		if(j==a) printf("\n");
		}
	}
	}
     
	

	return 0;
}
