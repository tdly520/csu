#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
    long  n;
    while(scanf("%ld",&n)!= EOF)
    {	long long a[n+1][n+1];
	for(int i=1;i<=n;i++)
		a[i][1]=a[i][i]=1;
	for(int i=1;i<=n;i++)
		for(int j=2;j<i;j++)
			a[i][j]=a[i-1][j]+a[i-1][j-1];
	for(int i=1;i<=n;i++)
	{
		for(int j=1;j<=i-1;j++)
			printf("%lld ",a[i][j]);
			printf("%lld",a[i][i]);
		printf("\n");
	}
  printf("\n");
	  }
       return 0;
    }	 

    




