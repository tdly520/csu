#include<bits/stdc++.h>
#include<string>
using namespace std;
bool su(long q)
{
	if(q==2)  return 1;
	for( long i=2;i<=sqrt(q);i++)
	{
		if(q%i==0)  return 0;
	}
	return 1;
}
int main()
{    
    long long j=1,b[10001];
	for(long i=2;i<=10000;i++)
	{
		if(su(i))  {b[j]=i;j++;	}
	
	}
    int n;
    while (scanf("%d", &n) != EOF)
    {
       long long a[n+1][n+1];
      for(int i=1;i<=n;i++)
		a[i][1]=a[i][i]=1;
	for(int i=1;i<=n;i++)
		for(int j=2;j<i;j++)
			a[i][j]=a[i-1][j]+a[i-1][j-1];
    int k=1;
	for(int i=1;i<=n-1;i++)
	{
		for(int w=i+1;w<=n;w++)
		{
			a[i][w]=b[k];
			k++;
		}
	}
	
    for(int i=1;i<=n;i++)
    {
       for(int w=1;w<=n-1;w++)
	   {
	   	cout<<a[i][w]<<" ";
		   }	cout<<a[i][n]<<endl;
		   
	}cout<<endl;
    }



    return 0;
}
