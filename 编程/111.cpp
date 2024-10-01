#include<bits/stdc++.h>
using namespace std;
int n,a[1001][1001];
int main()
{   

    int n;
    while(scanf("%d",&n)!= EOF)
    {
	for(int i=1;i<=n;i++)
	{
		a[i][i]=1;
		a[i][1]=1;
	}
	for(int i=3;i<=n;i++)
	{
		for(int j=2;j<=i-1;j++) a[i][j]=a[i-1][j-1]+a[i-1][j];
	}
	for(int i=1;i<=n;i++)
	{
		for(int j=1;j<=i;j++) cout<<a[i][j]<<" ";
		cout<<endl;
	}cout<<endl;
	  }
       return 0;
    }	 

    




