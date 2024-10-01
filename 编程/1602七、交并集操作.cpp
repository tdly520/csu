#include<bits/stdc++.h>
#include<string>
using namespace std;
int main()
{
	int n,m;
	while(scanf("%d",&n)!= EOF )
	{
	int a[n],b[n],c[1001]={};
	for(int i=1;i<=n;i++)
    {
    	scanf("%d",&a[i]);
	}
	for(int i=1;i<=n;i++)
    {
    	scanf("%d",&b[i]);
	}
	cin>>m;
	if(m==1){
		for(int i=1;i<=n;i++)
		{
			c[a[i]]=1;
			c[b[i]]=1;
		}
		for(int i=1000;i>=1;i--)
		{
		if(c[i]!=0) printf("%d ",i);
		
			
		}
		printf("\n");
	}
	else{
			for(int i=1;i<=n;i++)
		{
			c[a[i]]+=1;
			c[b[i]]+=1;
		}
		for(int i=1000;i>=1;i--)
		{
		if(c[i]==2) printf("%d ",i);
		
			
		}
		printf("\n");
	}	
	}
	
}
